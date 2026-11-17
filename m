Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929788;
	b=HRwmC4AH63ipRJPM/+EpyvGAB2B/iQ0yYAYOv4KL4aOBNLhlS/wxYWQNcePDhvZ8XGBs
	 2YD3aDaPE3DGaoXyxZB1DJ+vzudBTba1lkp63xR6DicP55gTm3StClLV0rdShWBoHhmvF
	 JwgqPXsqfVbw6SxI8CsfNInC5fiz1uqGOd8E51lsyyV4NET+VM8x2CIyzQlmgvnxX9frp
	 Omd/Sjgr1B+1/SSNBtXIoJ4RpQROxlmY18pgVoPQVChGwPI01k9Ebd6Vr3SHWUxHsi5T6
	 j1I/i1xASCvnPPPqxrd/LUIREwbl3a8BR1F7BVRTIBXuOp4oOq+FuMNqNNPSzzw/eAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929788;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Be2dTaYRuTeMSiZr/C3iNTETQ7WbKElq1raCkNzgp0g=;
	b=sZh3u1CjUEJMatVEH/bpTcL4hFoZQshxe0qoe9G/7hUZ8I1/TNWei9MEYSt2zd6Lfxt0
	 saPZLGzk5KxTnaA6Rjg5Z1VQ9VW2nP9XzBazhkboxbqlep3QlEPIuaraJbV41yuXJaPtw
	 PHwlhemstQWz5rfDkMvvvc1YuI/owHoXGBprCnKOe/bRPeRnQcFVxvl6kBSqd/RQnL7tx
	 8oM88S1uIctmYfRgZ6yFuYHjOTQbtiup5fUXnvydjlVBwFgEH5+wSMsZ7KA//KmMw2Vs3
	 OOOETwSxuDDup/mRzH5MnelqAsAC9TMiniXWznPRu9PJwh2dm5YDi1a8nDUzrdeE0wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WsoJlqdk;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960E606A32C;
	Tue, 17 Nov 2026 15:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C960E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WsoJlqdk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794929784;
	bh=p0aPUrV2t7O659E4kKwh/OBRJ4chchzDLVx2BMBwY6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WsoJlqdk7m4bdFtgY9+xPcaVnF1Fc265OWvU7gheC0L1FP1aivh+OLFuyrTYCNRrn
	 S9i9Z39Dayt5e5GV+jvPNLTRMLGj02+qx1G9/032w2aWOwbsFWL3cK+c8vdPyNxSCs
	 aJuFnToFweBtbNDHB3pZRYjJXgHEdJhMnlj45VP4XGlVhGICUtfs308np3z9ezL+50
	 LTV6fFpGZxEwSY0EzvQTg0DOgYVj1HpcA1RCnRbveBTnyu9Nrlsdq1ckdfa+HW3C7A
	 A2m8+DlZrdknkcKlchDj2cdh+jEc3mb17MlA9ZUzqs0txjYymEn5nbBhvNNqvL8/gz
	 CLYCQm2JlnBCQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB99917E0648;
	Tue, 17 Nov 2026 16:36:24 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9C83E480030; Tue, 17 Nov 2026 16:36:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 17 Nov 2026 16:35:38 +0100
Subject: [PATCH v3 2/9] dt-bindings: devfreq: event: rockchip,dfi: add
 rk3576
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
Message-Id: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-2-32ff1546b0e4@collabora.com>
References: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
In-Reply-To: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=kde048okcSOUuMGluJ2pdLxZmjahxqiNXkiSB6ShPbk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr8dHhHx/f/zCGLSYaYefmrmhHn45cAPYeBI
 nTdiMn5X1AesIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/HR4AAoJENju1/PI
 O/qaWJAP/2+hlHUIsbgIS3nK0e+Bso3oHjsJtp+eGoRp3WYS78r1UfN7+bNRANVlcDidOuMGSrF
 2Ya6QjyTOeSmlgRtj66Nj1ulsPcd+A3moEaXBqEoJsbK+yplJpsdC5UQ8OvGn45F0GUMQyAwd3c
 ywuW+3sZWYgMfnlBSDtwHbDzKSigk/+x7xqWudrdOIcMQZxSzJLkEpezRLLxqF0isjBzWC9SU8y
 E6+4FNmMTe9w3zm8CibMxhMuQIu5tVwdR8j4RcvgxK9RdKA5hLOb/15pCs9iMEBF0vucyWRMUmo
 h5r8ecn62SEtldMIALn6G/aSIBMlWbfDiFr22BlIDwpjBaS6bRBdW2r355bCVKXBuG8wGz1lNLQ
 Y5yvEkKt5cRtvp4rauwCHpDPHp92/YZJwYqbIxydAG41bG2hJl56DTGBc4c2kHRpeTyvL6meblo
 bC82AzS0lnJXlbPFPVUhCf4yGbhwy6xNti6Z8s58Xf72Pz53haNd6P/FKMWOf0sWaGS1vf8conE
 pchtFfpXMiJSVS2aAUMxklVFI1aAb/RQYP6pwS9Je4Tvz7Zx2iNYdXfkwKSAT4AFOLrzQxbwptm
 ua/NSf4KMktM1JAkl25x7yc3L218MaC/JilkIS+gwjZQEjdDPSpqdK33iO2w9Ds3kvYvsGIeO3B
 KnwsQ35STOh9I3IpjwwQp1g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The RK3576 has DFI hardware for monitoring the DDR's bandwidth much
like other rockchip SoCs do. Unlike the RK3588 however, it only has two
memory channels, so only two per-channel pclks for DFI.

Add a compatible for this SoC's variant, and add it to the conditionals
at the bottom of the bindings file.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/devfreq/event/rockchip,dfi.yaml       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
index d6e06a9bea19..964f1827496a 100644
--- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - rockchip,rk3399-dfi
       - rockchip,rk3568-dfi
+      - rockchip,rk3576-dfi
       - rockchip,rk3588-dfi
 
   clocks:
@@ -68,6 +69,28 @@ allOf:
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
+          items:
+            - description:
+                clock driving the DDR monitoring logic for memory channel 0
+            - description:
+                clock driving the DDR monitoring logic for memory channel 1
+        clock-names:
+          items:
+            - const: pclk_ddr_mon_ch0
+            - const: pclk_ddr_mon_ch1
+      required:
+        - clocks
+        - clock-names
+
   - if:
       properties:
         compatible:

-- 
2.53.0

