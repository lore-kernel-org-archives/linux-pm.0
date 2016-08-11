From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ARM: cpuidle: Fix error return code
Date: Thu, 11 Aug 2016 15:02:30 +0200
Message-ID: <1470920550-21625-1-git-send-email-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

We know that 'ret = 0' because it has been tested a few lines above.
So, if 'kzalloc' fails, 0 will be returned instead of an error code.
Return -ENOMEM instead.

Fixes: a0d46a3dfdc3 ("ARM: cpuidle: Register per cpuidle device")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/cpuidle/cpuidle-arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 4ba3d3fe142f..f440d385ed34 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -121,6 +121,7 @@ static int __init arm_idle_init(void)
 		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 		if (!dev) {
 			pr_err("Failed to allocate cpuidle device\n");
+			ret = -ENOMEM;
 			goto out_fail;
 		}
 		dev->cpu = cpu;
-- 
2.7.4


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
