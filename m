Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B03BB69A;
	Mon, 15 Jun 2026 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507042; cv=none; b=gQK7dAtIpHt+DwI8GzDXrdcGlZh7ARicNqVISAkFoojYWeVVyxqzlKX1gAWjGDIN0XDF1cXHZ3ygEuf+4UO3udqc8nWG9mY9VpwhLp4NH3SfzJmYdTCdW4pFewOGlCpFwtfJXJ80p5Kv42EHAGgJzP3jp1/BqRLwOm6RjCHwLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507042; c=relaxed/simple;
	bh=XTdvEH8kFdSPqPo+MIHYENwwtzmSXjuw3hi49t4EBTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tybp2/kSG0NQHWPgZh7zkoQQGWK0Wpv5MyxuRzQYHuXnKTzHQTA1kXyj5DCAeLG2HuNu1aTQsiz31g+UpG4aGBHZ7RA1UPRynmjy80z8aAU4WgTQ2bQt+XKC5+UjzinTHOcBhwK6OSYAyRImlSNeXOI7clVTR2ysmyOzLqPrYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowACXCOzWoy9qFjCUEw--.39449S2;
	Mon, 15 Jun 2026 15:03:50 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Kees Cook <kees@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pengpeng@iscas.ac.cn
Subject: [PATCH] thermal: intel: int3400: clean up ODVP on probe failures
Date: Mon, 15 Jun 2026 15:03:24 +0800
Message-ID: <20260615070326.71761-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXCOzWoy9qFjCUEw--.39449S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr48XFW5Gr1kGFWxGFWDXFb_yoW5AFyxpa
	y8AFy8GrWDWF4Sq3yDAF18XF4DGw4rK34YgFWFk3yYywsIvrWftryFyry5AFW0kFZ7KF45
	A345tFW8ursrG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUDOz3UUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

int3400_thermal_probe() calls evaluate_odvp() before several later
fallible setup steps. evaluate_odvp() can allocate ODVP state and create
odvp<N> sysfs files.

If thermal zone registration fails, or if a later sysfs setup step fails
before the notify handler is installed, the current unwind path can free
the private data without removing the ODVP files. The IMOK group failure
path also skips removal of the previously created UUID group.

Make cleanup_odvp() reset its pointers, route the thermal-zone failure
through ODVP cleanup, and make the later sysfs error paths unwind all
previously created sysfs state.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../intel/int340x_thermal/int3400_thermal.c        | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index d200734625ee..e2278baa328c 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -356,8 +356,10 @@ static void cleanup_odvp(struct int3400_thermal_priv *priv)
 			kfree(priv->odvp_attrs[i].attr.attr.name);
 		}
 		kfree(priv->odvp_attrs);
+		priv->odvp_attrs = NULL;
 	}
 	kfree(priv->odvp);
+	priv->odvp = NULL;
 	priv->odvp_count = 0;
 }
 
@@ -597,7 +599,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 							      &int3400_thermal_params);
 	if (IS_ERR(priv->thermal)) {
 		result = PTR_ERR(priv->thermal);
-		goto free_art_trt;
+		goto free_odvp;
 	}
 
 	priv->rel_misc_dev_res = acpi_thermal_rel_misc_device_add(
@@ -610,13 +612,16 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (acpi_has_method(priv->adev->handle, "IMOK")) {
 		result = sysfs_create_group(&pdev->dev.kobj, &imok_attribute_group);
 		if (result)
-			goto free_imok;
+			goto free_uuid;
 	}
 
 	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
 		result = device_create_bin_file(&pdev->dev, &bin_attr_data_vault);
-		if (result)
+		if (result) {
+			kfree(priv->data_vault);
+			priv->data_vault = NULL;
 			goto free_uuid;
+		}
 	}
 
 	result = acpi_install_notify_handler(
@@ -639,6 +644,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
 		device_remove_bin_file(&pdev->dev, &bin_attr_data_vault);
 		kfree(priv->data_vault);
+		priv->data_vault = NULL;
 	}
 free_uuid:
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
@@ -648,6 +654,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 	thermal_zone_device_unregister(priv->thermal);
+free_odvp:
+	cleanup_odvp(priv);
 free_art_trt:
 	kfree(priv->trts);
 	kfree(priv->arts);
-- 
2.50.1 (Apple Git-155)

