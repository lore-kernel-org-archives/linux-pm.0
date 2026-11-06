Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957607;
	b=iyI4CH8Ubd/P7D8pOuZZUn9zKZvdlZSaCKMLhv9jdKEwjsR+gNrJlfzluo5Y0xRQmkT8
	 FkYLzi+F3pSFoW3lv5M3ZXfazIkwHm73Cj4GozpT4VKMbWUtaKO7SfZmfgp5YYi/yYjIU
	 QNrxSX+XdAtJU8K9fy3En+yU3e8WTcl3k/cfELZ2L9relV5bn59f1ny7HK/NYLYqK/HST
	 bo5cQFqW4yEgffIwGgPZ3aNSF3rkD3LfMNdrIeg20hEExQdU1Bpnix5OvENPJYrf2owYW
	 SkPOQXvjNNGN394xAQoktJZI3fQN0SNPPyn3OlpzVx0Y1EqhnN8AjLVEVgx+wUg1yzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957607;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=0RogQ1G8sFuPL4PUjnb7jbOVpQtH3Ea/HTCj2EHRcDU=;
	b=vXhsiNwtJvlIeDBI1Niwl2x33XGDs5AnzX4BEwYw394+0JS101C/eFpcNqa7e8/Q4Gz9
	 XGrAx/DDmFQZr7SfmRbcMLYJCeLiE439+LasfUrrjsf9rr85XCSFyCjA3cR/l2jf2hdrZ
	 hGlMlT/cwKvEIAJZM6mlAvRfbkWjEGSm4rHUdWmNsNJ7gNak/Vqbex1xqbpAUZLhn3aWe
	 LmAAypeJEzDVhnx82g75/npoUo09Us9+Iptwh+k+i1F1A+7cQHZ51cJPJ49Mt/GCFa2h3
	 uUUuabqGQUyAy3FNGBWJkU+mq24JAHogjPRMO1xBV34SJnI7r/UMehepfd6UDRvgVXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Uaf1vubf;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD916082BD4
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 09:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FD916082BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Uaf1vubf
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1DA1D4E413F4;
	Fri,  6 Nov 2026 09:33:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4EFA5FFBC;
	Fri,  6 Nov 2026 09:33:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3588103292D0;
	Fri,  6 Nov 2026 10:33:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957601; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0RogQ1G8sFuPL4PUjnb7jbOVpQtH3Ea/HTCj2EHRcDU=;
	b=Uaf1vubft392vPUEjlPdiMsZOXqUx6YcjaNdJ6p3x71SBq3oR9yiRAxW4XuNGO2+I3cy5/
	xCdXEiUPFsvXH+DW4t1Q0nVTKI9mTypDWwM2zzwnaZgSAl0YYQ4VEifZekZUbUwnYQ4I/t
	t/R9ycpAa+PqV1atzdc2SUaTRMl0AptT7KA/9SVgDXHIggncDS00AgGu3ewNW+2vXz8OKl
	7IBsjqnUA+9nOiMGrKu4PHINaP4cUqqWD58XXdw3HIYHRPXLziVVsXEB+GjZ++K9z9cowm
	2PCEOJ1VF7VPFaM//4fa+tRwJu4VfJh5vDEne/AYyFqPXTzqIUCURQPX36MINA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:20 +0100
Subject: [PATCH 23/25] usb: dwc2: add support for Metanoia MT2824
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-mt2824-v1-23-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
In-Reply-To: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?= <randolph@andestech.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Add core parameters for the Metanoia MT2824 DWC2 controller: high-speed
UTMI PHY, no host DMA, and no OTG HNP/SRP support.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/usb/dwc2/params.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 091bfcfef753..d6a6a581d021 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -303,6 +303,17 @@ static void dwc2_set_stm32mp15_hsotg_params(struct dwc2_hsotg *hsotg)
 	p->hird_threshold_en = false;
 }
 
+static void dwc2_set_metanoia_mt2824_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->otg_caps.hnp_support = false;
+	p->otg_caps.srp_support = false;
+	p->speed = DWC2_SPEED_PARAM_HIGH;
+	p->host_dma = false;
+	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
+}
+
 const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "brcm,bcm2835-usb", .data = dwc2_set_bcm_params },
 	{ .compatible = "hisilicon,hi6220-usb", .data = dwc2_set_his_params },
@@ -347,6 +358,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	  .data = dwc2_set_stm32mp15_hsotg_params },
 	{ .compatible = "intel,socfpga-agilex-hsotg",
 	  .data = dwc2_set_socfpga_agilex_params },
+	{ .compatible = "metanoia,mt2824-usb",
+	  .data = dwc2_set_metanoia_mt2824_params },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);

-- 
2.56.0

