From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH] thermal: tegra: delete unneeded of_node_put
Date: Mon, 17 Jul 2017 16:42:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707171641190.2038@hadrien>
References: <1500108152-1812-1-git-send-email-Julia.Lawall@lip6.fr> <66e7906c-9472-4fcb-7c04-750bb27d3989@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <66e7906c-9472-4fcb-7c04-750bb27d3989-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On Mon, 17 Jul 2017, Jon Hunter wrote:

>
> On 15/07/17 09:42, Julia Lawall wrote:
> > Device node iterators perform an of_node_put on each iteration, so putting
> > an of_node_put before a continue results in a double put.
> >
> > The semantic match that finds this problem is as follows
> > (http://coccinelle.lip6.fr):
> >
> > // <smpl>
> > @@
> > expression e1;
> > local idexpression child;
> > iterator name for_each_child_of_node;
> > @@
> >
> >  for_each_child_of_node(e1,child) {
> >    ... when != of_node_get(child)
> > *  of_node_put(child);
> >    ...
> > *  continue;
> > }
> > // </smpl>
> >
> > Furthermore, the call to thermal_of_cooling_device_register immediately
> > calls __thermal_cooling_device_register with the same arguments.  The
> > latter function stores the device node argument, which is the second
> > argument of for_each_child_of_node, in the returned thermal_cooling_device
> > structure.  This returned structure is then stored in the cdev field of
> > stc.  Thus it seems that the second argument of for_each_child_of_node
> > escapes the scope of the for_each_child_of_node, so an explicit of_node_get
> > on success of thermal_of_cooling_device_register is also needed.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
> >
> > ---
> >  drivers/thermal/tegra/soctherm.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> > index 7d2db23..10f4fdd 100644
> > --- a/drivers/thermal/tegra/soctherm.c
> > +++ b/drivers/thermal/tegra/soctherm.c
> > @@ -1014,7 +1014,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
> >  		tcd = thermal_of_cooling_device_register(np_stcc,
> >  							 (char *)name, ts,
> >  							 &throt_cooling_ops);
> > -		of_node_put(np_stcc);
> >  		if (IS_ERR_OR_NULL(tcd)) {
> >  			dev_err(dev,
> >  				"throttle-cfg: %s: failed to register cooling device\n",
> > @@ -1022,6 +1021,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
> >  			continue;
> >  		}
> >
> > +		of_node_get(np_stcc);
> >  		stc->cdev = tcd;
> >  		stc->init = true;
> >  	}
>
> Thanks for fixing this. However, I am wondering if it is better for the
> 'of_node_get' to be placed within the
> thermal_of_cooling_device_register() function as it seems a bit odd if
> the caller needs to know that this is being stored for later use.
>
> Also, taking a quick look, I see a couple other drivers calling
> thermal_of_cooling_device_register() and they are also not calling
> of_node_get on success. So it maybe easier to fix placing it in the
> thermal_of_cooling_device_register() function.

I'm not an expert, but I had the impression that from some call sites, the
get would have been done already, because the argument is already stored
in some structure.  I can check more exhaustively.

julia


>
> Cheers
> Jon
>
> --
> nvpublic
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
