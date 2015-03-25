From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] intel_idle: mark cpu id array as __initconst
Date: Wed, 25 Mar 2015 22:15:14 +0100
Message-ID: <1427318114-21757-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34882 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbCYVPc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 17:15:32 -0400
Received: by wibbg6 with SMTP id bg6so40775220wib.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2015 14:15:31 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

The CPU ids are only tested in intel_idle_probe() which is itself an
__init function. For the MODULE_DEVICE_TABLE() file2alias doesn't care
about the section, just about the symbol name. So it's safe to mark
the cpu id array as  __initconst so its memory can be released after
initialization is done.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/idle/intel_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b0e58522780d..f5b7fc56fa4a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -776,7 +776,7 @@ static const struct idle_cpu idle_cpu_avn = {
 #define ICPU(model, cpu) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
 
-static const struct x86_cpu_id intel_idle_ids[] = {
+static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x1a, idle_cpu_nehalem),
 	ICPU(0x1e, idle_cpu_nehalem),
 	ICPU(0x1f, idle_cpu_nehalem),
-- 
1.7.10.4

