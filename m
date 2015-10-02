From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/2] cpuidle: mvebu: disable the bind/unbind attributes and
 use builtin_platform_driver
Date: Sat, 03 Oct 2015 00:24:30 +0100
Message-ID: <E1Zi9gk-0001YK-Nk@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:35365 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbbJBXYf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 19:24:35 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

As the driver doesn't support unbinding, nor does it support arbitary
binding of devices, disable the bind/unbind attributes for this driver.
Also, as the driver has no remove function, it can never be modular,
so use builtin_platform_driver() to avoid the module exit boilerplate.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index facd7d3e57dc..01a856971f05 100644
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
2.1.0

