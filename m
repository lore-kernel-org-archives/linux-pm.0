Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC2353A82
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773141; cv=none; b=MG/X8k2FwEYBvPlmeAzarc21GU3hqTsRCqpvqCu/ui6Z7lTnWy3rqN2sDh/rwGjiEKdNtsVsVb3AThdUKzPrjQgk9LU0ciZM8UAugh4MTCU4ETL5NtiLTZqka3hDrW1OHFiYbH0tCliwAfCY3KS1lWtq+nLrjQP+Q6Cr/nlwJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773141; c=relaxed/simple;
	bh=eHE2ySkMd6RAJ+Zg9AWbLE4UmHsl2HS5GH6ryQ6tlfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfmygIY19X1bx1sAxxNwKrIK9YjqdRucIS4N29RArbcR//xbl/L1qkRpHFdSnPuSBgFBb9/9+MN6GG8zeZKKzmgQ8XaKuQmQdhF5Ic42fCgUd5R9oMnqlWSMhkgNJ7ezLiyRSWPcQP84ac4Tv0PWBDLERqszIrjEGAeQqr0Jqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7uqO/Z/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7uqO/Z/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46f88060e8dso243231f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785773138; x=1786377938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Orw1gQutvOkZopO7ifTGK4f+dabsbqDeP0c5VLSqs1g=;
        b=m7uqO/Z/UI7Kqeb7bWxJ9Xp1xMERja3adVFrj7jYOnq5oAUUDVjkJf9JAujVleRRT2
         Dg275ztrMgYb6VuGdcfhK9QbmPWwyBaetkRGTJ9yLuHqvDaHKWCBt4AFUqHZH6hlwbvN
         mBNUj4f2ovEOmNjRI0TTCWg4Ggwy+zvaXEttcMqR/WBWJIwG1ZZnR0RnNPN5YZZmUJ1r
         mZWHh1wHSu6kbEsExo/xLHf2sU3GcemNwm1sQROgzMBZwMaSImQLB9vx++a/IuJ/+ySe
         wKDYP64AtbGtxaIYpC7oO3Y6ISKkYsj6p3tvy93+htIItLkV/IPbOvrtAeZGdN+LJ16P
         9vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785773138; x=1786377938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Orw1gQutvOkZopO7ifTGK4f+dabsbqDeP0c5VLSqs1g=;
        b=hi/A4j7bjoOgH9cbvmZA9l31y/5wRgL16MQnxd3ZBsefgndSD9sTHOnKeicV5GvvMS
         N/BlgLamfZq13j736d5dcM2K/UX2CypsClH0MEXtR9gHMmr64TSHL56WbbD3tfIKdS7P
         JNPSZxUgbqn7B2O/vtePPpmMUIBE2wPJmS3sWJC89h7B1sVkmDCjI2GdeOUBe2tyHRnF
         IL/CWfMdw/3gJ2bY7cLTe97zIdb8TLc0PqZbZGi2SoMQO/Tdk3Ne6VibdaLNmHr0Of+M
         MKSjfgFmJzudqjiyeoH59qCmLEbBXcFeH/sF3m8CGfd8oyjmm4zFHyMZyv2fF/6uyb9v
         9WFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfjqkdKhUg3uu0v5SGcfD04fSNijUcGAVjVtcxayFFK0BgeOOgedZFYJ2342GPQo28EKJtU8KmAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxjzQPCMWp5jS4Axk/HlRw3vAA3lfJw0NTgqTtgjwS9xpmTIS
	DyY17zg2hJfzTPEQPmji5Gvo+UwITs6O3n7HeAvupBaNFV0iX18TPqht
X-Gm-Gg: AR+sD11xTeeS7xcKsXifZsY0chVkxyYNa9CL6Mz5Et4H2Qrwd3L3iuBFzRWdhQq5s6x
	XycU9BlOKW5TtF7CpvDOb38Blr9hjT5lPMuQWd25Dovr+a1DDhRayy8XPx9ZRHQGCqehZzhklHY
	SwnE4aI9u7ixs2yg7kYriZ6pjpPMpe9yW0N/gWPCn1nu9o4Rf6FoQ7r4ZEFofVUsFtvqhCXfkA/
	/ah39HTe2BCGMYGunMGJbzSSRxeQJIkLoQHYH0ohLd01gnafP6MlW5HpRYqyUqiJavjbRp/en6N
	AEelaI7pt4VTeE2BbP5ofenprNQDHVAUNR85KvcyD0Yu9fJ9kQwUx6zXIID8Hm9UGalR6Tgsk4w
	DCPLbv2mEeQ5QM7b+Fa1ND+Lg95bknTebGC2b2BBMdxRqQ+9oy4MnJ6Zof+YOnuQ3RS/3KsFWkW
	wWmXOjujNYHoc0YFB0x4/eBYaewL9QU4YcCt21HycERNbQTOT8uiz+Bvg+pLGYg/sWXrknG/l4i
	9Vbz6YgjaqnQa2+GmGUnf7p/NFOyw+K/LdDY7X8pfFxk9Ba2msLwBpaORh73h/9Lq92
X-Received: by 2002:a05:6000:61e:b0:47f:4d11:3472 with SMTP id ffacd0b85a97d-47fd72a00e1mr15561662f8f.1.1785773138178;
        Mon, 03 Aug 2026 09:05:38 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B85F300A5CC0DBDABDC4661.dsl.pool.telekom.hu. [2001:4c4e:1b85:f300:a5cc:dbd:abdc:4661])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458b73asm31953719f8f.29.2026.08.03.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:05:37 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	alchark@gmail.com,
	chaoyi.chen@rock-chips.com,
	krzk@kernel.org,
	will@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 5/6] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Mon,  3 Aug 2026 18:05:21 +0200
Message-ID: <20260803160521.14621-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803094125.3285895-6-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com> <20260803094125.3285895-6-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiaxing,

Following on from my note on 4/6, since a v5 is coming anyway: rknn_core_0
as written here does not validate against the binding 1/6 installs. 1/6
adds the compatible and the conditional sram-supply, so every other
constraint in rockchip,rk3588-rknn-core.yaml still describes RK3588 only.

I put your node through dt-validate (dtschema 2026.6) against the binding
with 1/6 applied, macros resolved to plain numbers and everything else
left as you wrote it:

  npu@27700000 (rockchip,rk3576-rknn-core): clocks: [...6 entries...] is too long
  npu@27700000 (rockchip,rk3576-rknn-core): clock-names: ['aclk', 'hclk',
      'npu', 'pclk', 'aclk_cbuf', 'hclk_cbuf'] is too long
  npu@27700000 (rockchip,rk3576-rknn-core): power-domains: [[2, 7], [2, 8]] is too long
  npu@27700000 (rockchip,rk3576-rknn-core): resets: [[1, 20]] is too short
  npu@27700000 (rockchip,rk3576-rknn-core): reset-names: ['srst_a'] is too short

The last two are the ones easy to miss: the binding writes only
"resets: maxItems: 2", and dtschema fills in minItems from maxItems, so a
single reset is a hard failure rather than a permitted subset.

The v4 changelog says the reg entries were cut to the three the binding
defines after running dtbs_check, so I suspect that run predates the CBUF
clocks and the second power domain going in.

The fix is the same allOf shape you already used for sram-supply. This is
the diff I tested, on top of 1/6:

--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6

   clock-names:
+    minItems: 4
     items:
       - const: aclk
       - const: hclk
       - const: npu
       - const: pclk
+      - const: aclk_cbuf
+      - const: hclk_cbuf
@@
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2

   resets:
+    minItems: 1
     maxItems: 2

   reset-names:
+    minItems: 1
     items:
       - const: srst_a
       - const: srst_h
@@ allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-rknn-core
+    then:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          minItems: 6
+        power-domains:
+          minItems: 2
+        resets:
+          minItems: 1
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+    else:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+        power-domains:
+          maxItems: 1
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2

With that, your node validates clean, and the RK3588 example in the
binding still passes, so nothing loosens for the existing SoC - the else
branch pins it back to exactly what it has today. Take it as a starting
point rather than a finished patch; the DT maintainers may well want the
per-SoC clock list spelled out differently.

Separately, and this one spans 3/6 and 5/6: the resets you add to the
power-domain@ nodes have no binding at all. Same test, against
Documentation/devicetree/bindings/power/rockchip,power-controller.yaml:

  power-controller (rockchip,rk3576-power-controller): power-domain@7:
      Unevaluated properties are not allowed ('resets' was unexpected)

$defs/pd-node there defines reg, clocks, domain-supply, pm_qos and
#power-domain-cells, and every nesting level is unevaluatedProperties:
false. So 3/6 teaches the driver to read a property the schema does not
admit; that patch needs a binding change of its own, before or alongside
it.

For what it is worth I did check the DOMAIN_M_O_R_G to DOMAIN_M_O_R_G_W
rename in 2/6 against mainline, and you are right that DOMAIN_RK3576 is
its only user, so nothing else moves.

None of this touches RK3588, so it does not change what I said about the
tag on 4/6 - just worth folding into the same v5 rather than finding it
in a v6.

Thanks,
Igor
