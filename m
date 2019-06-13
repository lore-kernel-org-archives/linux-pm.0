Return-Path: <SRS0=Pn1r=UM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04823C31E45
	for <linux-pm@archiver.kernel.org>; Thu, 13 Jun 2019 18:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF44208CA
	for <linux-pm@archiver.kernel.org>; Thu, 13 Jun 2019 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560451114;
	bh=Ngejc2zcDXCMW1G3LQDXiNRs/5P4Fi5ZUSidUjkEnvw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=l4R31rhr7y6LM7a8VX1YNIKuyM1lg8sGA9yyNVITuSFzZFXHmLDmzyI274Xsv32YD
	 qn18lI3pWRhroAIYCYnpyh2cdhnGqb+bag0vxZ06pDM+vzBE+6pwyA5UbXpzsdhqRl
	 cCtGkHwKkn3bXb17XNrDsj2jifhL5DMWt382+XFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfFMSie (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfFMSid (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jun 2019 14:38:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE09D2147A;
        Thu, 13 Jun 2019 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560451113;
        bh=Ngejc2zcDXCMW1G3LQDXiNRs/5P4Fi5ZUSidUjkEnvw=;
        h=Date:From:To:Cc:Subject:From;
        b=S1GqvWtryLlaRQwnrcimEMEsbqq8teV289NakhOytBOjx07Q9Ozn4c5/GPviOwoVv
         pu5Tgpog4+DmkM+TvJLQsowEbwM3nZ9n9EFQjNbxZNQlHe1emN73R5MRWZ9dLatlFi
         +qElrSZzQkSm9Wzs+EgnNQIJHhOVIDiGyCLD0070=
Date:   Thu, 13 Jun 2019 20:38:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] thermal: intel: no need to check return value of
 debugfs_create functions
Message-ID: <20190613183830.GD32085@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 25 ++++----------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 1ef937d799e4..f0441ac25555 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -87,29 +87,14 @@ static struct dentry *debugfs;
 static unsigned int pkg_interrupt_cnt;
 static unsigned int pkg_work_cnt;
 
-static int pkg_temp_debugfs_init(void)
+static void pkg_temp_debugfs_init(void)
 {
-	struct dentry *d;
-
 	debugfs = debugfs_create_dir("pkg_temp_thermal", NULL);
-	if (!debugfs)
-		return -ENOENT;
-
-	d = debugfs_create_u32("pkg_thres_interrupt", S_IRUGO, debugfs,
-			       &pkg_interrupt_cnt);
-	if (!d)
-		goto err_out;
-
-	d = debugfs_create_u32("pkg_thres_work", S_IRUGO, debugfs,
-			       &pkg_work_cnt);
-	if (!d)
-		goto err_out;
 
-	return 0;
-
-err_out:
-	debugfs_remove_recursive(debugfs);
-	return -ENOENT;
+	debugfs_create_u32("pkg_thres_interrupt", S_IRUGO, debugfs,
+			   &pkg_interrupt_cnt);
+	debugfs_create_u32("pkg_thres_work", S_IRUGO, debugfs,
+			   &pkg_work_cnt);
 }
 
 /*
-- 
2.22.0

