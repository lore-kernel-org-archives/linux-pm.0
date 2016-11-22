From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 0/5] thermal: rockchip: optimization to improve the driver
Date: Tue, 22 Nov 2016 20:34:43 +0800
Message-ID: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, briannorris@chromium.org, heiko@sntech.de, smbarber@chromium.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

There are five patches posted for upstream.
89267b5 thermal: rockchip: improve conversion error messages
a0b5649 thermal: rockchip: don't pass table structs by value
bceed92 thermal: rockchip: fixes invalid temperature case
30be6d0 thermal: rockchip: optimize the conversion table
35636e9 thermal: rockchip: handle the set_trips without the trip points.
--

Brain posted the below patches for upstream.
89267b5 thermal: rockchip: improve conversion error messages
a0b5649 thermal: rockchip: don't pass table structs by value
That make sense to improve efficiency

Caesar post the below patches for upstream.
bceed92 thermal: rockchip: fixes invalid temperature case
30be6d0 thermal: rockchip: optimize the conversion table
35636e9 thermal: rockchip: handle the set_trips without the trip points.
That will fixes some issue in special cases.
--

Anyway, this series patches should can improve the rockchip thermal driver.

Brian Norris (2):
  thermal: rockchip: improve conversion error messages
  thermal: rockchip: don't pass table structs by value

Caesar Wang (3):
  thermal: rockchip: fixes invalid temperature case
  thermal: rockchip: optimize the conversion table
  thermal: rockchip: handle the set_trips without the trip points.

 drivers/thermal/rockchip_thermal.c | 123 ++++++++++++++++++++++++-------------
 1 file changed, 80 insertions(+), 43 deletions(-)

-- 
2.7.4
