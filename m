Return-Path: <SRS0=eDrI=W3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED6DC3A5A6
	for <linux-pm@archiver.kernel.org>; Sat, 31 Aug 2019 19:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EAD2187F
	for <linux-pm@archiver.kernel.org>; Sat, 31 Aug 2019 19:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567280125;
	bh=nomrr7/ZwaXfFP9Vugu1XnDb9O594s25KZVJY/zHus0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=WBugd+DPbmamBCm+8PNEkK85h2NIMRg/UgwiRqL2ZMqHYNpZs38SzqdSPEAQfeOK3
	 dcIS54TroM5nwvpxeL5R0IYMMuTSqaJEvckBUApKVi9O+zEzOyCVwp2Sixkkm8J9bP
	 +FuV9X4e5onPFadPzESO7G09Q9CMtJC2ffGysimg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfHaTfZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 31 Aug 2019 15:35:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38476 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:25 -0400
Received: by mail-io1-f66.google.com with SMTP id p12so21119613iog.5
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=N9muUaZvpx7q/k9h+lDLMlI0BBAXFFcb+pnVMkHbM+g=;
        b=Q2O2Y/0h3+ecjJRPs8kLmReV/R3MbGIGkAykIxCz2NpMLJt5cIW3GAaGIfR0Sz21Pw
         QpqW7uoA1O1MhVMxM5swJVH8ZFTQzV5wXpRPOWIgoQLM1KIVsNDv58TlSuh1K1qaIoXu
         8k8zhm2W8Pk6rN0vZ3m5axQO/ebdPQd8S+Nyx2CN6nz6PbAoOEL/gL1uWLPFuun3gyRW
         07zEL9oOu+epr7UXZ3dHFTlkLGfW+ansr82i05ILiE3JyzqaMKIZ+6f9YoBSiDzi732p
         AOG9agEVqfcqAqjG3j0YVotbgNQHIH7TZcLMYT7fSiUTWZuj03VhKnlf06+G+oNFiNuS
         Ljdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=N9muUaZvpx7q/k9h+lDLMlI0BBAXFFcb+pnVMkHbM+g=;
        b=eHUuw7p5M6DfjpyHZVd3iG9TlAlDydNat8z2+2p20n7LfQBpMvgafBJEQazCmqBVDz
         gMrixY7tWc0ma7uRPhLZNeIIMMTASZrAfgC3in7WTSlAf+zwTYKmeNM6BEaa4XzIqYqY
         Ngyrg4N70JzWAUBjM1XKTr7QAKZRfxZKxswFoIAUQ9p4TNrXefZ8+tao781QOhatyEC3
         4meRSg+9Vc2lPv2K/UIAn4oItpASWMdS6neeBFHnIuH3b1/pjTK3ko4Es5njuh6XgN63
         wRoAdTI9DaUM/rGE3hUfUq8sulxO4BkaRvTh3bnWzajualMjpxrG8DzzYJPKE/GlnHBi
         AkJg==
X-Gm-Message-State: APjAAAVdFwoiLlj1m/ShKhNcfVd2tYwyvDiLrBREOU5KS54JlIk6XFLt
        s1CKgiAm3XOXywpipnM+BGX6od7/
X-Google-Smtp-Source: APXvYqz8nKoySfeFlsrIiMdlLAz4qpQU+Xfk9eb4ytLIP67xI86f31M6xRaJOx1xKYCI8TVq5TGG7Q==
X-Received: by 2002:a5d:9aca:: with SMTP id x10mr24512335ion.11.1567280123932;
        Sat, 31 Aug 2019 12:35:23 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:23 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: [PATCH 05/19] tools/power turbostat: remove duplicate pc10 column
Date:   Sat, 31 Aug 2019 15:34:44 -0400
Message-Id: <d743dae6d1936160366a32f3400f03db1da9421b.1567277326.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

Remove the duplicate pc10 column.

Fixes: be0e54c4ebbf ("turbostat: Build-in "Low Power Idle" counters support")
Reported-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb9901c..90f7e8b4d4d4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -849,7 +849,6 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "pc8: %016llX\n", p->pc8);
 		outp += sprintf(outp, "pc9: %016llX\n", p->pc9);
 		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
-		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
 		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
 		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
 		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
-- 
2.20.1

