From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 0/5] ARM: rockchip: move io-domains under GRF
Date: Fri,  5 Feb 2016 22:20:13 +0100
Message-ID: <1454707218-23676-1-git-send-email-heiko@sntech.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60367 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754996AbcBEVUa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Feb 2016 16:20:30 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, sjoerd.simons@collabora.co.uk, dianders@chromium.org, david.wu@rock-chips.com, Heiko Stuebner <heiko@sntech.de>

The GRF contains both individual settings-bits as well as somewhat more
fully blocks like different phy-controls and also the io-voltage selection.
Similar to the power-domains living under the pmu, things like said
io-voltage selection should live under the grf instead of separate
nodes higher up.

This is even more important now that socs like the rk3368 and probably
more future socs seem to contain more than one GRF-area (a second one
under the PMU power-domain) with each containing a part of the voltage
selection. So having that in the correct place also prevents confusion.


Ideally patch1 would go into 4.6 through the power or avs tree and the
devicetree-related things should wait until after the next merge window
due to the updated binding, which I can then simply apply to my dts
branches.


Heiko Stuebner (5):
  PM / AVS: rockchip-io: make io-domains a child of the GRF
  ARM: dts: rockchip: make rk3288-grf a simple-mfd
  ARM: dts: rockchip: move rk3288 io-domain nodes to the grf
  arm64: dts: rockchip: make rk3368 grf syscons simple-mfds as well
  arm64: dts: rockchip: add rk3368 iodomains

 .../bindings/power/rockchip-io-domain.txt          |  4 ++-
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 33 +++++++++++----------
 arch/arm/boot/dts/rk3288-popmetal.dts              | 34 ++++++++++++----------
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            | 34 ++++++++++++----------
 arch/arm/boot/dts/rk3288-veyron.dtsi               | 28 +++++++++---------
 arch/arm/boot/dts/rk3288.dtsi                      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        | 22 ++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  4 +--
 drivers/power/avs/rockchip-io-domain.c             | 10 ++++++-
 9 files changed, 105 insertions(+), 66 deletions(-)

-- 
2.6.4

