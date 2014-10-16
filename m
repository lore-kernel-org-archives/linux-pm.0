From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 3/3] drivers: cpuidle: remove cpuidle-arm64 duplicate error messages
Date: Thu, 16 Oct 2014 14:59:57 +0100
Message-ID: <1413467997-32131-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:42147 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbaJPN71 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 09:59:27 -0400
In-Reply-To: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>

Current CPUidle driver for arm64 machines spits errors upon idle
state initialization and cpuidle driver registration failures.
These error messages are already printed in core code so there is
no need to print them again.

This patch removes the duplicate print messages from the cpuidle-arm64
driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/cpuidle-arm64.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm6=
4.c
index 50997ea..1b10f92e 100644
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -104,11 +104,8 @@ static int __init arm64_idle_init(void)
 =09 * reason to initialize the idle driver if only wfi is supported.
 =09 */
 =09ret =3D dt_init_idle_driver(drv, arm64_idle_state_match, 1);
-=09if (ret <=3D 0) {
-=09=09if (ret)
-=09=09=09pr_err("failed to initialize idle states\n");
+=09if (ret <=3D 0)
 =09=09return ret ? : -ENODEV;
-=09}
=20
 =09/*
 =09 * Call arch CPU operations in order to initialize
@@ -122,12 +119,6 @@ static int __init arm64_idle_init(void)
 =09=09}
 =09}
=20
-=09ret =3D cpuidle_register(drv, NULL);
-=09if (ret) {
-=09=09pr_err("failed to register cpuidle driver\n");
-=09=09return ret;
-=09}
-
-=09return 0;
+=09return cpuidle_register(drv, NULL);
 }
 device_initcall(arm64_idle_init);
--=20
2.1.2


