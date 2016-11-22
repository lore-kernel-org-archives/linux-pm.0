From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/3] thermal: handle get_temp() errors properly
Date: Tue, 22 Nov 2016 15:52:25 +0800
Message-ID: <1479801145.2360.24.camel@intel.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
         <20161119034158.GA26405@localhost.localdomain>
         <20161119053014.GA58324@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:45895 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751986AbcKVHw3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 02:52:29 -0500
In-Reply-To: <20161119053014.GA58324@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>

Hi, Brian,

On Fri, 2016-11-18 at 21:30 -0800, Brian Norris wrote:
> Hi,
> 
> On Fri, Nov 18, 2016 at 07:41:59PM -0800, Eduardo Valentin wrote:
> > 
> > On Fri, Nov 18, 2016 at 03:52:55PM -0800, Brian Norris wrote:
> > > 
> > > If using CONFIG_THERMAL_EMULATION, there's a corner case where we
> > > might
> > > get an error from the zone's get_temp() callback, but we'll
> > > ignore that
> > > and keep using its value. Let's just error out properly instead.
> > > 
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > >  drivers/thermal/thermal_core.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/thermal/thermal_core.c
> > > b/drivers/thermal/thermal_core.c
> > > index 911fd964c742..0fa497f10d25 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -494,6 +494,8 @@ int thermal_zone_get_temp(struct
> > > thermal_zone_device *tz, int *temp)
> > >  	mutex_lock(&tz->lock);
> > >  
> > >  	ret = tz->ops->get_temp(tz, temp);
> > > +	if (ret)
> > > +		goto exit_unlock;
> > Yeah, but the follow through is intentional, if I am not mistaken.
> OK...but it has a bug. It potentially utilizes an uninitialized value
> for *temp.
> 
Agreed.
> > 
> > > 
> > >  
> > >  	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz-
> > > >emul_temperature) {
> > Even if the driver is not able to read real temperature, but emul
> > temp
> > is configured, then there is still opportunity to report the
> > emulated
> > temperature.
> OK, maybe, but you should avoid doing this comparison then:
> 
> 513                 if (!ret && *temp < crit_temp)
> 514                         *temp = tz->emul_temperature;
> 
> Note that 'ret' might be 0 (from the calls to ->get_trip_type()), and
> then
> you're comparing with the uninitialized value of *temp. So you need
> some
> solution that accounts for this and decides to ignore the real
> temperature properly.
> 
right.
> > 
> > > 
> > >  		for (count = 0; count < tz->trips; count++) {
> > > @@ -514,6 +516,7 @@ int thermal_zone_get_temp(struct
> > > thermal_zone_device *tz, int *temp)
> > >  			*temp = tz->emul_temperature;
> > And if you check the lines at the bottom of the loop, you will see
> > that,
> > in the fail case, we will stil compare to what is the content of
> > temp,
> > which might be problematic.
> Yes...are you saying the same thing I am above?
> 
> > 
> > I would prefer we consider the patch I sent
> > some time ago:
> > https://patchwork.kernel.org/patch/7876381/
> Honestly I didn't look that deeply into the framework here (and I
> also
> don't use CONFIG_THERMAL_EMULATION), I was just fixing something that
> was obviously wrong.
> 
> But on first read, that patch looks good to me -- although it'd be
> good
> to note the uninitialized value fix in the comit log. Any reason that
> didn't end up getting merged? It looks like it got reviewed, and
> you're
> a thermal subsystem maintainer...
> 
hmmm, I forgot why I missed this one in the end.
Eduardo,
would you mind refresh and resend the patch?

thanks,
rui
> Brian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
