From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v10 0/5] rk3399 support ddr frequency scaling
Date: Mon,  5 Sep 2016 13:06:06 +0800
Message-ID: <1473051971-5500-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35127 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbcIEFGT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2016 01:06:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de
Cc: myungjoo.ham@samsung.com, mark.yao@rock-chips.com, cw00.choi@samsung.com, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org, tixy@linaro.org, typ@rock-chips.com, sudeep.holla@arm.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Lin Huang <hl@rock-chips.com>

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


Lin Huang (5):
  Documentation: bindings: add dt documentation for dfi controller
  PM / devfreq: event: support rockchip dfi controller
  Documentation: bindings: add dt documentation for rk3399 dmc
  PM / devfreq: rockchip: add devfreq driver for rk3399 dmc
  drm/rockchip: Add dmc notifier in vop driver

Following patch:
clk: rockchip: add new clock-type for the ddrclk
clk: rockchip: rk3399: add SCLK_DDRCLK ID for ddrc
clk: rockchip: rk3399: add ddrc clock support
have applied to:
http://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/v4.9-clk/next


 .../bindings/devfreq/event/rockchip-dfi.txt        |  19 +
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 210 +++++++++
 drivers/devfreq/Kconfig                            |  11 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/event/Kconfig                      |   7 +
 drivers/devfreq/event/Makefile                     |   1 +
 drivers/devfreq/event/rockchip-dfi.c               | 256 +++++++++++
 drivers/devfreq/rk3399_dmc.c                       | 480 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 116 +++++
 9 files changed, 1101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 drivers/devfreq/event/rockchip-dfi.c
 create mode 100644 drivers/devfreq/rk3399_dmc.c

-- 
2.6.6

