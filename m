From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/3] drivers/cpuidle: make cpuidle-ux500.c explicitly non-modular
Date: Sun, 13 Dec 2015 18:57:11 -0500
Message-ID: <1450051032-32329-3-git-send-email-paul.gortmaker@windriver.com>
References: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

cpuidle/Kconfig.arm:config ARM_U8500_CPUIDLE
cpuidle/Kconfig.arm:    bool "Cpu Idle Driver for the ST-E u8500 processors"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modularity so that when reading the
driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/cpuidle/cpuidle-ux500.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux500.c
index 8bf895c0017d..7941a090bea6 100644
--- a/drivers/cpuidle/cpuidle-ux500.c
+++ b/drivers/cpuidle/cpuidle-ux500.c
@@ -9,7 +9,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/cpuidle.h>
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
@@ -124,5 +124,4 @@ static struct platform_driver dbx500_cpuidle_plat_driver = {
 	},
 	.probe = dbx500_cpuidle_probe,
 };
-
-module_platform_driver(dbx500_cpuidle_plat_driver);
+builtin_platform_driver(dbx500_cpuidle_plat_driver);
-- 
2.6.1
