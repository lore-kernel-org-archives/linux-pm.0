Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134F3F105D
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 04:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707483; cv=none; b=a9Rx7BENW3UdakIK+h84o2N2RR4AAls2SCfSLjCBeZKLEjaKn1Io4inZozLCbRKNbPd8RuVHHA/QYo0Y9HNCbfkCMHNcRbihWNZt5mQTOM8k2v93ydJ5Cf1gfXLzJ/i/2pEOUC/QNbDv81UFrVu1zgI59tw3k2dHXEIM+Ir3Ucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707483; c=relaxed/simple;
	bh=QApoySis0Adh6uF/PzHVfhA1jkpjYHZNgPhek+gBJ7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8MZKpmBDs8ItObu3+VA72iOfacuMgm1Hxg6iSju1eKALZz8W+xbPshfo5vLfs0pz0yB4BDPPadv8CvmqT+/TmP7tmhgsqGIxkOxYT/pFTYRptpnsea5+CljUyrNIchqM3ukl0ruC6+nrdoWShR0FjqutKTg1nBJ3nc8isBVTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNP2ARos; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNP2ARos"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-47bbb846425so192845fac.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 21:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789707480; x=1790312280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UqClDMZv+Qp3g2QhTysx0rBLnCkZVZnC/Rs9Rzbs0+0=;
        b=DNP2ARosjyKw+bY806+Xx3kEQMAbw/NYtfLsiI0AUZtDEjmQT84M/PR3YA2edJbNol
         GTx07XQgvJ0qpS4WDD9hzWHQQC916mzEzICsB+0tphLjUiLNsdeSGCOj3zX9yloIjg/8
         SdrUPMEY0YPStVup277lMtnx5rUPNVrZ6jF5K9fJYVpqL8xYpogmW/qhBaEvzk8VunUS
         ts9AmAHd7jjKeeqEThDdFfN4g0E8MHbh8s1euwqVmdV7aAwD2UdjB0XGqbma/OPWSeKD
         6Ga4wCa1LKHxqD6EvaxwUFKyvxOk4X7WKZwoKMVi58HJCyD9hUtOVZEIPcx1AGa72OYF
         Yddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789707480; x=1790312280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UqClDMZv+Qp3g2QhTysx0rBLnCkZVZnC/Rs9Rzbs0+0=;
        b=jnvKfJhDR+CfDvAhXEqCx3V0K7kdXMwrRrvt7KiSui8ErG72XIoAUJ8OhONcjLRpiL
         Xi51JhwoGUs6ek0ASaUvPlFe/FimDuHDiuJ5s75PMgrPAHezARFWwh6bBVnHnnGAr/p9
         9w41hZ55CRqBc/qyAaJtb8dY306APZ1BeGTKUMvoUkZWxBXuFh71PZcJuZ1SsCMSCLG5
         MeOrqDCuVvb61H5pViI33oTbdTHsq+vVKyWwgiPFSiKTNfxMuZddIIsOYobbGIc1j1u/
         jUhOUve+r1+NJVS7aFAWqEcy3XI+qZc+BlassOmFj8wflHYPdXVbxrs/QrAuysAoM38U
         2dtA==
X-Gm-Message-State: AFuF++lvX2rGiNEwUK34mAuVvSu3e1VWNPLQ/q/uzogapyw1GqO0jJqu
	dHIZi/mA2O+OlB+Dkha0XcznqMsWb56g1zz6LAStKI3qrb7pLpTmKdS2
X-Gm-Gg: AYBFou2qPIUONb06ammmpVndZrQzHxFimOIRFGONAWM9Olmivv+cf7hfJLOuG/OJ3NO
	Yb340UdwEmJ2QImV7gV5hcFGRvbxr44Rqdgg8DbBGRfZtINqYArniKrLcH8wvxR0Eg+07p7XlId
	BTeJPqo5uf+aTxqchJ1A0Zbnui16odraoj1zJX9zffEp10SwQ5k872vUJhiSal//f0eUgdBjBb9
	DxD/1AUx/ioDdDZGKJPdPEv2TXpMR7AiMx2jd7TBJpcbbrWqQONkdnRuKyEMhgekhCZsWdljrGk
	yZ5Tz9ERHZgWLvrCQbWyUSWOX7qDAhGPn+81EXaPnWmo/Ukm2rv4cFY0RhlcedcCIu0O2+jhYGp
	6OhrjGEvzS+sKR0JrqAGcydELAfNaZURwo1KS+HWGByQYM1egdUqgilWRl9Awr/rYCkl/Wjx1ys
	8Mt9iln5E7PNf9cSCxZPVVkHhkBD16/14UpBw+YICM01cr/5MBUTo96QM3XzM82tXX19E1Nkw9E
	xsU
X-Received: by 2002:a05:6870:2419:b0:483:b498:9db0 with SMTP id 586e51a60fabf-486e5447154mr1433078fac.14.1789707480336;
        Thu, 17 Sep 2026 21:58:00 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48739da0d0dsm256318fac.12.2026.09.17.21.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 21:57:53 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Thu, 17 Sep 2026 23:57:46 -0500
Subject: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: describe the RTC's
 nvmem layout
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-1-558b8f95cfbc@gmail.com>
References: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
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
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789707469; l=1572;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=QApoySis0Adh6uF/PzHVfhA1jkpjYHZNgPhek+gBJ7E=;
 b=mjeSErd6IUo2Z5QDXzSoT7MEYbyj3Na50gNAofJEh5wz/azQT61QJzOrgH1djAKYxTLLJUkYV
 wo88yBIlUloAzlG19N2bRJfn1YRBdEMkcgp1nZ1QQEMSYEmHHj+zw0v
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

Four of the MT6397 RTC's alarm registers use only their low bits; the
high byte of each is storage the clock and the alarm don't touch.
MediaTek's documentation names them RTC_NEW_SPARE0 to RTC_NEW_SPARE3 and
assigns the first to a fuel gauge, which is what a battery driver reads
at boot so that the reported capacity does not jump across a reboot.

They sit in the RTC's always-on domain, so the driver can offer them as
a battery-backed nvmem provider. Allow a board to lay cells out over
them.

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..5c89c589b53c 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -81,6 +81,15 @@ properties:
 
       start-year: true
 
+      nvmem-layout:
+        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+        description:
+          The RTC carries four bytes of storage that neither the clock nor the
+          alarm uses, in the high half of four of the alarm registers, and
+          offers them as a battery-backed nvmem provider. MediaTek's
+          documentation names them RTC_NEW_SPARE0 to RTC_NEW_SPARE3 and gives
+          the first to a fuel gauge.
+
     required:
       - compatible
 

-- 
2.55.0

