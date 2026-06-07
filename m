Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C11370AC2;
	Sun,  7 Jun 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822223; cv=none; b=iyUYQNmxGmKbR6o1poNPGxowT8AnRKngotGqGTcjwZz9rOkM/HixZzA6zkcPxWx9vUaaDNQbd3QaePiUQ55mDbHThhWO34uEClzjt78BK4vRso4+995bFyKlfgjBKvTm1/KSOln0fvcpwfpk1Mam8lUKMC5fBey+8Te6jzYlqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822223; c=relaxed/simple;
	bh=zUgHmdCIbq96Oaq4a+AaK+m2Z7xxV3Y0tQmoT3nrPIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PGThXTUlMI2KsShfsvHIAUuGLnUbpZywKPRV/BgjpWY82P6kReNRSkiMZJ+QDR+7QpMfrPmY+9d8jJezhczpf1yCR2ay/wLAbWiix6zETTBPtp5ZTTiTK1n/nf9bJuNJUAMgWY4QGySCqyKN/hy7zFJ0+Mp1sdaORNXMaIzACGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=aak0GRcc; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="aak0GRcc"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DDC83EBD7;
	Sun,  7 Jun 2026 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1780822215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOpn8q/e9KDHjuTADsI/LP/WXhz5xWte6Jyh1YnSbuE=;
	b=aak0GRccrqSH+I7NJ9zUjiQh1v02aljznqVW+lXbVxHVSp1jJlll97qogw8PcGI+qT5i1z
	zDfgaR5WJopc1Vndt8oIncttXCGSHQ0OM6YhUOImhyJT9MEpQIWBV9KjyI+TfQG3NOofQz
	lXhXY6uM4fjTP1VUyUgQpyT9ZSnzCCO4xdAeDJN+jA1TUnmWpGsCvDBwRgHsw9bmmqAmBu
	TP4S0jDmmYOQA8wpmMcjEjhQyE9tD9PJR0GP98+hJCO0PkVXweSGcPGT/TvBlX7ZbPr4Rc
	3yJyELrR3wug6m1SIqJrLI6dKXr5b0bZAAbOUH23cflOGAJpdkA8p4P7JwCXFQ==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Sun, 07 Jun 2026 10:49:54 +0200
Subject: [PATCH v2 2/2] m68k: coldfire/5441x: register mcf-rcm-reset
 platform device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-coldfire-rcm-power-on-reason-v2-2-d0039d8a91e8@yoseli.org>
References: <20260607-coldfire-rcm-power-on-reason-v2-0-d0039d8a91e8@yoseli.org>
In-Reply-To: <20260607-coldfire-rcm-power-on-reason-v2-0-d0039d8a91e8@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780822212; l=1597;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=zUgHmdCIbq96Oaq4a+AaK+m2Z7xxV3Y0tQmoT3nrPIo=;
 b=S2X8D1QTDem3Xjm0UwPwHc3TPctfvrZpb3u4v7nUzpfehjTfunNaSDhZdDI2sxFkar6rPfCca
 MkSW1eQyIQSAGBAXoQ+6RhrgYTnyllAN8NMzkWqspBVQwTZrXBX6GX1
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Cause: dmFkZTFldwCH71C+v2YYvFuRL4mrh8ih0HMatuEUlJ3Jb/cmFklBaRSavyh1YvFiF13uJp7pcb0hhjGGR9+aRmIdVUYOKqU9+ysKpfF+qkHFgFhN5Y2g1j1U1yON033zyP26kxooifHuva0Dh1/cSBj3k8v/i6iU/aBsjID67dDrubDO/mcjKAAp1iULu2Y5YADlEtjFH6Io6GartUqzqR6GDCewy57W7pwMe0kE6OANwgkvaHWgdcIZW81GodCH6V2wTjGfvcAeDncZm7TUMmkXR3N17x2c6/ey5QI0LuYWsnv8hwWxzZbMhIXdkqECKbKn3LL+EYPqIW2UZ95+V5KzczoGjtNTUcbCuf3tkHNTlz63sglknGa55QKMI9+i177DfH3ex5Y2dpoAi+MX/eBtIt0aTJ3CVNwTF5wXesKD060zDBZglnhT2hk32M5DcQk56B3nsVEIncsIfP5+WIrOX3N3QyRjf//Svr3SybOX5iNmhgWeKLKOJhMFudJbev0vlR9uTUa7HThkJRvNkV5fqVLAS84PswKD5u07Hws9t5TLK3wjkZDlHylwSni7aXUhxdz4QiM2zjq42uvchEVIadlAZZ3lmEQHWqxP0nN4aSuJRnu1w3inz4vmResR0HEmqAhvPshmZog7IgOajHPyGcxzr6cIYci5PNJ0VKZGOBZ/uw
X-GND-State: clean
X-GND-Score: -100

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

