From: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/6] thermal: exynos: fix: Return from
 exynos_report_trigger() when therm_dev is NULL
Date: Fri, 04 Oct 2013 11:56:12 +0200
Message-ID: <20131004115612.1017e0f7@amdc308.digital.local>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
 <1380010102-25817-2-git-send-email-l.majewski@samsung.com>
 <524DE45E.1060606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <524DE45E.1060606-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Amit Daniel Kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonghwa Lee <jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

Thanks for reply.

> On 24-09-2013 04:08, Lukasz Majewski wrote:
> > The commit 4de0bdaa9677d11406c9becb70c60887c957e1f0
> > ("thermal: exynos: Add support for instance based
> > register/unregister") broke check for presence of therm_dev at
> > global thermal zone in exynos_report_trigger().
> > 
> > The resulting wrong test prevents thermal_zone_device_update()
> > call, which calls handlers for situation when trip points are
> > passed. Such behavior prevents thermal driver from proper reaction
> > (when TMU interrupt is raised) in a situation when overheating is
> > detected at TMU hardware. This patch fixes it.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/thermal/samsung/exynos_thermal_common.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_thermal_common.c
> > b/drivers/thermal/samsung/exynos_thermal_common.c index
> > f10a6ad..55a912a 100644 ---
> > a/drivers/thermal/samsung/exynos_thermal_common.c +++
> > b/drivers/thermal/samsung/exynos_thermal_common.c @@ -310,7 +310,7
> > @@ void exynos_report_trigger(struct thermal_sensor_conf *conf) }
> >  
> >  	th_zone = conf->pzone_data;
> > -	if (th_zone->therm_dev)
> > +	if (!th_zone->therm_dev)
> 
> Fine with this fix, as it really looks obvious. But after reading the
> code a bit, I am considering if we can remove the above check at all.

I have just preserved the old behaviour for -rcX fix.

> 
> Reading the driver code piece at drivers/thermal/samsung/exynos_tmu.c,
> by checking how exynos_register_thermal gets called, and how error is
> handled, I assume we do not need to check for th_zone->therm_dev.

It looks like we don't need this check (we will not register the
thermal zone if therm dev is not correct).

> 
> To me looks like the driver only allows th_zone's exist only with
> valid therm_dev, isn't it? Except for the probe sequence, maybe, at
> run time there is a time window that we have valid th_zone with
> invalid therm_dev. However, reading the probe, still, the irq gets
> initialized only in very end, so the work queue don't get queue till
> then at least.
> 
> So, my question before acking is, shall we remove this check
> altogether?

I think that it is up to you to decide how we proceed. 

Shall this patch go into v3.12-rcX since it is "obvious" (and documents
what and when was broken) or would you require to prepare "new" patch
with removal of this check?

> 
> 
> >  		return;
> >  
> >  	if (th_zone->bind == false) {
> > 
> 
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
