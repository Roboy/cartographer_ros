include "map_builder.lua"
include "trajectory_builder.lua"
include "roboy_outdoor_local.lua"

-- -- IMU -- --
TRAJECTORY_BUILDER_2D.use_imu_data = true

POSE_GRAPH.optimization_problem.ceres_solver_options.num_threads = 28
POSE_GRAPH.optimization_problem.ceres_solver_options.use_nonmonotonic_steps = true

--    huber_scale = 1e1,
--    acceleration_weight = 1e3,
--    rotation_weight = 3e5,
--POSE_GRAPH.optimization_problem.huber_scale = 1e-1
POSE_GRAPH.optimization_problem.acceleration_weight = 1e2
POSE_GRAPH.optimization_problem.rotation_weight = 3e8

--    local_slam_pose_translation_weight = 1e5,
--    local_slam_pose_rotation_weight = 1e5,
POSE_GRAPH.optimization_problem.local_slam_pose_translation_weight = 1e7
--POSE_GRAPH.optimization_problem.local_slam_pose_rotation_weight = 1e4

--    odometry_translation_weight = 1e5,
--    odometry_rotation_weight = 1e5,
--    fixed_frame_pose_translation_weight = 1e1,
--    fixed_frame_pose_rotation_weight = 1e2,
--POSE_GRAPH.optimization_problem.odometry_translation_weight = 1e3
--POSE_GRAPH.optimization_problem.odometry_rotation_weight = 1e7
--POSE_GRAPH.optimization_problem.fixed_frame_pose_translation_weight = 1e-3
--POSE_GRAPH.optimization_problem.fixed_frame_pose_rotation_weight = 1e4



-- -- GLOBAL -- --
POSE_GRAPH.optimize_every_n_nodes = 200

POSE_GRAPH.constraint_builder.ceres_scan_matcher.ceres_solver_options.num_threads = 28

POSE_GRAPH.constraint_builder.max_constraint_distance = 5
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.linear_search_window = 100
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.angular_search_window = math.rad(75.0)
--POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.branch_and_bound_depth = 20

--POSE_GRAPH.constraint_builder.sampling_ratio = 0.1

POSE_GRAPH.constraint_builder.min_score = 0.52 --0.68

-- LOOP CLOSURE --

--  matcher_translation_weight = 5e2,
--  matcher_rotation_weight = 1.6e3,
POSE_GRAPH.matcher_translation_weight = 5e5
--POSE_GRAPH.matcher_rotation_weight = 1.6e2

--    loop_closure_translation_weight = 1.1e4,
--    loop_closure_rotation_weight = 1e5,
--POSE_GRAPH.constraint_builder.loop_closure_translation_weight = 1e3
--POSE_GRAPH.constraint_builder.loop_closure_rotation_weight = 1e3


POSE_GRAPH.max_num_final_iterations = 1

return options
