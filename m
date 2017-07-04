From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] ARM: pm: add missing types include
Date: Tue,  4 Jul 2017 15:25:42 +0200
Message-ID: <20170704132542.27644-3-johan@kernel.org>
References: <20170704132542.27644-1-johan@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36117 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdGDN0I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2017 09:26:08 -0400
In-Reply-To: <20170704132542.27644-1-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, Johan Hovold <johan@kernel.org>

Add missing types.h include to make the suspend header self-contained
and avoid compilation breakage due to include-directive ordering.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/include/asm/suspend.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index 6c7182f32cef..a61905c86732 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_ARM_SUSPEND_H
 #define __ASM_ARM_SUSPEND_H
 
+#include <linux/types.h>
+
 struct sleep_save_sp {
 	u32 *save_ptr_stash;
 	u32 save_ptr_stash_phys;
-- 
2.13.2
