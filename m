Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796846;
	b=2y0mhYyWTSx15NyKrM89k1C+jPAQlVcw2lPyt9DUebetSrZVAn283QrD8aGqlepSrmnk
	 hfibzpFzwERH3lOLzyYc6aZwSM40r3PKiP4lu0YL2cozj6Yt9i9SHv87FZcJzU4nQF+01
	 QfEq2tvYY6owtheD1HxPp4CV2DHwhCKw67C9wh3CjhGCoHdxrUX8h6ZQvGYaljbsVN5jy
	 HgPqBFDvKj5mP7ZFvq7ILKJAJQtDUcvS4O0j3fOdBZJf1pb/1l/Z90N3sgQ8TRZl2Cngq
	 UsKAbgzq2R7f0/ILcBwTxvNNdejfdX2JTx5UOI3w7rmpCSSr3faphGION1sHI3z3bzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+Unuck0L/sShMb2nfjdX7eeGNAqWrxqSLL69bQBhGqw=;
	b=g86LfSgWUCDdx8+943KFYbOot9/yCcXnzoVyg1zDq0D3oHe0P4BUrjXVbaoDbAWmDpmz
	 DqFMxwqnKbM2a0wTxoJOtUSNiePz453byioorv4mH5CRNIlINE3l6V/7RRGZuq5b6Kikq
	 MTuRcDQYJR8xOBDCIe1xW2IGB9lofm2nsM1nBLswaOD92XuvToU/pSEndLO3qiBMEjlaz
	 EUbK4BIMh+vvkCjVCdPqZkEBLOLRTcFjVBllD5KzkACP+JuNdqD9A0T4yg0r70akKhWoD
	 le6GjjX8A5ANYJJsCm2ou4sCwNL/ji3h0Bv+qFYGvrP9jjAhbAg/5ZsK27HvtiWd92g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWY2U3gE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821F606A31F;
	Fri, 27 Nov 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWY2U3gE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEA51F00939;
	Fri, 27 Nov 2026 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796846;
	bh=+Unuck0L/sShMb2nfjdX7eeGNAqWrxqSLL69bQBhGqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWY2U3gEseWVVoDm6cU4dw0hzZLUA3VbMC6dUFrYxdr9bw92/4Ko5DS0PHE5i//lI
	 HHFm4le0C818UBgIYqM7phZh/V5f0tYUfWwsqzEZbsH7CVrPkhxjK/YS93lqtsT2u4
	 E2RiPX/lIJpEThgeLHa9AIyRnxxMUYs79oGzMCj9JDqazp8KfNMc8By3h7OmaDKobY
	 1/LHArKZP0hEgwTvD1ENtVzes5XNV3Q4mf/gcUm1gV+wEjz8O9coTt2ivxosdMTDwH
	 //1tp9U2A11smRSICElNa+KdOxyVVbGDPrV7vd1vihyj8ln6UBglxcaYvVo6zz4NCG
	 aKJ3WEJNPtRpw==
From: Geert Uytterhoeven <geert@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 03/14] clk: renesas: r8a78000: Shrink IDs to 16 bits
Date: Fri, 27 Nov 2026 17:26:48 +0100
Message-ID: <1b18c48f836202147a39385296ce9fecdb91657d.1795796064.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795796064.git.geert+renesas@glider.be>
References: <cover.1795796064.git.geert+renesas@glider.be>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Reduce table size by shrinking DT and fixed-rate clock IDs from 32 to 16
bits, which is still plenty.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v6:
  - Add Reviewed-by,

v5:
  - New.
---
 drivers/clk/renesas/r8a78000-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 03fcd128d4293cfc..236c638834703f95 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -17,8 +17,8 @@
 #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
 
 struct clk_id_map_entry {
-	u32 dt_id;		/* DT binding clock ID */
-	u32 fw_id;		/* FIXED_CLK() ID */
+	u16 dt_id;		/* DT binding clock ID */
+	u16 fw_id;		/* FIXED_CLK() ID */
 };
 
 struct clk_id_map {
-- 
2.43.0

