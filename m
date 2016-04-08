From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 7/7] ARM: dts: Add support of Bus frequency using VDD_INT for
 exynos5422-odroidxu3
Date: Fri, 08 Apr 2016 14:00:46 +0900
Message-ID: <1460091646-28701-8-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: mark.rutland@arm.com, inki.dae@samsung.com, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, cw00.choi@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux.amoon@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, devicetree@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds the bus device tree nodes for INT (Internal) block
to enable the AMBA bus frequency scaling and add the NoC (Network on Chip)
Probe Device Tree node to measure the bandwidht for AMBA AXI bus.

The WCORE bus bus is parent device in INT block using VDD_INT.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 1bd507bfa750..2a74abe6fc5d 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -361,6 +361,22 @@
 	cap-sd-highspeed;
 };
 
+&nocp_mem0_0 {
+	status = "okay";
+};
+
+&nocp_mem0_1 {
+	status = "okay";
+};
+
+&nocp_mem0_2 {
+	status = "okay";
+};
+
+&nocp_mem0_3 {
+	status = "okay";
+};
+
 &pinctrl_0 {
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
@@ -432,3 +448,86 @@
 	vdd33-supply = <&ldo9_reg>;
 	vdd10-supply = <&ldo11_reg>;
 };
+
+&bus_wcore {
+	devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
+			<&nocp_mem0_2>, <&nocp_mem0_3>;
+	vdd-supply = <&buck3_reg>;
+	exynos,saturation-ratio = <100>;
+	status = "okay";
+};
+
+&bus_noc {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_fsys_apb {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_fsys {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_fsys2 {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_mfc {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_gen {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_peri {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_g2d {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_g2d_acp {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_jpeg {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_jpeg_apb {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_disp1_fimd {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_disp1 {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_gscl_scaler {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
+
+&bus_mscl {
+	devfreq = <&bus_wcore>;
+	status = "okay";
+};
-- 
1.9.1
