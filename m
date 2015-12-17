From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/8 v5] enable to use thermal-zone on r8a7790/1
Date: Thu, 17 Dec 2015 13:08:11 -0800
Message-ID: <20151217210809.GE7999@localhost.localdomain>
References: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87d1u8qzsy.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
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

Applied the four above

>       5) thermal: rcar: enable to use thermal-zone on DT

This one requires further discussion.

>       6) ARM: shmobile: r8a7790: enable to use thermal-zone
>       7) ARM: shmobile: r8a7791: enable to use thermal-zone

These two will go on other tree, but depend on 5. So, still on hold.

>       8) thermal: of-thermal: of_thermal_set_trip_temp() call thermal_zone_device_update()
> 

Applied number 8 too.


BR,

Eduardo 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
