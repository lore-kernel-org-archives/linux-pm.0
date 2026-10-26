Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026564;
	b=NJ4PpFd6ibk2nC+LWt74l9a7O3rNjJgIp/pgNSWX+mT+RjlB3P2t4+XQjSxNzTOYijx0
	 9YfCORAXvLlrmaPFj+cKASPYOSaMTf+JNC0AdYRUuVpQsyGG9ubPN6qxXX3R8RasJ6zIr
	 zNlAIb80YuPnfFs81foHfaESc8SQJGj6vajTJWbKw0KNK+vctEKNyvz2U2xRu5hiLviGM
	 ldfOiHN0uSN+PO+SlloGkD7dG/+6+41oybWAdQsaKZAoNOoPauQ1BYoaF2xjAZu+IVEqT
	 SKSNJkGusw3ki2vL//YQtSd/h+dIRgocb6pL2sDsKz3nwf9TSj/dRte9pNBBZ+U31ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026564;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=wLFuu8tZf1E/YQuDfViod9+RbMD86cfFucSt/ed8wOA=;
	b=eSJuR++976Dgzvv/y3I4RCjjgXO5btwbk6ASb26IGTe9D+C2uEfVjKP64mdD6zF1XqMV
	 JYIbPbj7yp0CUTm7YZ+BX9s0APyBn5ruqwjR9SYD873IwEKc+/W4iH8svX/+2YOO7OfDU
	 oK290irJTWnG5OhSbS3tjscDJ5d3fQeZB13tNYaaIBg+jI256jrpScL8swjsELBxk0ldT
	 LHjszH0ED7EbFONV2WAOLwtsIyDgTng2kGhcvbjjxc7pZZf3d9y5mVi5zPMGgxDe0G7/e
	 H2mgWGj6VvcZn6fD1JlcKjDsrQyP4F/zFnbSrF4hAx8ZwfTdE3g8ivXP95rabKDTM/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73353606A31B;
	Mon, 26 Oct 2026 14:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD6E1F031E0;
	Mon, 26 Oct 2026 14:56:00 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM clocks
Date: Mon, 26 Oct 2026 15:55:23 +0100
Message-ID: <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793026273.git.geert+renesas@glider.be>
References: <cover.1793026273.git.geert+renesas@glider.be>
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

Add definitions for the clocks used by the PWM modules on R-Car X5H:
 - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
 - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH 2/7] dt-bindings: clock: renesas,r8a78000-cpg:
Add GPIO clocks"
https://lore.kernel.org/624a9fb09e4ec74b1995797e5121b86e7206f5f2.1792776697.git.geert+renesas@glider.be
---
 include/dt-bindings/clock/renesas,r8a78000-cpg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r8a78000-cpg.h b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
index cd7192ccecd4e22c..8c30476d41448cf5 100644
--- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
+++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
@@ -28,5 +28,8 @@
 #define R8A78000_CPG_SGD8_PERW_BUS		18
 #define R8A78000_CPG_SGD32_PERW_BUS		19
 #define R8A78000_CPG_S0D24_HSCN_OTHER		20
+#define R8A78000_CPG_SGASYNCD8_PERW_MAIN	21
+#define R8A78000_CPG_SGASYNCD16_PERW_MAIN	22
+#define R8A78000_CPG_S0ASYNCD8_PERW_MAIN	23
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */
-- 
2.43.0

