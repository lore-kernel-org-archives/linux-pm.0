From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [RESEND PATCH 0/8] Support and fixes the rk3228 SoCS for thermal
Date: Fri, 26 Feb 2016 02:16:58 +0100
Message-ID: <3480898.qXLEaXSdDG@phil>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com> <3650760.H1YezDtoUE@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <3650760.H1YezDtoUE@phil>
Sender: linux-clk-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>, edubezval@gmail.com
Cc: huangtao@rock-chips.com, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 16. Februar 2016, 00:25:39 schrieb Heiko Stuebner:
> Am Montag, 15. Februar 2016, 15:33:25 schrieb Caesar Wang:
> > 1a6f334 clk: rockchip: add id of the tsadc clock found on rk3228 SoCs
> > 8cf2d1b clk: rockchip: add the tsadc clocks found on rk3228 SoCs
> > bdc79c0 ARM: dts: rockchip: add the thermal main info found on rk3228
> > 22ea3c3 ARM: dts: rockchip: enable the tsadc for rk3228 evb
> 
> clk and devicetree patches look good and I'll pick those up once Eduardo
> is
> ok with (and has taken) the thermal-specific changes:
> > bd2720c thermal: rockchip: fix a impossible condition caused by the
> > warning df9c1bd thermal: rockchip: fix calculation error for
> > code_to_temp
> > fb11fbd thermal: rockchip: the rename compatibles for rockchip SoCs
> > b907b75 thermal: rockchip: fix the tsadc sequence output on
> > rk3228/rk3399

@Eduardo: any opinion on the patches related to the thermal driver itself?


Thanks
Heiko

