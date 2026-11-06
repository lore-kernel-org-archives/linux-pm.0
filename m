Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957525;
	b=jwtj/ZaDmCFEwQEo5G9X+D7UXnIUa+rFhd6Tgzl6cNKOFpaxu0XvIZJvvRCuhw3dMgat
	 zFqqVfmNTgoYrl+zWrzzfKzJH5curl9+0ZJnz35Dq2lcnlmq6iH06yjyJlhAO+sPIRmBE
	 u0HAY3Yh8BpVyfIJ3LOqHQTd+5/16Ncm9LIwTsnfO5dttyQkYiUtUsW/e1fxeYvHSsctG
	 vLe2lOac+65Q+JsOrnj5CgXpAWKhE7YqTElE5QTJcRRqd9N8kcGS6DBuoAZ/aoHZmd1Jv
	 wm7tLTEbxlxHEXmMuhTJeVB15rT7Z9vpM++bDy7ceBe8giW1Bq0yGz5tujow1jecS7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957525;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=6dIjK3KQyPYo7BGeihqe5v2Q2WzvnIFuvucFmY8UZiM=;
	b=GiOh4dmvGAHTFwzf/PpC4fA0jJaJKlH2RDX/WCXtQc2z0Kp9ghau2cq5ItRdfhcYHqxI
	 fUOzpgttKRzmX9WpWE5MoIZDQBKv2ZaUPsCuoUac8XWOhxPZ1zeB9oafn8At+3R+oXDhf
	 MXFN05aepx2aRaAhflm83frN0RuAPMQ/NKmkk4oI8iGktQu63KGxItEUqx/EM0iL/aRdA
	 E5QiyiD5cCldfEEJXwyEIXgUtTtEulQmb/I5bIx/Ye2E/QcW8xS372eOlsbfJiepvq4em
	 jjpmG+kL3U+DhmZekhu9YLVg5ej+Pdzvq70edUk3Ni3CUp1SmaukX/KfQW5Ea8la6tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wzk0AKUh;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C2606EE81;
	Fri,  6 Nov 2026 09:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB9C2606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wzk0AKUh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9CB8DC69166;
	Fri,  6 Nov 2026 09:32:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 207F95FFBC;
	Fri,  6 Nov 2026 09:32:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC820103292DF;
	Fri,  6 Nov 2026 10:31:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957519; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6dIjK3KQyPYo7BGeihqe5v2Q2WzvnIFuvucFmY8UZiM=;
	b=wzk0AKUhHtXWvefoMAkphBOjTffVQzMnfddS4ZbG16AEUdu4SGMZCgxM1nEu40Kovb0ZbB
	iiLRa03CunEJO+Gevda0SIEUaPwlx8z9towgjqw1NDpmIbPJZPdFIs6dpV/D0R2jjvZUsY
	6sf+galb57+IV19d56T/C04vO/3WBIGf93TBBVoy1qHZAn57/yK8985rTav7wfm3pB4ew4
	Tyb9hTHbz8Pgu8snCkrUXvWIhuir5xo/wPaNKJg9be66FdvG0Wc1+G9ltqQZ/YHxpb74Gr
	8KVzL7vI6mKbgG14ahBCIhzqaxnuCA440p6LVcxQKW3fJ4nbA10u11XVAvcYlg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:09 +0100
Subject: [PATCH 12/25] dt-bindings: spi: andestech,ae350-spi: add Metanoia
 MT2824
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
Message-Id: <20261106-mt2824-v1-12-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 integrates the Andes ATCSPI200 SPI controller. Add
its compatible string, with andestech,ae350-spi as a fallback.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
index 91e04f5d354a..6e5dd8175aa9 100644
--- a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - andestech,qilai-spi
+              - metanoia,mt2824-spi
           - const: andestech,ae350-spi
       - const: andestech,ae350-spi
 

-- 
2.56.0

