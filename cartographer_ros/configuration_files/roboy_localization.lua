include "roboy_indoor.lua"

TRAJECTORY_BUILDER.pure_localization = true

-- -- GLOBAL -- --
POSE_GRAPH.global_constraint_search_after_n_seconds = 7
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.18
POSE_GRAPH.global_sampling_ratio = 0.01

-- -- LOCAL -- -- 
POSE_GRAPH.constraint_builder.sampling_ratio = 0.4
--POSE_GRAPH.constraint_builder.min_score = 0.5
POSE_GRAPH.constraint_builder.max_constraint_distance = 10
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.linear_search_window = 15
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.angular_search_window = math.rad(15.0)

-- -- OPTIMIZATION -- --
POSE_GRAPH.optimize_every_n_nodes = 25
--POSE_GRAPH.max_num_final_iterations = 1

return options
