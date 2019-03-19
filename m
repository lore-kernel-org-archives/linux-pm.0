From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH v2 0/5] Add support for drm/rockchip to dynamically control the DDR frequency.
Date: Tue, 19 Mar 2019 14:13:18 -0400
Message-ID: <20190319181323.22804-1-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com, =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
List-Id: linux-pm@vger.kernel.org

Dear all,

The rk3399 platform has a DFI controller that can monitor DDR load and a
DMC driver that talks with the TF-A (Trusted Firmware-A) to dynamically
set the DDR frequency with following flow.

             kernel                          Trusted Firmware-A
                                                  (bl31)
        monitor ddr load
                |
                |
        get_target_rate
                |
                |           pass rate to TF-A
        clk_set_rate(ddr) --------------------->run ddr dvs flow
                                                    |
                                                    |
                 <------------------------------end ddr dvs flow
                |
                |
              return

These patches add support for devfreq to dynamically control the DDR
frequency into the drm rockchip driver. By default it uses the
'simple_ondemand' governor which can adjust the frequency based on the
DDR load.

Waiting for your feedback.

Best regards,
Gaël

Changes in v2:
- [PATCH 1/8] Really add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>.
- [PATCH 4/8] Removed from patchset.
- [PATCH 5/8] Removed from patchset.
- [PATCH 6/8] Removed from patchset.
- [PATCH 7/8] Reword the commit message to reflect the removal of
              rk3390-dram-default-timing.dts in v1.
- [PATCH 8/8] Move center-supply attribute of dmc node in file
              rk3399-gru-chromebook.dtsi (where ppvar_centerlogic is
	      defined).

Changes in v1:
- [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
- [RFC 1/10] s/Generic/General/ (Robin Murphy)
- [RFC 2/10] Add reviewed and acked tags from Chanwoo Choi and Rob Herring
- [RFC 3/10] Add an explanation for platform SIP calls.
- [RFC 3/10] Change if statement for a switch.
- [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
- [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
- [RFC 7/10] Removed from the series. I did not found a use case where this matters.
- [RFC 8/10] Move rk3399-dram.h to dt-includes.
- [RFC 8/10] Put sdram default values under the dmc node.
- [RFC 8/10] Removed rk3399-dram-default-timing.dts


Enric Balletbo i Serra (3):
  devfreq: rockchip-dfi: Move GRF definitions to a common place.
  dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.
  devfreq: rk3399_dmc: Pass ODT and auto power down parameters to TF-A.

Lin Huang (2):
  arm64: dts: rk3399: Add dfi and dmc nodes.
  arm64: dts: rockchip: Enable dmc and dfi nodes on gru.

 .../bindings/devfreq/rk3399_dmc.txt           |  2 +
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 20 +++++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 51 ++++++++++++-
 drivers/devfreq/event/rockchip-dfi.c          | 23 ++----
 drivers/devfreq/rk3399_dmc.c                  | 74 ++++++++++++++++++-
 include/dt-bindings/power/rk3399-dram.h       | 73 ++++++++++++++++++
 include/soc/rockchip/rk3399_grf.h             | 21 ++++++
 include/soc/rockchip/rockchip_sip.h           |  1 +
 10 files changed, 280 insertions(+), 18 deletions(-)
 create mode 100644 include/dt-bindings/power/rk3399-dram.h
 create mode 100644 include/soc/rockchip/rk3399_grf.h

-- 
2.21.0
