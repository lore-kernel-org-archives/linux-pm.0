From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v3 2/5] dt-bindings: devfreq: rk3399_dmc: Add
 rockchip,pmu phandle.
Date: Mon, 25 Mar 2019 13:55:42 +0900
Message-ID: <20190325045542epcms1p585d5cec9453adef9b4531ff2a2bf5be6@epcms1p5>
References: <20190321231440.19031-3-gael.portay@collabora.com>
        <20190321231440.19031-1-gael.portay@collabora.com>
        <CGME20190321231447epcas2p4de5947e1eced053fee285ccd75d1d669@epcms1p5>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321231440.19031-3-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infra>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@collabora.com>
List-Id: linux-pm@vger.kernel.org

>From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
>The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
>general register files to know the DRAM type, so add a phandle to the
>syscon that manages these registers.
>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>Acked-by: Rob Herring <robh@kernel.org>
>Signed-off-by: Gael PORTAY <gael.portay@collabora.com>
>---
>
>Changes in v3:
>- [PATCH v2 2/5] Add Signed-off-by: Gael PORTAY <gael.portay@collabora.com>.
>
>Changes in v2: None
>
>Changes in v1:
>- [RFC 2/10] Add reviewed and acked tags from Chanwoo Choi and Rob Herring
>
> Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
> 1 file changed, 2 insertions(+)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
