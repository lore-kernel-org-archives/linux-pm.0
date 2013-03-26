From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/2 v2] thermal: rcar: fixup registration failure case
Date: Tue, 26 Mar 2013 14:30:55 +0800
Message-ID: <1364279455.2821.2.camel@rzhang1-mobl4>
References: <87620gqbbe.wl%kuninori.morimoto.gx@renesas.com>
	 <874ng0qb9f.wl%kuninori.morimoto.gx@renesas.com>
	 <1364200856.2465.48.camel@rzhang1-mobl4>
	 <871ub3j9r3.wl%kuninori.morimoto.gx@renesas.com>
	 <87sj3iiu5m.wl%kuninori.morimoto.gx@renesas.com>
	 <87r4j2itio.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87r4j2itio.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-pm@vger.kernel.org, Linux-SH <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2013-03-25 at 23:07 -0700, Kuninori Morimoto wrote:
> Hi Zhang
> 
> These are v2 patch set of rcar_thermal driver fixup
> I noticed that v1 patch had bug.
> 
it seems that you did not run any test for the previous patch set, not
even build test.

have you tried this patch set before sending out?

thanks,
rui
> These patch set are for linus/master branch,
> and, these requires zhang/next's
> 
> f0e68fc3caf677e834f7bd0f601800e686b56c98
> (thermal: rcar: fix missing unlock on error in rcar_thermal_update_temp())
> 
> fb84d9907f0ff0e3f7d70d55039ddf0f78d2a472
> (thermal: rcar_thermal: propagate return value of thermal_zone_device_register)
> 
> current linus/master branch needs above 2 patches,
> and these patch set are based on these.
> 
> I Cc:ed SH-ARM ML
> 
> Kuninori Morimoto (2):
>       thermal: rcar: tidyup registration failure case
>       thermal: rcar: add pm_runtime_xxx() support
> 
>  drivers/thermal/rcar_thermal.c |   31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


