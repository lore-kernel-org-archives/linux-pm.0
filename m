From: Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 2/4] regulator: act8865: Convert poweroff-source DT property to system-power-controller
Date: Wed, 29 Oct 2014 07:35:33 +0000
Message-ID: <1414568135-8311-3-git-send-email-romain.perier@gmail.com>
References: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:46416 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbaJ2Hc0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 03:32:26 -0400
In-Reply-To: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de
Cc: grant.likely@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, johan@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 Documentation/devicetree/bindings/regulator/act8865-regulator.txt | 4 ++--
 drivers/regulator/act8865-regulator.c                             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
index 01a5b07..dad6358 100644
--- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
@@ -6,8 +6,8 @@ Required properties:
 - reg: I2C slave address
 
 Optional properties:
-- poweroff-source: Telling whether or not this pmic is controlling
-  the system power. See Documentation/devicetree/bindings/power/poweroff.txt .
+- system-power-controller: Telling whether or not this pmic is controlling
+  the system power. See Documentation/devicetree/bindings/power/power-controller.txt .
 
 Any standard regulator properties can be used to configure the single regulator.
 
diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 76301ed..435aba1 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -365,7 +365,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (of_system_has_poweroff_source(dev->of_node)) {
+	if (of_is_system_power_controller(dev->of_node)) {
 		if (!pm_power_off) {
 			act8865_i2c_client = client;
 			act8865->off_reg = off_reg;
-- 
1.9.1

