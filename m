From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v3 3/5] devfreq: rk3399_dmc: Pass ODT and auto power
 down parameters to TF-A.
Date: Mon, 25 Mar 2019 15:55:15 +0900
Message-ID: <20190325065515epcms1p4743158f941064730272c8f976d844237@epcms1p4>
References: <20190321231440.19031-4-gael.portay@collabora.com>
        <20190321231440.19031-1-gael.portay@collabora.com>
        <CGME20190321231449epcas1p4ea54b4862fd8552f207f81bce8cb706f@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321231440.19031-4-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infra>
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@collabora.com>
List-Id: linux-pm@vger.kernel.org

>From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
>Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
>on-die termination (ODT) and auto power down parameters from kernel,
>this patch adds the functionality to do this. Also, if DDR clock
>frequency is lower than the on-die termination (ODT) disable frequency
>this driver should disable the DDR ODT.
>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>Signed-off-by: Gael PORTAY <gael.portay@collabora.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers!
MyungJoo

>---
>
>Changes in v3:
>- [PATCH v2 3/5] Add Signed-off-by: Gael PORTAY <gael.portay@collabora.com>.
>		 Remove comments.
>		 Move pmu dt parsing after dt-parsing of timings to fix
>		  data->odt_dis_freq value.
>
>Changes in v2: None
>
>Changes in v1:
>- [RFC 3/10] Add an explanation for platform SIP calls.
>- [RFC 3/10] Change if statement for a switch.
>- [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
>
> drivers/devfreq/rk3399_dmc.c        | 71 ++++++++++++++++++++++++++++-
> include/soc/rockchip/rockchip_sip.h |  1 +
> 2 files changed, 71 insertions(+), 1 deletion(-)
