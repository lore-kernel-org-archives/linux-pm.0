Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB3126BF1;
	Wed,  8 Jul 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526435; cv=none; b=qn/R7EckrBqHB+FCBS3udk9RhrmK5dmOht8f35y7DPEGeOngya1gBsuHKWCQML5yaNlRdIYcilAlTjhh6XM8HR0c4Kx8bIYd1lACZ5Gzol20fI7ImxxbUgeCgKaBZXX5jbk1mc5W8TPoRrewK8p5OfhZn9CMH3kKVwy1i+zH5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526435; c=relaxed/simple;
	bh=6kbQQOgGrWyajJuCinW6QYuzMtl46e07MNhrVNKCJtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNqbXEv9Xkov+Aj17RCFF6Z7HidLRz0QMA/TT5py755vpRs9ptaA9ZHmxqw7eG7k3CdE2Vgzmu85Qm0Cn3f/6f0dlKH4a/GS40B9BKoQbt1sJRKC/iYsjBW5Oj+/fmKaDT7IghRAxQzoUtiipHc/tsMy7+MXz6bsbvWjdxSKBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C465B1F000E9;
	Wed,  8 Jul 2026 16:00:28 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 10/10] arm64: dts: renesas: ironhide: Add CPG/MDLC firmware properties
Date: Wed,  8 Jul 2026 18:00:20 +0200
Message-ID: <b3bf4e1f45bf7fba9a4c4f2f0961ce2986ea02ff.1783505329.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783505329.git.geert+renesas@glider.be>
References: <cover.1783505329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link the various Clock Pulse Generator (CPG) and Module Controller
(MDLC) device nodes to their SCMI provider.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 .../boot/dts/renesas/r8a78000-ironhide.dts    | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
index 00b5a010b7247722..5c009df903771687 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
+++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
@@ -129,6 +129,10 @@ tee@8c400000 {
 	};
 };
 
+&cpg {
+	firmware = <&scmi>;
+};
+
 &extal_clk {
 	clock-frequency = <16666600>;
 };
@@ -142,6 +146,118 @@ &hscif0 {
 	status = "okay";
 };
 
+&mdlc_aon {
+	firmware = <&scmi>;
+};
+
+&mdlc_cmnn {
+	firmware = <&scmi>;
+};
+
+&mdlc_cmns {
+	firmware = <&scmi>;
+};
+
+&mdlc_ddr0 {
+	firmware = <&scmi>;
+};
+
+&mdlc_ddr1 {
+	firmware = <&scmi>;
+};
+
+&mdlc_ddr2 {
+	firmware = <&scmi>;
+};
+
+&mdlc_ddr3 {
+	firmware = <&scmi>;
+};
+
+&mdlc_ddr4 {
+	firmware = <&scmi>;
+};
+
+&mdlc_ddr5 {
+	firmware = <&scmi>;
+};
+
+&mdlc_ddr6 {
+	firmware = <&scmi>;
+};
+
+&mdlc_ddr7 {
+	firmware = <&scmi>;
+};
+
+&mdlc_dsp {
+	firmware = <&scmi>;
+};
+
+&mdlc_gpc {
+	firmware = <&scmi>;
+};
+
+&mdlc_hscn {
+	firmware = <&scmi>;
+};
+
+&mdlc_hscs {
+	firmware = <&scmi>;
+};
+
+&mdlc_imn {
+	firmware = <&scmi>;
+};
+
+&mdlc_ims {
+	firmware = <&scmi>;
+};
+
+&mdlc_mm {
+	firmware = <&scmi>;
+};
+
+&mdlc_npu0 {
+	firmware = <&scmi>;
+};
+
+&mdlc_npu1 {
+	firmware = <&scmi>;
+};
+
+&mdlc_pere {
+	firmware = <&scmi>;
+};
+
+&mdlc_perw {
+	firmware = <&scmi>;
+};
+
+&mdlc_rt {
+	firmware = <&scmi>;
+};
+
+&mdlc_scp {
+	firmware = <&scmi>;
+};
+
+&mdlc_top {
+	firmware = <&scmi>;
+};
+
+&mdlc_vio {
+	firmware = <&scmi>;
+};
+
+&mdlc_vipn {
+	firmware = <&scmi>;
+};
+
+&mdlc_vips {
+	firmware = <&scmi>;
+};
+
 &mfis_scp {
 	status = "okay";
 };
-- 
2.43.0

