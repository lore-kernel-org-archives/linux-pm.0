From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 0/5] Fix a trivial typo and support rk3228/rk3399 SoCs for thermal driver.
Date: Wed, 25 Nov 2015 15:59:32 +0800
Message-ID: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34584 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbKYIAO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2015 03:00:14 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Dan Carpenter <dan.carpenter@oracle.com>, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Kosina <trivial@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org

This series pacthes to support the next soc for this thermal driver.
I don't have add the dts thermal data since these SoCs have *_not_* land
in this mailline. I believe these SoCs dts will land in this mainline,
then add the thermal data for Heiko.

This series patches can apply into Eduardo branch.
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git

Also, this series pacthes have build on github branch.
https://github.com/rockchip-linux/kernel/commits/develop4.4

PATCH[1/5]:
That's bit ugly typo, sorry for sending again :(.

PATCH[2/5]:
To fix a build warning came from Dan Carpenter report smatch check,
Thanks. :)

PATCH[3/5]:
Add the rk3228/rk339 SoCs compatible for dt-bindings.

PATCH[4/5]:
Add the rk3228 SoCs for thermal driver.

PATCH[5/5]:
Add the rk3399 SoCs for thermal driver.



Caesar Wang (5):
  thermal: rockchip: fix a trivial typo
  thermal: rockchip: fix a impossible condition caused by the warning
  dt-bindings: rockchip-thermal: Support the RK3228/RK3399 SoCs
    compatible
  thermal: rockchip: Support the RK3228 SoCs in thermal driver
  thermal: rockchip: Support the RK3399 SoCs in thermal driver

 .../bindings/thermal/rockchip-thermal.txt          |   2 +
 drivers/thermal/rockchip_thermal.c                 | 159 ++++++++++++++++++++-
 2 files changed, 155 insertions(+), 6 deletions(-)

-- 
1.9.1

