Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCE2D77F5;
	Wed, 30 Sep 2026 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.106.246.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749155; cv=none; b=hDUCmsVnHiXLxQAmHjjPu8Ru0SQlYRnVal3FaMb15ZjhAQ/k5/z0dHTT3pVvHJc41H+XPT+pyPrsoISntAFffkHmdzv+S95hHK0ovqrrcc8GvpBXsScNY1l8rx2JxQdcx5mZPhU8QyUMsZ4LkxVvRA7tsEIMPtvqWgdrADnRcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749155; c=relaxed/simple;
	bh=xRm3gEACpNR+yLo44YiEitOwVR6sFn5jhprGz3gHx2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JG2k0Cz0B9AUFR+f9NVEGP1p9FLQtEIv0AtjeBfSo0jCp8eiIHyZGRuVq8y3dSjqjQGV7cu+cxl4JRtgcZUVbgWmQmA/WZ1/d2sEEd4H4NXrMIIAocOApfbu08L21u/4HMsdi8AG+rokdfZ7Dz89BGXNf3ynjnM7vWhLTS+bj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=64.106.246.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from [127.0.1.1] (10.18.11.116) by mailsc.amlogic.com (10.8.11.35)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 29 Sep
 2026 23:14:06 -0700
From: Chongchong Ding <chongchong.ding@amlogic.com>
Date: Wed, 30 Sep 2026 14:13:49 +0800
Subject: [PATCH] ARM: hibernate: flush TLB after switching to idmap
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-hibernate-tlb-flush-v1-1-a0143c144c19@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAJyovGoC/yXMQQqDMBBA0avIrDtgpkTaXkW6MHFipkgqmVgK4
 t2b6vIt/t9AOQsrPJoNMn9E5Z0qzKUBH4c0McpYDdRS197phlEc5zQUxjI7DPOqEQN54+3V2I4
 s1HLJHOR7XPvnaV3di335r2DffwloWe93AAAA
X-Change-ID: 20260928-hibernate-tlb-flush-f2c1c5315625
To: Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Linus Walleij <linusw@kernel.org>, "Florian
 Fainelli" <f.fainelli@gmail.com>, Chongchong Ding
	<chongchong.ding@amlogic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748845; l=2140;
 i=chongchong.ding@amlogic.com; s=20260930; h=from:subject:message-id;
 bh=xRm3gEACpNR+yLo44YiEitOwVR6sFn5jhprGz3gHx2w=;
 b=mVY4hSIXxmwZwPg1yYsJdj/VEZwtR3MM2B3k+7Jzwm7JwFJD3phlpkbnh86VDwpuXiaeDS50v
 T0h+6xd+Eb5D0l9QU25+thhxHo+V9YPBWgZ+2HLVOF7qkFU8pVLibIJ
X-Developer-Key: i=chongchong.ding@amlogic.com; a=ed25519;
 pk=x1D2PG3lUVeB9gT9LLK2qTEJMxyeSY7/nexaR/wvK6o=
X-ClientProxiedBy: mailsh.amlogic.com (10.18.11.5) To mailsc.amlogic.com
 (10.8.11.35)

On 32-bit ARM, hibernate switches to the identity mapping to copy pages.
The idmap keeps an early RW snapshot of kernel mappings, so
STRICT_KERNEL_RWX text/rodata can be written during restore.

cpu_switch_mm() does not drop the global TLB entries from swapper.
copy_page() can therefore still hit the old RO translations and fail to
restore kernel RO sections.

Flush the local BTB and TLB after installing the idmap, matching
setup_mm_for_reboot() and the cpu_suspend() resume path.

Signed-off-by: Chongchong Ding <chongchong.ding@amlogic.com>
---
arch/arm/kernel/hibernate.c is only compiled when CONFIG_HIBERNATION is
enabled, and none of the 32-bit ARM defconfigs enable it, so the ARM
hibernation code has never been covered by the regular build tests.  This
bug was found while enabling the option for build coverage.
---
 arch/arm/kernel/hibernate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
index 231a76af09a0..1c7c1cb6dade 100644
--- a/arch/arm/kernel/hibernate.c
+++ b/arch/arm/kernel/hibernate.c
@@ -21,6 +21,7 @@
 #include <asm/suspend.h>
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 #include "reboot.h"
 
@@ -93,6 +94,17 @@ static void notrace arch_restore_image(void *unused)
 	if (IS_ENABLED(CONFIG_CPU_TTBR0_PAN))
 		uaccess_save_and_enable();
 	cpu_switch_mm(idmap_pgd, &init_mm);
+	local_flush_bp_all();
+
+#ifdef CONFIG_CPU_HAS_ASID
+	/*
+	 * The identity mapping has no clean ASID and may clash with entries
+	 * left behind by the previous page tables.  Without this flush,
+	 * copy_page() can translate through the stale read-only kernel
+	 * mappings instead of the writable aliases in the idmap.
+	 */
+	local_flush_tlb_all();
+#endif
 	for (pbe = restore_pblist; pbe; pbe = pbe->next)
 		copy_page(pbe->orig_address, pbe->address);
 

---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20260928-hibernate-tlb-flush-f2c1c5315625

Best regards,
--  
Chongchong Ding <chongchong.ding@amlogic.com>

