From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] ARM: shmobile: r8a7790: enable to use thermal-zone
Date: Mon, 7 Dec 2015 15:34:47 +0900
Message-ID: <20151207063443.GH22834@verge.net.au>
References: <871tb2hpn2.wl%kuninori.morimoto.gx@renesas.com>
 <87wpsugazs.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wpsugazs.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 04, 2015 at 03:18:11AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch enables to use thermal-zone on r8a7790.
> This thermal sensor can measure temperature from -40000 to 125000,
> but over 117000 can be critical on this chip.
> Thus, default critical temperature is now set as 115000 (this driver
> is using 5000 steps) (Current critical temperature is using it as
> 90000, but there is no big reason about it)
> 
> And it doesn't check thermal zone periodically (same as current
> behavior). You can exchange it by modifing polling-delay[-passive]
> property.
> 
> You can set trip temp if your kernel has CONFIG_THERMAL_WRITABLE_TRIPS,
> but you need to take care to use it, since it will call
> orderly_poweroff() it it reached to the value.
> echo $temp > /sys/class/thermal/thermal_zone0/trip_point_0_temp
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I have marked this and the following shmobile patch as deffered
pending acceptance of the driver changes (earlier in the patchset).
Please repost the shmobile patches once that has occurred.
