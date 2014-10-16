From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 1/3] drivers: cpuidle: add status property to ARM idle states
Date: Thu, 16 Oct 2014 14:59:55 +0100
Message-ID: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:40046 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbaJPN7Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 09:59:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>

On some platforms the device tree bindings must provide the kernel
with a status flag for idle states, that defines whether the idle
state is operational or not in the current configuration.

This patch adds a status property to the ARM idle states compliant
with ePAPR v1.1 and updates the DT parsing code accordingly.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 14 ++++++++++++++
 drivers/cpuidle/dt_idle_states.c                      |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Docume=
ntation/devicetree/bindings/arm/idle-states.txt
index 37375c7..d8ab4b9 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -317,6 +317,20 @@ follows:
 =09=09=09    In such systems entry-latency-us + exit-latency-us
 =09=09=09    will exceed wakeup-latency-us by this duration.
=20
+=09- status:
+=09=09Usage: Optional
+=09=09Value type: <string>
+=09=09Definition: A standard device tree property [5] that indicates
+=09=09=09    the operational status of an idle-state.
+=09=09=09    If present, it shall be:
+=09=09=09    "okay": to indicate that the idle state is
+=09=09=09=09    operational.
+=09=09=09    "disabled": to indicate that the idle state has
+=09=09=09=09=09been disabled in firmware so it is not
+=09=09=09=09=09operational.
+=09=09=09    If property is not present the idle-state must be
+=09=09=09    considered operational.
+
 =09In addition to the properties listed above, a state node may require
 =09additional properties specifics to the entry-method defined in the
 =09idle-states node, please refer to the entry-method bindings
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_sta=
tes.c
index 52f4d11..22840f4 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -169,6 +169,9 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 =09=09if (!state_node)
 =09=09=09break;
=20
+=09=09if (!of_device_is_available(state_node))
+=09=09=09continue;
+
 =09=09if (!idle_state_valid(state_node, i, cpumask)) {
 =09=09=09pr_warn("%s idle state not valid, bailing out\n",
 =09=09=09=09state_node->full_name);
--=20
2.1.2


