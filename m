Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794895570;
	b=rLTVDXALuvE48MhdC2F1LlL0n9LWZnBo5ve5OqGPvFlmWcJe44bNh0njWqK7Kq4Olx7D
	 hV+zDNDjskhmH7s/Ci+kCOOcp1yawL/ex1iOiX0WqtO5vPjk4McldWoMpqI0kTEZ6zKY9
	 h+DsHRbzZt2mWgiW/QMG5eg9m4yxkuZChA4AM9ORInhxXlXFL8pSQy2XF2q1XoFtK6swj
	 wjAqCyYdr+/gbW7rLT86zBEd2CRUJQzKzooW5sSqctndZJK0LdqscOYBJCheHZhuLKj0e
	 MuliMvDREp95/QFBtS3F2F4gJ2hKeM9Ubs3+OzbVuSyH2LzaIKKtbynAtyDU/4etC1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tl9vm/5oN7PPPGTUSOoXHW2ARgY0Relof58jU72z34E=;
	b=Ylzu5eZIK3zv02+PdQL008RZL/QR5Emp19znspqN2rcGo0Jmk6Eg/v/WrHcwbVCgftWZ
	 nt5inmzfA9n0bKOqp6LRQUuvHr2kZF1lLgA7VMf/cWlQLvbEYwyXiCEeC+hLT6RcG/IXw
	 YI9S5ruoHS4ey3QB4snJhJ9MEDDZXLVSGnrfkgLqLd47m/lOm9zRRKM0Nz3jW9egS5NKE
	 VQAFevsvXNP9hUPmiyI6yBFqO3g95u8bsNd9acJqD5W+/TxfrC+44iYabKKuwe5VUJvDY
	 VVJ1MYWSWhFQ65WCkJiI3WkIklCmY5KaX/mz4rzZwYxP9kybLVufd5ed8zuVnoBO3XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MxHopM0;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB1606A329
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93DB1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0MxHopM0
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso4003139b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 22:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794895569; x=1795500369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tl9vm/5oN7PPPGTUSOoXHW2ARgY0Relof58jU72z34E=;
        b=0MxHopM0RoBSrxdcP0gh7Wtc+00aT+pe1XFBwhR++vrkRR9p3A4+zNGV9iJYHboU6L
         hEyHUZ6hG2q/BZfuPXKczNao6M/nT9VoyuPZRju9iHOFdTbCAXI6yaVlNAKM2DAlCA3E
         OvE3WqiZxLgN6mXNYVe81Uor8ozSE245dBZONxyE2SX7Rb+NbSEbCM+kEOdpCououT3z
         QndBh9pTKIjQnK78uVltO8m0LZmGTnR7UPZQM8j0UtO3zNDWS1GSHCKcS4GSjMZE7hAq
         Hsc1I6obwUAVhlGHgy9S02gEJj9DoWIzLb/+H+qp5dMJ0ApHw+/as+AzEtny2xus6+rp
         f5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794895569; x=1795500369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tl9vm/5oN7PPPGTUSOoXHW2ARgY0Relof58jU72z34E=;
        b=HJ6VPDO/rpJEvFp+6uhDkEqidOJd3PgzuEZ5ziUuRwOc+vS5uCh0WecpxqRKkfb31e
         /IrqTmZsA5v+QGG4mRiRXTW5BBIvCpmdvoQQetsiL0lawJOEgxoU08Zsrfuu5R73uJsz
         McFlxsg1OUUE9+90MIV2dxt4WOTe32U3gafcOuOSx6UxcPbJoS/T9qU/D20m3kRRWaqc
         hkC0HfsiM8f+J791XYayGiBhuTzFh5pNuh7ETCHp+eQ4qJK5BzP8Vi4YFRQcviIE9KeG
         LFFKcPU9/BBVmVv71NSHSGssBe6hz0aG9oX/kxOtiYa2jh1yLKr3vZwphLglH1Tooc/h
         PWBQ==
X-Forwarded-Encrypted: i=1; AL+hErHQXC52lzhkCrtv/mScnm7UUu3uD4YoinIAx2nNMWlzf6aa1lW/Wftc87pHpXCBtBaFHgwDYi4gNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9XQd3ZFA10FVaoi6ltuzjSTrVryXH2n2h0uiwT53hFKAHkcnSA
	65c4RmdnSVp/dEoDRx4RIwz/u2GAvKeovm9BkMOXwyjV+b2H3HFmFohc
X-Gm-Gg: AYBFou1/Pv4Urq+RxYlpW+j6A/dAGyoSH//xnEJ/2pfrOy5UCAWnJ4+Pr9Z1n3/9u6J
	uLJ2s0sGYNdC2DCvvNrup0BTOdr3JHCLOUCXfUIckVtETZ1dwoLsHpBAQhjHFvqs83O9Tshj4Sf
	8qp7pblkJ+YjvCUlw69S8cFRLFOo6FN/y0WBwR7udm4SkYtgiDAJIOFPnQWEz6S74WeDlUR12bk
	erg1YZnzCvvFXCR3EoyTZ61WOoySQQSzbPBSOBHfp+2Sys8G6S0FyUSIHeZ5W8EuhIt3GgKt8FO
	BEr3F451/bOyaxDTwHy85bR7LnA/nGPwsEloWw0D0jCkoF/hjVYNZpL1tsgfUTUTQvVjWujb//R
	KYFVFVrKxtRE/YKYn2iF5csQ9pL7B5YCHOkC4h3RCakaFa+UnBHJQQ8VKFW88xeNgfahvR8asNm
	jhbqauracX/BfW80UON1MvopOzJ1fdOTs6r7/4W0o/KZzc+sHYxYmgeudwV9LR6AXZCUb82bne5
	CotyrBElwA6Wd99wXQQtsf/I11xWCMQrDzZJ3WbxkVU9ruGUML8RoLl2dioksNAmhzzWKAGAxsO
	mW87AgVtph3V+C9oWgmYACzxUlMDuRF7H9UjEjScSCqOcN6bGQOC6KaHhR8+nhZR231yOMuoiqG
	rRLkfz1UdD1M=
X-Received: by 2002:a05:6a20:a79a:b0:3f9:3f64:9bad with SMTP id adf61e73a8af0-3f93f649df2mr5801702637.4.1794895568851;
        Mon, 16 Nov 2026 22:06:08 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm4464623b3a.13.2026.11.16.22.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 22:06:08 -0800 (PST)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH 2/4] reset: ma35d1: Register auxiliary device for the temperature sensor
Date: Tue, 17 Nov 2026 14:04:59 +0800
Message-Id: <20261117060501.2611071-3-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117060501.2611071-1-zychennvt@gmail.com>
References: <20261117060501.2611071-1-zychennvt@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The on-chip temperature sensor is controlled through a register of the
SYS block, which is already bound to this driver. Create an auxiliary
device so that a thermal driver can bind to it without a separate
devicetree node.

Failing to create the auxiliary device only affects temperature
reporting, so warn and continue.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 drivers/reset/Kconfig        |  1 +
 drivers/reset/reset-ma35d1.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index eda9c698a95f..cf42fd6f7a3c 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -220,6 +220,7 @@ config RESET_NUVOTON_MA35D1
 	bool "Nuvoton MA35D1 Reset Driver"
 	depends on ARCH_MA35 || COMPILE_TEST
 	default ARCH_MA35
+	select AUXILIARY_BUS
 	help
 	  This enables the reset controller driver for Nuvoton MA35D1 SoC.
 
diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
index d2962c0c80be..8c82175d7466 100644
--- a/drivers/reset/reset-ma35d1.c
+++ b/drivers/reset/reset-ma35d1.c
@@ -4,6 +4,7 @@
  * Author: Chi-Fang Li <cfli0@nuvoton.com>
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
 #include <linux/container_of.h>
 #include <linux/device.h>
@@ -218,7 +219,15 @@ static int ma35d1_reset_probe(struct platform_device *pdev)
 	if (err)
 		dev_warn(&pdev->dev, "failed to register restart handler\n");
 
-	return devm_reset_controller_register(dev, &reset_data->rcdev);
+	err = devm_reset_controller_register(dev, &reset_data->rcdev);
+	if (err)
+		return err;
+
+	/* The temperature sensor is also controlled through the SYS block */
+	if (!devm_auxiliary_device_create(dev, "thermal", NULL))
+		dev_warn(dev, "failed to create thermal auxiliary device\n");
+
+	return 0;
 }
 
 static struct platform_driver ma35d1_reset_driver = {
-- 
2.34.1

