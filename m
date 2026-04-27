Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F93E0C5A
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309910; cv=none; b=iCAMi+L/Z4sjRfdqZbgqtiH8bIU0TR8cKiRizwPfkMQfyZwwPqXh91tu2RFJaWiyplXeg0qKAAGkBNGf16eYOy0bA413loo+dW1Nkwwt0yT6QnMcF9PTU43ygbIN9IuIdckLr7LuyFTmjy3r59g43zLpdCnTzWcrZeqpGUNentY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309910; c=relaxed/simple;
	bh=8XX6N1itE1yUmT3wOPte20qndhJThWgZfj+VXQ3AB4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AI/DCNKiwLsis4bzdSqQbDix/UfG3D/g1SExvcVZWTdVX2gTnngO9iQRnLIelZg+c0OtA+MqFqdCrTrdRkHPckvdB6dh3zkCnWEu+2uVZggyKL9TLzOxhDoEz4qKStYLNBaEalKvEcGERAuy9RzwoxQx+4bbGEPyXL2mMXEP2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGN8pTcS; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGN8pTcS"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40ede943bf0so7164105fac.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777309908; x=1777914708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRXPhKIxUEkhfArxTsVmrthzYNjEzyOQR0qGn2CDhHk=;
        b=LGN8pTcSdPJ/h00o0yaSF8yl5iiCnrzfDMvRxJPK12HYAkjXSrHX/0lcDRSr/daiB4
         1vEPElF9k/feJFJOSYB0fP4RUYF17RzkckBX7wrjIko69XkVNUFP6/H0vGwDjk08PulN
         YQWp9V4Sps8KXujc/0sJYdAMZ++W8PAC2MBETd5WMdIZx+t0psNcSSWHfaegQ1pw9HSK
         UL4+O2N/lM05lBq0kYHtaBvGimSRhQh9jA9G6ZXnvoImEqrXTwLakjJ8bI81sbTax50/
         7Rgabcw7WWXI+9L1mZHiXIZPdzaMgx6qS+O5hZ7ZCAnp2UdlFQlZz6iRpQjSJOz0iLpU
         JLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309908; x=1777914708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GRXPhKIxUEkhfArxTsVmrthzYNjEzyOQR0qGn2CDhHk=;
        b=ftf9kYzPXAl+qIBLJY2Gwdn/TdfnAZ1k+ZxhjJ7UsJ29oGpcbYndxJ7dv86AMoXkUl
         ycf5pL96Ip6aXhUJTmZowctWQsZlFVKEZ9DoaQvrHeLgbSPrzMpIwhXSh47Kqc9ZZEg4
         kfbBgb8+I2YMmP6FlKAMrEEr95AMCdhxc+iJnwudcmGkh1IfpTHklUjyLIZJ+k3EeJAh
         Sh/CU3lMHtqf49uUQveRtTifJlIkaM7fMEZZU+1+KC4fwbad7run9LMO9ZIxvvQ1XpMF
         4h3OzEgpunhu/FEkZOjpuDZVQb+lfoMS/T7BehnoQKvwE/kqcqUPnUHjn65b+5Iwl4OR
         PbCg==
X-Gm-Message-State: AOJu0YwrmpK9SDA61+dk30PDf2MFvD99kju8OJZnrtWFe3ViZa57ZZ0W
	07eK1QEESCsi5Ao+YVde1LcK/4SVQO198/217CVDcv5Afjh5ho4D0Jlo
X-Gm-Gg: AeBDiesVP7vfVK8FC4fe9MsAf73Zjo/DnSBML++RFgvgUVs43GHpAehvByN9r66ahf0
	7BPDwQf0zthG8HUFI1Y1IktdiJqW4xn+kHZVDhgmbM9eIDwLhb+chBv8EuSbCoIGZrE6rxDJxOT
	k8cKEcfkeJOZb1ItApZUN9EksRdu0bV6FDFPxiCRo0npMweZPctEUr7QlH576P0bVuUHkasY2FW
	kbVS5JwCWJziNLMtSNeNkr+rQWAa2t3iiAwDDQ/ikJBI5ebCQLwSX5zEuWVKQEdsglvOLLtql10
	MqFhUS8n8gTY/47i4/X+4SqK6oODoKj0K1onV3ipReuzCNzckD/5NZujli60so++AKaJTM3uM2b
	dynK+AD0BcEddTIXrIW6Ck7hWW4iRx6SmXSlT0U2MONFEoAaZtSbImSCc62we8bSM/14GWEDlEh
	fguyBgnOWSx95ExrK0mliZ1Fk3ZExZ1FY=
X-Received: by 2002:a05:6820:f00a:b0:696:1a85:587b with SMTP id 006d021491bc7-6961a856499mr11658167eaf.39.1777309907872;
        Mon, 27 Apr 2026 10:11:47 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6955036558esm10261236eaf.14.2026.04.27.10.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:11:47 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	xsf@rock-chips.com,
	sre@kernel.org,
	simona@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	jesszhan0024@gmail.com,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 5/6] dt-bindings: arm: rockchip: Add Anbernic RG Vita-Pro
Date: Mon, 27 Apr 2026 12:09:13 -0500
Message-ID: <20260427170914.5062-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427170914.5062-1-macroalpha82@gmail.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add compatible string for the Anbernic RG Vita-Pro.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1a9dde18626d..b8babe9d3a26 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -66,6 +66,12 @@ properties:
               - anbernic,rg-ds
           - const: rockchip,rk3568
 
+      - description: Anbernic RK3576 Handheld Gaming Console
+        items:
+          - enum:
+              - anbernic,rg-vita-pro
+          - const: rockchip,rk3576
+
       - description: Ariaboard Photonicat
         items:
           - const: ariaboard,photonicat
-- 
2.43.0

