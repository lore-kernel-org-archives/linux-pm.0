Return-Path: <SRS0=F5jN=W7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A10C3A5AA
	for <linux-pm@archiver.kernel.org>; Wed,  4 Sep 2019 16:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFAE23400
	for <linux-pm@archiver.kernel.org>; Wed,  4 Sep 2019 16:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613646;
	bh=vQXw80gGOeXR32PUUqH05QRPUB3Lrm/+eXRwbwX2Qf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LHaY0h2LXK3qJkkVstZGrnsBJVTG7GhOMChyK/ZgBW5Qo+VG6oq13emyKpeH2eBS5
	 KXVIEYWbCEZqj1lzmqV/uCa4eT033GlC4PApTu3u2+QDHja69pR855TUwShG+Dc+gd
	 ogaNJnymhGEYfPFgAf/ndQ1UKtd0e7Zf59XamFpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbfIDP7u (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732485AbfIDP7t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Sep 2019 11:59:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E550520820;
        Wed,  4 Sep 2019 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612788;
        bh=vQXw80gGOeXR32PUUqH05QRPUB3Lrm/+eXRwbwX2Qf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLJpORlk7GSIW8Ld+Qzfkg+N+/0Sj2d3NNrx+iyV29+wyluOY0tbAD8Jo21ppyjSw
         5Vk291sA5FijR2uV2x4Hr0DELy78WilxRsA+1gE9IFM3AR+0BiYrHvJ7oB0OkxWeiA
         rH0KBmzWcvyn2IupfIi/nNgUBN1ejTfLxXsia7wA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 83/94] tools/power turbostat: fix buffer overrun
Date:   Wed,  4 Sep 2019 11:57:28 -0400
Message-Id: <20190904155739.2816-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

[ Upstream commit eeb71c950bc6eee460f2070643ce137e067b234c ]

turbostat could be terminated by general protection fault on some latest
hardwares which (for example) support 9 levels of C-states and show 18
"tADDED" lines. That bloats the total output and finally causes buffer
overrun.  So let's extend the buffer to avoid this.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 066bd43ed6c9f..0ff52b3c967a7 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5125,7 +5125,7 @@ int initialize_counters(int cpu_id)
 
 void allocate_output_buffer()
 {
-	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
+	output_buffer = calloc(1, (1 + topo.num_cpus) * 2048);
 	outp = output_buffer;
 	if (outp == NULL)
 		err(-1, "calloc output buffer");
-- 
2.20.1

