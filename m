Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8D445AFC;
	Mon, 21 Sep 2026 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022796; cv=none; b=aP5ZnHqTJWUdW/mu5mn5UIoGky03/Am1Q1nIEh1fpE+MDf87pT2G2x1NxPaHMIk0axdrYhyJq35Jf1XMa/a77obKxZkVUurbwZCDwcysuVtTr1OfAb2yfLtwWFNn0k9MmmP00fhVwarZ46zzWBBtGZSZ17NlzRcOvYbWVRsRPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022796; c=relaxed/simple;
	bh=UNAUWNTqDPEuEuXC9mWoAT2pgMMEmi++BoO2+4ivAP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vtti0a3JxslTe63Pb0wgu98lzlqIULWGjgv84zpPY+kmNZAd4rEUouLLzo7eDodUM5rrizodIk0S4pl/2GPNqOdayY3djclerxiiNSi7u/v6HZrnkwplKmlxvu0KyAVwdjnrri4FKRLaYCIcljVMFv1Un4mSR8L+RxBW0hgxd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KgrWLCTi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KgrWLCTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790022792;
	bh=UNAUWNTqDPEuEuXC9mWoAT2pgMMEmi++BoO2+4ivAP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KgrWLCTixCpueeWZJYJatDYFFKABzGxUFyJNgtN9jHGp8svFbo0bLIMtI/O7zr0Z/
	 kugHDhO/4uNs0AS9Feniq/xJ/Msau78QnezHUm/5kC6SPtgcS4S+75C+c/9jFIvQV4
	 7bpEtZ5SgDn0TZx9c+ymOq3t5aZ+TCkCs5O39RzIFuIPgw92kaKtT0lrrZMKYjzwmH
	 T3o+WxCzQevb7usgSmGlZUxZzgipzZ9rWotkQ02CUGUrZGVCsQ9TFNukwfL+rzuIbk
	 by6fnl3/o7fB34Ovs/bZrKRieqdKZ5Idy9nzKTNIyixhtPzOxYPJEcDaM0hmjHDpln
	 fsQ340jnhUjgA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C47317E0034;
	Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EA5ED480029; Mon, 21 Sep 2026 22:33:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 22:32:44 +0200
Subject: [PATCH v2 1/8] dt-bindings: clock: rk3588: add PCLK_DDR_MON_CH
 clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-rockchip-dfi-cleanup-v2-1-43ff34ac8599@collabora.com>
References: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
In-Reply-To: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=973;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=C8FVn7J52GHndEtJHzBBi/WU5EQNwPsmo9I3eNfLHLk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxlIetecYtb3J20hC8atWcsqbglmT+CkhLC
 Jk8dABUQO2ml4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZSHAAoJENju1/PI
 O/qatlUP/iKZB4Gl3yFDu8Y/+0Iq43KSyrYLCXR9ldal0npuRdHgFT73/9h1tWPPk3qlD+A4Oco
 o9EVEMS7JaW4K/V/1oO5mvKc/QfVXLyesmKBEtGSlAWQqj/x887J9MfiN69aWNEAuAC2dVPj1Xj
 gxgZADlRRN8kfCZc8joF3A+LW9ZOHCdhYQPrF6XiUSH6/8pi3AUQX8fEjfNOfIHC9qbS6M8aQYP
 uYjr6EivK+rzzT4Pq+HJJh0ECw5jP4p4v+b73loUOcirk/xEURicbYHGyw38SOPdcSqeS3Er9wt
 PGNydlrTP5xhHOwdtBhENHmxsR4f5GwXKeQrejnXDKjd1kemfZAxZJnB4bKONKDjPgYW85LyP48
 +nPyY259UheJ1vYpanOLlwpUn9gqq+K6eKMgLXZztsJaIbVTX5oLPpFWKiDW5ClsnXu2qFOf1z+
 ZW1v5M8Uro3HVQiZIdixBlN19MdYtKgSheYvTs0BhyS1Z1bpYEkHDXZAc8F0TqVbKYyZOZxmsrh
 bCWAxagd9zb8xMIlfEXKX+EfZfMkrnpYZiLb4xLjClW9oMRCiIdDbjFYGzpdZc0hF9lRCiu9gvp
 qKEg/0gtoA6/g2SwmTWaFnksntSrIRcXT4XPNkPblgq/aNHaEc07llQUBV5nQ30GbuDwnkj8Rhe
 or5n3Xx0mwJds6nTEZSAt5w==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

On RK3588, each memory channel has its own DDR bandwidth monitor
silicon, and each instance of that has its own clock gate that drives
the monitor logic.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 include/dt-bindings/clock/rockchip,rk3588-cru.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
index 7528034cff56..6ea25019ebb4 100644
--- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
@@ -738,6 +738,10 @@
 #define I2S1_8CH_MCLKOUT_TO_IO		723
 #define I2S2_2CH_MCLKOUT_TO_IO		724
 #define I2S3_2CH_MCLKOUT_TO_IO		725
+#define PCLK_DDR_MON_CH0		726
+#define PCLK_DDR_MON_CH1		727
+#define PCLK_DDR_MON_CH2		728
+#define PCLK_DDR_MON_CH3		729
 
 /* scmi-clocks indices */
 

-- 
2.53.0

