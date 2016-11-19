From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/3] thermal: handle get_temp() errors properly
Date: Fri, 18 Nov 2016 21:30:15 -0800
Message-ID: <20161119053014.GA58324@google.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
 <20161119034158.GA26405@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33158 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbcKSFaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Nov 2016 00:30:19 -0500
Received: by mail-pg0-f45.google.com with SMTP id 3so110165165pgd.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Nov 2016 21:30:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161119034158.GA26405@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>

Hi,

On Fri, Nov 18, 2016 at 07:41:59PM -0800, Eduardo Valentin wrote:
> On Fri, Nov 18, 2016 at 03:52:55PM -0800, Brian Norris wrote:
> > If using CONFIG_THERMAL_EMULATION, there's a corner case where we might
> > get an error from the zone's get_temp() callback, but we'll ignore that
> > and keep using its value. Let's just error out properly instead.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >  drivers/thermal/thermal_core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 911fd964c742..0fa497f10d25 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -494,6 +494,8 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
> >  	mutex_lock(&tz->lock);
> >  
> >  	ret = tz->ops->get_temp(tz, temp);
> > +	if (ret)
> > +		goto exit_unlock;
> 
> Yeah, but the follow through is intentional, if I am not mistaken.

OK...but it has a bug. It potentially utilizes an uninitialized value
for *temp.

> >  
> >  	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
> 
> Even if the driver is not able to read real temperature, but emul temp
> is configured, then there is still opportunity to report the emulated
> temperature.

OK, maybe, but you should avoid doing this comparison then:

513                 if (!ret && *temp < crit_temp)
514                         *temp = tz->emul_temperature;

Note that 'ret' might be 0 (from the calls to ->get_trip_type()), and then
you're comparing with the uninitialized value of *temp. So you need some
solution that accounts for this and decides to ignore the real
temperature properly.

> >  		for (count = 0; count < tz->trips; count++) {
> > @@ -514,6 +516,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
> >  			*temp = tz->emul_temperature;
> 
> And if you check the lines at the bottom of the loop, you will see that,
> in the fail case, we will stil compare to what is the content of temp,
> which might be problematic.

Yes...are you saying the same thing I am above?

> I would prefer we consider the patch I sent
> some time ago:
> https://patchwork.kernel.org/patch/7876381/

Honestly I didn't look that deeply into the framework here (and I also
don't use CONFIG_THERMAL_EMULATION), I was just fixing something that
was obviously wrong.

But on first read, that patch looks good to me -- although it'd be good
to note the uninitialized value fix in the comit log. Any reason that
didn't end up getting merged? It looks like it got reviewed, and you're
a thermal subsystem maintainer...

Brian
