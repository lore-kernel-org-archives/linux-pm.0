Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10309476699
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548885; cv=none; b=GwxCx4McNilWqIQCuaFl/jX+ytkgf3PMMvtvwiH29147q9igOZca7qf9NG7zbpB+Xa9M1Pr9wyglT/pM73lrbIEdfGYvhrh93hzaQk1jPnzJAsKt8YfopIFBIyh2imfy4RN+eibOJcnH/vbCLfAuzHHeJtg9M7Aw0j7Jo76PSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548885; c=relaxed/simple;
	bh=x0XfJfYYmm0lZckHiSTrULL19u0GEKu1sJMJbH7EwyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXG+0t/FIb8EMKeedv0FU71n98vxOBX6BJZtQtqgEdUHR3/zTd0y8XFwSao4rjAmuGL3cWDa20inpe7reTw5W/Al5ei8a/BxT/qq5VmdPnUHuxRCkkBuNcAHjvVzQMC9yLiZdBsjss9wgXVSoSc94Gsbe5rzZHgvCBbQPGDxim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFJpR9Hy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFJpR9Hy"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1111405a91.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786548873; x=1787153673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzIk5I7OqDCOAhpxa2DhuDUN9BeeRjYb7EQC4Ahia0I=;
        b=XFJpR9Hyc8Lt2lxvmcKjpWT7qA5Lv0Wp74VAnzbEFy/nbzJvnRpccTNcBpOX84y+j1
         Lxv5U9cmTQFxcw95NLAj1d1Zr68cI4J5L8+Yv8tEPDbvppTypDY9FhNEI8yYK0EHLM3c
         KtB/jk0EC5vXa3FNej7452fEg5YfCfSlpc5SqyZrbIjvQgIwijFogwO5vccuU6Bbo1IH
         GHfKHEJwjw1dq11r0B7YS2aoF36SheP+Hdnk1OTPmrOHF7Gp87qUG22d4Z75pF5J4L6N
         U8cibdvEdUgyS+mrsuUqGEEwY2KG6i+sWpibhrnYb3qB7supSglugw5qKeOtyWJb1Mnx
         UUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548873; x=1787153673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzIk5I7OqDCOAhpxa2DhuDUN9BeeRjYb7EQC4Ahia0I=;
        b=ARWTjwMLWJUw9HheZcXlOi+10jYHXNx6r7jY+rkUCuuzm5req8dazhHrXQpPiroUbR
         EDqvjDlea3xuElnRiJ1CqjRXfw8YRKdtmR32XOqcjWZHPYz4rTOw0IOh7/+C7flfqgoz
         73DUxFBTEHApCaJREp0BPv3ZRXj1ZHqGNEI5OLaZXJAyz5w0NQvGmfz7jZtM+z/gD/RE
         TMSkaQlds3FpMP1yyJb/EaxGIb/dsnvkVG4bjGuQj0TPrUD+H1IkQcR2OrPvgZ4eTT6E
         JxsdyQcsBlpfx7lMFgYVS08Pq0Ek/v8FUd69X6Eh83ADQi8znWMmDyoSjDpOcN6Dhu4/
         +mgg==
X-Forwarded-Encrypted: i=1; AHgh+Rpuyq13EM7/IHB6K/IOTgEa4AfesJdRePOAO+DjM5owLhPkQAPRJ+e77FcNj/St465GDJ84ZcFeEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvoCwyDzF7DMlPw7YBrWPigB2C9CbtsyxMF9/Sr3L313ugHiM
	gsJ/EWX4jw7axlYfTL1srjNk1U/AqKyrktfJ7WddMv2LrHpvfy4UUh8=
X-Gm-Gg: AR+sD12f/2meJIJxgBmu9oUFW60It6iUtyFb+OdI8aAi2Di2SXhFTJMAFgvAzQoW3s6
	eakRY5bqsXZHvPeActglCEyYu/MP/Crgms4yrZApWhPY5RTNsW9nHjde9tT/Fw8J9epWvMDdjgT
	FfCSz/g5G2WyCzXCVCAh19yFa6WTCXR+PllaFn3Yn7wQJX03i6U0XOvqFvdOkCZ205U7Tr64fBK
	/XJEqGKPNnQ8u2zlhGJNo8WRdgJWBvg46+pJ41vOw4fcrbtJfvTV4FJS1lL44aAO971mR2zC9gS
	uXq4imK++tTDHm2d2R+UJEpHvlzJ23Rrggq/di9qSZo5PejfRj3H1hpJEf/JiPS/+AeuTXxD4Pj
	teOPW4iUc7QzrzOJa1k3QvqgL3Cki2N81nFtU9dE4rldEKBlUdaPIlxy5x8rQD9UKY18XfIme3V
	T6AV9sLCzGunMo5pV9Th61lHN7fwPMy8U6VdhH/+AmrTMQWx00O5/mWP57y3zAKvRmY2VDmCP+1
	ad+MgFqymlXBtaixqCxsushiLPM71ZzENQ=
X-Received: by 2002:a17:90a:d64f:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-393011eea08mr7525677a91.7.1786548872437;
        Wed, 12 Aug 2026 08:34:32 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([14.97.72.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31dba3e9791sm7160804eec.0.2026.08.12.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:34:32 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andre Eikmeyer <andre@negmaster.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Sebastian Reichel <sre@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH RESEND v7] thunderbolt: Add device links for Apple T2 NHI
Date: Wed, 12 Aug 2026 11:34:07 -0400
Message-ID: <20260812153411.1159-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812153411.1159-1-atharvatiwarilinuxdev@gmail.com>
References: <20260812153411.1159-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ice Lake Thunderbolt NHI That are only on T2 Macs. The NHI and its
associated PCIe Root Ports all sit directly on the Root Complex
with no upstream port. Identify the tunneled PCIe Root Ports by
their PCI IDs and create device links back to the NHI so that
PCIe tunnels can be re-established after sleep.

And on other Thunderbolt NHI's, like Titan Ridge, the default method
is used to add device links.

Co-developed-by: Andre Eikmeyer <andre@negmaster.com>
Signed-off-by: Andre Eikmeyer <andre@negmaster.com>

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
Changes in v7:
- Used pci_lock_rescan_remove to prevent race conditons.
- Fixed patch format.

Changes in v6:
- Used for_each_pci_bridge in Icelake section
- Removed has_apple_t2_chip as its not required now

Changes in v5:
- Used Icelake root PCI IDs for detection of root ports instead of TRP

Changes in v4:
- Limited TRP check to T2 Icelake systems only
- Optimized has_apple_t2_chip check
- Included pci.h to drivers/thunderbolt/tb.c
- Used __free(pci_dev_put) to avoid label

Changes in v3:
- Fix build errors with non-x86 machines
- Used __initconst for apple_t2_devices
- Removed UEFI_QUIRK_SKIP_CERT as its unused now
- Used IS_ENABLED(CONFIG_ACPI) in tb_apple_add_links for the T2 part
- Removed !bid check to remove warning with -Waddress

Changes in v2:
- Used a less generic name for has_t2_chip
- Used DMI instead of PCI for has_apple_t2_chip to avoid PCI problems
- Initialized ret in tb_apple_add_links

Link to v6:
https://lore.kernel.org/all/20260730223435.2874-1-atharvatiwarilinuxdev@gmail.com/

Link to v5:
https://lore.kernel.org/all/20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com/

Link to v4:
https://lore.kernel.org/all/20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com/

Link to v3:
https://lore.kernel.org/all/20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com/

Link to v2:
https://lore.kernel.org/all/20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com/

Link to v1:
https://lore.kernel.org/all/20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com/

 drivers/thunderbolt/tb.c | 49 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..2534c6378000 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/x86/apple.h>
 
@@ -3305,16 +3306,62 @@ static const struct tb_cm_ops tb_cm_ops = {
 static bool tb_apple_add_links(struct tb_nhi *nhi)
 {
 	struct pci_dev *upstream, *pdev;
-	bool ret;
+	bool ret = false;
 
 	if (!x86_apple_machine)
 		return false;
 
+	/* Identify the tunneled PCIe Root Ports by their PCI IDs
+	 * on Macs with Icelake NHI's
+	 * and create device links so that
+	 * PCIe tunnels can be re-established after sleep.
+	 */
+	if (nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI0 ||
+		nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI1) {
+		const struct device_link *link;
+
+		pci_lock_rescan_remove();
+
+		for_each_pci_bridge(pdev, nhi->pdev->bus) {
+			if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+				continue;
+
+			switch (pdev->device) {
+			/* Ice Lake Thunderbolt 3 PCIe Root Ports */
+			case 0x8a1d:
+			case 0x8a1f:
+			case 0x8a21:
+			case 0x8a23:
+				break;
+			default:
+				continue;
+			}
+
+			link = device_link_add(&pdev->dev, &nhi->pdev->dev,
+					DL_FLAG_AUTOREMOVE_SUPPLIER |
+					DL_FLAG_PM_RUNTIME);
+			if (link) {
+				dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+					dev_name(&pdev->dev));
+				ret = true;
+			} else {
+				dev_warn(&nhi->pdev->dev,
+					"device link creation from %s failed\n",
+					dev_name(&pdev->dev));
+			}
+		}
+
+		pci_unlock_rescan_remove();
+		return ret;
+	}
+
 	switch (nhi->pdev->device) {
 	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
 		break;
 	default:
 		return false;
-- 
2.43.0

