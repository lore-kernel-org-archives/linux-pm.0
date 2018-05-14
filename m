From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [RFC PATCH 00/10] Add support for drm/rockchip to dynamically control the DDR frequency.
Date: Mon, 14 May 2018 23:16:00 +0200
Message-ID: <20180514211610.26618-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>, kernel@collabora.com, Sean Paul <seanpaul@chromium.org>, linux-arm-kernel@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>, Yakir Yang <kuankuan.y@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Catalin Marinas <catalin.marinas@arm.com>, Elaine Zhang <zhangqing@rock-chips.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mark Yao <markyao0591@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Kever Yang <kever.yang@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
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

Although the patches were present in the chromeos kernel for long time I
am sending this as a RFC because I have doubts on some of them,
specially patch 4/10 that tries to sync the TF-A with the kernel using a
mutex, to be honest I did not find another way to do it so feedback is
more than welcome.

The patches apply on top of current 4.17-rc5 and depends on the
following series to apply cleanly.

 1. https://lkml.org/lkml/2018/5/9/464
 2. https://lkml.org/lkml/2018/4/23/354

Waiting for your feedback.

Best regards,
 Enric


Derek Basehore (3):
  devfreq: rk3399_dmc / clk: rockchip: Sync with vblank in the kernel
    for DDRfreq.
  devfreq: rk3399_dmc / clk: rockchip: Disable DDR clk timeout on
    suspend.
  clk: rockchip: set clk-ddr to GET_RATE_NOCACHE.

Enric Balletbo i Serra (3):
  devfreq: rockchip-dfi: Move GRF definitions to a common place.
  dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.
  devfreq: rk3399_dmc: Pass ODT and auto power down parameters to TF-A.

Lin Huang (3):
  devfreq: rk3399_dmc / rockchip: pm_domains: Register notify to DMC
    driver.
  arm64: dts: rk3399: Add dfi and dmc nodes.
  arm64: dts: rockchip: Enable dmc and dfi nodes on gru.

Sean Paul (1):
  drm: rockchip: Add DDR devfreq support.

 .../bindings/devfreq/rk3399_dmc.txt           |   2 +
 .../rockchip/rk3399-dram-default-timing.dtsi  |  38 ++++
 arch/arm64/boot/dts/rockchip/rk3399-dram.h    |  73 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  21 ++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     |  29 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  22 +-
 drivers/clk/rockchip/clk-ddr.c                | 159 ++++++++++++---
 drivers/clk/rockchip/clk.c                    |   2 +-
 drivers/clk/rockchip/clk.h                    |   3 +-
 drivers/devfreq/event/rockchip-dfi.c          |  23 +--
 drivers/devfreq/rk3399_dmc.c                  | 191 +++++++++++++++---
 drivers/devfreq/rk3399_dmc_priv.h             |  16 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  46 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |   9 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  35 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  34 ++++
 drivers/soc/rockchip/pm_domains.c             |  36 ++++
 include/soc/rockchip/rk3399_dmc.h             |  44 ++++
 include/soc/rockchip/rk3399_grf.h             |  21 ++
 include/soc/rockchip/rockchip_sip.h           |   1 +
 20 files changed, 734 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-dram-default-timing.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-dram.h
 create mode 100644 drivers/devfreq/rk3399_dmc_priv.h
 create mode 100644 include/soc/rockchip/rk3399_dmc.h
 create mode 100644 include/soc/rockchip/rk3399_grf.h

-- 
2.17.0
