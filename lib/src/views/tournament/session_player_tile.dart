/*
 * Copyright 2019 Marco Gomiero
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:friends_tournament/src/bloc/tournament_bloc.dart';
import 'package:friends_tournament/src/bloc/providers/tournament_bloc_provider.dart';
import 'package:friends_tournament/src/data/model/app/ui_player.dart';
import 'package:friends_tournament/src/data/model/app/ui_session.dart';
import 'package:friends_tournament/src/data/model/db/player_session.dart';

class SessionPlayerTile extends StatefulWidget {
  final UIPlayer player;
  final int step;
  final UISession session;

  final double buttonSize = 20;
  final double iconSize = 16;

  SessionPlayerTile({this.player, this.session, this.step = 1});

  @override
  _SessionPlayerTileState createState() => _SessionPlayerTileState();
}

class _SessionPlayerTileState extends State<SessionPlayerTile> {
  TournamentBloc tournamentBloc;

  @override
  Widget build(BuildContext context) {
    tournamentBloc = TournamentBlocProvider.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.player.name,
            style: TextStyle(fontSize: 22),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: widget.buttonSize,
                height: widget.buttonSize,
                child: FloatingActionButton(
                  onPressed: _decrementScore,
                  elevation: 2,
                  child: Icon(
                    Icons.remove,
                    size: widget.iconSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.player.score.toString(),
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                width: widget.buttonSize,
                height: widget.buttonSize,
                child: FloatingActionButton(
                  onPressed: _incrementScore,
                  elevation: 2,
                  child: Icon(
                    Icons.add,
                    size: widget.iconSize,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _incrementScore() {
    tournamentBloc.setPlayerScore.add(
      PlayerSession(widget.player.id, widget.session.id,
          widget.player.score + widget.step),
    );
  }

  _decrementScore() {
    int score = widget.player.score;
    if (score - widget.step >= 0) {
      tournamentBloc.setPlayerScore.add(
        PlayerSession(widget.player.id, widget.session.id,
            widget.player.score - widget.step),
      );
    }
  }
}
