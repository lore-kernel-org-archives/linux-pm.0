From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 1/3] Documentation: devicetree: psci: define CPU suspend parameter
Date: Tue, 11 Feb 2014 14:17:51 +0000
Message-ID: <1392128273-8614-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33404 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaBKORG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2014 09:17:06 -0500
In-Reply-To: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Kevin

OS layers built on top of PSCI to enter low-power states require the
power_state parameter to be passed to the PSCI CPU suspend method.

This parameter is specific to a power state and platform specific,
therefore must be provided by firmware to the OS in order to enable
proper call sequence.

This patch adds a property in the PSCI bindings that describes how
the CPU suspend power_state parameter should be defined in DT in
all device nodes that rely on PSCI CPU suspend method usage.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/psci.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation=
/devicetree/bindings/arm/psci.txt
index 433afe9..6fc32a5 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -42,6 +42,13 @@ Main node optional properties:
=20
  - migrate       : Function ID for MIGRATE operation
=20
+Device tree nodes that require usage of PSCI CPU_SUSPEND function (ie idle
+states bindings) must specify the following properties:
+
+- power-state
+=09=09Value type: <u32>
+=09=09Definition: power_state parameter to pass to the PSCI
+=09=09=09    suspend call.
=20
 Example:
=20
--=20
1.8.4


