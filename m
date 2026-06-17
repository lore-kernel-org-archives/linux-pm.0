Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B23502A7;
	Wed, 17 Jun 2026 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723868; cv=none; b=okQ9+4geRLAic57rOSyR0cYAEFYTY09Gi61f81If5v9cidEQs/R8j7/fjjh0xtk2b07buDbE5Dk6bWDkZvTgHb0fH5q+rbDVcgdCZhBGcGNgVk8lcNtWkoachtjzy5ZguOUh31OIwlqeTox8Y2hBelp8kEqNVueI6Yn8v1f33bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723868; c=relaxed/simple;
	bh=zUgHmdCIbq96Oaq4a+AaK+m2Z7xxV3Y0tQmoT3nrPIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLWxgCzwtKjXEujvci4qpJib/HOvY6EdG6IOFGf0jmSPRusUhoBWoF/rk/Q3fauplfh1OfaTMj8VqoccjU6vmt1GM6esYZhJiN6muh/wOo2hwMnfiKSQKk+m6M7q5LDyReF+zgSx+9enrU8cAZ+MRTnf/YtGdLQjGKlNgzDnZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=gm/0Qed2; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="gm/0Qed2"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E50AE1F75F;
	Wed, 17 Jun 2026 19:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1781723859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOpn8q/e9KDHjuTADsI/LP/WXhz5xWte6Jyh1YnSbuE=;
	b=gm/0Qed2LV8sM5euENZAqjBQ9o6bHxdANG7jCVZ+/k0bWLbS3nYMaLnFQL/DMp7Ek99xO2
	YOErxPTnf6fKnCURpkpxasVHmjDK7bf8ViJzDMw2Q6rkpE9X88nBnODUqTW9O/yv9MmUIK
	D/ZVGbHf4eTC6W0xgH2WHJHTrr49wZmNQWMij4M1h0viJTedEhCBFUrJrAtyklM8ejV61M
	dYbdDclJeilKO6ifmtiHVKzDn5XBoYDmz4iPIAszjqwzDuwDhu0aohGUy82eaw4LJqIjWB
	NU84HyNAI54Or+EKDyuY/qAL95ggUTOjvPPoFBJ9hAZLlIgydfGxv6bQa4TeTQ==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Wed, 17 Jun 2026 21:17:16 +0200
Subject: [PATCH v3 2/2] m68k: coldfire/5441x: register mcf-rcm-reset
 platform device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-coldfire-rcm-power-on-reason-v3-2-1a7c7b6b14e7@yoseli.org>
References: <20260617-coldfire-rcm-power-on-reason-v3-0-1a7c7b6b14e7@yoseli.org>
In-Reply-To: <20260617-coldfire-rcm-power-on-reason-v3-0-1a7c7b6b14e7@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781723856; l=1597;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=zUgHmdCIbq96Oaq4a+AaK+m2Z7xxV3Y0tQmoT3nrPIo=;
 b=0NZMmLgrSIn/qI+zDkh8iyjKNFX3xLJ+mM0RqopurXLKUlLPT8Dzd58wHyPo4wJDHOmcg2dNE
 jMktL8HvApyDtwO/99jFx5AUuNQY0idLOQo0VhNcNnQKgG4P8moJHec
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGGen1Aoh+3Xbqx0LsZbbSCz2aEJthWcpe63xc9fiELMZSNbfcy0ERPyYIPeQ9uk4trfHDqLOHjsP8LswY+yVaUj+JNuXDHZ40gv6l2zUiGZJVhDPMzjC4UxDH+imOB3MwsaNQBMvsxrxJnA5R1OpZYtt3a5GuQwSpvObNJZPOL0ckLh405340td3Ut2N6Ii5b7sxAiTwH85EuOgWyFucQV3FO07ZixgE7o2i7EirLtDs6RkQZr6bgRwmv0Y5nzUSy4k4HNKLq+yemOSieB8EiXeiPZyKjqUNEEcHFYmincN3jT79+TgfSRyA4Fcfo7ad5AOtGdzqUqkV3hiABnwJP2ZSaCMaci0KRXjrY6tnxEHLT2zLU0/CJvqV3GvfEQQCEnqoe+/P1i5k8lyxJN723/XA1XGzCl7zwKBDzXbjqOfzPpCknvWppjoCmhCOEK4/1QGWq1ym+B+oCZwQ5pqcuRpzvAR4a4nfSQuyA5G5Bnm/ODNzm5ifOwWRZIdk7s+gJgaJzahJKbEylIQexrz914ryiGLuS2FJ/2JAW59WaHG61LUjH8wjpM4clOeNXs30byU8q+u8MkGZVQJuK8LnRS475DHyXa/W2UEzzJp3nfQPBuia7gNe/E5p1Hp8h3GuF6Bj3Eo7cqe6BNPjPTE8wrlolKUQrKq7cjlHoctICeNw

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

