Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FBAC3DA79
	for <linux-pm@archiver.kernel.org>; Fri,  9 Dec 2022 15:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiLIP1H (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Dec 2022 10:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiLIP0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44354900E7
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:35 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lB9w+h77K1tVFaJ2tkym5DpGnEbi6xiiEez0xShG2E=;
        b=El4bf2NiWfktzebIfFCKL2VmRf35I8fVLTIxjHRQcTsvszVop6EVDkoS8mb7lL6az0Uqnb
        zj9IP/clHKFwJTd+DWGPNbAfebdj4TOoNYbPjVY3nn4cgu477VpSYJbt2Ue1aK5I9hzA1F
        YEucgedkURZNy3kDPAd7xMpHkOPH6v/j3iGswS2ZwH6WuMUbx2Vx3UB7hj4R7KD7bA3TGy
        LZojmmmnPunRRHOXEIQ1TgajgaARb837BUOfY1rwFeNmAc5EL/78ghmbEUxexKIMsjmXlp
        w08oZWzCkuBWjYeXumuqTI34F6QklxA1RvTSV/i1cZOoafUE1Q70e59On2TJMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lB9w+h77K1tVFaJ2tkym5DpGnEbi6xiiEez0xShG2E=;
        b=XVmKuhldUgOQMd/fFWzgOM2y/OjCLAlbDK0g5czyOfn1t1CgAXUiDD5CCkptMtfUUGgd9F
        vXcAkfNk3RgsPMAg==
From:   "thermal-bot for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/sysfs: remove unnecessary check in
 trip_point_hyst_show()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <Y0pu2M6kKzIlhCMw@kili>
References: <Y0pu2M6kKzIlhCMw@kili>
MIME-Version: 1.0
Message-ID: <167059959175.4906.316857501482540497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     1627cd2f820ad90d3249e6b4e6f1dbadfbed0d33
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1627cd2f820ad90d3249e6b4e6f1dbadfbed0d33
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Sat, 15 Oct 2022 11:27:04 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/sysfs: remove unnecessary check in trip_point_hyst_show()

The "ret" variable is zero at this point.  No need to check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/Y0pu2M6kKzIlhCMw@kili
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index cef860d..d37133a 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -226,7 +226,7 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 
 	mutex_unlock(&tz->lock);
 
-	return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
+	return sprintf(buf, "%d\n", trip.hysteresis);
 }
 
 static ssize_t
