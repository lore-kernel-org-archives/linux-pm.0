From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RESEND PATCH 7/8] ARM: dts: rockchip: add the thermal main info found on rk3228
Date: Tue, 01 Mar 2016 11:03:26 +0100
Message-ID: <1971048.7T2zBta3A8@diego>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com> <1455521613-27340-8-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:49097 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865AbcCAKDh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 05:03:37 -0500
In-Reply-To: <1455521613-27340-8-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, huangtao@rock-chips.com, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Am Montag, 15. Februar 2016, 15:33:32 schrieb Caesar Wang:
> This patch adds the thermal needed main information for rk3228 SoCS.
> 
> Basically has the following content:
> 
> 1) TSADC controller:
> Add the needed attributes for rk3036 TSADC controller.
> 
> Especially for the TSHUT, in some cases if we are unable to shut it down
> in orderly fashion (says: kernel is stuck holding a lock or similar), then
> hardware TSHUT will reset it.
> If the temperature is over 95C over a period of time the thermal shutdown
> of the tsadc is invoked with can either reset the entire chip via the CRU,
> or notify the PMIC via a GPIO. This should be set in the specific board.
> 
> 2) Thermal zones:
> Add the needed device mode for thermal generic framework.
> Detail in Documentation/devicetree/bindings/thermal/thermal.txt.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts32 branch for 4.6


Thanks
Heiko
