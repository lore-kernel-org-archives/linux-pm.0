From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 3/4] arm: dts: rk3229: add a new cpu opp table
Date: Fri, 19 May 2017 23:46:13 +0200
Message-ID: <3157044.sksXPZM55k@phil>
References: <1495016177-2413-1-git-send-email-frank.wang@rock-chips.com> <1495016177-2413-4-git-send-email-frank.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1495016177-2413-4-git-send-email-frank.wang@rock-chips.com>
Sender: linux-clk-owner@vger.kernel.org
To: Frank Wang <frank.wang@rock-chips.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, charles.chen@rock-chips.com, cody.xie@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com, finley.xiao@rock-chips.com, zhangqing@rock-chips.com, wmc@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Hi Frank,

Am Mittwoch, 17. Mai 2017, 18:16:16 CEST schrieb Frank Wang:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This patch adds some new frequencies for rk3229 board.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/rk3229-cpu-opp.dtsi | 85 +++++++++++++++++++++++++++++++++++

I'm not yet sure if I like that approach. The other option I'm considering
and also tend to prefer at the moment would be to have this in a
rk3229.dtsi, creating a chain of
	rk322x.dtsi
		\- rk3228-evb.dts
		\- rk3229.dtsi
			\- rk3229-evb.dts

similar to what we do with the rk3xxx.dtsi -> rk3188.dtsi.

If I remember correctly, there are some other tiny differences between the
rk3228 and rk3229, so having the rk3229.dtsi already would make it
easier to place needed stuff into it later on.


Heiko

>  1 file changed, 85 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3229-cpu-opp.dtsi
> 
> diff --git a/arch/arm/boot/dts/rk3229-cpu-opp.dtsi b/arch/arm/boot/dts/rk3229-cpu-opp.dtsi
> new file mode 100644
> index 0000000..89e8413
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3229-cpu-opp.dtsi
> @@ -0,0 +1,85 @@
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *  Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/ {
> +	/delete-node/ opp-table0;
> +
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <975000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <1000000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <1175000>;
> +		};
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1275000>;
> +		};
> +		opp-1296000000 {
> +			opp-hz = /bits/ 64 <1296000000>;
> +			opp-microvolt = <1325000>;
> +		};
> +		opp-1392000000 {
> +			opp-hz = /bits/ 64 <1392000000>;
> +			opp-microvolt = <1375000>;
> +		};
> +		opp-1464000000 {
> +			opp-hz = /bits/ 64 <1464000000>;
> +			opp-microvolt = <1400000>;
> +		};
> +	};
> +};
> 


