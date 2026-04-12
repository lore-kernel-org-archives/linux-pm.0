Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA115382383
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028818; cv=none; b=NNJj8QVpJlYqPqc0KjgEOZDZ8f1TtNgH8FhnMeofQyk4sK3WWK60jp5LVxuAsjwGiHyX0b+856o6BtvOq1vzEVu2mFOH/thuwa7tp3VCva3p8lU4MRmUpG1gDMd0LSHmZcNFzGzYm7vxCDRwsPz69hLh973Iu+veyBaonj3o8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028818; c=relaxed/simple;
	bh=42F6utcKd3gLqGHgRReG79dhQyNqoIpXviS0dvCDzbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWNtAQH8vyeFeSzED++gw8CYyhA03vKBwEC1vLwRP4SQdZPVCYU0sCTgkwOXdGxVqvge/LZyWmVIj1hBYhrvmINxGqOu0eHNgJdOywZ7IzaIdqZZFc4zK5jD9E+bRA52Fxy3z/C8hEXjNoPzuHHpDhdksP/mpQcWQeEj6IAgKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdaJ//xx; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdaJ//xx"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1623990a12.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028816; x=1776633616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUbjFnD1QMPjMsDMoAjk9FSJkr+sca4XDIBykL3ZmcA=;
        b=sdaJ//xxCKaVF3x0ym6U0sE56usfrnQLOOtmONni4qb6kDTwzAh7DQAZYQgsp5+7lL
         nDfVw842hL/VuXGYaDXX1gdoCyiQx9OTulXdjGUSDnFoBjPNB4XqBd9iICy/0/RxfUWd
         41m5lEw7wnkS4Azr9RXV7J/DpGnH073M1tKpJMbl3c81dMZY7Y0pWS2bQmkvy/iiI6Cd
         0VmBMgglQjgxb36Mt5Rs1OKKl2L05lmMwlgPg+KcJHyknUPvL0M1+WQvRzut0Yldh/jA
         GPw0UuRkL7OSL1S6f0NaHwIPgbiNrsm1/rxjZbWt35jS7WkDk8V4oWXROO3elP0ScW8c
         kzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028816; x=1776633616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LUbjFnD1QMPjMsDMoAjk9FSJkr+sca4XDIBykL3ZmcA=;
        b=lJGa7pfpQ9wQsBybLO02iWBv8ugn121y0OddBRbACr1ODvobJ69paAta+sUhKv2pTS
         ZRr8xewEiy79KW9Y0hpZ/PXIFwnvJZGTcMH5s6rfKDFb38egID5Ur3mSCWiepGLYxrBA
         azhCDaaKhkmhwibyiEiKfj7E82FDHE3OL6M9OCdbvZHh9CCaR714MqCt0xqK02rJp5Hq
         ljM9R/Jv2CkaR8Z9HKoeG9bx4qDkmYErxyKqfOnta7unsguG3w3Njnl7mV9/wd4ttDsi
         plAEbr1rdKGiPekSfdlaryv0gAr2ePM30Bdmb8EW0eBbFMX/sr0sdxpOuacX5Kz5rdon
         /0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUp8Az4kKVmcVP2j1nxAGvO8BlZ8gLnDJOI4PMIBG8c+uC1P0qav/TSVHZnOX7ONojSzvczcxs5oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+Venuh4oYzzNgqCE5qt4dKWJkSFHPLAaDElvOOz1uFnhSGWF
	Ej/Sv6DlqAHj8dUEZbTG2iQ9u2t3B2UJZZNOx3XCU8DBxFFlNr95J9sYNyjpNA==
X-Gm-Gg: AeBDiesLEXkMaVH/k3l3XKjqfsFbHXgbqHxKCzvzGMxCozI7o3eaqUNBTYwtn8QkMj/
	F83cur1DnAllzGw0CkEz2myM63eGReFZpfPayIOw/WbF2NeApNn2NYjK17eF8Wa9RP7p6km35GU
	CBMugAns703XaawvrzYsIeqi7WkHf2Y87Y7ZkJMMc65px9ZT9i0QvtXxuRGnuAX67I2EN2kfUoK
	PA6+AISvlIp2ZD9UQOxAd7WEmoADlMPqKT3BsB0pmq6Jk6X5zZMyb77tkMJUumtbEsXJOvEKBMK
	GHTeDp2006G6gFXbMwM6/liJgT1rJK7geA1szFsMonZC1XNYpcAetEMkg95OXhIVnY+NUrxlpKw
	iZhAVgeDxc5joO/YlLN4sI0BLd5UpMIZfGibj0Cf9ybbt8+UoER4d1CJNyX/l0rcFpMbwvUthWY
	vwh8hDzv7wjusAcNIXfB9ldl/icpRXCBZXkHvEUpUsbWxc96yp8Pp8NKFgxKN0EQkeo3yd4QkNn
	FU/8hIakRUEqFAjnE3v/luUFac5Sef9KOrXw6A=
X-Received: by 2002:a05:6a20:7d9d:b0:39b:7f5f:d58e with SMTP id adf61e73a8af0-39fe403e647mr11187464637.47.1776028816242;
        Sun, 12 Apr 2026 14:20:16 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (100.130.194.35.bc.googleusercontent.com. [35.194.130.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a3e6d2sm7615779a12.32.2026.04.12.14.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:20:15 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	daniel@0x0f.com,
	laurent@vivier.eu,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 2/2] m68k: virt: Switch to qemu-virt-ctrl driver
Date: Sun, 12 Apr 2026 21:19:52 +0000
Message-ID: <20260412211952.3564033-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260412211952.3564033-1-visitorckw@gmail.com>
References: <20260412211952.3564033-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the "qemu-virt-ctrl" platform device during board
initialization to utilize the new generic power/reset driver.

Consequently, remove the legacy reset and power-off implementations
specific to the virt machine. The platform's mach_reset callback is
updated to call do_kernel_restart(), bridging the legacy m68k reboot
path to the generic kernel restart handler framework for this machine.

To prevent any regressions in reboot or power-off functionality when
the driver is not built-in, explicitly select POWER_RESET and
POWER_RESET_QEMU_VIRT_CTRL for the VIRT machine in Kconfig.machine.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Kconfig.machine |  2 ++
 arch/m68k/virt/config.c   | 42 +--------------------------------------
 arch/m68k/virt/platform.c | 20 ++++++++++++++++---
 3 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index de39f23b180e..624e6b27f394 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -133,6 +133,8 @@ config VIRT
 	select GOLDFISH_TIMER
 	select GOLDFISH_TTY
 	select M68040
+	select POWER_RESET
+	select POWER_RESET_QEMU_VIRT_CTRL
 	select RTC_CLASS
 	select RTC_DRV_GOLDFISH
 	select TTY
diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
index 632ba200ad42..b338e2a8da6a 100644
--- a/arch/m68k/virt/config.c
+++ b/arch/m68k/virt/config.c
@@ -13,18 +13,6 @@
 
 struct virt_booter_data virt_bi_data;
 
-#define VIRT_CTRL_REG_FEATURES	0x00
-#define VIRT_CTRL_REG_CMD	0x04
-
-static struct resource ctrlres;
-
-enum {
-	CMD_NOOP,
-	CMD_RESET,
-	CMD_HALT,
-	CMD_PANIC,
-};
-
 static void virt_get_model(char *str)
 {
 	/* str is 80 characters long */
@@ -33,25 +21,9 @@ static void virt_get_model(char *str)
 		(u8)(virt_bi_data.qemu_version >> 16),
 		(u8)(virt_bi_data.qemu_version >> 8));
 }
-
-static void virt_halt(void)
-{
-	void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
-
-	iowrite32be(CMD_HALT, base + VIRT_CTRL_REG_CMD);
-	local_irq_disable();
-	while (1)
-		;
-}
-
 static void virt_reset(void)
 {
-	void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
-
-	iowrite32be(CMD_RESET, base + VIRT_CTRL_REG_CMD);
-	local_irq_disable();
-	while (1)
-		;
+	do_kernel_restart(NULL);
 }
 
 /*
@@ -113,20 +85,8 @@ void __init config_virt(void)
 		 virt_bi_data.tty.mmio);
 	setup_earlycon(earlycon);
 
-	ctrlres = (struct resource)
-		   DEFINE_RES_MEM_NAMED(virt_bi_data.ctrl.mmio, 0x100,
-					"virtctrl");
-
-	if (request_resource(&iomem_resource, &ctrlres)) {
-		pr_err("Cannot allocate virt controller resource\n");
-		return;
-	}
-
 	mach_init_IRQ = virt_init_IRQ;
 	mach_sched_init = virt_sched_init;
 	mach_get_model = virt_get_model;
 	mach_reset = virt_reset;
-	mach_halt = virt_halt;
-
-	register_platform_power_off(virt_halt);
 }
diff --git a/arch/m68k/virt/platform.c b/arch/m68k/virt/platform.c
index 1560c4140ab9..764f556b4b32 100644
--- a/arch/m68k/virt/platform.c
+++ b/arch/m68k/virt/platform.c
@@ -30,7 +30,10 @@ static int __init virt_platform_init(void)
 		DEFINE_RES_MEM(virt_bi_data.rtc.mmio + 0x1000, 0x1000),
 		DEFINE_RES_IRQ(virt_bi_data.rtc.irq + 1),
 	};
-	struct platform_device *pdev1, *pdev2;
+	const struct resource virt_ctrl_res[] = {
+		DEFINE_RES_MEM(virt_bi_data.ctrl.mmio, 0x100),
+	};
+	struct platform_device *pdev1, *pdev2, *pdev3;
 	struct platform_device *pdevs[VIRTIO_BUS_NB];
 	unsigned int i;
 	int ret = 0;
@@ -57,19 +60,30 @@ static int __init virt_platform_init(void)
 		goto err_unregister_tty;
 	}
 
+	pdev3 = platform_device_register_simple("qemu-virt-ctrl",
+						PLATFORM_DEVID_NONE,
+						virt_ctrl_res,
+						ARRAY_SIZE(virt_ctrl_res));
+	if (IS_ERR(pdev3)) {
+		ret = PTR_ERR(pdev3);
+		goto err_unregister_rtc;
+	}
+
 	for (i = 0; i < VIRTIO_BUS_NB; i++) {
 		pdevs[i] = virt_virtio_init(i);
 		if (IS_ERR(pdevs[i])) {
 			ret = PTR_ERR(pdevs[i]);
-			goto err_unregister_rtc_virtio;
+			goto err_unregister_virtio;
 		}
 	}
 
 	return 0;
 
-err_unregister_rtc_virtio:
+err_unregister_virtio:
 	while (i > 0)
 		platform_device_unregister(pdevs[--i]);
+	platform_device_unregister(pdev3);
+err_unregister_rtc:
 	platform_device_unregister(pdev2);
 err_unregister_tty:
 	platform_device_unregister(pdev1);
-- 
2.53.0.1213.gd9a14994de-goog

