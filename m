Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749850;
	b=IZolnXogu3iGfsjJw9LYcFbIWE+on5GQgGyCrGIFQFJeLVDD64zh5tt0L2DW8x+cX/+3
	 O84oXVH22FrbWvKi3CB6z5z4bz8ejrNoE3Omfktptc54lr/FKR5hTKyvt7caoIJjoA4E6
	 ojqbexOCQz9MMr3n/tLQfoJ2SJxhZ08ESMMTlWRpsh0jyETfejeLjYxpqgKr5VhugmHh7
	 Wux5o5DZ4XTFmcnIkrotkE0+2B+jDyYTqbHu/M7d4RWBhbYRe/IHBsanRViSHfE0EEH/T
	 r2PkalyZDwOz7HcUqqffFYYDa7mCqR+CbigiHZjZEo1ZV/tGOCJ+CfuHlvwVTgnLjHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cTsNKU2kYOf2rxmtGG/9JRKLpirEPzdL4P8zLLZqK4o=;
	b=iPcmpeJtvvzbqcWNLO+LMqJ5UHW1upxSZZKWDTzBQKV6YXMeq3cT9ARjUZA+C+k5S7Kc
	 eh6kFxpnwdQV0NDYeHEJz87ckoLOsk6IsZ2dg3k2IAVDvKz1sQRTzdQAnpwMdmpWZq+DK
	 rR5bLn47Ho+f2VrOmmp9h3gsGSCzjdFIEpE59pACP3FxOIj+Zvr7qvQkEsGE3Osk7dLvv
	 FEckp5r17tmzCBgOnPnpJ4wCIktVZKj37SKqgr7ghkp6O5u1sVd0kdMhVit2e8eaB7RG9
	 yCwQqN2nDdX7UCd1b18pxSCYdMF2jLMEhhfdOdq8wLFRtYcMRu+7oAqs52Vs95JWp4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=S2CaE4kk;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B6606A33D
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 10:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 550B6606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=S2CaE4kk
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so5352665e9.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792749849; x=1793354649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTsNKU2kYOf2rxmtGG/9JRKLpirEPzdL4P8zLLZqK4o=;
        b=S2CaE4kk3jH9Uyh64w6TN6cAvNVq8cP3cD86Qgw3Wvp7NLqwcjeXlsrNpdEthrK9LP
         cwMUkpnwqOJ7XtuW5UskVPPAqZC7ul2fhA7u1hfxzqROmCoDYOCe6T7L8tkQ9A3+Hp19
         ILFlwXibu5I81PDs3tQUCGJuudBc3w7z8lXYHUOpeIpMazDDPk7hwkIDrAHSrDXB7Cj1
         paXDGApq7Ya3IAz4S+nZeu0wYqtzIdMML4Kb9yWksm/qYKPKpk0aFwh15hhDfR21Z9YJ
         Jjq2sWPovpOgvLxYJBsQXmvBGTmwHaTMrWgURM12d/NI2TjW49OPv205Yx4lkAliOw29
         pyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749849; x=1793354649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTsNKU2kYOf2rxmtGG/9JRKLpirEPzdL4P8zLLZqK4o=;
        b=w2GzYR1/4rOX62po3eQmUnn9PHRxFsW4hD4SU3tIqTc3GI3gXut0Y6ZtEVp0LWLF3C
         z/K2lvB/W6SuEURChL7agM2MNuJD8Dr9n5itoMW/fri70E+g87fP6hnpCmwcj2wQL1kF
         rX4Y/AV9oHTTMHk6UE7MXZ24bdXuHbKDxAGpu1sp8dOfZKsX282hNcUzroKYDhtwNVlr
         dnCgzCRilNDeSAOKKg5fg4Gz+0pzrmME6FayF2enMrf9XeLTxYTl1P0ufizxIfqRrSrr
         Wc59WTsHe3AiwYVsJ2179wtifFwyxfO764C+W8XWcGqnT4jEuu4k5v1xq9/x0FieZonV
         onwQ==
X-Forwarded-Encrypted: i=1; AKwUvBz60rh3WF1yOdqPyLEvntUXK1vf3P4UA2FJe/B6P4J6dwKhGXHkvUIwCAv4ivb5HmQQnCcAKxyg3g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKrn5ZJ1Wq5JfnuWl+8rOgsAehv/kCmOaIwkMeYtvkZcjv8w5tj
	RUK1wggXDkUIXBypd5eFPBBIWBxCSYP9li4jg6KfbGfRvLgar04t8l17mdbUah6SWaI=
X-Gm-Gg: AYBFou220ocs+CxVakL+fLVkT0z/MJp4+lgaOGkNvVigechS7B3dc/k4fLlB5qejshb
	wAtwgGVd1bzff74iE1oHGVJocvyXk2OOntAsDVKj/qud+/wMpIBRH8MRHx7KU6/8YqnOEDRXKpK
	oUX4jzFNkvT0wMDCBAcikv04lFPn773xlj6Y0bWE8CwUf7DsIBAJ4AizCn+SYdjQaihQJcgorWL
	rQ8QsBf0750zTCVgHgT36r4ZtPJPzydMcAcNI4ihOIcXcebbS7Helee8xI7RQ6Wi7+tuS+MR9FV
	dCeYpWkX8+pOGRXqnh3VQjJ6rWWLO1lM6XGeiTTDqIlgutLWslGgs8qY6WxEN2Ic6D9atRX88V4
	Bpcls6zCav2zXvorVzBmwGvNumJ/QZ6tVdZzKIGFcsTm8JOGOQJe0oibm22uiAyEMbbiHu46hcE
	WPh50HrXr1+UBuKBP/4RwWVTCLO28iExGyHjh7UOokxekDCdivlKLntTwjxHIX1+nHDhqTPVXwB
	xL6nBt95C/B8udQhl/GTS8RgCuTmNLrq+psxN8XDMl+MLnHKCzMCupWtcaZhYBMR1n+Gk2e8L9T
	0ZD0o7+QVWyt5PX/kb3x+ZGY61v7qr1w5w==
X-Received: by 2002:a05:600c:4ecc:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a211c917e3mr26963135e9.9.1792749847336;
        Fri, 23 Oct 2026 03:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:6877:44a0:5297:9502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21045df9dsm75761435e9.8.2026.10.23.03.04.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 03:04:07 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dt-bindings: power: supply: axp20x-usb-power: Add the AXP2101
Date: Fri, 23 Oct 2026 12:03:58 +0200
Message-ID: <20261023100401.67592-5-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023100401.67592-1-olivier@mgcrea.io>
References: <20261023100401.67592-1-olivier@mgcrea.io>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AXP2101's USB power supply reports whether VBUS is present and the
input current limit, like the AXP717's; its registers differ, so it gets
its own compatible.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 2ec036405ae4..1c582aa5e1d0 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -25,6 +25,7 @@ properties:
           - x-powers,axp223-usb-power-supply
           - x-powers,axp717-usb-power-supply
           - x-powers,axp813-usb-power-supply
+          - x-powers,axp2101-usb-power-supply
       - items:
           - const: x-powers,axp803-usb-power-supply
           - const: x-powers,axp813-usb-power-supply
-- 
2.39.5

