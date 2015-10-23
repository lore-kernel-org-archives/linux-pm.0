From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] cpuidle: mvebu: disable the bind/unbind attributes and use builtin_platform_driver
Date: Fri, 23 Oct 2015 13:54:58 +0200
Message-ID: <1445601298-31138-2-git-send-email-daniel.lezcano@linaro.org>
References: <562A1FE0.1060302@linaro.org>
 <1445601298-31138-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445601298-31138-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

As the driver doesn't support unbinding, nor does it support arbitary
binding of devices, disable the bind/unbind attributes for this driver.
Also, as the driver has no remove function, it can never be modular,
so use builtin_platform_driver() to avoid the module exit boilerplate.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index facd7d3..01a8569 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -127,11 +127,12 @@ static struct platform_driver mvebu_cpuidle_driver = {
 	.probe = mvebu_v7_cpuidle_probe,
 	.driver = {
 		.name = "cpuidle-mbevu",
+		.suppress_bind_attrs = true,
 	},
 	.id_table = mvebu_cpuidle_ids,
 };
 
-module_platform_driver(mvebu_cpuidle_driver);
+builtin_platform_driver(mvebu_cpuidle_driver);
 
 MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
 MODULE_DESCRIPTION("Marvell EBU v7 cpuidle driver");
-- 
1.9.1
