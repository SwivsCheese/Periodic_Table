ALPHANUMERIC=$1
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else

if [[ ! $ALPHANUMERIC =~ ^[0-9]+$ ]]
then
  LENGTH=$(echo -n "$1" | wc -m)
  if [[ $LENGTH -gt 2 ]] # HEY THIS IS IF WE TYPE THE NAME OF THE ELEMENT
  then
  # if bigger than 1 char (aka, the element name)
    ELEM_NAME=$($PSQL "select * from elements where name='$ALPHANUMERIC'")
    if [[ -z $ELEM_NAME ]]
    then
      echo "I could not find that element in the database."
    else
    # return long sentence
      BCE=$($PSQL "select * from elements INNER JOIN properties using(atomic_number) INNER JOIN types using (type_id) where name='$ALPHANUMERIC'")
      echo "$BCE" | while read TYPERS_ID LINE ATOMIC_NUM LINE SYMBOWL LINE NAME LINE ATOMIC_MASS LINE MPC LINE MPB LINE TYPERS
      do
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOWL). It's a $TYPERS, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $MPB celsius."
      done 
      
    fi
  # now all I have to do is say if alphanumeric = symbol or atomic_num
  else # HEY THIS IS IF WE TYPE THE SYMBOL OF THE ELMENT
    ELEM_SYMB=$($PSQL "select * from elements where symbol='$ALPHANUMERIC'")
    
    if [[ -z $ELEM_SYMB ]]
    then
      echo "I could not find that element in the database."
    else
    # return long sentence
      BCE=$($PSQL "select * from elements INNER JOIN properties using(atomic_number) INNER JOIN types using (type_id) where symbol='$ALPHANUMERIC'")
      echo "$BCE" | while read TYPERS_ID LINE ATOMIC_NUM LINE SYMBOWL LINE NAME LINE ATOMIC_MASS LINE MPC LINE MPB LINE TYPERS
      do
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOWL). It's a $TYPERS, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $MPB celsius."
      done
    fi

  fi
else # INPUT IS A NUMBER!!!
ELEM_NUMB=$($PSQL "select * from elements where atomic_number=$ALPHANUMERIC")
    
    if [[ -z $ELEM_NUMB ]]
    then
      echo "I could not find that element in the database."
    else
    # return long sentence
      BCE=$($PSQL "select * from elements INNER JOIN properties using(atomic_number) INNER JOIN types using (type_id) where atomic_number=$ALPHANUMERIC")
      echo "$BCE" | while read TYPERS_ID LINE ATOMIC_NUM LINE SYMBOWL LINE NAME LINE ATOMIC_MASS LINE MPC LINE MPB LINE TYPERS
      do
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOWL). It's a $TYPERS, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $MPB celsius."
      done
    fi
fi

fi
