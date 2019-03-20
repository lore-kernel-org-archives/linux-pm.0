From: =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: Enable dmc and dfi nodes on
 gru.
Date: Wed, 20 Mar 2019 14:35:32 -0400
Message-ID: <20190320183532.ko2j7ggqfxey7co5@archlinux.localdomain>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <CGME20190319181359epcas4p11159b40adf1c883d179e18356d4cbd30@epcas4p1.samsung.com>
 <20190319181323.22804-6-gael.portay@collabora.com>
 <3adc4347-7dd9-106f-e564-26d39ff38ffb@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3adc4347-7dd9-106f-e564-26d39ff38ffb@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On Wed, Mar 20, 2019 at 02:05:21PM +0900, Chanwoo Choi wrote:
> ...
> > +&display_subsystem {
> > +	devfreq = <&dmc>;
> > +};
> 
> When I checked the rockchip_drm_drv.c on linux-next.git (20190320),
> there are no any codes about this. Maybe it should be removed.
>

Good catch! This is a artifact that remain after I removed two patches
from v1.

> > ...
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Best Regards,
Gaël
