From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v2 0/2] set specific ddr frequency when stop ddr dvfs
Date: Thu,  3 Nov 2016 14:16:08 +0800
Message-ID: <1478153770-8433-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: cw00.choi@samsung.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

We need ddr run a specific frequency when ddr dvfs stop working. So we
implement get suspend frequency function in devfreq framework, and call
it in rk3399 dmc driver.

Lin Huang (2):
  PM/devfreq: add suspend frequency support
  PM/devfreq: rk3399: set specific ddr frequency when stop ddr dvfs

 drivers/devfreq/devfreq.c    | 17 ++++++++++++++++-
 drivers/devfreq/rk3399_dmc.c |  2 +-
 include/linux/devfreq.h      |  9 +++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
1.9.1
