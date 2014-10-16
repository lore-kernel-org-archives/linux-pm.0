From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/3] drivers: cpuidle: add idle-state-name description to ARM idle states
Date: Thu, 16 Oct 2014 14:59:56 +0100
Message-ID: <1413467997-32131-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:40428 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbaJPN7Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 09:59:25 -0400
In-Reply-To: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kevin Hilman <khilman@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>

On ARM machines, where generally speaking the idle state numbering has
no fixed and standard meaning it is useful to provide a description
of the idle state inner workings for benchmarking and monitoring purposes.

This patch adds a property to the idle states bindings that if present
gives platform firmware a means of describing the idle state and export
the string description to user space.

The patch updates the DT parsing code accordingly to take the description,
if present, into consideration.

Cc: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 6 ++++++
 drivers/cpuidle/dt_idle_states.c                      | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Docume=
ntation/devicetree/bindings/arm/idle-states.txt
index d8ab4b9..6f68718 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -331,6 +331,12 @@ follows:
 =09=09=09    If property is not present the idle-state must be
 =09=09=09    considered operational.
=20
+=09- idle-state-name:
+=09=09Usage: Optional
+=09=09Value type: <string>
+=09=09Definition: A string used as a descriptive name for the idle
+=09=09=09    state.
+
 =09In addition to the properties listed above, a state node may require
 =09additional properties specifics to the entry-method defined in the
 =09idle-states node, please refer to the entry-method bindings
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_sta=
tes.c
index 22840f4..5301912 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -27,6 +27,7 @@ static int init_state_node(struct cpuidle_state *idle_sta=
te,
 {
 =09int err;
 =09const struct of_device_id *match_id;
+=09const char *desc;
=20
 =09match_id =3D of_match_node(matches, state_node);
 =09if (!match_id)
@@ -73,6 +74,10 @@ static int init_state_node(struct cpuidle_state *idle_st=
ate,
 =09=09return -EINVAL;
 =09}
=20
+=09err =3D of_property_read_string(state_node, "idle-state-name", &desc);
+=09if (err)
+=09=09desc =3D state_node->name;
+
 =09idle_state->flags =3D CPUIDLE_FLAG_TIME_VALID;
 =09if (of_property_read_bool(state_node, "local-timer-stop"))
 =09=09idle_state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
@@ -82,7 +87,7 @@ static int init_state_node(struct cpuidle_state *idle_sta=
te,
 =09 *=09and desc become string pointers
 =09 */
 =09strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN - 1);
-=09strncpy(idle_state->desc, state_node->name, CPUIDLE_DESC_LEN - 1);
+=09strncpy(idle_state->desc, desc, CPUIDLE_DESC_LEN - 1);
 =09return 0;
 }
=20
--=20
2.1.2


