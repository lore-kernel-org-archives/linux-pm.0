From: Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 12/16] unicore32: support poweroff through poweroff handler call chain
Date: Tue, 30 Sep 2014 11:00:52 -0700
Message-ID: <1412100056-15517-13-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51899 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbaI3SBi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 14:01:38 -0400
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it if pm_power_off
is set to NULL.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/unicore32/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/unicore32/kernel/process.c b/arch/unicore32/kernel/process.c
index b008e99..421fde6 100644
--- a/arch/unicore32/kernel/process.c
+++ b/arch/unicore32/kernel/process.c
@@ -66,6 +66,8 @@ void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 	machine_halt();
 }
 
-- 
1.9.1

