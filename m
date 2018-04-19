From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 2/6] dt-bindings: clock: add DDR3 standard speed bins.
Date: Thu, 19 Apr 2018 13:10:35 +0200
Message-ID: <5662116.zj93FbmDPb@phil>
References: <20180419104019.24406-1-enric.balletbo@collabora.com> <20180419104019.24406-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419104019.24406-3-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, dianders@google.com, groek@google.com, kernel@collabora.com, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Enric,

Am Donnerstag, 19. April 2018, 12:40:15 CEST schrieb Enric Balletbo i Serra:
> DDR3 SDRAM Standard (JESD79-3F) defines some standard speed bins for
> DDR3 memories. The devfreq/rk3399_dmc.txt binding refers to this file
> which does not exist, so add a ddr.h file with the standard speed bins
> for DDR3.
> 
> Fixes: c1ceb8f7c167 (Documentation: bindings: add dt documentation for rk3399 dmc)
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  include/dt-bindings/clock/ddr.h | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 include/dt-bindings/clock/ddr.h
> 
> diff --git a/include/dt-bindings/clock/ddr.h b/include/dt-bindings/clock/ddr.h
> new file mode 100644
> index 000000000000..506aef7e609e
> --- /dev/null
> +++ b/include/dt-bindings/clock/ddr.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +
> +#ifndef DT_BINDINGS_DDR_H
> +#define DT_BINDINGS_DDR_H
> +
> +/* DDR3-800 Standard Speed Bins */
> +#define DDR3_800D	15
> +#define DDR3_800E		18
> +/* DDR3-1066 Standard Speed Bins */
> +#define DDR3_1066E	18
> +#define DDR3_1066F	21
> +#define DDR3_1066G	24

looking at the mentioned jedec standard, I don't see where these numerical
values are defined in the standard itself. [I may be blind though]

Could you explain a bit more where these numerical values are coming from?


Thanks
Heiko
