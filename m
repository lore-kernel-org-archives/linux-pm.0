Return-Path: <SRS0=m8DM=3F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF48C33CAF
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 18:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CF520684
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 18:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198909;
	bh=nTPmWZG5QsXK9I/nWtJnDvDqWkReAjvAHtCTuXPCuMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S2lG6RNHe+/ZlhWq6uN3it3WqxWUliBL805xyry/UrWxEiIAJBqk3yAAL0yW3ektc
	 Ts4R1O3lt0GMFFvrLfBU7kJ2tkfc87u11jXQ+QC024KMowMjp/Cu42kMyvuwKCQOEU
	 2PYRtcoiFHhJNWw1CkxByHu4IyrA8t7nSNg08X/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392504AbgAPR1o (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:27:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392500AbgAPR1o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 12:27:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA04246E0;
        Thu, 16 Jan 2020 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195663;
        bh=nTPmWZG5QsXK9I/nWtJnDvDqWkReAjvAHtCTuXPCuMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPUQRFVrsX17NYzy/tUdfv6YOlZj3LZulqG+ef682TStwu73Gd+DWX+1ZX1ea5Z1y
         xcdc8i8A33o5Wasq4hX77UKKbepAOeqdROBtG3/K5IbkoIAPfmVx9NRr651q1WbpzM
         /tQSH6NAUypjMG0VLDHHqkrKqlOuhGkzgtMHuDzQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 222/371] cpufreq: brcmstb-avs-cpufreq: Fix initial command check
Date:   Thu, 16 Jan 2020 12:21:34 -0500
Message-Id: <20200116172403.18149-165-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 22a26cc6a51ef73dcfeb64c50513903f6b2d53d8 ]

There is a logical error in brcm_avs_is_firmware_loaded() whereby if the
firmware returns -EINVAL, we will be reporting this as an error. The
comment is correct, the code was not.

Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 7281a2c19c36..bae319037658 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -762,8 +762,8 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 	rc = brcm_avs_get_pmap(priv, NULL);
 	magic = readl(priv->base + AVS_MBOX_MAGIC);
 
-	return (magic == AVS_FIRMWARE_MAGIC) && (rc != -ENOTSUPP) &&
-		(rc != -EINVAL);
+	return (magic == AVS_FIRMWARE_MAGIC) && ((rc != -ENOTSUPP) ||
+		(rc != -EINVAL));
 }
 
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
-- 
2.20.1

