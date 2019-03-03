include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "imu",
  published_frame = "base_link",
  odom_frame = "odom",
  provide_odom_frame = false,
  publish_frame_projected_to_2d = false,
  --use_pose_extrapolator = true,
  use_odometry = false,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 1,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 10,
  num_point_clouds = 0,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true
MAP_BUILDER.num_background_threads = 28

-- -- INPUT DATA -- --
TRAJECTORY_BUILDER_2D.min_range = 0.25
TRAJECTORY_BUILDER_2D.max_range = 25

TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 20

TRAJECTORY_BUILDER_2D.voxel_filter_size = 0.05
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_length = 3
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.min_num_points = 70

TRAJECTORY_BUILDER_2D.use_imu_data = true
POSE_GRAPH.optimization_problem.acceleration_weight = 1e5
POSE_GRAPH.optimization_problem.rotation_weight = 1e2


-- -- LOCAL -- --
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.use_nonmonotonic_steps = true
--TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.max_num_iterations = 20
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.num_threads = 28
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 5 --20
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 2e3 --80

TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = false
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.1
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(10.0)
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.translation_delta_cost_weight = 0.01
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.rotation_delta_cost_weight= 0.01 

TRAJECTORY_BUILDER_2D.motion_filter.max_time_seconds = 1.
TRAJECTORY_BUILDER_2D.motion_filter.max_distance_meters = 0.05
TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians = math.rad(1.0)

TRAJECTORY_BUILDER_2D.submaps.num_range_data = 12
--TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 1080

-- TRAJECTORY_BUILDER_2D.submaps.grid_options_2d.grid_type = 


-- -- GLOBAL -- --
POSE_GRAPH.optimize_every_n_nodes = 100
POSE_GRAPH.constraint_builder.ceres_scan_matcher.ceres_solver_options.num_threads = 28

POSE_GRAPH.optimization_problem.ceres_solver_options.num_threads = 28
POSE_GRAPH.optimization_problem.ceres_solver_options.use_nonmonotonic_steps = true

POSE_GRAPH.constraint_builder.max_constraint_distance = 10
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.linear_search_window = 15
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.angular_search_window = math.rad(60.0)

--POSE_GRAPH.constraint_builder.sampling_ratio = 0.05

--POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.branch_and_bound_depth = 6

POSE_GRAPH.constraint_builder.min_score = 0.65

--POSE_GRAPH.constraint_builder.ceres_scan_matcher

POSE_GRAPH.constraint_builder.loop_closure_translation_weight = 1e3
POSE_GRAPH.constraint_builder.loop_closure_rotation_weight = 1e4
--POSE_GRAPH.matcher_translation_weight = 1e1
--POSE_GRAPH.matcher_rotation_weight = 1e3
--POSE_GRAPH.optimization_problem.*_weight
--POSE_GRAPH.optimization_problem.ceres_solver_options

--POSE_GRAPH.max_num_final_iterations = 10

return options
