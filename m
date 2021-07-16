Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C75C07E95
	for <linux-pm@archiver.kernel.org>; Fri, 16 Jul 2021 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51886613E8
	for <linux-pm@archiver.kernel.org>; Fri, 16 Jul 2021 16:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhGPQlM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:41:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:14458 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPQlL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Jul 2021 12:41:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="274584105"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="274584105"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 09:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="656445438"
Received: from srpawnik.iind.intel.com ([10.223.107.57])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2021 09:38:14 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] thermal: int340x: Use IMOK independently
Date:   Fri, 16 Jul 2021 22:09:46 +0530
Message-Id: <20210716163946.3142-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some chrome platform requires IMOK method in coreboot. But these platforms
don't use GDDV data vault in coreboot. As per current code flow, to enable
and use IMOK only, we need to have GDDV support as well in coreboot. This
patch removes the dependency for IMOK from GDDV to enable and use IMOK
independently.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 .../intel/int340x_thermal/int3400_thermal.c        | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 823354a1a91a..19926beeb3b7 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -108,9 +108,12 @@ static struct attribute *imok_attr[] = {
 	NULL
 };
 
+static const struct attribute_group imok_attribute_group = {
+	.attrs = imok_attr,
+};
+
 static const struct attribute_group data_attribute_group = {
 	.bin_attrs = data_attributes,
-	.attrs = imok_attr,
 };
 
 static ssize_t available_uuids_show(struct device *dev,
@@ -522,6 +525,12 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (result)
 		goto free_rel_misc;
 
+	if (acpi_has_method(priv->adev->handle, "IMOK")) {
+		result = sysfs_create_group(&pdev->dev.kobj, &imok_attribute_group);
+		if (result)
+			goto free_imok;
+	}
+
 	if (priv->data_vault) {
 		result = sysfs_create_group(&pdev->dev.kobj,
 					    &data_attribute_group);
@@ -545,6 +554,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	}
 free_uuid:
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
+free_imok:
+	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
 free_rel_misc:
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
@@ -573,6 +584,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	if (priv->data_vault)
 		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
+	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
 	thermal_zone_device_unregister(priv->thermal);
 	kfree(priv->data_vault);
 	kfree(priv->trts);
-- 
2.17.1

