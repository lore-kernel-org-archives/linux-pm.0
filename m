Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970253E51E2
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404110; cv=none; b=Z7xkg6NRd2X5EbT7S+NDbzurs6W1PA16dDzaew8FHnOVY+ygSy4cn4+BYpUNyh68vdJG90utKa0cprZIA2sRcjtXloqHs1VhsNejJtbLwJGw6fmCOjPM2fKBvWc2kWk2BO+mjZ1jwhVeXpml3+zoxI3ZYwCG+9nmpeWcZLQCVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404110; c=relaxed/simple;
	bh=Tjd+qqKRlPATrV03pdQqCuwbNQZAlKYm8gvQMT9w2Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II8FyFgksWQrhNAt9jQD5u8rfy4tVrzf4SUTZYcVZPkBJJAgSm4ouiE5kTapa7oDVs3KERngavssEJo6AOZZ14S7z8XKifmjkO623IxFOvpWYjg0DDtYLuKoR6lDvEcvCcCPxzzEyLUunjvGFp5n6WO+Gq3xBEnOQd2CcWmvaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2Eawk14; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2Eawk14"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so3385432a12.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404107; x=1786008907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw0S7j61Xivg5Kyv67PljsWbYXB5K5jcfpwkKzbAMRA=;
        b=G2Eawk14W2Wxzn+5rau8+r/S/V07rV+gwAUQEWin4ziHjuvGIk7PjDpbDc6cI/5Afi
         1c+Gfi/oowW0FVuUQLhtAx1mhjYrbLpVW2+EpWHfRnYyWPHfFr6beET/jNJfuUvIEbIS
         k7I7L0TPB1WVkpwZiPKhb9qIi1CGt0ILvp60OykAhCMzZ5xkHmOEmvSQkpBulpSzfJXn
         9ejkpK1H8xFp0FQW88ggsRzzgxkwYDEZMSH/2xvMqc4xOSg720SK4Fs1tILaEgkBWMt0
         45PktRKzvCvpjX9vzcu2hv9ZPVwQA24JxhqFfpQBZPHcT/MXEvQ95G8ebUWcwcr5jVSk
         2L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404107; x=1786008907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw0S7j61Xivg5Kyv67PljsWbYXB5K5jcfpwkKzbAMRA=;
        b=T9qvWBXUqZlozfzvDWWLrzhO1nY73xI/LPYqGFwa6lCGO/dnM5VBM2ulAO9MqXOPPm
         Zro1QtsKo5+2tl482Pod/Z/aW5lHuHt/hxJbFp8NHRKqQlB6/kAq47g0EPHKp7fkrSz/
         8g9+66BiuJRU9CDlzaEp+m/6EUwvFIHTRzFeSuV0PHxp3GwFrOg2AUNwzduzh+1fVA8o
         tr/ld/OgtYDzauQtkXExubAOYoOoVpMDOggvXON4LiuE6KkLUkof2ls2qXc5sz8xvF0A
         3luO/UXoWYOuvdRd0lX6egNGmQmvDDNQHwLTGZU1kFe99mKIkN+s3wjqFbnhLr3uH1dZ
         DqEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrq3g1VpKZqvwZZVzGdSjCskw5WrDxYJ8xDZp60WiUsTBCWAbxvVWaIUSAoH/9bYhzsKhaIfmarFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxker9T/hht0zYmvXDJ0g3k1FulT/YYi4jyTwdz6RQV2A2MrRsu
	KjJgIW0EzxjD58i6nR3iNylwc9fwA5bVgnRwaT3V8D3sfLqAweYFS1eF
X-Gm-Gg: AR+sD10l+IVLE7RA8EdLNWGIVIJnwR49TKZ8UW+WW54Q8riqS5OuDhglhzxx60dTyuc
	rN+ngAwAP9E6hXLLcL15AElmXqq4ualPRep1qFGOSxNNfizfa/3X/13AnEzKa1fDFC9nhoX2HA9
	z9D4wsfCSowVMImQBp7qVEqRyGoyUdGcLuuO3yYn94vilkDNCmvWhVhrcJ+lMxy2QSOdDeQw7Iu
	ed+AxkdHUA9sxSmQVd/rlOlXD2X335FQre+8YVnvED9OVqqloO9++5NzwaIeC8TF9Mk1pkfWDd2
	VbVpwaKQIzHyoSuNlZPNB2+QcGLpS8OpZa53PlQRIvmi9xhmpRxsFQ1z5RbpOcE0GhS+6IVueY/
	V6gOMLL+WsVXSBHTFAcswyycFTqSN1gfq0Kq7MuFTDp1KiviTOuo0YeKBrmEudjid40OmaROvOv
	/jEMKHr12zm1Et3nXmHGNK5VNn5tQBz47DkdAhXU7GerTxETQuLhBzLi0gj2PUKcGuDd9Ss2xC4
	hgnXsHaFjntj6gRnNnyomc=
X-Received: by 2002:a17:907:3e95:b0:c12:6d26:1ca with SMTP id a640c23a62f3a-c1fa5b8c45bmr96855566b.61.1785404106729;
        Thu, 30 Jul 2026 02:35:06 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8577e78sm46733066b.20.2026.07.30.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:35:06 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [RFC PATCH 1/3] dt-bindings: soc: qcom: add xiaomi,taoyao-pmic-glink compatible
Date: Thu, 30 Jul 2026 11:35:00 +0200
Message-ID: <20260730093502.689505-2-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730093502.689505-1-zstaseg@gmail.com>
References: <20260730093502.689505-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible string used by Xiaomi 12 Lite 5G (taoyao) so its
battery manager can be matched to a device-specific variant in
qcom_battmgr.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 16ad4f5698fc..8ca057c4e3e6 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -41,6 +41,7 @@ properties:
       - items:
           - enum:
               - qcom,sm7325-pmic-glink
+              - xiaomi,taoyao-pmic-glink
           - const: qcom,qcm6490-pmic-glink
           - const: qcom,pmic-glink
       - items:
-- 
2.53.0

