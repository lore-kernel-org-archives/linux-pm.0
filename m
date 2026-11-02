Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638230;
	b=UHhhPPW6RnYkRViijzA7oe+Hc0ltvKbv34sCM0YfpkD7Fl40LM3kKPPfNVh1XaTbTg51
	 SqUW30ebjf6pRHXp1kPBIZFY4NlXvMuwylgRGmgPALq22Y3Wcgb6InesMv8glffKNm2q1
	 4L3ybIKGb3ZD8uE9rMw2AjRSv0PP2UEyR/fD0ZmUHmU2s5wK9tLsYLkjT7SE1oRtI7AGE
	 TIQZDeGMPOou3uIlTAODn5976oTVoyNYwlSwQtJK0orVjir51mFmRJ2MR/GOMY3vPjOF4
	 beg+DLKR+LEWdK03h56wRvr2MBeMNV9UJkI1HuTR1rGl5/4f7W7+TVIocv8sIzb7mOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=KTg+Lt8n8cyfd+bzP669ss9gAVOsDYk15W0k0texwBs=;
	b=z6UJTbzW5hBvErvt3GGTix2F/Jf43aXG4vdr/DyA5nGlTzDZXkOBMSZ/WI8Fi2bo/oqM
	 3g7XmOwAUpw2/2WXm/bD5s+1x61sDcVMuER7S++CPHawKJS2lCRGgUGaH3n+vQRetCq7n
	 HTPVEky7VkksfAoNA4pj9cNXMG9UdiqE71K+DsTltLuLyPR8PA5SVj9UAykODxY9O44WD
	 Ol60gZX7M5+NpU10HICuc5pF0xg2KcoFpSsie5x3y2I20iaoH5RC86Q5hzR/r3UsZT9cT
	 zQXCo3hgoAlWrc12+8KeZAecMpf/cyAuZKSKWOBQxD8ZQzxl7CHexVnwG3Kc05K65iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0v6Qu6l;
	arc=none smtp.remote-ip=74.125.231.128
Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811646074648
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 16:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 811646074648
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0v6Qu6l
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-84e8a9fae57so1646870a34.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 08:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638229; x=1794243029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KTg+Lt8n8cyfd+bzP669ss9gAVOsDYk15W0k0texwBs=;
        b=c0v6Qu6lGqB/NueLXwCJ0MbujVdcNa7sv9DyU6myuKFeILKR0PllAb1Sq8tx/QGgA+
         NfzxVnnoiyT5gmxc7CfnMxcRZR2u99gOm4l2mYFJFeqYNSQGiWexUrEDEz8OGEdkpXEq
         ZoKErvxvBrvSxkn7YsEsokpzcg+042WJRx5YAGJQrWn6bV+KvOgC4EVVfOPUiNUYc6Bn
         LukM0cKT66JMYkHQAqA9257BWRnPtp7rbFFfCjFLYmLDVNf/OvNV+iWIk1yUEbFUzQ6G
         DWK0oYFpNaRxMasT0Sevyqmmos593gnGO/7WPzOq44iH4+Mu/XlUFqRryRkhIdQ70iQo
         R1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638229; x=1794243029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTg+Lt8n8cyfd+bzP669ss9gAVOsDYk15W0k0texwBs=;
        b=IbkDz1mK/6YgcZl6FPC1ZZ+JvWuJCNqH1K0TBSzBXyZd9X9XbUVmoZpmFOJq/g/ckV
         xyycw0ADpjBfs45tE/CHj3/ulcIspbboXO27MUdYlH08fr42GrHTB1qhwjLzuB1c0MQe
         jj9emBKZk/2XMp374U+V449cXWNE9T+73Ste7fibZuq00fb9TipvVeK2kvkDfHG0BIsb
         6ylR0oOSjgcNvyDAkM4WJdhKTUYeALtsC6H7PYfF/0c2RZnW3PWh7iFso2+ITfD5/ZD9
         +eiK9Mpef3wUwlfC7vSSXTA+xPq9ulOCPmFjUnmLprx81zcNTPbRYZeh0rrzTO59iFV9
         jxQA==
X-Gm-Message-State: AFq9FYI/EJiC7T5BgrC9JV8iZhdXH50YlIoD6y9Ce+TVSHQRuqu365sj
	OyrVpP18i0PQz211dX/SBbjaMC9zE37Dc1psZo+KHe13Mij9n07Bp9JD
X-Gm-Gg: AYBFou0rGwDHgirw60i7+p3Y2Xyu77iXBXLKuZKCGo1cXy0Ue0l6VrGnovwaGkZB15K
	y1z1qyxupTLyVbaMPzvorPFAKEZWuzcZ76YDfDcJsqS6N6pSdhc+o1bnG7/qOdkqwG1tG1Zmy37
	DOn1CoRt295iwl6TJBuX1lofcNuVG1DO4j3lLImLEa0OPH3SIg613jhQj3zH2VZcr7A90qINKSP
	vFqkskAdutfnIREw+kJ1UTb893HhVsja20fM5pefDiafVxXkQsyey6ENH5YxlA7eHYWyEhHoybN
	TP4aR27fe91FziS+Q0rpVMbuMBaJA+0entIygEK4NCcVta9EPMlN2un67olfJMQAKLQCCOKFe7W
	v0b6q+ltPm/ZLX9HP9Y0sgl3z6lwgSo5J206coZy3bU19hdfcFon9MRLspD4D4Fuh7eGUML4H7n
	t6yyon27D76VRJr4OM2vWZZOSlVAS+1U8S1SHNWo9FqWrdFyxG3AVNWi9IcO3hOlqBZKF4733eF
	fLQun0Wzncm4UuMnGfRs9vl7hpSb36CupY9P2EcgnmzE6HFIh6O8xwnquQ/Y3Yu8B5xn66hqglx
	tTGh2fKo6FpWpsmm31fMLrs2wWSq/MOUze65QP69HrhkFTv/Cx4vuL625ptswez09em/wAWYABD
	U8QTBVN8o7VirYkB6Hq4=
X-Received: by 2002:a05:6830:4487:b0:843:b6f8:de3f with SMTP id 46e09a7af769-85d365529d5mr7247305a34.18.1793638229426;
        Mon, 02 Nov 2026 08:50:29 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354985cdsm9936779a34.10.2026.11.02.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:50:28 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 02 Nov 2026 10:50:21 -0600
Subject: [PATCH v2 1/2] dt-bindings: mfd: mediatek: mt6397: describe the
 RTC's 32 kHz output
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-1-19ca72815374@gmail.com>
References: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com>
In-Reply-To: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793638226; l=1237;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=3CyHV7hxEQyK84ACcArH+5qoJrY2fIpfuKy4fIAGdtU=;
 b=0Wf1b+8NmB4OEOpczcJRUHMeGyBxsbhLHqpUCilWHGZgwVqtkqscNpMc02ashPTcWUbtr4lgH
 WpE9hQMgNpfD6tqblyH80VYcqOYLALDE/Fh5XCg6akXUTVKecaowEVt
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MT6397 RTC drives its 32 kHz clock out of the PMIC, where boards
use it as the sleep clock of a Wi-Fi/Bluetooth combo chip. The output
is off unless something turns it on.

Let the RTC node provide it as a clock.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 055625362951..3bfe1ad60d2d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -84,6 +84,11 @@ properties:
 
       start-year: true
 
+      "#clock-cells":
+        description:
+          The 32 kHz clock the RTC drives out to other chips.
+        const: 0
+
       nvmem-layout:
         $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
         description:
@@ -694,5 +699,6 @@ examples:
 
         rtc {
             compatible = "mediatek,mt6397-rtc";
+            #clock-cells = <0>;
         };
     };

-- 
2.55.0

