From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
Date: Tue, 23 Jun 2015 13:33:09 +0530
Message-ID: <20150623080309.GI16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <20150623025031.GD16776@linux>
 <20150623071647.GD3245@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150623071647.GD3245@x1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 23-06-15, 08:16, Lee Jones wrote:
> Thanks for your timely review Viresh.

Your welcome Lee :)

> On Tue, 23 Jun 2015, Viresh Kumar wrote:
> > On 22-06-15, 16:43, Lee Jones wrote:
> > > +config ARM_ST_CPUFREQ
> > > +	bool "ST CPUFreq support"
> > 
> > Isn't using ST just too generic? There are multiple SoCs ST has been
> > involved with, I have worked on a completely different series.
> > Probably a more relative string is required here, like stih407 ?
> 
> This is ST's only CPUFreq implementation and is pretty board
> agnostic.  This particular driver only currently supports the STiH407
> family, but internally it supports some others too.  I'll have a chat
> and see if we can make it more specific somehow.

So, SPEAr is also from ST. And it already have a driver for itself.

> > > +	if (!ddata->dvfs_tab_count) {
> > > +		dev_err(&pdev->dev, "No suitable AVS table found\n");
> > 
> > Why is this an error? I thought in this case you will go ahead with
> > the normal OPP-table.
> 
> I've written it so it's an error within this function, as it makes the
> function fail, but is downgraded by the caller to a warning and
> gracefully bypassed to still allow frequency scaling.

Not that, I was asking about the print. I thought we will still try to
find OPP from the CPU node and a warning or a error might not be the
right choice. You can surely add a debug print. Currently you are
doing a dev_err() here, followed by a dev_warn() I think..

> > So you have added new OPPs here, but cpufreq-dt will try to add old
> > OPPs. You must be getting lots of warnings ?
> 
> Yes, we recieve the 'duplicate OPPs detected' warning, but there is
> nothing we can do about that.

:)

OPP-v2 will get that solved too..

> > > +	if (ddata->substrate < 0)
> > > +		goto set_default;
> > 
> > Maybe:
> > 
> > 	if (ddata->substrate >= 0)
> >                 return;
> 
> 0 is a valid substrate value.

I had >= in the comparison. Wasn't that right?
And I was just suggesting that a single return can be used instead of

if (xyz)
        goto set_default;
return;

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
