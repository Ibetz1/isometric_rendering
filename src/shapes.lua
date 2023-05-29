return {
    top_face  = engine.mat.new_mat(
        {0, 1, 1, 0},
        {0, 0, 1, 1}
    ),

    left_face  = engine.mat.new_mat(
        {-1, 0, 1, 0},
        {0,  0, 1, 1}
    ) + 1,

    right_face = engine.mat.new_mat(
        {0, 1, 1, 0},
        {-1,  0, 1, 0}
    ) + 1
} -- needs transform post include