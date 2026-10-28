import 'package:flutter/material.dart';

void main() {
  runApp(const IpSubnetCalculatorApp());
}

class IpSubnetCalculatorApp extends StatelessWidget {
  const IpSubnetCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IP & Subnet Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111A2B),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

const Color bg = Color(0xFF111A2B);
const Color panel = Color(0xFF1E2A3D);
const Color field = Color(0xFF10192B);
const Color border = Color(0xFF34445C);
const Color cyan = Color(0xFF24C7FF);
const Color muted = Color(0xFF91A0B7);
const Color green = Color(0xFF00D99A);

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF172338), bg],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 850;
              return Column(
                children: [
                  const _Header(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(3, 0, 3, 3),
                      child: Column(
                        children: [
                          if (compact)
                            const Column(
                              children: [
                                _InputCard(
                                  title: 'SELEZIONA PARAMETRO INGRESSO 1',
                                  parameter: 'IP Host (anche binario)',
                                  value: '192.168.100.100',
                                  showMenu: true,
                                ),
                                SizedBox(height: 14),
                                _InputCard(
                                  title: 'SELEZIONA PARAMETRO INGRESSO 2',
                                  parameter: 'Subnet Mask / CIDR',
                                  value: '255.255.255.0 (/24)',
                                  showMenu: false,
                                ),
                              ],
                            )
                          else
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _InputCard(
                                    title: 'SELEZIONA PARAMETRO INGRESSO 1',
                                    parameter: 'IP Host (anche binario)',
                                    value: '192.168.100.100',
                                    showMenu: true,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Expanded(
                                  child: _InputCard(
                                    title: 'SELEZIONA PARAMETRO INGRESSO 2',
                                    parameter: 'Subnet Mask / CIDR',
                                    value: '255.255.255.0 (/24)',
                                    showMenu: false,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: compact ? 28 : 18),
                          const _ResultsPanel(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF24344C))),
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              gradient: const LinearGradient(
                colors: [Color(0xFF34B8FF), Color(0xFF2465E9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(Icons.hub_outlined, size: 28, color: Colors.white),
          ),
          const SizedBox(width: 16),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IP & Subnet Calculator',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFF3F6FC),
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Calcolatore Avanzato IPv4 & IPv6',
                style: TextStyle(fontSize: 8, color: muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  final String title;
  final String parameter;
  final String value;
  final bool showMenu;

  const _InputCard({
    required this.title,
    required this.parameter,
    required this.value,
    required this.showMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: showMenu ? 370 : 140,
      padding: const EdgeInsets.fromLTRB(30, 22, 30, 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1D293B).withOpacity(.82),
        border: Border.all(color: border, width: .8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: muted,
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: .15,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _SelectField(parameter, expanded: showMenu),
                    if (showMenu) const _DropdownOptions(),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VALORE INSERITO',
                      style: TextStyle(
                        color: muted,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 48,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: field,
                        border: Border.all(color: border, width: .7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SelectField extends StatelessWidget {
  final String text;
  final bool expanded;

  const _SelectField(this.text, {required this.expanded});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 19),
      decoration: BoxDecoration(
        color: field,
        border: Border.all(color: cyan, width: .8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 8, color: Color(0xFFE5EBF5)),
            ),
          ),
          Icon(
            expanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
            size: 20,
            color: expanded ? cyan : muted,
          ),
        ],
      ),
    );
  }
}

class _DropdownOptions extends StatelessWidget {
  const _DropdownOptions();

  @override
  Widget build(BuildContext context) {
    const options = [
      '• IP Host (anche binario)',
      'Network/Binario',
      'Broadcast/Binario',
      'Numero di Host',
      'Subnet Mask',
    ];

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.fromLTRB(5, 3, 5, 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1C293C),
        border: Border.all(color: cyan, width: .8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          for (int i = 0; i < options.length; i++)
            Container(
              height: 42,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                color: i == 0 ? const Color(0xFF174765) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: i == 0
                    ? null
                    : const Border(bottom: BorderSide(color: Color(0xFF2B394D), width: .6)),
              ),
              child: Text(
                options[i],
                style: TextStyle(
                  fontSize: 10,
                  color: i == 0 ? cyan : const Color(0xFFB2BDCE),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ResultsPanel extends StatelessWidget {
  const _ResultsPanel();

  @override
  Widget build(BuildContext context) {
    const rows = [
      _ResultRowData(
        'Indirizzo Network',
        '192.168.100.0',
        '11000000.10101000.01100100.00000000',
        valueColor: cyan,
      ),
      _ResultRowData(
        'Subnet Mask',
        '255.255.255.0 (/24)',
        '11111111.11111111.11111111.00000000',
        binaryColor: green,
      ),
      _ResultRowData(
        'Indirizzo Broadcast',
        '192.168.100.255',
        '11000000.10101000.01100100.11111111',
        valueColor: Colors.white,
      ),
      _ResultRowData(
        'Gateway Predefinito',
        '192.168.100.1',
        '11000000.10101000.01100100.00000001',
        valueColor: Colors.white,
      ),
      _ResultRowData(
        'Range Host Validi',
        '192.168.100.1 - 192.168.100.254',
        'Primo: ...00000001 | Ultimo: ...11111110',
        valueColor: green,
        binaryColor: muted,
      ),
      _ResultRowData(
        'Max Host Utilizzabili',
        '254',
        '2^8 - 2 = 254 indirizzi utili',
        valueColor: const Color(0xFFFFB547),
        binaryColor: muted,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 30, 32, 26),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border.withOpacity(.75), width: .7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 2,
                height: 28,
                decoration: BoxDecoration(
                  color: cyan,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'Risultati Calcolo IPv4',
                style: TextStyle(
                  color: Color(0xFFF1F4FB),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 54),
              Container(
                width: 200,
                height: 28,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 13),
                decoration: BoxDecoration(
                  color: const Color(0xFF124765),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'DECIMALE & BINARIO',
                  style: TextStyle(
                    color: cyan,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              color: field,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('PARAMETRO', style: _ColumnHeaderStyle()),
                ),
                Expanded(
                  flex: 3,
                  child: Text('VALORE DECIMALE', style: _ColumnHeaderStyle()),
                ),
                Expanded(
                  flex: 6,
                  child: Text('RAPPRESENTAZIONE BINARIA (OCTETS)', style: _ColumnHeaderStyle()),
                ),
              ],
            ),
          ),
          for (final row in rows) _ResultRow(data: row),
        ],
      ),
    );
  }
}

class _ColumnHeaderStyle extends TextStyle {
  const _ColumnHeaderStyle()
      : super(
          color: muted,
          fontSize: 9,
          fontWeight: FontWeight.w600,
          letterSpacing: .1,
        );
}

class _ResultRowData {
  final String parameter;
  final String decimal;
  final String binary;
  final Color valueColor;
  final Color binaryColor;

  const _ResultRowData(
    this.parameter,
    this.decimal,
    this.binary, {
    this.valueColor = const Color(0xFFE8EDF6),
    this.binaryColor = const Color(0xFF56B7E8),
  });
}

class _ResultRow extends StatelessWidget {
  final _ResultRowData data;

  const _ResultRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 54),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF2B394D), width: .65)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              data.parameter,
              style: const TextStyle(
                color: Color(0xFFE6EBF4),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              data.decimal,
              style: TextStyle(
                color: data.valueColor,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              data.binary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: data.binaryColor,
                fontSize: 9,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
