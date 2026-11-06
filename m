Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957546;
	b=Pbx0+bDDL+0wG3Qwig2HKSykqDtQv2a5IOcyUWYvc9DjGE2jnkNaAu9Ig6gN7bT8uDzQ
	 iVZGBP+8mPdkJgaRjR1enkn6+C2YYZS++X7GXapZqjwALISXOB4jKW1jCXystqrIn3ieh
	 Mg4UHOIDsyE7UIS+F+xRqXX4Qb33YprnkpEi6kTNSn84j+SpTnDihkJV/rkC71LmsbY1e
	 ziyboOMYeSUYDrnDpnTU/mWAbNm3YmD60ubDpgmNgEBx8MdhXc6W2hM7bpRk9d/ZZugDB
	 O6aLrg8ZcaDdUpqwDfmfA78lhZ/gWKwfELArpjUs5jSYZnyfsgegi80SqYTScNMcJGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957546;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=5QZ6o6JjR9MBHdZ2umi91SU/jrU4YivF8J5ejKsH45w=;
	b=k8DNyRc55lOLozTcQHDhmBmJVCn1AWKeEnb93+mhISaqxOeYmK5DQwsLDJZQ/+P2dz+G
	 FONQSN6NPZxe+Ctn0n9EZkECKnVIi1cN0eSSYKLblO5zwmmWh6ZtpXAXJq9TurEjBePbE
	 llGVaxkM2Y25cb4Hfh40cX8qYtWkyv/xUNJm1fVQkbuwzy/i/rdZMM7I76NPJOjitOKb7
	 EnNMZOalscAXJXOGYe74JTz+OE7MFGIP8DpAlInKSttvZls/EKDvMQ8VMNRt6H6WWkVmT
	 b163YUyXajb1B6kiH/o1yHxFk46Do2VB9h8V0t6QM69Mkby481n2lvRxCU81CZf+6Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IyJLimh8;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4B60A260B;
	Fri,  6 Nov 2026 09:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E4B60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IyJLimh8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E407BC69166;
	Fri,  6 Nov 2026 09:32:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67EDE5FFBC;
	Fri,  6 Nov 2026 09:32:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C438103292CA;
	Fri,  6 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5QZ6o6JjR9MBHdZ2umi91SU/jrU4YivF8J5ejKsH45w=;
	b=IyJLimh8+SZ5sqvGUtTtXYTsCrpfgNc4dWN6JZQiJzzpRvgbbD0Nup/ckVV9Rcly44soUO
	sR5E4Z8zF+hM+ifrUztJUoZgZWKaB2m+9wOB8Sog3Wcuy67+yS4G4tsX4GnHXNkYJAUUM5
	EiWnGp14xQ1tTa6iG1jPcC52sqDl7Y1RN8rgMvHB5WByDmJ3g6RrbFk5DyHjtfNevmr36c
	PdXR/nVzmrVhr0wds8GNIhXz5ag/a6cppMFAOUXa073e7uCHBW7oQkyzkiT7FjnFI/EzvE
	IIDGJQgklNcxSbfqPZTEmdpzT4jeppEBjjkUbVzkf57JQMBfmobNpd98/UGj4w==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:12 +0100
Subject: [PATCH 15/25] riscv: add ARCH_METANOIA Kconfig entry
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
Message-Id: <20261106-mt2824-v1-15-86087eaf5af4@bootlin.com>
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

Add support for Metanoia RISC-V SoCs such as the MT2824. The Metanoia
MT2824 is built around Andes AX45MP cores, so select the Andes errata
workarounds.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 arch/riscv/Kconfig.socs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index cecbce0c4983..adcb10bca966 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -18,6 +18,14 @@ config ARCH_ESWIN
 	  This enables support for ESWIN SoC platform hardware,
 	  including the ESWIN EIC7700 SoC.
 
+config ARCH_METANOIA
+	bool "Metanoia SoCs"
+	depends on MMU
+	select ARCH_HAS_RESET_CONTROLLER
+	select ERRATA_ANDES
+	help
+	  This enables support for Metanoia SoC platforms.
+
 config ARCH_MICROCHIP_POLARFIRE
 	def_bool ARCH_MICROCHIP
 

-- 
2.56.0

