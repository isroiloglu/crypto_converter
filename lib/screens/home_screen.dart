import 'package:crypto_converter/blocs/bloc/crypto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoConverter'),
        centerTitle: true,
      ),
      body: BlocBuilder<CryptoBloc, CryptoState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Theme.of(context).primaryColor, Colors.grey]),
            ),
            child: _buildBody(state),
          );
        },
      ),
    );
  }

  _buildBody(CryptoState state) {
    if (state is CryptoLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
        ),
      );
    } else if (state is CryptoLoaded) {
      return RefreshIndicator(
        color: Theme.of(context).accentColor,
        onRefresh: () {
          context.bloc<CryptoBloc>().add(RefreshCoins());
        },
        child: ListView.builder(
            itemCount: state.coins.length,
            itemBuilder: (BuildContext _context, int index) {
              final coin = state.coins[index];
              return ListTile(
                leading: Text(
                  '${++index}',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }),
      );
    } else if (state is CryptoError) {
      return Center(
        child: Text(
          'Error loading coins \nPlease check your connection',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
