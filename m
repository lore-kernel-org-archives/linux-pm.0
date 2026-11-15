Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794762716;
	b=Pg90S+JBiIdND+I0FtlMM2Q/qpkAi1h/2qyACZ10LYo+THTFM9gIjrY2mQXdZOlPeEZR
	 sgwtm7VX4v34bN81dHH44v3g/xRljVtaF4cm6j0BkDiFBphtnhef4fh3dL/cFIFxJ/P/W
	 4enA1wOp6y1Yg3gMPP8NJict45xh6XjFoTMPWfv0F2TQQUwYMQHlaQAB5JNGSO0JPpXcB
	 etEzRdVSE7XaEC0ELooPCKHKncSICmyBosKFTSHpUwHe3AH63wQ+p91WRbufq3WhofJk8
	 cji2F6cqGOKeEHcpiazyOqYx7cAqvMrp5Fr6jPrTAgYpbmnWy8q+jI6ZHXeYM9c5Faw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794762716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fG9+hLmOKOGQqcT30+RWcvcEitQrcTtgZaflUnQk5PM=;
	b=C+psbewhlnDwOT46uDkPH8T9uqGPLihkkjcHLDwhbVTB8nYbx1tUVKn8EYzgP/Iu5/bY
	 jCkfc/dnJ3jPw0hZuazJJRPHc7yspQVg7JiGMjtwlcAnGOc9IcdWCT1lbXX1Kcg95iyb+
	 bpyNQ4mUiPklUfWLt5gep0eRTpyjE6joeffzQ1vu8W/Gm4shU6vAXvIkNQ4tTOwcrugal
	 J9OljLTCBhDFwLGncQ4eE0VMuwK2dEZqEvKYylX2MUaYms34RfuAIhj9MceiLpqCIMb9N
	 3pL7ywkksovFD0hxENmkRLGaxBUNTj1MrNKzl5s4ORVVXRJpPZe5fGsZtSBJ1ZzM9eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=eapHzAaA;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D5C606A8A4
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 17:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D5C606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=eapHzAaA
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so5312185e9.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 09:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mgcrea.io; s=google; t=1794762714; x=1795367514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fG9+hLmOKOGQqcT30+RWcvcEitQrcTtgZaflUnQk5PM=;
        b=eapHzAaA6LfdTDi2XpzV2acZajFlvqIjQ8eYwV2+YyTjvOxhSIQWoR81b1lStVRbwx
         VDivTF9kpr+gBFiUJ9QCITDVgWp9wXt6bzacu3lflkaOYVLrKk+S3iAnf0cI7bh9BwS0
         Vd7BXRPIM5zgNmdAl8ihFiuaOPGBzez1olUXci3uYrpY+LQ1afTnYNJJLGQcAy8t0oVs
         xqREWrR5ZIvRhlB0k/Gn6C6+cR5vS3zLU3iVn1/X64A11zRHNJbelS3rvpilRuFJdflm
         D3Uiz/VQ5jLdhQhgu4lPgroNl7gRuXXagwatcHTtGzf7fes83oo2plN7xumo+immm/XQ
         UMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794762714; x=1795367514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fG9+hLmOKOGQqcT30+RWcvcEitQrcTtgZaflUnQk5PM=;
        b=xxyRz/qFl5z7FAxQzwOtatdH4USrKO0Dfw9WX3QCjGtkLaw4OjqcqlkQ7oqT20K7+8
         N4iNOYJu2v3fniDa0eMXc1YIpwc0cgwn3F6lAw3e+hX3q6ySU8z9N4vKxkNVquAhTthL
         31NvThRwpH3MIRx/D5RlAmCX/xV2i37GkfF5LO6ij4tXu5TPwlqG3zGINPNS9VrHjCip
         orduDvC2j/nHAwEJ1EaGCm02b8FgUZWsDfkON90xoOCxS1yAcwsYbZuhIJLTj0AAFL1n
         9IDwo9GArEuTjzCKiy0yDt+h/jyfwa29XOeC0o0WQZ9VtQ02Awm29dNltMlokADid5aa
         eJLA==
X-Forwarded-Encrypted: i=1; AL+hErE1skLyOHMoz7zD8zrGp8E3RGQGnHXfqendanxMoQefHrpHZk92BI5m5ZQiIRbxAD0M0/m8r7Rpkg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9q0DL7BCiNPTHbwTPRbgKnFdaMXlW6FcajcZMjipCLYxn/6aaq
	VgjetyUPDlN5nVJJcYppvRuju8mFcAv2jGcm/tUY3SMyu4prXL3YXJ4OplADG4GojSo=
X-Gm-Gg: AYBFou2CoAt3wSrX/7iie+5JuexI2mquvBlkmefXRVkyhtFjBPwwdfJJI4g0Xbm10Dj
	0IquYK/7/ZOh5WpAGyX+rNDwRTvWxCtwtGWaQc+w7ivuiP65sjVM9DH6UqovtrwFvYroNMYOhah
	I2EQ6pgzHmmC6wg9zvZL4rN70Zg7zhTrQ/Cv6Lq9fM0qZXZuRRs+uc6x66W52Qqv5s33UcA0TAO
	tQeTNe7w851YQroewgG4cmEcCTGF6ZkA9SCkl/0xWwEjkJeJqgXLyu/cKa7Iy83E6NKvdbPYJdr
	sG8L+ZS3T1TWBzxXg6V03Dr2Is3HiyucYaUy8w/3f1vO7zH6KbP2wYVwll8ltJHtZAqTeOdLRpN
	2sKhMbA1qmpz/tAwqjY7blU2NdtBLXx6FAbTonk8YtIpB5MeO1fp5gdkZkbOpvFNqoM6YrP3is6
	TAlkCqUkDLQioTJSVgZ9oIiOlShmxhRfEpELpBRDcppW+5SRc5+EGHUDqM/X+ZoTyCRDICBo+lM
	WYC/ZdPHRTnXoVIjq9QdLTGMTHgiqFueOPYodT1vlZ0a6t7ZTCirotv69F8I1IManJVTznd98PQ
	Vnv+eq7Y+HJmkdjmDCXlYYR5Xc5cVU0Zxx046BYJ/owfAdZ4neNFCADFxdwqDg==
X-Received: by 2002:a05:600c:3e10:b0:4bb:6651:9eda with SMTP id 5b1f17b1804b1-4bb6651a042mr80157395e9.14.1794762714298;
        Sun, 15 Nov 2026 09:11:54 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:b9ad:41d3:c29c:11b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac0e1esm205418705e9.3.2026.11.15.09.11.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 09:11:53 -0800 (PST)
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
Subject: [PATCH v2 4/7] dt-bindings: power: supply: axp20x-usb-power: Add the AXP2101
Date: Sun, 15 Nov 2026 18:11:47 +0100
Message-ID: <20261115171150.64431-5-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261115171150.64431-1-olivier@mgcrea.io>
References: <20261115171150.64431-1-olivier@mgcrea.io>
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
 .../supply/x-powers,axp20x-usb-power-supply.yaml     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 2ec036405ae4..439b3ea6a7f5 100644
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
@@ -101,4 +102,15 @@ allOf:
           enum: [100000, 500000, 900000, 1500000, 2000000, 2500000,
                  3000000, 3500000, 4000000]
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - x-powers,axp2101-usb-power-supply
+    then:
+      properties:
+        input-current-limit-microamp:
+          enum: [100000, 500000, 900000, 1000000, 1500000, 2000000]
+
 additionalProperties: false
-- 
2.39.5

