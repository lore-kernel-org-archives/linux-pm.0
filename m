From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v7 5/8] dt-bindings: interconnect: Document qcom,
 msm8916 NoC bindings
Date: Tue, 31 Jul 2018 19:13:37 +0300
Message-ID: <20180731161340.13000-6-georgi.djakov@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180731161340.13000-1-georgi.djakov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, skannan@codeaurora.org, arnd@arndb.de, seansw@qti.qualcomm.com, khilman@baylibre.com, mturquette@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, daidavid1@codeaurora.org, evgreen@chromium.org, linux-arm-msm@vger.kernel.org, vincent.guittot@linaro.org, georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org, abailon@baylibre.com
List-Id: linux-pm@vger.kernel.org

Document the device-tree bindings Network-On-Chip interconnect driver
for Qualcomm msm8916 platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/qcom-msm8916.txt    |  39 ++++
 include/dt-bindings/interconnect/qcom.h       | 187 ++++++++++++++++++
 2 files changed, 226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
 create mode 100644 include/dt-bindings/interconnect/qcom.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
new file mode 100644
index 000000000000..f309eaed3d19
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
@@ -0,0 +1,39 @@
+Qualcomm MSM8916 Network-On-Chip interconnect driver binding
+----------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,msm8916-bimc"
+			"qcom,msm8916-pnoc"
+			"qcom,msm8916-snoc"
+- #interconnect-cells : should contain 1
+- reg : shall contain base register location and length
+
+Optional properties :
+clocks : list of phandles and specifiers to all interconnect bus clocks
+clock-names : clock names should include both "bus_clk" and "bus_a_clk"
+
+Examples:
+
+		snoc: snoc@580000 {
+			compatible = "qcom,msm8916-snoc";
+			#interconnect-cells = <1>;
+			reg = <0x580000 0x14000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+		bimc: bimc@400000 {
+			compatible = "qcom,msm8916-bimc";
+			#interconnect-cells = <1>;
+			reg = <0x400000 0x62000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+		pnoc: pnoc@500000 {
+			compatible = "qcom,msm8916-pnoc";
+			#interconnect-cells = <1>;
+			reg = <0x500000 0x11000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+		};
+
diff --git a/include/dt-bindings/interconnect/qcom.h b/include/dt-bindings/interconnect/qcom.h
new file mode 100644
index 000000000000..2177a216e17e
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm interconnect IDs
+ *
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __QCOM_INTERCONNECT_IDS_H
+#define __QCOM_INTERCONNECT_IDS_H
+
+#define MASTER_AMPSS_M0 1
+#define MASTER_AMPSS_M1 2
+#define MASTER_LPASS_PROC 11
+#define MASTER_MSS_PROCI 12
+#define MASTER_MSS_PROCD 13
+#define MASTER_MSS_MDM_PORT0 14
+#define MASTER_LPASS 15
+#define MASTER_MDP_PORT0 22
+#define MASTER_MDP_PORT1 23
+#define MASTER_ROTATOR 25
+#define MASTER_GRAPHICS_3D 26
+#define MASTER_VFE 29
+#define MASTER_SPDM 36
+#define MASTER_PCIE 45
+#define MASTER_CRYPTO 47
+#define MASTER_QDSS_BAM 53
+#define MASTER_SNOC_CFG 54
+#define MASTER_CRYPTO_CORE0 55
+#define MASTER_OCMEM_DMA 58
+#define MASTER_QDSS_ETR 60
+#define MASTER_USB3 61
+#define MASTER_JPEG 62
+#define MASTER_VIDEO_P0 63
+#define MASTER_VIDEO_P1 64
+#define MASTER_JPEG_OCMEM 66
+#define MASTER_VIDEO_P0_OCMEM 68
+#define MASTER_DEHR 75
+#define MASTER_QDSS_DAP 76
+#define MASTER_TIC 77
+#define MASTER_SDCC_1 78
+#define MASTER_SDCC_2 81
+#define MASTER_TSIF 82
+#define MASTER_BLSP_2 84
+#define MASTER_BLSP_1 86
+#define MASTER_USB_HS 87
+#define MASTER_IPA 90
+#define MASTER_UFS 95
+#define MASTER_PCIE_1 100
+#define MASTER_USB3_1 101
+#define MASTER_CNOC_MNOC_MMSS_CFG 102
+#define MASTER_CNOC_MNOC_CFG 103
+#define MASTER_TCU_0 104
+#define MASTER_TCU_1 105
+#define MASTER_CPP 106
+
+#define SNOC_MM_INT_0 10000
+#define SNOC_MM_INT_1 10001
+#define SNOC_MM_INT_2 10002
+#define SNOC_MM_INT_BIMC 10003
+#define SNOC_INT_0 10004
+#define SNOC_INT_1 10005
+#define SNOC_INT_BIMC 10006
+#define SNOC_BIMC_0_MAS 10007
+#define SNOC_BIMC_1_MAS 10008
+#define SNOC_QDSS_INT 10009
+#define PNOC_SNOC_MAS 10010
+#define PNOC_SNOC_SLV 10011
+#define PNOC_INT_0 10012
+#define PNOC_INT_1 10013
+#define PNOC_M_0 10014
+#define PNOC_M_1 10015
+#define BIMC_SNOC_MAS 10016
+#define BIMC_SNOC_SLV 10017
+#define PNOC_SLV_0 10018
+#define PNOC_SLV_1 10019
+#define PNOC_SLV_2 10020
+#define PNOC_SLV_3 10021
+#define PNOC_SLV_4 10022
+#define PNOC_SLV_8 10023
+#define PNOC_SLV_9 10024
+#define SNOC_BIMC_0_SLV 10025
+#define SNOC_BIMC_1_SLV 10026
+#define BIMC_MNOC_MAS 10029
+#define BIMC_MNOC_SLV 10030
+#define SNOC_BIMC_MAS 10031
+#define SNOC_BIMC_SLV 10032
+#define CNOC_SNOC_MAS 10033
+#define CNOC_SNOC_SLV 10034
+#define SNOC_CNOC_MAS 10035
+#define SNOC_CNOC_SLV 10036
+#define SNOC_PNOC_MAS 10041
+#define SNOC_PNOC_SLV 10042
+#define BIMC_INT_APPS_EBI 10043
+#define BIMC_INT_APPS_SNOC 10044
+#define SNOC_BIMC_2_MAS 10045
+#define SNOC_BIMC_2_SLV 10046
+#define PNOC_SLV_5 10047
+#define PNOC_SLV_7 10048
+#define PNOC_INT_2 10049
+#define PNOC_INT_3 10050
+#define PNOC_INT_4 10051
+#define PNOC_INT_5 10052
+#define PNOC_INT_6 10053
+#define PNOC_INT_7 10054
+
+#define SLAVE_EBI_CH0 512
+#define SLAVE_AMPSS_L2 514
+#define SYSTEM_SLAVE_FAB_APPS 517
+#define SLAVE_SYSTEM_IMEM 519
+#define SLAVE_MSS 521
+#define SLAVE_LPASS 522
+#define SLAVE_SPDM 533
+#define SLAVE_RPM_MSG_RAM 535
+#define SLAVE_MPM 536
+#define SLAVE_TSIF 575
+#define SLAVE_MSM_PDM 577
+#define SLAVE_MSM_TCSR 579
+#define SLAVE_USB3 583
+#define SLAVE_OCIMEM 585
+#define SLAVE_SERVICE_SNOC 587
+#define SLAVE_QDSS_STM 588
+#define SLAVE_CAMERA_CFG 589
+#define SLAVE_DISPLAY_CFG 590
+#define SLAVE_CPR_CFG 592
+#define SLAVE_MISC_CFG 594
+#define SLAVE_VENUS_CFG 596
+#define SLAVE_GRAPHICS_3D_CFG 598
+#define SLAVE_MMSS_CLK_CFG 599
+#define SLAVE_MNOC_MPU_CFG 601
+#define SLAVE_SERVICE_MNOC 603
+#define SLAVE_OCMEM 604
+#define SLAVE_SDCC_1 606
+#define SLAVE_SDCC_2 608
+#define SLAVE_SDCC_4 609
+#define SLAVE_BLSP_2 611
+#define SLAVE_BLSP_1 613
+#define SLAVE_USB_HS 614
+#define SLAVE_PDM 615
+#define SLAVE_PRNG 618
+#define SLAVE_CLK_CTL 620
+#define SLAVE_SECURITY 622
+#define SLAVE_TCSR 623
+#define SLAVE_TLMM 624
+#define SLAVE_CRYPTO_0_CFG 625
+#define SLAVE_CRYPTO_1_CFG 626
+#define SLAVE_IMEM_CFG 627
+#define SLAVE_MESSAGE_RAM 628
+#define SLAVE_BIMC_CFG 629
+#define SLAVE_BOOT_ROM 630
+#define SLAVE_CNOC_MNOC_MMSS_CFG 631
+#define SLAVE_PMIC_ARB 632
+#define SLAVE_SPDM_WRAPPER 633
+#define SLAVE_DEHR_CFG 634
+#define SLAVE_QDSS_CFG 635
+#define SLAVE_RBCPR_CFG 636
+#define SLAVE_RBCPR_QDSS_APU_CFG 637
+#define SLAVE_SNOC_MPU_CFG 638
+#define SLAVE_CNOC_ONOC_CFG 639
+#define SLAVE_CNOC_MNOC_CFG 640
+#define SLAVE_PNOC_CFG 641
+#define SLAVE_SNOC_CFG 642
+#define SLAVE_EBI1_DLL_CFG 643
+#define SLAVE_PHY_APU_CFG 644
+#define SLAVE_EBI1_PHY_CFG 645
+#define SLAVE_SERVICE_CNOC 646
+#define SLAVE_IPS_CFG 647
+#define SLAVE_QPIC 648
+#define SLAVE_DSI_CFG 649
+#define SLAVE_UFS_CFG 650
+#define SLAVE_RBCPR_CX_CFG 651
+#define SLAVE_RBCPR_MX_CFG 652
+#define SLAVE_PCIE_CFG 653
+#define SLAVE_USB_PHYS_CFG 654
+#define SLAVE_VIDEO_CAP_CFG 655
+#define SLAVE_VPU_CFG 658
+#define SLAVE_OCMEM_GFX 662
+#define SLAVE_CATS_128 663
+#define SLAVE_OCMEM_64 664
+#define SLAVE_PCIE_0 665
+#define SLAVE_PCIE_1 666
+#define SLAVE_PCIE_0_CFG 667
+#define SLAVE_PCIE_1_CFG 668
+#define SLAVE_TCU 672
+#define SLAVE_APPSS 673
+
+#endif
