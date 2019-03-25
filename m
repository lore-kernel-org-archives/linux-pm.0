From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v3 1/5] devfreq: rockchip-dfi: Move GRF definitions to a
 common place.
Date: Mon, 25 Mar 2019 13:48:40 +0900
Message-ID: <20190325044840epcms1p20afe8dc66d0357e6a97939e1b2bb6e76@epcms1p2>
References: <20190321231440.19031-2-gael.portay@collabora.com>
        <20190321231440.19031-1-gael.portay@collabora.com>
        <CGME20190321231444epcas2p364deab07c3436f4ac78c63cb2d103a0b@epcms1p2>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321231440.19031-2-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infra>
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@collabora.com>
List-Id: linux-pm@vger.kernel.org

>From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
>Some rk3399 GRF (Generic Register Files) definitions can be used for
>different drivers. Move these definitions to a common include so we
>don't need to duplicate these definitions.
>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>Signed-off-by: Gael PORTAY <gael.portay@collabora.com>
>---
>
>Changes in v3:
>- [PATCH v2 1/5] Add Signed-off-by: Gael PORTAY <gael.portay@collabora.com>.
>
>Changes in v2:
>- [PATCH 1/8] Really add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>.
>
>Changes in v1:
>- [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>- [RFC 1/10] s/Generic/General/ (Robin Murphy)
>- [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
>- [RFC 7/10] Removed from the series. I did not found a use case where this matters.
>
> drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
> include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
> 2 files changed, 28 insertions(+), 16 deletions(-)
> create mode 100644 include/soc/rockchip/rk3399_grf.h
>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
