# check if cowfortune is disabled
if [ "$ZSH_COWFORTUNE_DISABLE" = "1" ]; then return; fi

# check if cowfortune exists
if [ ! -f "$(which cowfortune)" ]; then return; fi

cowfortune
