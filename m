Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0336CC3DA6E
	for <linux-pm@archiver.kernel.org>; Fri,  9 Dec 2022 15:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiLIP1G (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Dec 2022 10:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiLIP0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4289F900DA
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:35 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uckS2QwrpCYgIrHInOz9Wl2S3qNfB2UqvtZywmiySCs=;
        b=wfJn+vp/8NjuNbojoWKiS0zMfNP3hElNSLAJHTZ0IIdafyypC/QAZKVd2o5x5CG+6dWc3q
        Z3vzHDH4ZdmBvUZojWBXoCXqtFvBjELCEke4zCIu60ZKi491Q2qk5u6aFEOTEdlzlWGCNs
        uMJbDMBzV0loxyTs5HGNO2pV3HRvua1AbHlmib6YuMoCjV5cbXBYt4mlbl6dMfTZ8WUgRB
        oOLVJJfACD2hXAfeizaXq8NzkZ/dKMDv36H4h/Uh8RiqccVr2L8N0OJ8M54g4GuM7iIRMh
        cH1xPOvQ+n58q6zBZjhgsnkkB1D8F4WImZFugRjdQ0AxGkLGfLyO+Z5TZtiyrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uckS2QwrpCYgIrHInOz9Wl2S3qNfB2UqvtZywmiySCs=;
        b=bM6XkcITY9OydwDUXCWDlgLEQWfO7LQK/NAPQFFTkhrRskDxOOFs29sZiWbDg/Uxae1jFb
        YOzachjkQjzy1FCQ==
From:   "thermal-bot for Marcus Folkesson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx8mm_thermal: Validate
 temperature range
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221014073507.1594844-1-marcus.folkesson@gmail.com>
References: <20221014073507.1594844-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Message-ID: <167059959145.4906.16158658500498892747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     86f0836ca9f6669993da7feba0a04d21506e05e0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//86f0836ca9f6669993da7feba0a04d21506e05e0
Author:        Marcus Folkesson <marcus.folkesson@gmail.com>
AuthorDate:    Fri, 14 Oct 2022 09:35:07 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/imx8mm_thermal: Validate temperature range

Check against the upper temperature limit (125 degrees C) before
consider the temperature valid.

Fixes: 5eed800a6811 ("thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Link: https://lore.kernel.org/r/20221014073507.1594844-1-marcus.folkesson@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx8mm_thermal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 68608d8..182cc20 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -65,8 +65,14 @@ static int imx8mm_tmu_get_temp(void *data, int *temp)
 	u32 val;
 
 	val = readl_relaxed(tmu->base + TRITSR) & TRITSR_TEMP0_VAL_MASK;
+
+	/*
+	 * Do not validate against the V bit (bit 31) due to errata
+	 * ERR051272: TMU: Bit 31 of registers TMU_TSCR/TMU_TRITSR/TMU_TRATSR invalid
+	 */
+
 	*temp = val * 1000;
-	if (*temp < VER1_TEMP_LOW_LIMIT)
+	if (*temp < VER1_TEMP_LOW_LIMIT || *temp > VER2_TEMP_HIGH_LIMIT)
 		return -EAGAIN;
 
 	return 0;
