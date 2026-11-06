Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957503;
	b=yQZc5tpzZnSupeqduh8vPH4msq/75d/wTuhvlNSiSf/DKXwPKTMgC2H+HIpWtEFL7MUv
	 5B8YD6U2mZPlUCZg9MMGGqZ8NFa2ENt+akC3BBO31rq162BfQVtmXRofFGKvB+PGSt4r2
	 KXV65Y/94QndXCr8OO5oZ2i3l7QBxUCJsVvcjzKRO2Od7Cnv3bbBRKZHruVOyI7JWl1H5
	 0qBwSNjse250pjlZl5CI7N6TBJ0MoCK8SVrohFbMz3vfXn1tFm4AFAFLbcquadQS4+qze
	 Eyoeo6ODIi0PQ147PcOUqEZyWGjY7lXI9w2SQHmk5RD0bVYN4yvTZ+91IRm6NrPZV8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957503;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=2RPHFJlKoNUsrHhH8iiJsLuk3l1owV1sHk6Qha4yz5k=;
	b=F1pb34iUIUHGHiwfB2HO9Y/MxzKjC8cMmUEJR6gMPhJEGPtrY6JgxZXDma4iWMh+2ZZp
	 XL9Q8RRKCDe1kcl6ViF3mvieaNtLUPuoQio44BPcGvVpihpYbEKn5KhyuKZlllIrRzWOq
	 N5/GKB8f62YlR/snUYOkE+2KtLZes2PJh+o7/11Q6daXvxJnGpyE3cW7HvsYThgTe+cCD
	 ODHb1muiFmdTQG+/2yiAfbabJ1Y8pNMgFmtILpZkq/ZvIUdUt3xYgiSq51NKVlqE9zf2O
	 MK51O+ZaGkpJ+QpgC7mUAKHl/vnenuwMXrbnEUoJMAZtwlV0h2+nMGSz4ZTcJRFarVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=spH+nNJF;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E99606A338
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 09:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23E99606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=spH+nNJF
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C74AF4E413F4;
	Fri,  6 Nov 2026 09:31:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FF2F5FFBC;
	Fri,  6 Nov 2026 09:31:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFC16103292D3;
	Fri,  6 Nov 2026 10:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957498; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2RPHFJlKoNUsrHhH8iiJsLuk3l1owV1sHk6Qha4yz5k=;
	b=spH+nNJFFWCk19pHQNFzeMXVYdz39HUw/xGPcL2RmGUcas8FWu/FrKGp1YJWp9pAkfBrTN
	Xz/J0Wdrfh+ohhqZXFioP2ukCpe9BcRFbRmuHpvu1qgkN86CxlD3rlMZJF8aU7fKPOvlyX
	+AlqvA2YrULh37P1M0A3dvotE5JfL1qA/b9gDf1ohphSrOV172IJGPq0AGQOfkj0I5E+6u
	J8hwOYXy6k6/Up48ENjrEujiKWFOpQ9q52jFEQtxzwZ5Ap5g6WZq9JOFlRBeXNlv/PINvb
	H5QhvvrS1vTNsBfbvuryQ7ZsEGN4hEgVNsbTxmz2AAzX/5OGCYVapPgZicX3nw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:06 +0100
Subject: [PATCH 09/25] dt-bindings: timer: andestech,plmt0: add Metanoia
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
Message-Id: <20261106-mt2824-v1-9-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 integrates the Andes PLMT0 timer. Add its compatible
string, with andestech,plmt0 as a fallback.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/timer/andestech,plmt0.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml b/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml
index 90b612096004..b33350cf43a5 100644
--- a/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml
+++ b/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml
@@ -21,6 +21,7 @@ properties:
     items:
       - enum:
           - andestech,qilai-plmt
+          - metanoia,mt2824-plmt
       - const: andestech,plmt0
 
   reg:

-- 
2.56.0

