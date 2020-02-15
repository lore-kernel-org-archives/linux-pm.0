Return-Path: <SRS0=ObCQ=4D=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39ADC2BA83
	for <linux-pm@archiver.kernel.org>; Sat, 15 Feb 2020 11:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A70D206D7
	for <linux-pm@archiver.kernel.org>; Sat, 15 Feb 2020 11:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAnsRZrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgBOLKA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 15 Feb 2020 06:10:00 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34757 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgBOLKA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Feb 2020 06:10:00 -0500
Received: by mail-qt1-f195.google.com with SMTP id l16so4131408qtq.1;
        Sat, 15 Feb 2020 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tgIqByN7XK24vWrC6nkP1j06yZWkabnWcaD6QHevAA=;
        b=OAnsRZrxLzsePOUoefhvykzJyy66wrA75NeIrIfjFZTRg3RKuu5aOgNnPeqlCUP1Bv
         qFASsLHEhn4nJLU+sK68+mJ2j07Te5eKuxE77kA80A75zRIPJaoJf+qBZ/EeLMpTjZVI
         rfOHqBGUqKX9doHA0ZkY2LuwSfJMoN4+vRR5CHRAOLQj8PSaGjatNLTaij/zU4hwz8wS
         N3SXAm5BUGYzwK9Y8Ef4dGlCSOQOE4koHK7ej8k2sE/OzcduCVmrX5miIlAy2F/BDx89
         kSLX+N62WhmqGRzQMYJCKaxp8hcjH8evy5SGtwGydSGRetb0fgHH/WuO9wTXaOB3f6IC
         2dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tgIqByN7XK24vWrC6nkP1j06yZWkabnWcaD6QHevAA=;
        b=dbMSFnonE3WYN4F6bjXh/MJ/0uvPD50BIanmzEhV95x6VMF7ClZ4VoRqrNW/+4Y4bb
         8DG9jAKVlOhpSFSor9n9viVgYMha3MPm8uXLkFHTHoELR4izx1KhtDPTJuptTeV342FE
         K5oUkhUa8a1rl5NQjVHtFRPPoTkP/Zyup/pV0/1ciXvnmJs9zSDLc+q9ek4XAV8LuN7Q
         WiWmMZbtufoSE3PKF3l5tDpxCRR/gbRtXHicm3JVul2g4WdaAXf+okDSBfLRO67mnM6y
         F2kmngw8oVqAIjcxDXPTZDeskeQHH2vgdHBxXRa4G1uW0q5yI/aINt6riYUW4PZz18LR
         juBg==
X-Gm-Message-State: APjAAAVS6JJZmALOBs7Rz1mbzNHG3NknUcBF9DZeeMP2ui4KFGd7zWnC
        gsOhvSnFZGbUFYvGeWwHPEM=
X-Google-Smtp-Source: APXvYqzz16+gBcXj4y+ZQg7aGlsiLozUDN4iATmw4hS0hkhb6CjY9rVl3mR9MVzy1KZvZoURGFE3qg==
X-Received: by 2002:ac8:6697:: with SMTP id d23mr6000567qtp.235.1581764999481;
        Sat, 15 Feb 2020 03:09:59 -0800 (PST)
Received: from prism.localdomain (ip72-195-144-14.ri.ri.cox.net. [72.195.144.14])
        by smtp.gmail.com with ESMTPSA id m54sm5279735qtf.67.2020.02.15.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 03:09:58 -0800 (PST)
From:   Alexander Koskovich <zvnexus@gmail.com>
X-Google-Original-From: Alexander Koskovich <zvnexus@outlook.com>
To:     arjan@linux.intel.com, jacob.jun.pan@linux.intel.com
Cc:     zvnexus@gmail.com, Alexander Koskovich <zvnexus@outlook.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/intel_powerclamp: Don't report an error for AMD CPUs
Date:   Sat, 15 Feb 2020 11:09:37 -0500
Message-Id: <20200215160938.1025-1-zvnexus@outlook.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Resolves dmesg error "intel_powerclamp: CPU does not support MWAIT".

The error that is outputted in dmesg prior to this patch
is innacurate, AMD Ryzen CPUs do support MWAIT. We could
also add the AMD vendor to the MWAIT check, but even though
AMD CPUs do support MWAIT, they fail the C-state package
check so it's better just to bail out in the beginning.

Signed-off-by: Alexander Koskovich <zvnexus@outlook.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 53216dcbe173..3c5b25bfa596 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -650,6 +650,11 @@ static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
 	.set_cur_state = powerclamp_set_cur_state,
 };
 
+static const struct x86_cpu_id amd_cpu[] = {
+	{ X86_VENDOR_AMD },
+	{},
+};
+
 static const struct x86_cpu_id __initconst intel_powerclamp_ids[] = {
 	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_MWAIT },
 	{}
@@ -659,6 +664,11 @@ MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
 static int __init powerclamp_probe(void)
 {
 
+	if (x86_match_cpu(amd_cpu)) {
+		pr_info("Intel PowerClamp does not support AMD CPUs\n");
+		return -ENODEV;
+	}
+
 	if (!x86_match_cpu(intel_powerclamp_ids)) {
 		pr_err("CPU does not support MWAIT\n");
 		return -ENODEV;
-- 
2.25.0

