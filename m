Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76D38E11F
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798775; cv=none; b=miJVZXEi5cUVjJGqIXe/gqC60B0BSXfYC/GYRvn1WUDcFDFWygMsRXSuR4CIDc9gt6JYj6JKi3XlJo/LMf9HXcqe15IBxH6SvMt746RQjWkIEb5RXufOIKtFCrjVMWZpnpuu2w9KG0lzZzqyH8SQj1WtRzLTRCeNgarLk8ts15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798775; c=relaxed/simple;
	bh=skkrqdaR/0vPKuUeSwmb6iwhZ8r9gu0r7vVQvuCbBik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErInjEJit6JxeAs15hEToAq3Pg5Tb+cprbjD9483cbWQ0NtFxCZXh/bsud7TuGKLMagpUyFtMDCv53br8Wt72OY4v0HP142yYFnEffFmbQGX8bRylEub9WNkkB+GOyAh0SsMEdYRE6B4jnIWzCqnzY7tS7BIOpcXDsGuiIcqN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUSSrAph; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUSSrAph"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b7c2788dso3970926f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 04:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798773; x=1773403573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWHYFXyM7zqNoEaGGLabRt6WO8B9aIWRMhobpXYX2k4=;
        b=kUSSrAph8/UVQPztSZw6A1jhHFfGaT6qA/DAJ4/5HsqnIuClA8jEItkmmWq6/UP+kf
         UYiPomSHwQhyn0IkvRxOSN1NHO6bfE1zaPLFDn9ruR6W/W6GydZdr4jz5wqmTU6s74Jb
         MPLtCdEZIYlx0D4eTUWWIW4WvTYM+ZwHk2IOGZCC/7ybXxBTHLdjTDVKBlDkWSD0obyb
         acMgl/B1L8BggiYpMkDGZXR/ESPTFwx5XfVMX8GY5SHaapgK8pjd29XjJVnJeXxjAOUf
         iofpYaCMPay5bnA69StNLsblT5oXkCKVcRbaLhhacZW0+edSJRyZijnPnuYuTrdvAkyf
         GOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798773; x=1773403573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWHYFXyM7zqNoEaGGLabRt6WO8B9aIWRMhobpXYX2k4=;
        b=O7kopjh6w9s6nTPGTzTu7AbRwD6cFGIrLsFUUjwyON2eOj+7doevqU1EVJkMO3TmPc
         VswWEBlJZO6bsJWbeZ9FMgRiKuHEbTQnL8e+Bd/W3qgNKolGJ9e3IUX2NIYPVBdnGF/O
         dNN2moRh14WY42HALW9HaBx2N+6yVk7SiuWGJooSlrbf70f7CubsgYjtoPb8aQzpvOw8
         Sdg/R3lpaX+sVP4J0trKZErsXEb2ermBdNvCPLJroXjeaktajUCq1/YDSfJAAMCNnE2t
         kKDLFFwf0jMkK6ltYuo9kc03zKEJe+H4hkRoHndqMT2xblFqGTrrV/Y/7kfMJMGwXO2S
         3rkA==
X-Forwarded-Encrypted: i=1; AJvYcCXIYFoZVh5Smm2ykRUPZlV36TLPPifxosr3UWr26NdXjX5K5g1PtlRbRlI/XaBVjYrutS4v/2QScg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygywpVHgJP68/mlxR1qUgcCahcWU8wzxLnVbNzbpNHA0i6hQ4x
	YuIgObMVyJbf06e1+vzQd7H7YI74nsYHGJd3EVUhTP0OqEZLiVGFtC0S
X-Gm-Gg: ATEYQzyY85j9c6IQ3xhiL86Zr7SWXW+i1rZxl7RC5nJ3U835hl8Wjw1+RnCuQkjFWz5
	zh8Qiu4OmSkbVfmDKY2elcCDaz1NlZQjFYnXvx/6KH8TIViZObzAmKA4vjhQkvN1fcXyGKxNHmb
	aVJIgttjIt5/jTsvimkMV+qLmrnm0SbiAHgs2H3WGy7KmANV4AubW2vRcYrKweu6qsmHDWOWNqJ
	oQN471/t+H2W3LC9SwrQ+419gnu+w9SjPMddQjsylgAEZ+J0bKDfC8Ce5sgBfYe8VYqugVjbO8+
	dC4hnsU1DseeRERw86E5XcFHhB5418fR4laIETF4VIpH0x0fbvSymdxhh05u0s7WRkTl8khx2/0
	olV8+qOKgwQPPOX6Z99U70iyGHYI6zolL5XJpRBjxLhP3qtkkaH2eqhVrggZoVe7IWgbfV6d+MP
	U50xddIbhzjpZ5wnlVFR0dxuvnNLdzRg==
X-Received: by 2002:a05:6000:4283:b0:439:b912:7391 with SMTP id ffacd0b85a97d-439da34840bmr3145089f8f.10.1772798772610;
        Fri, 06 Mar 2026 04:06:12 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:06:12 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/7] dt-bindings: regulator: add support for MT6392
Date: Fri,  6 Mar 2026 12:03:06 +0000
Message-ID: <20260306120521.163654-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120521.163654-1-l.scorcia@gmail.com>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add binding documentation of the regulator for MT6392 SoCs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index c358b2f8059c..bb1456d01ba9 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -100,6 +100,7 @@ properties:
               - mediatek,mt6328-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

