import 'package:go_router/go_router.dart';

// Importar las vistas de universidades
import '../views/universidad_list_view.dart';
import '../views/universidad_form_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/universidades',
  routes: [
    // Rutas de universidades
    GoRoute(
      path: '/universidades',
      name: 'universidades',
      builder: (_, __) => const UniversidadListView(),
    ),
    GoRoute(
      path: '/universidades/create',
      name: 'universidades.create',
      builder: (context, state) => const UniversidadFormView(),
    ),
    GoRoute(
      path: '/universidades/edit/:id',
      name: 'universidades.edit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return UniversidadFormView(id: id);
      },
    ),
  ],
);
