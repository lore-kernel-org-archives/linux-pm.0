From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RESEND PATCH 8/8] ARM: dts: rockchip: enable the tsadc for rk3228 evb
Date: Tue, 01 Mar 2016 11:03:35 +0100
Message-ID: <2412973.Kxto885cTd@diego>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com> <1455521613-27340-9-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455521613-27340-9-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, huangtao@rock-chips.com, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Am Montag, 15. Februar 2016, 15:33:33 schrieb Caesar Wang:
> This patch enables the tsadc for rk3228 evb board.
> 
> The rk3228 evb board uses the CRU to reset the chip since it hasn't the
> PMIC to connect it, and TSHUT is low active on evb board.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts32 branch for 4.6


Thanks
Heiko
