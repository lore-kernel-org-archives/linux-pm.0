From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 9/9] drivers: sh: Disable PM runtime for multi-platform r8a7740 with genpd
Date: Mon,  3 Nov 2014 16:34:56 +0100
Message-ID: <1415028896-9005-10-git-send-email-geert+renesas@glider.be>
References: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:58347 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbaKCPfD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 10:35:03 -0500
In-Reply-To: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If the default PM domain using PM_CLK is used for PM runtime, the real PM
domain(s) cannot be registered from DT later.

Hence do not enable it when running a multi-platform kernel with genpd
support on an r8a7740. The R-Mobile PM domain driver will take care of
PM runtime management of the module clocks.

The default PM domain is still needed for:
  - platforms without genpd support,
  - the legacy (non-DT) case, where genpd may take over later, except
    for the C5 "always on" PM domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - No changes,
v3:
  - Reword,
v2:
  - New.
---
 drivers/sh/pm_runtime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index fe2c2d595f599b2f..85cc89fd3e7d7cb7 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -81,7 +81,9 @@ static int __init sh_pm_runtime_init(void)
 		if (!of_machine_is_compatible("renesas,emev2") &&
 		    !of_machine_is_compatible("renesas,r7s72100") &&
 		    !of_machine_is_compatible("renesas,r8a73a4") &&
+#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 		    !of_machine_is_compatible("renesas,r8a7740") &&
+#endif
 		    !of_machine_is_compatible("renesas,r8a7778") &&
 		    !of_machine_is_compatible("renesas,r8a7779") &&
 		    !of_machine_is_compatible("renesas,r8a7790") &&
-- 
1.9.1

