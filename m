From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/3] dt-binding: clock: Add k2g clock definitions
Date: Fri, 19 Aug 2016 19:33:41 -0500
Message-ID: <20160820003342.13599-3-nm@ti.com>
References: <20160820003342.13599-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46149 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755529AbcHTAek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2016 20:34:40 -0400
In-Reply-To: <20160820003342.13599-1-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, Nishanth Menon <nm@ti.com>

From: Tero Kristo <t-kristo@ti.com>

Add identifiers for the K2G clocks managed by the PMMC.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 MAINTAINERS                     |   1 +
 include/dt-bindings/clock/k2g.h | 234 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 235 insertions(+)
 create mode 100644 include/dt-bindings/clock/k2g.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1837b98d96a9..f24aa97f845c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11577,6 +11577,7 @@ F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 F:	include/dt-bindings/genpd/k2g.h
 F:	drivers/soc/ti/ti_sci_pm_domains.c
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
+F:	include/dt-bindings/clock/k2g.h
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
diff --git a/include/dt-bindings/clock/k2g.h b/include/dt-bindings/clock/k2g.h
new file mode 100644
index 000000000000..cddffc360a13
--- /dev/null
+++ b/include/dt-bindings/clock/k2g.h
@@ -0,0 +1,234 @@
+/*
+ * TI K2G SoC clock definitions
+ *
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __DT_BINDINGS_CLOCK_K2G_H__
+#define __DT_BINDINGS_CLOCK_K2G_H__
+
+/*
+ * The clock IDs listed in this file are describing the clocks at IP's
+ * boundaries. The firmware is not exposing any of the generic clocks
+ * from the system, those are handled internally by the firmware.
+ */
+#define K2G_DEV_PMMC_MPM_VBUS_CLK		0
+#define K2G_DEV_PMMC_MPM_FUNC_32K_CLK		1
+#define K2G_DEV_PMMC_MPM_FUNC_OSC_CLK		2
+#define K2G_DEV_PMMC_MPM_DAP_CLK		3
+
+#define K2G_DEV_MLB_MLB_SYS_CLK			0
+#define K2G_DEV_MLB_MLB_SHB_OCP_CLK		1
+#define K2G_DEV_MLB_MLB_SPB_OCP_CLK		2
+#define K2G_DEV_MLB_MLB_IO_CLK			3
+#define K2G_DEV_MLB_MLBP_IO_CLK			4
+
+#define K2G_DEV_DSS_PI_DSS_OCP_CLK		0
+#define K2G_DEV_DSS_PI_DSS_VP_CLK		1
+
+#define K2G_DEV_MCBSP_VBUS_CLK			0
+#define K2G_DEV_MCBSP_CLKS			1
+#define K2G_DEV_MCBSP_CLKS_PARENT_AUDIO_OSC	2
+#define K2G_DEV_MCBSP_CLKS_PARENT_MLB_IO_CLK	3
+#define K2G_DEV_MCBSP_CLKS_PARENT_MLBP_IO_CLK	4
+#define K2G_DEV_MCBSP_CLKS_PARENT_SYS_OSCCLK	5
+#define K2G_DEV_MCBSP_CLKS_PARENT_XREFCLK	6
+#define K2G_DEV_MCBSP_CLKS_PARENT_UART_PLL	7
+
+#define K2G_DEV_MCASP_VBUS_CLK			0
+#define K2G_DEV_MCASP_AUX_CLK			1
+#define K2G_DEV_MCASP_AUX_CLK_PARENT_AUDIO_OSC		2
+#define K2G_DEV_MCASP_AUX_CLK_PARENT_MLB_IO_CLK		3
+#define K2G_DEV_MCASP_AUX_CLK_PARENT_MLBP_IO_CLK	4
+#define K2G_DEV_MCASP_AUX_CLK_PARENT_SYS_OSCCLK		5
+#define K2G_DEV_MCASP_AUX_CLK_PARENT_XREFCLK		6
+#define K2G_DEV_MCASP_AUX_CLK_PARENT_UART_PLL		7
+
+#define K2G_DEV_DCAN_VBUS_CLK			0
+#define K2G_DEV_DCAN_CAN_CLK			1
+
+#define K2G_DEV_EMIF_V_CLK			0
+#define K2G_DEV_EMIF_M_CLK			1
+#define K2G_DEV_EMIF_DFT_LOCAL_CLK		2
+#define K2G_DEV_EMIF_PUB_CTL_CLK		3
+#define K2G_DEV_EMIF_PHY_CTL_CLK		4
+#define K2G_DEV_EMIF_VBUSP_CLK			5
+
+#define K2G_DEV_MMCHS_VBUS_CLK			0
+#define K2G_DEV_MMCHS_CLK_ADPI			1
+#define K2G_DEV_MMCHS_CLK32K			2
+
+#define K2G_DEV_GPMC_GPMC_FCLK			0
+
+#define K2G_DEV_ELM_CLK				0
+
+#define K2G_DEV_SPI_VBUSP_CLK			0
+
+#define K2G_DEV_ICSS_VCLK_CLK			0
+#define K2G_DEV_ICSS_CORE_CLK			1
+#define K2G_DEV_ICSS_CORE_CLK_PARENT_ICSS_PLL	2
+#define K2G_DEV_ICSS_CORE_CLK_PARENT_NSS_PLL	3
+#define K2G_DEV_ICSS_UCLK_CLK			4
+#define K2G_DEV_ICSS_IEPCLK_CLK			5
+
+#define K2G_DEV_USB_BUS_CLK			0
+#define K2G_DEV_USB_PHYMMR_CLK			1
+#define K2G_DEV_USB_SUSP_CLK			2
+#define K2G_DEV_USB_REF_CLK			3
+#define K2G_DEV_USB_DFT_ULPI_CLK		4
+#define K2G_DEV_USB_DFT_UTMI_CLK		5
+#define K2G_DEV_USB_CLKCORE			6
+
+#define K2G_DEV_NSS_VCLK			0
+#define K2G_DEV_NSS_SA_UL_CLK			1
+#define K2G_DEV_NSS_SA_UL_X1_CLK		2
+#define K2G_DEV_NSS_ESW_CLK			3
+/*
+ * Mux register is internal to the CPTS, so we must allow NSS to control it.
+ * CPTS_REFCLK_P/N is a direct input to this mux, so ignore it is ignored
+ * in the SoC clock tree.
+ */
+#define K2G_DEV_NSS_CPTS_CHIP_CLK1_2		4
+#define K2G_DEV_NSS_CPTS_CHIP_CLK1_3		5
+#define K2G_DEV_NSS_CPTS_TIMI0			6
+#define K2G_DEV_NSS_CPTS_TIMI1			7
+#define K2G_DEV_NSS_CPTS_NSS_PLL		8
+#define K2G_DEV_NSS_GMII_RFTCLK			9
+#define K2G_DEV_NSS_RGMII_MHZ_5_CLK		10
+#define K2G_DEV_NSS_RGMII_MHZ_50_CLK		11
+#define K2G_DEV_NSS_RGMII_MHZ_250_CLK		12
+#define K2G_DEV_NSS_RMII_MHZ_50_CLK		13
+
+#define K2G_DEV_PCIE_VBUS_CLK			0
+
+#define K2G_DEV_OTP_VBUS_CLK			0
+
+#define K2G_DEV_GPIO_VBUS_CLK			0
+
+#define K2G_DEV_TIMER64_VBUS_CLK		0
+#define K2G_DEV_TIMER64_TINL			1
+#define K2G_DEV_TIMER64_TINL_PARENT_TIMI0	2
+#define K2G_DEV_TIMER64_TINL_PARENT_TIMI1	3
+#define K2G_DEV_TIMER64_TINH			4
+#define K2G_DEV_TIMER64_TINH_PARENT_TIMI0	5
+#define K2G_DEV_TIMER64_TINH_PARENT_TIMI1	6
+#define K2G_DEV_TIMER64_TOUTL			7
+#define K2G_DEV_TIMER64_TOUTH			8
+
+#define K2G_DEV_SEC_MGR_SEC_CLK_PI		0
+
+#define K2G_DEV_MSGMGR_VBUS_CLK			0
+
+#define K2G_DEV_BOOTCFG_VBUS_CLK		0
+
+#define K2G_DEV_ARM_BOOTROM_VBUS_CLK		0
+
+#define K2G_DEV_DSP_BOOTROM_VBUS_CLK		0
+
+#define K2G_DEV_DEBUGSS_VBUSP_CTTBRCLK_CLK	0
+#define K2G_DEV_DEBUGSS_VBUSP_STMD0_CLK		1
+#define K2G_DEV_DEBUGSS_VBUSP_SLAVE_CLK		2
+#define K2G_DEV_DEBUGSS_VBUSP_MASTER_CLK	3
+#define K2G_DEV_DEBUGSS_TCK			4
+#define K2G_DEV_DEBUGSS_CS_TRCEXPT_CLK		5
+#define K2G_DEV_DEBUGSS_DSP_TRACECLK		6
+#define K2G_DEV_DEBUGSS_STMXPT_CLK		7
+
+#define K2G_DEV_UART_CBA_CLK_PI			0
+
+#define K2G_DEV_EHRPWM_VBUS_CLK			0
+
+#define K2G_DEV_EQEP_VBUS_CLK			0
+
+#define K2G_DEV_ECAP_VBUS_CLK			0
+
+#define K2G_DEV_I2C_VBUS_CLK			0
+
+#define K2G_DEV_CP_TRACER_CP_TRACER_CLK		0
+
+#define K2G_DEV_EDMA_TPTC_CLK			0
+#define K2G_DEV_EDMA_TPCC_CLK			1
+
+#define K2G_DEV_SEMAPHORE_VBUS_CLK		0
+
+#define K2G_DEV_INTC_VBUS_CLK			0
+
+#define K2G_DEV_GIC_VBUS_CLK			0
+
+#define K2G_DEV_QSPI_QSPI_CLK			0
+#define K2G_DEV_QSPI_DATA_BUS_CLK		1
+#define K2G_DEV_QSPI_CFG_BUS_CLK		2
+#define K2G_DEV_QSPI_QSPI_CLK_O			3
+#define K2G_DEV_QSPI_QSPI_CLK_I			4
+
+#define K2G_DEV_ARM_64B_COUNTER_CLK_INPUT	0
+#define K2G_DEV_ARM_64B_COUNTER_VBUSP_CLK	1
+
+#define K2G_DEV_TETRIS_CORE_CLK			0
+#define K2G_DEV_TETRIS_SUBSYS_CLK		1
+
+#define K2G_DEV_CGEM_CORE_CLK			0
+#define K2G_DEV_CGEM_TRACE_CLK			1
+
+#define K2G_DEV_MSMC_VBUS_CLK			0
+
+#define K2G_DEV_DFT_SS_VBUS_CLK			0
+#define K2G_DEV_DFT_SS_TCK			1
+
+#define K2G_DEV_CBASS_VBUS_CLK			0
+
+#define K2G_DEV_SMARTREFLEX_SCLK_CLK		0
+#define K2G_DEV_SMARTREFLEX_REFCLK1_CLK		1
+#define K2G_DEV_SMARTREFLEX_TEMPMCLK_CLK	2
+
+#define K2G_DEV_EFUSE_VBUS_CLK			0
+
+/* Outputs from board (inputs to SoC) */
+#define K2G_DEV_BOARD_SYS_OSCIN			0
+#define K2G_DEV_BOARD_SYS_CLK			1
+#define K2G_DEV_BOARD_AUDIO_OSCIN		2
+#define K2G_DEV_BOARD_DDR			3
+#define K2G_DEV_BOARD_MLBCLK			4
+#define K2G_DEV_BOARD_MLBPCLK			5
+#define K2G_DEV_BOARD_XREFCLK			6
+#define K2G_DEV_BOARD_TIMI0			7
+#define K2G_DEV_BOARD_TIMI1			8
+
+/* Inputs to board (outputs from SoC) */
+#define K2G_DEV_BOARD_SYSCLKOUT			10
+#define K2G_DEV_BOARD_OBSCLK			11
+#define K2G_DEV_BOARD_OBSCLK_PARENT_MAIN_PLL	12
+#define K2G_DEV_BOARD_OBSCLK_PARENT_DSS_PLL	13
+#define K2G_DEV_BOARD_OBSCLK_PARENT_ARM_PLL	14
+#define K2G_DEV_BOARD_OBSCLK_PARENT_UART_PLL	15
+#define K2G_DEV_BOARD_OBSCLK_PARENT_ICSS_PLL	16
+#define K2G_DEV_BOARD_OBSCLK_PARENT_DDR_PLL	17
+#define K2G_DEV_BOARD_OBSCLK_PARENT_PLL_CTRL	18
+#define K2G_DEV_BOARD_OBSCLK_PARENT_NSS_PLL	19
+#define K2G_DEV_BOARD_OBSCLK_PARENT_SYSOSC	20
+#define K2G_DEV_BOARD_MII_CLKOUT		21
+#define K2G_DEV_BOARD_TIMO0			22
+#define K2G_DEV_BOARD_TIMO1			23
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_0L	24
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_0H	25
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_1L	26
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_1H	27
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_2L	28
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_2H	29
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_3L	30
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_3H	31
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_4L	32
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_4H	33
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_5L	34
+#define K2G_DEV_BOARD_TIMO_PARENT_TIMER64_5H	35
+
+#endif
-- 
2.9.1.200.gb1ec08f

