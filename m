From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/3] drivers/cpuidle: make cpuidle-clps711x.c explicitly non-modular
Date: Sun, 13 Dec 2015 18:57:10 -0500
Message-ID: <1450051032-32329-2-git-send-email-paul.gortmaker@windriver.com>
References: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/cpuidle/Kconfig.arm:config ARM_CLPS711X_CPUIDLE
drivers/cpuidle/Kconfig.arm:    bool "CPU Idle Driver for CLPS711X processors"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/cpuidle/cpuidle-clps711x.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-clps711x.c b/drivers/cpuidle/cpuidle-clps711x.c
index 18a7f7380508..66a9f231ec41 100644
--- a/drivers/cpuidle/cpuidle-clps711x.c
+++ b/drivers/cpuidle/cpuidle-clps711x.c
@@ -12,7 +12,7 @@
 #include <linux/cpuidle.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 
 #define CLPS711X_CPUIDLE_NAME	"clps711x-cpuidle"
@@ -56,8 +56,4 @@ static struct platform_driver clps711x_cpuidle_driver = {
 		.name	= CLPS711X_CPUIDLE_NAME,
 	},
 };
-module_platform_driver_probe(clps711x_cpuidle_driver, clps711x_cpuidle_probe);
-
-MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
-MODULE_DESCRIPTION("CLPS711X CPU idle driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver_probe(clps711x_cpuidle_driver, clps711x_cpuidle_probe);
-- 
2.6.1
