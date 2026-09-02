Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4047CC78;
	Wed,  2 Sep 2026 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348661; cv=none; b=PN59yvfB6p7UF1fOVouMP/gfH46VBpOG7P6W8CG4dYoBOvLMoV33Q0WbqzS9YLjvgFPaxUPgEaqFJfVAWhcY70cWTU6jtk9GThj8LIj3hRb1kqj4tpGzBTm47ortN8ttfaInXwZhBMLPJuyvF3sIahM/8s/OtcJL7MRQ7iZyfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348661; c=relaxed/simple;
	bh=qSUGGCiyT2Hcvo0aCnkiMLLTcEWs3wCY//Dr6hwM1b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOJSyjRsembPA++bQKb/vSe5wdDDsTggIRXFRFP6kOFRVJ2ObX8NTXkGWnpc75kIQAgnPuqHRCI87iJAzpgmZOM0qJ6rkSylyI00BatUPOqCnQlaeu92dOeV1LDtiOAk2EzzQEbsliX0d5ITqdXj2dGDthuNfUCnkbSZudw1oFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE291F00A3A;
	Wed,  2 Sep 2026 11:30:46 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
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
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>
Cc: devicetree@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 12/12] arm64: dts: renesas: ironhide: Add CPG/MDLC renesas,scmi-firmware properties
Date: Wed,  2 Sep 2026 13:29:28 +0200
Message-ID: <da82ca150ef0bae62ba61b60376103c262f60ebc.1788338320.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788338320.git.geert+renesas@glider.be>
References: <cover.1788338320.git.geert+renesas@glider.be>
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
v3:
  - s/firmware/renesas,scmi-firmware/,

v2:
  - No changes.
---
 .../boot/dts/renesas/r8a78000-ironhide.dts    | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
index 04291f04da2b7fb5..a6f055a1f38a8449 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
+++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
@@ -170,6 +170,10 @@ ecc@1e66660000 {
 	};
 };
 
+&cpg {
+	renesas,scmi-firmware = <&scmi>;
+};
+
 &extal_clk {
 	clock-frequency = <16666600>;
 };
@@ -183,6 +187,118 @@ &hscif0 {
 	status = "okay";
 };
 
+&mdlc_aon {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_cmnn {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_cmns {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_ddr0 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_ddr1 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_ddr2 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_ddr3 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_ddr4 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_ddr5 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_ddr6 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_ddr7 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_dsp {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_gpc {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_hscn {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_hscs {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_imn {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_ims {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_mm {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_npu0 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_npu1 {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_pere {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_perw {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_rt {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_scp {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_top {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_vio {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_vipn {
+	renesas,scmi-firmware = <&scmi>;
+};
+
+&mdlc_vips {
+	renesas,scmi-firmware = <&scmi>;
+};
+
 &mfis_scp {
 	status = "okay";
 };
-- 
2.43.0

