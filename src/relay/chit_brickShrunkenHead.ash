// <center><font size=2><b>Shrunken Head:</b></font><small><center>Animating horrible tourist family</small><table border=0><tr><td><img alt="Abilities: Meat Drop Bonus (52%), Cold Attack (48%)" title="Abilities: Meat Drop Bonus (52%), Cold Attack (48%)" src="https://d2uyhvukfffg5a.cloudfront.net/otherimages/shrunkenhead.png" /></td><td class="small">HP: <b>565</b></td></tr></table>

void bake_shrunkenhead() {
	buffer result;

	string pattern = '<center><font size=2><b>Shrunken Head:</b></font><small><center>Animating ([\\w\\s]+?)</small><table border=0><tr><td><img alt="Abilities: ([^"]+)" title="Abilities: [^"]+" src="[^"]+" /></td><td class="small">HP: <b>([^<]+)</b></td></tr></table>';
	matcher shrunkenMatcher = create_matcher(pattern, chitSource['wtfisthis']);

	result.brickStart('Shrunken Head', 'shrunkenhead', '4');
	result.tagStart('tr');
	result.tagStart('td', attrmap {
		'class': 'icon',
		'title': 'Shrunken Head',
	});
	result.addImg(itemimage('shrunkenhead.gif'), attrmap {});
	result.tagFinish('td');
	result.tagStart('td', attrmap { 'class': 'info', 'colspan': '3' });
	result.append('Animating ');

	if(shrunkenMatcher.find()) {
		result.append(shrunkenMatcher.group(1));
		result.br();
		result.append('HP: ');
		result.append(shrunkenMatcher.group(3));
		result.br();
		result.append('Abilities: ');
		result.append(shrunkenMatcher.group(2));
	} else if(chit_available($item[shrunken head]) > 0) {
		result.append('nothing, go find a foe to reanimate!');
		if(last_monster() != $monster[none] && current_round() != 0) {
			result.br();
			result.append(last_monster());
			result.append(' gives ');
			result.append(shrunken_head_zombie(last_monster()).join(', '));
		}
	}

	result.tagFinish('td');
	result.tagFinish('tr');
	result.brickFinish();
}
