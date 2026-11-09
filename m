Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231293;
	b=DMY/SZ0+Jia38stJcufIvWc0OTaRHqJ4QjN47itVo6bb9s+eSA93QR9zPiepxomTCKe1
	 vK9iZKuL8pFHPJfQsOR7ZaQNnaOBJZAcPGcuJ7it2iSccZrDyPjZjdk91Nh4/A2ZlUd6u
	 FSdTnUcq+CPbI7axfNi5TVSaoT5mj9bn8sbsXxq4GBHsG34iGCCyu2Wv9athsgmajiS9B
	 HWE/RUuNU/3IzM+qk0DP4938nSNlyiXU0eO2O2z3fuWLNeY88qs2RbXFN4X6p9qHtRoVL
	 ALXX9f5o/a/td6lUY/64rzN91xhXRibvtaGeerVEIc4/cl3k2bGDkLKDv0BxY/j3tDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231293;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=oRUyjp5FKvQ9juN4Vc+B3Vss9s8WsUkwnZUNCwvuQMw=;
	b=vYba07RyNiN6HvcmMUavsZJqRu4ZVYUhR7OyZAs9Slhw+24iFCbbbzdx3OW2bvYlEQ9w
	 mRtXhzVA3QJ3c6FLug+BE8u0ZAgbMYPF+KsSXImvuZ8I5GIUZYVwXkMQzflpfV7mxmxDO
	 8ujS3fntvKTHXkMSf/ieqdNQk2/vE+AZbVqz/asMUVe4oM+rlkS8B+4Ol49n5ZlSfpob+
	 eI7pTiMM/3x5j2JFzASiTBnQi3IKeuvf/6YMkNgK1Ix0r/bqBO1bZENxuCxm2C40uYCcs
	 amn7pbesmAwO9NMRIvFRsqXdMEns62xnrE4eqATCm2AjMOrv36RLY7h/lEP49YDN35A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=eR3sRap4;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65979606A322;
	Mon,  9 Nov 2026 13:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65979606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=eR3sRap4
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3283CDA8;
	Mon,  9 Nov 2026 14:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231149;
	bh=K/s9v+4fxec2xSJTTOOywr807fv1+rY0tqQW2d4W1C4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eR3sRap4ezju4b45KY43joWpc1UEz4YCNpgNmmUP+zNx+BYZeldhT23zfTO3LCmJ0
	 oQGt52h/QE+CiOLv0WAqKRuB01s3UCa+ut/qfSqldIaD5db7zhlVMHegN8xjftHn+v
	 kqbKXt33qAcCJcXZtdXvmLhF/u6b82eBbRutwsKI=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:22 +0900
Subject: [PATCH v4 01/13] dt-bindings: clock: renesas,r8a78000-cpg: Add
 CPG_SGDn_VIO_DP_{TX,OTHER}
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-1-1b2072e8c37e@ideasonboard.com>
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
 Paul Elder <paul.elder+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

Add the CPG_SGDn_VIO_DP_TX and CPG_SGDn_VIO_DP_OTHER clocks that are
used by FCPV, VSP, VCON, and DPTX cores.

It should be noted that there is likely a discrepancy regarding the
clocks. In practice it ought not to be an issue as all the clocks derive
from the same SGD1_VIO_MAIN clock and none of them are programmable or
gateable.

According to the datasheet, the FCPV[BID] and VSPD cores use
SGD*_VIO_DP_TXφ while the VSP[BI] cores use SGD*_VIO_DP_OTHERφ.
However, educated guessing suggests that IP cores in the same pipeline
should be using the same clocks:
- FCPV[BI] -> VSP[BI]:                  SGD*_VIO_DP_OTHERφ
- FCPVD -> VSPD -> VCON -> DPTX:        SGD*_VIO_DP_TXφ

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>

---
Changes in v4:
- Add all the clocks
- remove DNI
- add notes about suspected clock naming
---
 include/dt-bindings/clock/renesas,r8a78000-cpg.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r8a78000-cpg.h b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
index 9d7f3afcb2c52ec4caac574b75810822ad3d59c4..0b2822785a669d99fc0724852e39ec7aa56839ea 100644
--- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
+++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
@@ -32,5 +32,15 @@
 #define R8A78000_CPG_SGASYNCD16_PERW_MAIN	22
 #define R8A78000_CPG_S0ASYNCD8_PERW_MAIN	23
 #define R8A78000_CPG_CANFD_SCP_MAIN		24
+#define R8A78000_CPG_SGD1_VIO_DP_TX		25
+#define R8A78000_CPG_SGD2_VIO_DP_TX		26
+#define R8A78000_CPG_SGD4_VIO_DP_TX		27
+#define R8A78000_CPG_SGD8_VIO_DP_TX		28
+#define R8A78000_CPG_SGD16_VIO_DP_TX		29
+#define R8A78000_CPG_SGD1_VIO_DP_OTHER		30
+#define R8A78000_CPG_SGD2_VIO_DP_OTHER		31
+#define R8A78000_CPG_SGD4_VIO_DP_OTHER		32
+#define R8A78000_CPG_SGD8_VIO_DP_OTHER		33
+#define R8A78000_CPG_SGD16_VIO_DP_OTHER		34
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */

-- 
2.47.3

