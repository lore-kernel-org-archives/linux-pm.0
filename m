Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CD50AC1D;
	Mon, 21 Sep 2026 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025310; cv=none; b=sErmPA+LuqbEIfQgCjvgSoWt2GqBI3rYJcb2O+kFRafZLzWDwRrOO42ybmf9Ivk5+Z14n+BTy+leG03vTCyqSmQ79udke3Anvipq0ZpxhWd8hYVc5akQRvMKtts9/BHWnF4yiewpM0fExfOTdgo6p0a+ja/isuq4HWjdSogJ7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025310; c=relaxed/simple;
	bh=VoqqLLcbqJ7OYvrFkHoyD2jL5/9nvJRUdeotMKqe9rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kL5IxZdKy7FT3zYTmXNBLozhjFVGVtCB5m0bx7N0dTypTTa4t//3lhjPEiQVGnpA7pQ7Km+lF3H9+4USgQZaD4zhqRhkAiI5mjZ6qOB2JkfrOcduyF6ZCTHkDu+f9PiKCX4hKq1iYbh5C9cnilT+DFK9Q5If8/t6JsAEcazfncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TnBMzW9o; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TnBMzW9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790025306;
	bh=VoqqLLcbqJ7OYvrFkHoyD2jL5/9nvJRUdeotMKqe9rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TnBMzW9ogObbzv4Jshf9LXM0UEPAPl/7r2RM9GYowYZhXvwqKzo/m+pOCARvET2xj
	 adHWsqEpn9yI0NDh6bYxzRlaeeylYtjed5AucoHA42PYy2cuIa+Ude9rZO4LtSriKP
	 VNfrpOylyT9MRxcsrFkUHdsyRrad2KVGUDGV/GHO9uuooZb9t2NKP/WMRgI1aPXJIe
	 7Bp2N96WJQr+uIQmqBtW3KMYiugsg/DBMwPFPNm/nL8maeocWAhbJkTaCtioJTOz0e
	 cX6kGPl0rRCSxWJILU0ow0CHFKMhoylpQtijIONUHeQrA//64S2RtcbSp/fyeFdxeR
	 K2sc5fqsaYusw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 95DAB17E047B;
	Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 55F06480030; Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 23:15:05 +0200
Subject: [PATCH v2 3/7] dt-bindings: devfreq: event: rockchip,dfi: add
 rk3576
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-rockchip-dfi-rk3576-support-v2-3-04f847016321@collabora.com>
References: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
In-Reply-To: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=svizK2KZChAhOebL3KzZOubuF9KRTtGwxI+oht9v+X0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxnlprk0WbrOj3hWgPgzpbDHqRL7Yv5/e2A
 PCUYfGDbzHYv4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZ5aAAoJENju1/PI
 O/qa3RAP/3qjAtVEachEjuEjG3Eld5oGRCbCmvU2TdyDC70rjacUDzTlZH/KZSAl7r85bMEi8we
 0hGt5sktCodCqCPNtuLeTsAMUY/SCnABJvageD6T9G0WNFc/2gg5UqJCl/JqhjY2BpaBgQNr/1t
 CEUNly1EHwC9XsFyIOkiUp2MZU7pQ1EcwSka6D69HRgxdobFXCSLCRXdVxdwwhj7hosyDkG60k0
 I0O6zNwIZnvt/g1aFrM56ifk7OTDmJ5reJYBaq4KM5niNMvgXwJ+rCgHn7OoBKHVEJG0fmHUkZI
 kv17Bu/bVCThPRClakl++I7avTbUVecA5E/F+/N5fxp6IZy6CHmEPsLiwqjkSzju6ytloJfG7hT
 +sJpxDESrVa6KEaRkdCi/J8NYfsY0CN8++309vT1ZvFGsrAKFK3T1AH8Xi5LCjygQWAMLQOEfGG
 wlbwYNIlvkb1suTw/8/qvs90e8NnwoyrV7ERJvt5uMmE8Ft42l3x71rBqOlLt3aRUosoyjHlO4Z
 SKB+rEn9eMgh9XN64PDZu+znT/qKF82GQgzfblFkIgn9hSNxzTwiNzigF0ZYw7vC4ZPJQcucP1z
 4EO9UGUsBnqymX0XAYWuzk/4wLFPw4W/RNJRLwQ26vEn+hbJnYi5Rw0rqiJ7XOchPa7vhLXF3g1
 KnwoyFo5zwO9BzEwTYEwqsg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The RK3576 has DFI hardware for monitoring the DDR's bandwidth much
like other rockchip SoCs do. Unlike the RK3588 however, it only has two
memory channels, so only two per-channel pclks for DFI.

Add a compatible for this SoC's variant, and add it to the conditionals
at the bottom of the bindings file.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/devfreq/event/rockchip,dfi.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
index 3450e28b4020..dcf3bbde3e8d 100644
--- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - rockchip,rk3399-dfi
       - rockchip,rk3568-dfi
+      - rockchip,rk3576-dfi
       - rockchip,rk3588-dfi
 
   clocks:
@@ -64,6 +65,24 @@ allOf:
         - clocks
         - clock-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-dfi
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+      required:
+        - clocks
+        - clock-names
+
   - if:
       properties:
         compatible:

-- 
2.53.0

