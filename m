From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v3 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Date: Wed, 24 Apr 2019 00:27:22 +0200
Message-ID: <20190423222622.GA30401@vmlxhi-102.adit-jv.com>
References: <20190423141414.24264-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423141414.24264-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, george_davis@mentor.com, joshua_frkuska@mentor.com, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <rosca.eugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Jiada,

On Tue, Apr 23, 2019 at 11:14:12PM +0900, Jiada Wang wrote:
> There are issues with interrupt handling in rcar_gen3_thermal driver.
> 
> Currently IRQ is remain enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> triggered but not able to clear IRQ status, thus cause system to hang.
> 
> Since the irq line isn't shared between different devices,
> so the proper interrupt type flag should be IRQF_ONESHOT.
> 
> This patch-set fix these interrupt handling retated issues.
> 
> ---
> v3: fix to use correct code base
>     remove unused "flag" variable in rcar_gen3_thermal_irq
[..]

Based on below:
 - basic functional testing [1]
 - 40 min of loading and unloading the driver in a loop doesn't
   trigger the original problem (soft lockup)

Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

[1] Basic functional testing on H3-ES2.0-ULCB-KF-M06:
rcar-gen3:~# T0=/sys/devices/virtual/thermal/thermal_zone0/temp
rcar-gen3:~# T1=/sys/devices/virtual/thermal/thermal_zone1/temp
rcar-gen3:~# T2=/sys/devices/virtual/thermal/thermal_zone2/temp
rcar-gen3:~# stress-ng --cpu 16 --timeout 60s &
[1] 2300
rcar-gen3:~# stress-ng: info: [2300] dispatching hogs: 16 cpu
rcar-gen3:~# for i in $(seq 1 24); do \
                 cat $T0 $T1 $T2 | tr '\n' ' '; echo; sleep 5; \
             done
31500 37500 34500 
32000 37500 34500 
32500 38000 35000 
33500 39500 36500 
34000 39500 36500 
35000 40500 37500 
35500 41000 38000 
36000 42000 38500 
36500 42000 39000 
37500 43000 40000 
stress-ng: info: [2300] successful run completed in 60.55s
[1]+  Done                    stress-ng --cpu 16 --timeout 60s
37500 42500 39000 
37500 41500 39000 
37000 41000 38000 
36500 40500 38000 
36000 40000 37000 
35500 39500 36500 
35500 40000 36000 
35000 39500 35500 
35000 39500 36000 
34500 38000 35500 
34500 39000 35500 
34000 38500 35000 
34000 37500 35500 
33500 38000 35500 

-- 
Best regards,
Eugeniu.
