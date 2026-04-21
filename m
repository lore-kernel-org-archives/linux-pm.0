Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC228504D;
	Tue, 21 Apr 2026 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795138; cv=none; b=WWU8oweTcqEd3oXgPzEYeraicBga2OouaI3i/Dn527k1HF0Rv836nngXkxknUPbP9jOpeCzXIGw0/jIopLoVloLvamZibPh/PoKVS67gLc8lrxbxfDzHBbVtmJzjOeQM2J3nHo5aT4mUxQbEQln9eZ17bAc5ywh62V1ap7d+0D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795138; c=relaxed/simple;
	bh=fblMpjqFfnjUAr+HNDhVWeUb9w8+sGgLDBS5LTLkD1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddakym7sqJIUpFDGKXHSOnfVV4Z8u2Lz7duIEAG6cjPZbiWy8GSzCTEOpTPm3XQz3x5U6mLHXgzMoZBptYLtpVGRvBdcLxRiRQ2X6DIXeZARrSBjXi6kXeu4t/KlX06YD4DqOwXnAeotP4JYbpi56nJucUBgRi93+x5/8OTiMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5B2C2BCB0;
	Tue, 21 Apr 2026 18:12:13 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 04/14] arm64: dts: renesas: ironhide: Enable SCMI devpd, sys, and reset
Date: Tue, 21 Apr 2026 20:11:37 +0200
Message-ID: <2eb3c62df7b6ccedb525569fe34c10403e2fdcf5.1776793163.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776793163.git.geert+renesas@glider.be>
References: <cover.1776793163.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCP FW SDKv4.28.0 and later for Renesas R-Car X5H Ironhide not only
implements the SCMI base and clock management protocols, but also the
SCMI power domain, system power, and reset domain management protocols.

Enable support for the latter by adding the corresponding SCMI protocol
subnodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
index e2470257d2f32a03..2fb9557a7eb9dbb7 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
+++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
@@ -31,10 +31,24 @@ scmi: scmi {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			scmi_devpd: protocol@11 {
+			    reg = <0x11>;
+			    #power-domain-cells = <1>;
+			};
+
+			scmi_sys: protocol@12 {
+			    reg = <0x12>;
+			};
+
 			scmi_clk: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
 			};
+
+			scmi_reset: protocol@16 {
+			    reg = <0x16>;
+			    #reset-cells = <1>;
+			};
 		};
 	};
 
-- 
2.43.0

