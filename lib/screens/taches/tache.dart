import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/date_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../database/task_database.dart';
import '../../modele/task_model.dart';
import '../authentification/login.dart';

/// Main task list screen
/// Displays all tasks for the logged-in user with add/edit/delete functionality
class TaskListScreen extends StatefulWidget {
  final int userId;

  const TaskListScreen({super.key, required this.userId});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskDao _taskDao = TaskDao();
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  /// Load all tasks for the current user
  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final tasks = await _taskDao.getAllByUser(widget.userId);
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Show add task dialog
  void _showAddTaskDialog() {
    final nameController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        ),
        child: StatefulBuilder(
          builder: (context, setDialogState) => Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppConstants.debutezEnregistrement,
                        style: TextStyle(fontSize: AppConstants.fontSizeMedium,fontWeight: AppConstants.fontWeightMedium),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: AppConstants.primaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingL),

                // Name field
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: AppConstants.nom,
                    filled: true,
                    fillColor: AppConstants.greyLightColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusSmall,
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingM),

                // Date picker
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppConstants.primaryColor,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (date != null) {
                      setDialogState(() {
                        selectedDate = date;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.spacingM),
                    decoration: BoxDecoration(
                      color: AppConstants.greyLightColor,
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusSmall,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormatter.formatDatePadded(selectedDate),
                          style: TextStyle(
                            fontSize: AppConstants.fontSizeMedium,
                          ),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingL),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        _showErrorSnackBar(AppConstants.erreurNomTacheVide);
                        return;
                      }

                      final task = Task(
                        userId: widget.userId,
                        name: nameController.text,
                        date: selectedDate,
                        createdAt: DateTime.now(),
                      );

                      try {
                        await _taskDao.insert(task);
                        if (mounted && context.mounted) {
                          Navigator.pop(context);
                        }
                        _loadTasks();
                      } catch (e) {
                        _showErrorSnackBar(
                          e.toString().replaceAll('Exception: ', ''),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadiusLarge,
                        ),
                      ),
                    ),
                    child: Text(
                      AppConstants.enregistrer,
                      style: TextStyle(color: AppConstants.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Show edit task dialog
  void _showEditTaskDialog(Task task) {
    final nameController = TextEditingController(text: task.name);
    DateTime selectedDate = task.date;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        ),
        child: StatefulBuilder(
          builder: (context, setDialogState) => Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppConstants.modifierLaTache,
                      style: TextStyle(
                        fontSize: AppConstants.fontSizeLarge,
                        fontWeight: AppConstants.fontWeightMedium,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: AppConstants.primaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingL),

                // Name field
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: AppConstants.faireLeMenuage,
                    filled: true,
                    fillColor: AppConstants.greyLightColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusSmall,
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingM),

                // Date picker
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppConstants.primaryColor,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (date != null) {
                      setDialogState(() {
                        selectedDate = date;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.spacingM),
                    decoration: BoxDecoration(
                      color: AppConstants.greyLightColor,
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusSmall,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormatter.formatDatePadded(selectedDate),
                          style: TextStyle(
                            fontSize: AppConstants.fontSizeMedium,
                          ),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingL),

                // Update button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        _showErrorSnackBar(AppConstants.erreurNomTacheVide);
                        return;
                      }

                      final updatedTask = Task(
                        id: task.id,
                        userId: task.userId,
                        name: nameController.text,
                        date: selectedDate,
                        isCompleted: task.isCompleted,
                        createdAt: task.createdAt,
                      );

                      try {
                        await _taskDao.update(updatedTask);
                        if (mounted && context.mounted) {
                          Navigator.pop(context);
                        }
                        _loadTasks();
                      } catch (e) {
                        _showErrorSnackBar(
                          e.toString().replaceAll('Exception: ', ''),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadiusLarge,
                        ),
                      ),
                    ),
                    child: Text(
                      AppConstants.modifier,
                      style: TextStyle(color: AppConstants.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Delete task
  Future<void> _deleteTask(int taskId) async {
    try {
      await _taskDao.delete(taskId);
      _loadTasks();
    } catch (e) {
      _showErrorSnackBar(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Toggle task completion
  Future<void> _toggleTaskCompletion(Task task) async {
    try {
      await _taskDao.toggleComplete(task.id!, !task.isCompleted);
      _loadTasks();
    } catch (e) {
      _showErrorSnackBar(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Show error snack bar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icones/back.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              AppConstants.blackColor,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
        title: Text(
          AppConstants.gestionnaireLyst,
          style: TextStyle(
            color: AppConstants.blackColor,
            fontSize: AppConstants.fontSizeLarge,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppConstants.primaryColor,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(AppConstants.paddingVertical),
              child: Column(
                children: [
                  // Task counter card - updated to match design: gradient burgundy card,
                  // title top-left, icon in small rounded box top-right, large counter bottom-left
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppConstants.paddingLarge),
                    decoration: BoxDecoration(
                      gradient: AppConstants.primaryGradient,
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusLarge,
                      ),
                    ),
                    child: SizedBox(
                      height: 140,
                      child: Stack(
                        children: [
                          // Title top-left
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Text(
                              AppConstants.tachesTotales,
                              style: TextStyle(
                                color: AppConstants.whiteColor,
                                fontSize: AppConstants.fontSizeMedium,
                                fontWeight: AppConstants.fontWeightMedium,
                              ),
                            ),
                          ),

                          // Icon top-right inside a small rounded white-outline box
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 64,
                              height: 64,
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                'assets/images/Tasks.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          // Large counter bottom-left
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Text(
                              _tasks.length.toString().padLeft(2, '0'),
                              style: TextStyle(
                                color: AppConstants.whiteColor,
                                fontSize: AppConstants.fontSizeCounter,
                                fontWeight: AppConstants.fontWeightBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingL),

                  // Task list
                  Expanded(
                    child: _tasks.isEmpty
                        ? Center(
                            child: Text(
                              'Aucune tâche pour le moment',
                              style: TextStyle(
                                color: AppConstants.greyColor,
                                fontSize: AppConstants.fontSizeMedium,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _tasks.length,
                            itemBuilder: (context, index) {
                              final task = _tasks[index];
                              return Container(
                                margin: const EdgeInsets.only(
                                  bottom: AppConstants.spacingS,
                                ),
                                padding: const EdgeInsets.all(
                                  AppConstants.spacingM,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.spacingS,
                                  ),
                                  border: Border.all(
                                    color: task.isCompleted
                                        ? AppConstants.greyLightColor
                                        : AppConstants.greyMediumColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task.name,
                                            style: TextStyle(
                                              fontSize:
                                                  AppConstants.fontSizeMedium,
                                              decoration: task.isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: task.isCompleted
                                                  ? AppConstants.greyColor
                                                  : AppConstants.blackColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: AppConstants.spacingXS,
                                          ),
                                          Text(
                                            DateFormatter.formatDatePadded(
                                              task.date,
                                            ),
                                            style: TextStyle(
                                              fontSize:
                                                  AppConstants.fontSizeSmall,
                                              color: task.isCompleted
                                                  ? AppConstants.greyColor
                                                  : AppConstants.violetColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (!task.isCompleted) ...[
                                      IconButton(
                                        onPressed: () =>
                                            _toggleTaskCompletion(task),
                                        icon: SvgPicture.asset(
                                          'assets/icones/checkbox 1.svg',
                                          width: 24,
                                          height: 24,
                                          colorFilter: ColorFilter.mode(
                                            AppConstants.successColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            _showEditTaskDialog(task),
                                        icon: SvgPicture.asset(
                                          'assets/icones/Vector.svg',
                                          width: 24,
                                          height: 24,
                                          colorFilter: ColorFilter.mode(
                                            AppConstants.warningColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ],
                                    IconButton(
                                      onPressed: () => _deleteTask(task.id!),
                                      icon: SvgPicture.asset(
                                        'assets/icones/trash 1.svg',
                                        width: 24,
                                        height: 24,
                                        colorFilter: ColorFilter.mode(
                                          AppConstants.errorColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: AppConstants.primaryColor,
        child: SvgPicture.asset(
          'assets/icones/Plus.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            AppConstants.whiteColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
