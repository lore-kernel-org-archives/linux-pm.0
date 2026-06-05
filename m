Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191173B5835;
	Fri,  5 Jun 2026 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638757; cv=none; b=t71RTWzOT+8cn5zxooIIM3OOeJ9MaQCs1eDPvyJ+373AiJ6PM4ldKsRJ9fiI7oKeQKn2uujeWJlFeWquRNpUCP8VSThxaMbaJdShX3ftaruAN+S8k4neAotdGsFm2v/TOUBU6aqbdIzXW9iXVS9jWSvo0PlOFR67exWMoc0ghn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638757; c=relaxed/simple;
	bh=bP5tNSZNLgHvo3fNrwnO3hqLOKKjLHqWasbuWuv3sVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hesixCNM+9cASwPpBSIKuTgmw3cpIxpfn9z7SImFW0ru2jBGaGvdk/6TQYgG6hai78HdX0jkmdLX11iATfgZhelPH1u/c7ZipaVsPur6mjyEtTUtHLiiOFnnj9w5jySuZMadm0c0xOf+ClriMIVIp1kOm8H1dK++u0bOG1lisfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dICLL7bS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dICLL7bS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98611F00893;
	Fri,  5 Jun 2026 05:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638754;
	bh=v6DYK4RgVU1B+Cg+Edv/FttlEEvwAbId7aUFrj6ggb8=;
	h=From:Date:Subject:To:Cc;
	b=dICLL7bSxXTCGv6RusfV6Zl3iRLcyNZGEZY95DUn5KAzkCls/LynkNrvw9xH115/P
	 qgL7949UJgYwusxM/6cHyxOn70qZtoOydMJAnta+w0kl5EZ923hQtjn3Cm2UnT+B8f
	 2i6Kaz6w0U4gTlxJ2Lae+ZjrchWXDWc8ewDAHC01wQNP2iZaTrwU8n0+J71B/JmzNp
	 1wTCfBfttLg4KnnnQXi3x3gOPLC3JVCJ8cSGOerpx+su500latAwJJxNctQqCXIx2q
	 WxoQuZ+PETVDjLrZsF/zNczqAy6C/xox80d0aKu2ykl5cZjyzixwoTn8B1F8JeeP2Q
	 RG5jCNnvqZg1Q==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 04 Jun 2026 22:52:28 -0700
Subject: [PATCH] power: supply: max17042_battery: Use modern PM ops to
 clear up warning
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-max17042_battery-fix-unused-suspend_soc_alerts-v1-1-3562a68e6f36@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNywrCMBCF4Vcps3YgSUMtvopIyGXUiKYlk5RK6
 bsbdfktzvk3YMqRGE7dBpmWyHFKDfLQgb/bdCOMoRmUUIMYhMaXXeVRaGWcLYXyG69xxZoqU0C
 uPFMKhidv7JNyYeyVE6Pr9ei8hHY6Z2qDX/B8+Zure5Av3wrs+wdFUJzqkgAAAA==
X-Change-ID: 20260604-max17042_battery-fix-unused-suspend_soc_alerts-32b08b348bc1
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Vincent Cloutier <vincent@cloutier.co>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2763; i=nathan@kernel.org;
 h=from:subject:message-id; bh=bP5tNSZNLgHvo3fNrwnO3hqLOKKjLHqWasbuWuv3sVc=;
 b=kA0DAAoWHWsmkXHAGpYByyZiAGoiZCCifuKA7nOHI9ND7OhK2gDjJho4L02ey3xEYgOEYhRbw
 4h1BAAWCgAdFiEEe+MlxzExnM0B2MqSHWsmkXHAGpYFAmoiZCAACgkQHWsmkXHAGpbZawD+K/RP
 qbB3O0zoZibpQm4Y3tQ1YwuU+RW3tVablSBB5boA/jLVrknK5dKhx4nTd6lv2VK+Xk1fqY3Y3fv
 9OYs86OkG
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building for a platform that does not have power management, such
as s390, there is an unused function warning, as
max17042_suspend_soc_alerts() is only used in max17042_suspend(), which
is under a CONFIG_PM_SLEEP #ifdef.

  drivers/power/supply/max17042_battery.c:957:13: error: 'max17042_suspend_soc_alerts' defined but not used [-Werror=unused-function]
    957 | static void max17042_suspend_soc_alerts(struct max17042_chip *chip)
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the modern DEFINE_SIMPLE_DEV_PM_OPS(), which allows the compiler to
see the functions as used while allowing it to eliminate them as unused
during the optimization phase. Use pm_ptr() to allow the compiler to
drop max17042_pm_ops when there is no PM support.

Fixes: 601885ffb5e9 ("power: supply: max17042_battery: Keep only critical alerts during suspend")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/power/supply/max17042_battery.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 0fb46c1c203f..639dacdb9b31 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1296,7 +1296,6 @@ static int max17042_platform_probe(struct platform_device *pdev)
 	return max17042_probe(i2c, dev, irq, id->driver_data);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max17042_suspend(struct device *dev)
 {
 	struct max17042_chip *chip = dev_get_drvdata(dev);
@@ -1327,10 +1326,9 @@ static int max17042_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(max17042_pm_ops, max17042_suspend,
-			max17042_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(max17042_pm_ops, max17042_suspend,
+				max17042_resume);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id max17042_acpi_match[] = {
@@ -1397,7 +1395,7 @@ static struct i2c_driver max17042_i2c_driver = {
 		.name	= "max17042",
 		.acpi_match_table = ACPI_PTR(max17042_acpi_match),
 		.of_match_table = of_match_ptr(max17042_dt_match),
-		.pm	= &max17042_pm_ops,
+		.pm	= pm_ptr(&max17042_pm_ops),
 	},
 	.probe		= max17042_i2c_probe,
 	.id_table	= max17042_id,
@@ -1407,7 +1405,7 @@ static struct platform_driver max17042_platform_driver = {
 	.driver	= {
 		.name	= "max17042",
 		.acpi_match_table = ACPI_PTR(max17042_acpi_match),
-		.pm	= &max17042_pm_ops,
+		.pm	= pm_ptr(&max17042_pm_ops),
 	},
 	.probe		= max17042_platform_probe,
 	.id_table	= max17042_platform_id,

---
base-commit: 7e541f6dbd05921d0bbb99646028cb9982535707
change-id: 20260604-max17042_battery-fix-unused-suspend_soc_alerts-32b08b348bc1

Best regards,
--  
Cheers,
Nathan

