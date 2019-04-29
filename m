Return-Path: <SRS0=2Oin=S7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F266C43219
	for <linux-pm@archiver.kernel.org>; Mon, 29 Apr 2019 16:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369EC2087B
	for <linux-pm@archiver.kernel.org>; Mon, 29 Apr 2019 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bIp8G+wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfD2Qzr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:55:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46241 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2Qzr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 12:55:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id j11so5587863pff.13
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AMPQbvcwEN3ZxVejjVGKTdlBJSPIcIJE/Kqfir3TvYk=;
        b=bIp8G+wuW7rQ37gmaDIBfuVrDfU8/YiaQDK8l32Oica8Kx/A1l2ujRTouhaWa+Z+ij
         flAq4xBxcbvNGPlRN9vQpCyQPxD12S0O29alldRN9z70HpZdhWyiJSeZPCztOCgfQXnf
         O4JwOSc6XAbQ3t2XNr1sX0N3pkIf9wisrgu5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AMPQbvcwEN3ZxVejjVGKTdlBJSPIcIJE/Kqfir3TvYk=;
        b=hvYlIbO44keTQ3AM+VAJuSD+8AxYaG+uFktcxH9QxrC1k1NGXxSQXkuCUnyGz7t3mA
         xMnYjN3g9JmmbYNxSCgBehqwQ/8MXKYDHjURPp8OKC2TezAYEypPvf+BwDhgm6jV+xpA
         oFX+FQo5uwUGinPs3HoqeUzzN+gJ8b/iAuZT63RTvaiyFA2AehrmhbyWBMrG94y3c0aA
         LvV9KxLLVhTW+og5Gufn66rRowgnS9mWyxJkpeceuIl2Tfg9iO02hzFUG14uBwwJ0UgV
         CPgEgSxfAMeonNixUybveEtLAQydgBZOZhbB75ks8to4nTezFi9fvb5FuCp3zrhr1boM
         I90Q==
X-Gm-Message-State: APjAAAUKUyFiP2nxZTMivtraBgMwRqXGlUTeG5X5O29mETCkugLQYCMH
        4J/tlAYBFwLbMMpo1kzlm/2wHw==
X-Google-Smtp-Source: APXvYqxUDG2Rl+yER4noZW2kdX8sLT0Bu5I2nqTLysmUo8pb2pNLanJKAOumCSV+467bL/eGFeLSWA==
X-Received: by 2002:a63:500f:: with SMTP id e15mr59974587pgb.198.1556556946665;
        Mon, 29 Apr 2019 09:55:46 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 132sm24490812pfw.87.2019.04.29.09.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 09:55:45 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] thermal: broadcom: Remove ACPI support
Date:   Mon, 29 Apr 2019 22:25:29 +0530
Message-Id: <1556556929-25704-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429165529.dg9jwIWvnIUS6KLAR-wKSLDFTjhOfqqE6QcmDhYhEhs@z>

Unlike DT framework, thermal-zones and its parameters can't be parsed
using ACPI framework. So that ACPI support is removed in this driver.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reported-by: David Woodhouse <dwmw2@infradead.org>
---
 drivers/thermal/broadcom/sr-thermal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
index 2284cbe..475ce29 100644
--- a/drivers/thermal/broadcom/sr-thermal.c
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Broadcom
  */
 
-#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -100,18 +99,11 @@ static const struct of_device_id sr_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sr_thermal_of_match);
 
-static const struct acpi_device_id sr_thermal_acpi_ids[] = {
-	{ .id = "BRCM0500" },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(acpi, sr_thermal_acpi_ids);
-
 static struct platform_driver sr_thermal_driver = {
 	.probe		= sr_thermal_probe,
 	.driver = {
 		.name = "sr-thermal",
 		.of_match_table = sr_thermal_of_match,
-		.acpi_match_table = ACPI_PTR(sr_thermal_acpi_ids),
 	},
 };
 module_platform_driver(sr_thermal_driver);
-- 
2.7.4

