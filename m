From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 7/7] drivers/power: Convert non-modular syscon-reboot to use builtin_driver_register
Date: Sun, 10 May 2015 15:49:45 -0400
Message-ID: <1431287385-1526-8-git-send-email-paul.gortmaker@windriver.com>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:58279 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbbEJTwP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2015 15:52:15 -0400
In-Reply-To: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

This file depends on Kconfig options all of which are a bool, so
we use the appropriate registration function, which avoids us
relying on an implicit inclusion of <module.h> which we are
doing currently.

While this currently works, we really don't want to be including
the module.h header in non-modular code, which we'd be forced
to do, pending some upcoming code relocation from init.h into
module.h.  So we fix it now by using the non-modular equivalent.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/power/reset/syscon-reboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index d3c7d245ae63..7d0d269a0837 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -88,4 +88,4 @@ static struct platform_driver syscon_reboot_driver = {
 		.of_match_table = syscon_reboot_of_match,
 	},
 };
-module_platform_driver(syscon_reboot_driver);
+builtin_platform_driver(syscon_reboot_driver);
-- 
2.2.1

