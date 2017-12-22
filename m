From: TimGuo <timguo@zhaoxin.com>
Subject: [PATCH] x86/acpi/cstate delete some unuseful operations
Date: Fri, 22 Dec 2017 19:55:04 +0800
Message-ID: <1513943704-4117-1-git-send-email-timguo@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from zxshcas01.zhaoxin.com ([180.169.121.91]:6701 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750995AbdLVLzd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 06:55:33 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, mingo@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, TimGuo <timguo@zhaoxin.com>

Unuseful cache flush operations which will be executed by ucode when entering C3 will
cause larger C3 enter latency. And the bus master disable operation is not need for
centaur platforms.

Signed-off-by: TimGuo <timguo@zhaoxin.com>
---
 arch/x86/kernel/acpi/cstate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index dde437f..3eee490 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -51,6 +51,18 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
        if (c->x86_vendor == X86_VENDOR_INTEL &&
            (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
                        flags->bm_control = 0;
+
+       if (c->x86_vendor == X86_VENDOR_CENTAUR) {
+               /*
+                * on all centaur CPUs, sw need not execute cache flush operation
+                * when entering C3 type state.
+                *
+                * On all Centaur platforms, ARB_DISABLE is not required while
+                * entering C3 type state.
+                */
+               flags->bm_check = 1;
+               flags->bm_control = 0;
+        }
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);

--
1.9.1



保密声明：
本邮件含有保密或专有信息，仅供指定收件人使用。严禁对本邮件或其内容做任何未经授权的查阅、使用、复制或转发。
CONFIDENTIAL NOTE:
This email contains confidential or legally privileged information and is for the sole use of its intended recipient. Any unauthorized review, use, copying or forwarding of this email or the content of this email is strictly prohibited.
