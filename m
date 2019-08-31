Return-Path: <SRS0=eDrI=W3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C8C3A5A7
	for <linux-pm@archiver.kernel.org>; Sat, 31 Aug 2019 19:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F172187F
	for <linux-pm@archiver.kernel.org>; Sat, 31 Aug 2019 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567280122;
	bh=ZPyE6GzU+VI5GsDtoCm8eHjAROu6QHj2iwynsk0mia0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=rroR6QdFEjHmTwLZ2+KJVeLcV/doiE3+EEkmdQ3Mp3aRw4dD/KXvSkNKZV2gkhRHR
	 zibBI4iLFiwQgjfGaIfxPtyMgm4P2T8olB4EGmSwMHJd4mbxmNBs31svsqQVhjeZ4S
	 mLx8igqNqRmGE3leWrANIW6IoXWYcdRQGGaTJXwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfHaTfV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 31 Aug 2019 15:35:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44385 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:21 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so21033135iog.11
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=3jrtH4QPMegn0RNPk9aukm+I7ke9BQFMqSbfVMu+JR8=;
        b=CIetX9kaBkddmunFUMGxUiesVvBvdqc1YTx2iPksEmPdZBTvyBzGTpfd/Z6WmAVj0N
         rhDQaluNitXeFCeMkqQeIRyG3zstkoQpvFXsGQdR4gpBw+t6709L4XbdVKYVzRnyJ/EJ
         wbqToLIJWlkadlndU/1dhWbjvNSHpIbsu9X7eVjpi5YKoQASfncmC9jeaNmMo9shDiky
         nDqyEiOy8xRxDkm22MNyb1SFytrvja3SBDl8jNrHqNFQfkxsILUBSSEQZBdPJx0XI6op
         215+ByIaZ+QHiy/tS8XZw+VmFmma3PKinA/yNHC+kdkTZyip41/xj7Fyct7RryHA6c6Z
         nfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=3jrtH4QPMegn0RNPk9aukm+I7ke9BQFMqSbfVMu+JR8=;
        b=a0ewkr6s63AxBhri4vRVWovfZQ9BCJsTaL3Uk+f7kF/O+WNZRiXX6pS16aWRK8GcAg
         eSZifpaQdJRAiQ3GC4bKkuTny5bhnQ/YwRtZLyk9fIORlyQGZH32gAesQQkvhxowOeQf
         aq/x2JD9nqw+GcYmtvKvGMKbwasKlPqN3eGZjtheJQgd0KU2z+U2sdHxDVdP8zNBnJTH
         qyZpU5kvGQEqY25CsDZ8QTOL44ieHX9VvTD7ar1cPYVNYl8Wk8hwaQvBe/g4S6l6snas
         V+axlZkr1Ps6lcJziVvlo13I5F/XfBRIH/bYj9nyWjcVtU10tqcwsNDvtwyPVnrsSX2s
         824w==
X-Gm-Message-State: APjAAAVA2n3zn4/0DpHvSswZFeSUC+bmWmYHceXtYMJG94MH+baxpRWx
        5vdvB3ipQYUwYu3Ma/sjM6fb7Qza
X-Google-Smtp-Source: APXvYqyUKkzsdHp1Fh8iYabE7pKXvocUssxyqT5SvKImXCDhRpsUDKyl/mc9TowZ8XQItEAC3etVMA==
X-Received: by 2002:a02:ac84:: with SMTP id x4mr17930316jan.2.1567280120194;
        Sat, 31 Aug 2019 12:35:20 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:19 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 02/19] tools/power/x86: Enable compiler optimisations and Fortify by default
Date:   Sat, 31 Aug 2019 15:34:41 -0400
Message-Id: <6ac1730f7db86f0a92d4de0f2b4ca9cd124080fe.1567277326.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
References: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

Compiling without optimisations is silly, especially since some
warnings depend on the optimiser.  Use -O2.

Fortify adds warnings for unchecked I/O (among other things), which
seems to be a good idea for user-space code.  Enable that too.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/Makefile              | 3 ++-
 tools/power/x86/x86_energy_perf_policy/Makefile | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 045f5f7d68ab..13f1e8b9ac52 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -9,9 +9,10 @@ ifeq ("$(origin O)", "command line")
 endif
 
 turbostat : turbostat.c
-override CFLAGS +=	-Wall -I../../../include
+override CFLAGS +=	-O2 -Wall -I../../../include
 override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
 override CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
+override CFLAGS +=	-D_FORTIFY_SOURCE=2
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
diff --git a/tools/power/x86/x86_energy_perf_policy/Makefile b/tools/power/x86/x86_energy_perf_policy/Makefile
index 1fdeef864e7c..666b325a62a2 100644
--- a/tools/power/x86/x86_energy_perf_policy/Makefile
+++ b/tools/power/x86/x86_energy_perf_policy/Makefile
@@ -9,8 +9,9 @@ ifeq ("$(origin O)", "command line")
 endif
 
 x86_energy_perf_policy : x86_energy_perf_policy.c
-override CFLAGS +=	-Wall -I../../../include
+override CFLAGS +=	-O2 -Wall -I../../../include
 override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+override CFLAGS +=	-D_FORTIFY_SOURCE=2
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-- 
2.20.1

