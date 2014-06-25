From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v5 2/8] Documentation: devicetree: psci: define CPU suspend parameter
Date: Wed, 25 Jun 2014 15:10:15 +0100
Message-ID: <1403705421-17597-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48515 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352AbaFYOKc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 10:10:32 -0400
In-Reply-To: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>

OS layers built on top of PSCI to enter low-power states require the
power_state parameter to be passed to the PSCI CPU suspend method.

This parameter is specific to a power state and platform specific,
therefore must be provided by firmware to the OS in order to enable
proper call sequence.

This patch adds a property in the PSCI bindings that describes how
the CPU suspend power_state parameter should be defined in DT in
all device nodes that rely on PSCI CPU suspend method usage.

Reviewed-by: Sebastian Capella <sebcape@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/psci.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation=
/devicetree/bindings/arm/psci.txt
index b4a58f3..fae3eed 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -50,6 +50,14 @@ Main node optional properties:
=20
  - migrate       : Function ID for MIGRATE operation
=20
+Device tree nodes that require usage of PSCI CPU_SUSPEND function (ie idle
+states bindings[1]) must specify the following properties:
+
+- entry-method-param
+=09=09Usage: Required for idle states bindings [1].
+=09=09Value type: <u32>
+=09=09Definition: power_state parameter to pass to the PSCI
+=09=09=09    suspend call.
=20
 Example:
=20
@@ -64,7 +72,6 @@ Case 1: PSCI v0.1 only.
 =09=09migrate=09=09=3D <0x95c10003>;
 =09};
=20
-
 Case 2: PSCI v0.2 only
=20
 =09psci {
@@ -88,3 +95,6 @@ Case 3: PSCI v0.2 and PSCI v0.1.
=20
 =09=09...
 =09};
+
+[1] Kernel documentation - ARM idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
--=20
1.9.1


