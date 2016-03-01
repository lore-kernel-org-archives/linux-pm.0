From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RESEND PATCH 0/8] Support and fixes the rk3228 SoCS for thermal
Date: Mon, 29 Feb 2016 20:39:53 -0800
Message-ID: <20160301043951.GA9884@localhost.localdomain>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
 <3650760.H1YezDtoUE@phil>
 <3480898.qXLEaXSdDG@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33529 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbcCAEj6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 23:39:58 -0500
Content-Disposition: inline
In-Reply-To: <3480898.qXLEaXSdDG@phil>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Caesar Wang <wxt@rock-chips.com>, huangtao@rock-chips.com, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 26, 2016 at 02:16:58AM +0100, Heiko Stuebner wrote:
> Am Dienstag, 16. Februar 2016, 00:25:39 schrieb Heiko Stuebner:
> > Am Montag, 15. Februar 2016, 15:33:25 schrieb Caesar Wang:
> > > 1a6f334 clk: rockchip: add id of the tsadc clock found on rk3228 SoCs
> > > 8cf2d1b clk: rockchip: add the tsadc clocks found on rk3228 SoCs
> > > bdc79c0 ARM: dts: rockchip: add the thermal main info found on rk3228
> > > 22ea3c3 ARM: dts: rockchip: enable the tsadc for rk3228 evb
> > 
> > clk and devicetree patches look good and I'll pick those up once Eduardo
> > is
> > ok with (and has taken) the thermal-specific changes:
> > > bd2720c thermal: rockchip: fix a impossible condition caused by the
> > > warning df9c1bd thermal: rockchip: fix calculation error for
> > > code_to_temp
> > > fb11fbd thermal: rockchip: the rename compatibles for rockchip SoCs
> > > b907b75 thermal: rockchip: fix the tsadc sequence output on
> > > rk3228/rk3399
> 
> @Eduardo: any opinion on the patches related to the thermal driver itself?


Not really, adding them to my fixes branches. Thanks.

> 
> 
> Thanks
> Heiko
> 
