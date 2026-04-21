Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7AC3A3E87;
	Tue, 21 Apr 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777694; cv=none; b=NDwx8ffMabCT1KlPkUBmJoZV6VQEXBWrWl9cDRtiBUNW1ChlCaZlassadFvfQzsclR2+zmZdxf6HUXEuQ2RguTIhYglixnY3QJTGz87urwdp2RNa0Wmlcx3sTDU6F5EWK2DKTJtJZRKtQuGxcsM5QcF9LDtXjur3/e6AJZogKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777694; c=relaxed/simple;
	bh=iqq7O0pe3th+d4Oz8TJ6sgNAUQ2DvMZJTF97JIOkip0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qFc1W6ehqSa4Q30CuGDPugSVDoJLtavDhcIFyoG3xWTGZrIL9rl5M5kYN4Y037HRRzBeFOe8JS8QhXhYU1epuxtm3K8lxwyL+W1/Di9BII2DhwK7Ym3ytghDRMbcHiKI+wJ2oshNx7dQzkqShMD1QKmP3Py7voqXDJBOpRJxQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 02A692338E;
	Tue, 21 Apr 2026 16:21:30 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] thermal/int340x_thermal: handle data_vault when the value is ZERO_SIZE_PTR
Date: Tue, 21 Apr 2026 16:21:30 +0300
Message-Id: <20260421132130.38289-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>

commit 7931e28098a4c1a2a6802510b0cbe57546d2049d upstream.

In some case, the GDDV returns a package with a buffer which has
zero length. It causes that kmemdup() returns ZERO_SIZE_PTR (0x10).

Then the data_vault_read() got NULL point dereference problem when
accessing the 0x10 value in data_vault.

[   71.024560] BUG: kernel NULL pointer dereference, address:
0000000000000010

This patch uses ZERO_OR_NULL_PTR() for checking ZERO_SIZE_PTR or
NULL value in data_vault.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ kovalev: bp to fix CVE-2022-48703 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 28913867cd4b..a064a4eb31fb 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -466,7 +466,7 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
 				   obj->package.elements[0].buffer.length,
 				   GFP_KERNEL);
-	if (!priv->data_vault) {
+	if (ZERO_OR_NULL_PTR(priv->data_vault)) {
 		kfree(buffer.pointer);
 		return;
 	}
@@ -531,7 +531,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (result)
 		goto free_rel_misc;
 
-	if (priv->data_vault) {
+	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
 		result = sysfs_create_group(&pdev->dev.kobj,
 					    &data_attribute_group);
 		if (result)
@@ -549,7 +549,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 free_sysfs:
 	cleanup_odvp(priv);
 	if (priv->data_vault) {
-		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
+		if (!ZERO_OR_NULL_PTR(priv->data_vault))
+			sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 		kfree(priv->data_vault);
 	}
 free_uuid:
@@ -579,7 +580,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
-	if (priv->data_vault)
+	if (!ZERO_OR_NULL_PTR(priv->data_vault))
 		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 	thermal_zone_device_unregister(priv->thermal);
-- 
2.50.1

