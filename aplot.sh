shopt -s globstar
opwd=$(pwd)
exists() { [[ -e $1 ]]; }

for i in **/
do
	cd $i
	if exists *.json
	then
		svg=$(echo ${i%/}| tr / _).svg
		$opwd/plot.sh | gnuplot > $opwd/$svg
	fi
	cd $opwd
done
