Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E43C9ECF;
	Tue,  2 Jun 2026 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392130; cv=none; b=gl8qR7XVdE3e+T6KGA/bVb5QO17OSNmtToW8dx0Ol786vnDstwTnnEIpiG9vkrc5bM7oQbrfQFD5W+RNdCujqqkJ0eHqxSmFqx0rXJlpY0mSAXq8UtWBIEIRmn/PT08adbVerKpz0Q4XFVyYYKlwtEDLXgkbVAYLPIKN9/4kPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392130; c=relaxed/simple;
	bh=zUgHmdCIbq96Oaq4a+AaK+m2Z7xxV3Y0tQmoT3nrPIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+7Gd7+vN7lDectpRjNP+wsoAI5WiYNG9LuYQFPOhrRUz3J1BoQgnOpM1lFqvSy/umq0Eq240Tsq6rn5NCa5sJNZZAeDzxUAZmrrDPTyy8VFMVWzYouqPxQdLsutfy16VDPz/IY+r2sSGOt3DfJ9BQn29ae2BhY5gcDcNdUwXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=TYod2iAH; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="TYod2iAH"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00B243EBE0;
	Tue,  2 Jun 2026 09:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1780392119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOpn8q/e9KDHjuTADsI/LP/WXhz5xWte6Jyh1YnSbuE=;
	b=TYod2iAHGaFmX8gfGvZVQ9kS/3H06D3Lie42aI5D369agC40q+7iDRRLXsXd/5mFXJErRA
	iIJrpQl9LgIUfkZagqvCV4JsP9g7axcSnPCA2pENbq3hnN7g+MzlpUqiaWplB4AZ02vQDb
	WkJ00xaAM/zHB7Fglo64yu7VNXwdR6pLuRpblbLDqpP0DXVMV8mL7NjOdeQ4QpQ3RakTcv
	zixhVmbWbuSD6PE/KMrQjIoMyklsr7J40gOmq3/OQ0kyTdr8qKvA9x9F4eyDTEEZDNW7i8
	LgFp1OVdlHpQpYK7D/g6oMpDM/vVBQk1JYYzBIP4xXSHaNMmaTlELX2uICpo4g==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Tue, 02 Jun 2026 11:21:23 +0200
Subject: [PATCH 3/3] m68k: coldfire/5441x: register mcf-rcm-reset platform
 device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-coldfire-rcm-power-on-reason-v1-3-fbc3eab0c016@yoseli.org>
References: <20260602-coldfire-rcm-power-on-reason-v1-0-fbc3eab0c016@yoseli.org>
In-Reply-To: <20260602-coldfire-rcm-power-on-reason-v1-0-fbc3eab0c016@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780392115; l=1597;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=zUgHmdCIbq96Oaq4a+AaK+m2Z7xxV3Y0tQmoT3nrPIo=;
 b=5SujqjGuJ0ghK/9aLkOXppW/AYn+1grWT+QTEQV8r6qarRLCk+sNCDH0/NFi70DO9CJwLDwzE
 cpp9BAjQZBoDWr6HSU/Lgi+dNxs91aORzMzhqxMjq5GQwCU4VciO6iU
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGZnDm+qP+IIE8q7fl0ylzs7vW7XFxPlmP9Riz87oMhwGzvZZIRYplOiORTbDN4OXFi+K8S2y2wJ8ELCaUF0EYbuKfNpj66kov/TBETXf91nZVoCTSEd5oiOHPUy0ZWxAVHyVHYvFebNY7AvzJ3lwSgiyYVHRb3qBly/HEuWT3b0eg/9zAdM6HpyoKevIj6OrQ2Vd9YNKpuoNFww5O3G3J2pO+gQsOqZ+sx23SLGeri912Jce4X53gaqVGP0yw+/XcvDwx/KK9V/NlfOeLQ9vLhwxat1T0K1eM8xFbdboKRCu6vrqJtqumZptPM87DF74+OnKHNzc5wncqIWGB4RswGrNy5/V7KkG01X2H6Re8QL47+9f4yIJff4dP/ZtjYCPzFeUnZ6qVdFCTtAV+QycL4uZowelxbQ0vaFmHTJk8nvQt9AsDr/nNi4WIRAc5/C9m9gSYA5alUOnqCZuTfH17nDvSPye03ggPpkDt5mCMOtWhSzTscFKaOkQiFmc2TIriqYZE1WY+yh2UTwdfp+M/UTrAgRmoUe8gdLSJ5p0auJCcOxGB63bWqk5D4aPJcAA9fXwSJ9CvkJRsZWrmstFQbuE91GgFhgjZrlOklTWX0sL5yF9P6USgDD/jaGOjIiQN1XCspJ2NxFYu0MU9FkVRUEuYXg6OZOOkSSMz0Iksyvw
X-GND-State: clean

Add SoC-level registration of the mcf-rcm-reset platform device so the
power_on_reason sysfs attribute is created on every MCF5441x board
without per-board boilerplate.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/coldfire/m5441x.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 7a25cfc7ac07..852e52d95eaf 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/platform_device.h>
 #include <asm/machdep.h>
 #include <asm/coldfire.h>
 #include <asm/mcfsim.h>
@@ -239,6 +240,30 @@ static void __init m5441x_fec_init(void)
 	__raw_writeb(0x03, MCFGPIO_PAR_FEC);
 }
 
+/*
+ * Reset Controller Module status register. Exposed to userspace as
+ * /sys/devices/platform/mcf-rcm-reset/power_on_reason by the mcf-rcm-reset
+ * driver (drivers/power/reset/mcf-rcm-reset.c).
+ */
+static struct resource m5441x_rcm_resource[] = {
+	{
+		.start	= MCF_RSR,
+		.end	= MCF_RSR,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static int __init m5441x_rcm_init(void)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_simple("mcf-rcm-reset", -1,
+					       m5441x_rcm_resource,
+					       ARRAY_SIZE(m5441x_rcm_resource));
+	return PTR_ERR_OR_ZERO(pdev);
+}
+arch_initcall(m5441x_rcm_init);
+
 void __init config_BSP(char *commandp, int size)
 {
 	m5441x_clk_init();

-- 
2.39.5

