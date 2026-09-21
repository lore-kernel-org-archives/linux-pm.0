Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE31503BFA;
	Mon, 21 Sep 2026 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025310; cv=none; b=lfrh8rLih3NcfeobLJCEJdKSmoJycgSWfseip2HCcX/15+QV84s9qrs67WxzAJWuHzGbW+atbdO9XLIPrDYg977z8jSjLX+ExKbBr+9LZFwVAPHALAl2UkxpdiJq65AyaZmueqJATcBj2cl3yUn3cLdfdJj1QuS6Jn54nRObcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025310; c=relaxed/simple;
	bh=+lY5BeFcwV5FB838TAcxY9ito2AIXwIBAsYU2ILeoMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bEoBMU42jg2KLhfA2xenCHw6pWPmeYkjHs107fsodA96Amdes07GJVEcO5d79WvWAZCNiPIv0NCvTZGwIQGBzFw0e6zqly7WnYCFWldc6p4sd0+rFf/gXn0CDZ+HUP4DdoNW5iKabO3q7IPRFS9/hfz7FCetu0/VZTPVv5dOmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mKqIvTJ/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mKqIvTJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790025306;
	bh=+lY5BeFcwV5FB838TAcxY9ito2AIXwIBAsYU2ILeoMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mKqIvTJ/sugvQXhTC8/kxB6CBZ5I5cDM25m2Bf2hrBH7gmu4eFyohrMCaNGvDvLcB
	 cWhSMHTSQ1UPOVKyun6a0jj3+vxSdrvAEjZjyyjbLjuXVq/Xxb+BsLT4T9gi990zZs
	 6fG6umLpV1VsTfCSs7P79z/CYAJhArU3CJfJgEydqOnfCU8G4B1x7cvBfVXau9KzRn
	 91jHb6O6OHlRU+f2w9C1npyg6A5Q14J33KdpYMnxtAiBVYmi5jCVUurs8nanm/vTya
	 Uy0lIxnDaKlcoLsLgMZpqN9UXbd7n+j8sURCbuPaulLFqS1XFvD40Cxdk2WA7qcbOs
	 OYkTIL1XO6i1g==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9715617E09ED;
	Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 52352480029; Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 23:15:03 +0200
Subject: [PATCH v2 1/7] dt-bindings: clock: rk3576: add more DFI clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-rockchip-dfi-rk3576-support-v2-1-04f847016321@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=888;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=JMwGtADsjoZugYy5kca2WIyyIS8H1fB5ycX9ZpgOJ8Y=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxnloifqvy9AhQN26uetADWeyOqzmmP2Wct
 u4nYUBzLv1Iq4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZ5aAAoJENju1/PI
 O/qazIYP/R/VOsf7acYrt4KZ3ThXy8nO6Fl2wJznbO6viavpiKYsJWM/oDs2U9sgE6ZbgqVB9XG
 HDwSvtCrc3LwjThSoLBTBqbsSzaEztULRi88blqHTes/kbDQc1NAY4AILwIPH2V15i8dS9PDH5m
 Q5TgWrop00jdkqaDFBkIJ7wmWTx+FTtjpVWdKyp5c4XO/Oxy0jyilRljKaG/lGGTGgBmx7MxmaK
 oe70ovVfVBwWSq38OTsAkT/2+GGdaKRc4NzVmRgEjd8+Slifk4bZHbf90NmsC77iNdMdD/6PJr1
 GfRc/X/qSFxGpgFaGFdjo7kXK131hdBulYrpEy90jGNBhOEPbpQftnnjFTPAlIMZ9klZ3ze0Uhd
 01oOLNPTnfvE/eUxzTaqwGx4Z/raKo14qfhRnXrjX6QVXg27SR9/5OSOkffhffVG98iOXvbtemF
 fFqLqHt2ZiXi86sbdMrlgbOGbXv7DItWrRIDx8TVNk6r6KZtV2v5Y3K6F4nYEval46wS9oDcaqF
 d9PNxJYNuRPjTA3DSL+oxwbNRCcGpDW7uZu26wsFYe89+/V7CINujP3ogdWd7uzSgKk/eM5jFwb
 y9oVj8GmRG8NX15OdfDKfWcuaPeMs7I8Z4k9R6O7e6Xbh0sU/iPrupEvVElrd36BlnrzwJ/72h6
 9bXVwvvM6UbazdkMwOBkwuQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

When the RK3576 CRU DT binding got upstreamed, some DFI clocks
were missed. Add identifiers for them.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 include/dt-bindings/clock/rockchip,rk3576-cru.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/rockchip,rk3576-cru.h b/include/dt-bindings/clock/rockchip,rk3576-cru.h
index ded5ce42e62a..c5b74f2d8926 100644
--- a/include/dt-bindings/clock/rockchip,rk3576-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3576-cru.h
@@ -604,4 +604,10 @@
 #define CLK_FSPI0_TO_IO			576
 #define CLK_FSPI1_TO_IO			577
 
+/* Clocks that were missed initially */
+#define PCLK_DDR_MON_CH1		578
+#define TMCLK_DDR_MON_CH1		579
+#define CLK_DFI_CH0			580
+#define CLK_DFI_CH1			581
+
 #endif

-- 
2.53.0

