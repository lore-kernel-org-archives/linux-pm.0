Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777985;
	b=XuM464YNeOmiWr9BWSMEC/DkB9VsYHklLtpTnROyOMEBHswJKS0r3MR1HTvn52h+ycTj
	 +s+LCz5rBg+qzeDbosWP2+h4aLdXRzZ9qmhpEqUNF8K7m9YDFL+DY2KiD++P4dPw2AZl3
	 iQ5MrnBBUVmxA4q+HR5Dru4PPomiHnIXEv6omOBgciub5qircCYKZwWFfz5tNiuPBvbL8
	 cmqKNQnbRumjnAiYNBaa8DzhUmYfkSQJ32JRhZcr8bZkxDjMdq7+B46xBJCVI7US8N5JY
	 Vq2qc+cjBDX4qr8ambD4X4CVi2/iPRhE2wyhiL0r6LLTkC1rWLxP8ZTjGJ2Wqn9KsLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777985;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=cmw0kJvPlogc0Dq5lVT/xEgR88keU7nR4P6aPNL3aqg=;
	b=MBy+w/ccLCWx/RveHjgsuXUz7V3h/D50J7sThPBiIaKxiARRg8w0j9Nrq0jXDJyk0Hd1
	 jn1gJkX2MhFR3dkDWEplmRegTEnyq4UwaQwliY3q61gcmegM28miLFi5NodaiA3LhWfhE
	 j4z73Bl7bz80EOpNutYJ+f73SePqFhSATmWsfqXZDR21QlUv9BVDfoTwzDvWGlMtZLcz/
	 zxm0/dhN/o0VuOIW3/+PscSs6P/Hj7+vDelNxA7BIMVOSXiRkrxqEY73CMUSYFcoMYOSj
	 ZxNYKxLEGwcY1n9o8OqHGPN9vTG5fzgzDQbpY1zDgDdc+9aBgj9K9yKMtnVg5KQreNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612DA606A31F;
	Fri, 23 Oct 2026 17:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A3D1F01825;
	Fri, 23 Oct 2026 17:52:50 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/7] dt-bindings: clock: renesas,r8a78000-cpg: Add GPIO clocks
Date: Fri, 23 Oct 2026 19:50:40 +0200
Message-ID: <624a9fb09e4ec74b1995797e5121b86e7206f5f2.1792776697.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792776697.git.geert+renesas@glider.be>
References: <cover.1792776697.git.geert+renesas@glider.be>
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

Add definitions for the clocks used by the GPIO modules on R-Car X5H:
  - R8A78000_CPG_SCPBUSD16_SCP_MAIN,
  - R8A78000_CPG_S0D24_PERE_MAIN,
  - R8A78000_CPG_SGD32_PERW_BUS,
  - R8A78000_CPG_S0D24_HSCN_OTHER.
Include a few more clocks from the same groups for ordering consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/dt-bindings/clock/renesas,r8a78000-cpg.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r8a78000-cpg.h b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
index 14b3885f2d9933a3..cd7192ccecd4e22c 100644
--- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
+++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
@@ -12,5 +12,21 @@
 #define R8A78000_CPG_SGASYNCD16_PERW_BUS	2
 #define R8A78000_CPG_MSO_SCP_MAIN		3
 #define R8A78000_CPG_MSOCK_PERW_BUS		4
+#define R8A78000_CPG_SCPBUSD1_SCP_MAIN		5
+#define R8A78000_CPG_SCPBUSD2_SCP_MAIN		6
+#define R8A78000_CPG_SCPBUSD4_SCP_MAIN		7
+#define R8A78000_CPG_SCPBUSD6_SCP_MAIN		8
+#define R8A78000_CPG_SCPBUSD8_SCP_MAIN		9
+#define R8A78000_CPG_SCPBUSD16_SCP_MAIN		10
+#define R8A78000_CPG_SCPBUSD32_SCP_MAIN		11
+#define R8A78000_CPG_S0D1_PERE_MAIN		12
+#define R8A78000_CPG_S0D2_PERE_MAIN		13
+#define R8A78000_CPG_S0D3_PERE_MAIN		14
+#define R8A78000_CPG_S0D4_PERE_MAIN		15
+#define R8A78000_CPG_S0D8_PERE_MAIN		16
+#define R8A78000_CPG_S0D24_PERE_MAIN		17
+#define R8A78000_CPG_SGD8_PERW_BUS		18
+#define R8A78000_CPG_SGD32_PERW_BUS		19
+#define R8A78000_CPG_S0D24_HSCN_OTHER		20
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */
-- 
2.43.0

