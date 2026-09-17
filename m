Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA5595739;
	Thu, 17 Sep 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653862; cv=none; b=ONtYn+FK2zZijWBvDEPzwVWCV/ptRfw4vt1mfAtDuQvTxIFQo7ZXPsmXPYBIVSKd7doQJL6++zFYpQ4zE9ShgFVvu/Pb6y8LvsQsvxuPusBTBQQZdRYe4LLltA0NkdJhpQLGQRc6bYahS9N39RqmsG4r0xtA6udG/S254DX88OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653862; c=relaxed/simple;
	bh=+lY5BeFcwV5FB838TAcxY9ito2AIXwIBAsYU2ILeoMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPonqMOyYcA5hrzn9di70qSoJWr/xwnGKTkR26GigaNtct1fjgr8iOUJFuwed23AzJlu5t3LIpu0q9yialLAIEQMDaDWmzw8eZMlU95QOLH3alHYYA3j0BO+MI3WjIaOTWSTb41uIcIGiEdYMVa1PUVhkch9CknRLOtMfJbMKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GSO8Nouh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GSO8Nouh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789653858;
	bh=+lY5BeFcwV5FB838TAcxY9ito2AIXwIBAsYU2ILeoMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GSO8NouhnIrUU1B3YujfbZvvE7+mLDvWytQ2vcQlxnMqyetbYJgXGwIAG4ZZBA2/w
	 OsJHnYjRJlwDaDA0Qx+OYr71laPfDa1VH99m2dUjKdeSvv4ZqPqetDVdN1J+ZVU3Lc
	 E+drHNYvWUlQWwgebSB1erGyAmKSSW6HByr+8U7F1GbLVFgqnLEtgNCGVrV2R+gpjD
	 1M5qV4dgYxndIcz61dAk+JZ/MQ5bP3V6MOPaIx4Xanx7H4mjX+AIIqe0Soa+drlhJj
	 MSquWTWgYoKbPWCwTo2wzbb7Am8GlVvPqxGfSwzdsYfBvzeRvpwUifVN+F1TnX40tX
	 HHCkWfhUwH44w==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A82017E0074;
	Thu, 17 Sep 2026 16:04:18 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E4586480029; Thu, 17 Sep 2026 16:04:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 16:04:07 +0200
Subject: [PATCH 1/7] dt-bindings: clock: rk3576: add more DFI clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-rockchip-dfi-rk3576-support-v1-1-a5752a29f7bd@collabora.com>
References: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
In-Reply-To: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
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
 b=kA0DAAoB2O7X88g7+poByyZiAGqr82Gg+ziNO8WErazFJTt5jJP61npnkoV6x1KcGnWH6jxJu
 YkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq/NhAAoJENju1/PIO/qarQgP+wdz
 V84TmRG89qN3+4xvPAMg6GvMv160aZD+ZJ/ND6VqWuNxshjwQg9zOfk5KDWOCpU1GksL+6p78Td
 8k0xyuNOLirZe25JfyqxQogMiI06RdOGeQwb6MhS/CsLbSalokUqsJk+htIvjCj/HnIPT6MYknG
 oMSzql+ZtuGKKP6LKVHQswxrhIUw+KhSCeAJFHNYNGFXZTG8S27CZuO+FJRwGgLQJsozoDKnEAJ
 xIyYaC0HfXhwy0I43moMQEFXbz8DYOWb+W50SpIBMpDa0HunpRoS6ONn9PimpGICFboUQKTDhpc
 EDFpExCjKLzYHea7NNYg4fre1MJ+/MdBR5z7/SOCo7YAy1dtLI+leFsqxjz2EEoQlETkQ9S74Cy
 7HVT3XQoNeLwlq+aK6LY1WOXFlxDlJIC03cgE5YY/b4ep0OgtoTuvlcmO6L9NFZHjvEvXzUkwES
 /3OUVXY/xspfEFPu4eGfSMRGmXuRyuEjapwSrrus3n0aZTEqtUSH7woN4siDJlqJPiRT+deUble
 prz9xlUQnNfQDMJ8+MveNBJGeLN2ZH/Wr6ggW5a/T0au/QjYYpznS5L0ffagrrMNzeWKVy5AR8v
 xQzGxMAg5LHMooZ/3nWFZHXsqe6EWFSvrZpgeI8tyKiZqtlbTglWd5Dme1SAeU2ovF3w6qGqocW
 GYFHE
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

