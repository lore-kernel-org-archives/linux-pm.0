Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957577;
	b=sJu6wPyZnzwY5UJyFptZYhfdnj684wolaGDiaWLUtyZPwq65Pn6ianOXE3phlYhaMIVp
	 HzK1sSc6V8jhJ9e5h6kKS72cbhlmP+GnhcjLshLb/fzDoVtJnWqj8YR1ZavwIhkwAb76v
	 ZHU/GtR7h3EE441vsnhKavYJ/Sr+s3ryK+j7w5kfX32x1QN64NhRmHqSLX+7yIBQLPxfr
	 y/ZX9daq7E10K+mPPsKNyQJy1O5jify50FH4J26c+MOOutgBHkdnPAVkEmPCJZMFqV/XK
	 580E7bS9/EBXVVdJwIH1bKu+73MuCDwzqV68ylb/+qck/5VIplIFonQ1YVzMzeRanOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957577;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=2eLb4/hEalOsNDyuK5k3PlmAjtiGDb2pfVtc2bnmxwo=;
	b=dnZMSvXmMz1OOeT4bZbF1jdlbw50ZwMbzqNvLNlzLYOhokRKhakqV4qOLmSmzCHsKd37
	 gtSH6vCSaQrP6VrXPwWKfkIpIvSzqGPIBYlw5dcLRE6LCxIB7nQF1w6Jf+H54LXpTYbBz
	 UnKgCJgmtFhgr7RyIFv/XAz8exoZP7F5Nt9ufP8CcC+mOdYdZwdaCjj9qRIea82TYn0BM
	 tiLq7y3MwgeP+w6gnBSmPbCmhS4LaSQbZnPDF5D56zT64l+Lh327kBALmWWzgkd+cIYha
	 Eu7wPNoNSu0N5BvkisuRBkMhbjIDRo0e+9CoazA+BZUs9ZA08RetP2M610CNfrUc/pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Aii6yZfC;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF1606D829;
	Fri,  6 Nov 2026 09:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DCF1606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Aii6yZfC
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 083911A1350;
	Fri,  6 Nov 2026 09:32:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C88D65FFBC;
	Fri,  6 Nov 2026 09:32:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D245F103292DE;
	Fri,  6 Nov 2026 10:32:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957571; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2eLb4/hEalOsNDyuK5k3PlmAjtiGDb2pfVtc2bnmxwo=;
	b=Aii6yZfCIFCI0GXPg8OhujaaRz8LvHYfq/WVQY8kq/0GFAavkecQEl59l9jBcTVDT/7y1T
	bgRfKxIE91ytduKR40xbBUZ72QfMzZI0gv0z7A2iiwLqC8z0Y2bTTIARIRTdmtkf0J380M
	XWFj37mrCCfsxxZ/u9O0qSwwlwubRG+10r35mMAaSM0gHJ4rkjiN8O8Bsic1jvQBQoDcgZ
	C0o8c5xi4LsQS27x/tV7lQ+fqwnOhA8b816EUHw6+DGCIvrDES5BO7wdIoXrtaRlVx7bpr
	buyhkvgx16/PDWR6uAP+2Rf2SwoIfPJXBaMdPGmZCOLvhRXc/AlSKb3RuKRoyA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:16 +0100
Subject: [PATCH 19/25] watchdog: atcwdt200: allow building for Metanoia
 SoCs
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
Message-Id: <20261106-mt2824-v1-19-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 integrates the Andes ATCWDT200 watchdog. Allow the
driver to be built for ARCH_METANOIA.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f7d0a0c2c0ef..2499a6612f85 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2148,7 +2148,7 @@ config WATCHDOG_RTAS
 
 config ATCWDT200_WATCHDOG
 	tristate "Andes ATCWDT200 Watchdog support"
-	depends on ARCH_ANDES || COMPILE_TEST
+	depends on ARCH_ANDES || ARCH_METANOIA || COMPILE_TEST
 	help
 	  Driver for the Andes ATCWDT200 watchdog timer. It provides access to
 	  programmable reset and interrupt counters with clock-source dependent

-- 
2.56.0

