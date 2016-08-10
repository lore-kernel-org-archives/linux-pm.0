From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v5 0/8] rk3399 support ddr frequency scaling
Date: Wed, 10 Aug 2016 11:26:36 +0800
Message-ID: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35540 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544AbcHJD0t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2016 23:26:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de
Cc: myungjoo.ham@samsung.com, mark.yao@rock-chips.com, cw00.choi@samsung.com, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org, tixy@linaro.org, typ@rock-chips.com, sudeep.holla@arm.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, Lin Huang <hl@rock-chips.com>

rk3399 platform have dfi controller can monitor ddr load,
and dcf controller to handle ddr register so we can get the
right ddr frequency and make ddr controller happy work(which
will implement in bl31). So we do ddr frequency scaling with
following flow:

             kernel                                bl31

        monitor ddr load
                |
                |
        get_target_rate
                |
                |           pass rate to bl31
        clk_set_rate(ddr) --------------------->run dcf flow
                |                                   |
                |                                   |
        wait dcf interrupt<-------------------trigger dcf interrupt
                |
                |
              return

Lin Huang (8):
  clk: rockchip: add new clock-type for the ddrclk
  clk: rockchip: rk3399: add SCLK_DDRCLK ID for ddrc
  clk: rockchip: rk3399: add ddrc clock support
  Documentation: bindings: add dt documentation for dfi controller
  PM / devfreq: event: support rockchip dfi controller
  Documentation: bindings: add dt documentation for rk3399 dmc
  PM / devfreq: rockchip: add devfreq driver for rk3399 dmc
  drm/rockchip: Add dmc notifier in vop driver

 .../bindings/devfreq/event/rockchip-dfi.txt        |  20 +
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     |  35 ++
 drivers/clk/rockchip/Makefile                      |   1 +
 drivers/clk/rockchip/clk-ddr.c                     | 152 ++++++
 drivers/clk/rockchip/clk-rk3399.c                  |  19 +
 drivers/clk/rockchip/clk.c                         |   9 +
 drivers/clk/rockchip/clk.h                         |  33 ++
 drivers/devfreq/Kconfig                            |   9 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/event/Kconfig                      |   7 +
 drivers/devfreq/event/Makefile                     |   1 +
 drivers/devfreq/event/rockchip-dfi.c               | 253 ++++++++++
 drivers/devfreq/rk3399_dmc.c                       | 512 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 128 +++++-
 include/dt-bindings/clock/rk3399-cru.h             |   1 +
 include/soc/rockchip/rockchip_sip.h                |  27 ++
 16 files changed, 1205 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 drivers/clk/rockchip/clk-ddr.c
 create mode 100644 drivers/devfreq/event/rockchip-dfi.c
 create mode 100644 drivers/devfreq/rk3399_dmc.c
 create mode 100644 include/soc/rockchip/rockchip_sip.h

-- 
1.9.1

