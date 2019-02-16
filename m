From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/3] PM / devfreq: do some cleanup
Date: Sat, 16 Feb 2019 10:18:23 -0500
Message-ID: <20190216151826.11584-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The informations come from the coccinelle tool.

drivers/devfreq/tegra-devfreq.c:577:5-8: Unneeded variable: "ret".
Return "0" on line 603
drivers/devfreq/rk3399_dmc.c:325:2-3: Unneeded semicolon
drivers/devfreq/event/rockchip-dfi.c:214:2-3: Unneeded semicolon

Yangtao Li (3):
  PM / devfreq: rk3399_dmc: remove unneeded semicolon
  PM / devfreq: rockchip-dfi: remove unneeded semicolon
  PM / devfreq: tegra: remove unneeded variable

 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 drivers/devfreq/rk3399_dmc.c         | 2 +-
 drivers/devfreq/tegra-devfreq.c      | 7 ++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.17.0
