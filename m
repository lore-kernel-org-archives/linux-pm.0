Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957496;
	b=tvnolRVwFqz4Q8iqIe+nGteQeQ9Q7spiPMTbBpDNbaWp7A8yBctu7HAJaPgSn8ENugZO
	 0Ll24JlRkOrYdpS7W9wIKGyKnthpgEgeY0U1LY2knTaM/eolEUD4qDM1fV8Nd2wEOoOIc
	 yK6suZIuD5gEzfNZctnQn5fxmR2PTnBmLaZ5gE+X3MXjPUqNqzuej7eZLyZIVJz6DjsGS
	 Y0l5gVpfYacaSoKihUaFmtVEkMt3jlUHoRO3bUjAt6pJi1F6VAN2FxC/uiGCKokda48Md
	 PVmjZ9HAVmIDOvTMIurLcPjAXO2T9/ztfkZRospoJrE2vZSxKb7PdziK7lYxJjqaWDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957496;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=dGYVs8TEgGGOAbRpdMbC6rjsIyrgh7PeAJahuuixs7Y=;
	b=cZ0lCgjB7tU64WGXp+/OZcpibs3r/OsSCHeTbgA/I73EY4zbX1oQywWKt0LI7jG/UUbg
	 Lg3VyCV42VHejY8MlVlTGjk3dJnxjltP/qTOQkW93Dk7pwEDtNWm5cPoCW6xcx1UPbJJd
	 DAPSDRoPcj7of/HvItMyzOYF3JjLAV85ghKrw0u7vn+owpomjA6Z/Ldz3hFEBiz9OQoPQ
	 eh9bBA+K9xuLmkgJ/uHelLxNucM35/6jYO8u1Ni7jlEgFVmDV16RrlOqWtz7CAUPsD/jD
	 M4jS36xYfnAX2nlsWvyom2m53DWfSsthLebpmlKGdYwwRuCJJ58FssWSbWTXgjk6g/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=afgbf5zi;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44794606EE91;
	Fri,  6 Nov 2026 09:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44794606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=afgbf5zi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EC13D4E413E9;
	Fri,  6 Nov 2026 09:31:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEC8C5FFBC;
	Fri,  6 Nov 2026 09:31:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D770103292CA;
	Fri,  6 Nov 2026 10:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dGYVs8TEgGGOAbRpdMbC6rjsIyrgh7PeAJahuuixs7Y=;
	b=afgbf5ziCJaaBa6xX8Lhcriicf+ABvhzX1xI/3iuH1iI3bEnyB49sarXE2LXNlcaLL92pd
	IJ1hHRgtEDuTrTvdIBWMEOoLIvG+5ZsdzDYtUqxdPAQDIqYXFZ43DdC3zfOojqugJd9sCx
	ZgxroG8raOwWge2Jn+Sa0gyXkjTCWizM1G5OojdlmmmbowfI0A1UPnt0UNAuTbCMX2v8Oy
	vvwxRfy6Y0oCTcdBvw0VVZqQgQlBXOIlzDeiOmw2rpeiUxHlw6lgVgTf5BqDOGB0lHV/xR
	YgaO4Q1ns/9XXTaoHAJHJkmjxCbykJd9o8qyjjQ4Fy5IMl5LiLNk4j02Artfxg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:05 +0100
Subject: [PATCH 08/25] dt-bindings: interrupt-controller: andestech,plicsw:
 add Metanoia MT2824
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
Message-Id: <20261106-mt2824-v1-8-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 integrates the Andes PLICSW software interrupt
controller. Add its compatible string, with andestech,plicsw as a
fallback.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 .../devicetree/bindings/interrupt-controller/andestech,plicsw.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,plicsw.yaml b/Documentation/devicetree/bindings/interrupt-controller/andestech,plicsw.yaml
index eb2eb611ac09..a61fe7ca9023 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/andestech,plicsw.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/andestech,plicsw.yaml
@@ -23,6 +23,7 @@ properties:
     items:
       - enum:
           - andestech,qilai-plicsw
+          - metanoia,mt2824-plicsw
       - const: andestech,plicsw
 
   reg:

-- 
2.56.0

