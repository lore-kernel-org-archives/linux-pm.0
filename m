From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/8 v5] enable to use thermal-zone on r8a7790/1
Date: Tue, 15 Dec 2015 13:49:28 +0900
Message-ID: <20151215044924.GC32397@verge.net.au>
References: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 15, 2015 at 01:16:20AM +0000, Kuninori Morimoto wrote:
> 
> Hi
> 
> These are v5 of thermal-zone support for r8a7790/r8a7791.
> 
> Kuninori Morimoto (8):
>       1) thermal: rcar: move rcar_thermal_dt_ids to upside
>       2) thermal: rcar: check every rcar_thermal_update_temp() return value
>       3) thermal: rcar: check irq possibility in rcar_thermal_irq_xxx()
>       4) thermal: rcar: rcar_thermal_get_temp() return error if strange temp
>       5) thermal: rcar: enable to use thermal-zone on DT
>       6) ARM: shmobile: r8a7790: enable to use thermal-zone
>       7) ARM: shmobile: r8a7791: enable to use thermal-zone
>       8) thermal: of-thermal: of_thermal_set_trip_temp() call thermal_zone_device_update()

I have marked patches 6 and 7 as deferred pending acceptance of the driver
changes.
