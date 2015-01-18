From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v1 0/1] thermal: rockchip: make temperature reporting much more accurate
Date: Mon, 19 Jan 2015 00:15:52 +0800
Message-ID: <1421597753-2082-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.3]:34106 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbARQRD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jan 2015 11:17:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org


This patch is merged on chromiumos/third_party/kernel.
https://chromium-review.googlesource.com/#/c/239190/

Tested on veyron boards.



Caesar Wang (1):
  thermal: rockchip: make temperature reporting much more accurate

 drivers/thermal/rockchip_thermal.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
1.9.1


