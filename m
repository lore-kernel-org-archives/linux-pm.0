Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031205;
	b=pk8Dd2rm6PKZsERsQgB6bBd3fMa+PCAeIR+MEFtww2hNESe00BPb6MWGyoG1tRRkT2Cp
	 ppnjK5Pfrwr51bZDUeQ3s9DnefPDaj7ccQEtlhshQuYoF2GADsUidUTHtzp7BkgTEOb6c
	 jzkPUqRTDuJfPTQOLaGSKOSSzUicdWcpjlCHECoDPx+SdRm5EJWRC6fgzYo0m+NyIQ8Mb
	 zi8mOfdcc29YSGtaNVVG9qwnOWXhg5pv0qp73FWAD+V1frgxQtlgy/86T6XZIPS4iY4Pf
	 Wt5UHn5VpUaRTbORaYUDm+4hrwyLll2lhlRIad5oL4zCVSA00f3oZdvbanu8i0jI+og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031205;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=dP3XDxcbkDxBHVzVunybo/0fEra3abNXamUCZJfJJlU=;
	b=r0X4cEVeLznI2Xmfdo6Ujrl0jjOpzmpmbkvYW5d30FFSHSu/5JzgjivHcR4hdZvsygZ3
	 baCJw9Cs4REC7Ud1sTex/2MUNYXQ6RxUkhQhXIcIRrTxZW+ebb+71IgEknQATZsLqXo3v
	 2b+4PtWLF0lBSJPld3F+Fr4b+8zGUaMULdhh8pucEES/5jqagYKntgGgr4qaR3kRXDEty
	 scCgf00CUHfABopm2p7S0tcsP0socnj3yRgdFHl0aN7fCa4I/VNJ0Fhp1ZPUKN4Kw6cLJ
	 GQUGzBDjKQmL/PVFbcGy0X3CtLurb+BoDw8EJk1n4BujiMze8VavM9Dvm4Yv8sd9tBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BDF606A320;
	Wed, 18 Nov 2026 19:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159091F000C4;
	Wed, 18 Nov 2026 19:46:39 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
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
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 15/15] arm64: dts: renesas: ironhide: Enable SCMI devpd, sys, clock, and reset
Date: Wed, 18 Nov 2026 20:45:03 +0100
Message-ID: <066ce69ad5d9b6a041ef4bf36ad5e75f87ccb421.1795029012.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795029012.git.geert+renesas@glider.be>
References: <cover.1795029012.git.geert+renesas@glider.be>
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

SCP FW SDKv4.28.0 and later for Renesas R-Car X5H Ironhide not only
implement the SCMI base protocol, but also the SCMI power domain, system
power, clock, and reset domain management protocols.

Enable support for the latter by adding the corresponding SCMI protocol
subnodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v5:
  - Add Tested-by,

v4:
  - No changes,

v3:
  - No changes,

v2:
  - Fix misindentations,
  - Add scmi_clk node, as it is no longer added in earlier commits.
---
 .../boot/dts/renesas/r8a78000-ironhide.dts    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
index b2d6b06c63881896..ade8bcd3a0e5ee8b 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
+++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
@@ -31,6 +31,25 @@ scmi: scmi {
 			arm,no-completion-irq;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			scmi_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_sys: protocol@12 {
+				reg = <0x12>;
+			};
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
 		};
 	};
 
-- 
2.43.0

