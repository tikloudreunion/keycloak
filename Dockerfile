FROM keycloak/keycloak:26.2.5-0 AS base

ENV KC_DB=postgres
ENV FEATURES=hostname[:v2]
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

FROM base AS builder

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM base AS runner

COPY --from=builder /opt/keycloak /opt/keycloak/

WORKDIR /opt/keycloak
