From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/3] thermal: handle get_temp() errors properly
Date: Tue, 22 Nov 2016 03:00:47 -0800
Message-ID: <20161122110045.GB2018@localhost.localdomain>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
 <20161119034158.GA26405@localhost.localdomain>
 <20161119053014.GA58324@google.com>
 <1479801145.2360.24.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36251 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932521AbcKVLAp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 06:00:45 -0500
Content-Disposition: inline
In-Reply-To: <1479801145.2360.24.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>

On Tue, Nov 22, 2016 at 03:52:25PM +0800, Zhang Rui wrote:
> Hi, Brian,
> 
> On Fri, 2016-11-18 at 21:30 -0800, Brian Norris wrote:
> > Hi,
> > 
> > On Fri, Nov 18, 2016 at 07:41:59PM -0800, Eduardo Valentin wrote:
> > > 
> > > On Fri, Nov 18, 2016 at 03:52:55PM -0800, Brian Norris wrote:
> > > > 
> > > > If using CONFIG_THERMAL_EMULATION, there's a corner case where we
> > > > might
> > > > get an error from the zone's get_temp() callback, but we'll
> > > > ignore that
> > > > and keep using its value. Let's just error out properly instead.
> > > > 
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > ---
> > > >  drivers/thermal/thermal_core.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/thermal/thermal_core.c
> > > > b/drivers/thermal/thermal_core.c
> > > > index 911fd964c742..0fa497f10d25 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -494,6 +494,8 @@ int thermal_zone_get_temp(struct
> > > > thermal_zone_device *tz, int *temp)
> > > >  	mutex_lock(&tz->lock);
> > > >  
> > > >  	ret = tz->ops->get_temp(tz, temp);
> > > > +	if (ret)
> > > > +		goto exit_unlock;
> > > Yeah, but the follow through is intentional, if I am not mistaken.
> > OK...but it has a bug. It potentially utilizes an uninitialized value
> > for *temp.
> > 
> Agreed.

I also agree that this section of current get_temp is buggy. That is why 
I sent the patch some time ago.

> > > 
> > > > 
> > > >  
> > > >  	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz-
> > > > >emul_temperature) {
> > > Even if the driver is not able to read real temperature, but emul
> > > temp
> > > is configured, then there is still opportunity to report the
> > > emulated
> > > temperature.
> > OK, maybe, but you should avoid doing this comparison then:
> > 
> > 513                 if (!ret && *temp < crit_temp)
> > 514                         *temp = tz->emul_temperature;
> > 
> > Note that 'ret' might be 0 (from the calls to ->get_trip_type()), and
> > then
> > you're comparing with the uninitialized value of *temp. So you need
> > some
> > solution that accounts for this and decides to ignore the real
> > temperature properly.
> > 
> right.
> > > 
> > > > 
> > > >  		for (count = 0; count < tz->trips; count++) {
> > > > @@ -514,6 +516,7 @@ int thermal_zone_get_temp(struct
> > > > thermal_zone_device *tz, int *temp)
> > > >  			*temp = tz->emul_temperature;
> > > And if you check the lines at the bottom of the loop, you will see
> > > that,
> > > in the fail case, we will stil compare to what is the content of
> > > temp,
> > > which might be problematic.
> > Yes...are you saying the same thing I am above?

Yes, Brian, we are concerned about the same bug.


> > 
> > > 
> > > I would prefer we consider the patch I sent
> > > some time ago:
> > > https://patchwork.kernel.org/patch/7876381/
> > Honestly I didn't look that deeply into the framework here (and I
> > also
> > don't use CONFIG_THERMAL_EMULATION), I was just fixing something that
> > was obviously wrong.

Yeah, but that is why we need people to look the code considering all
features. :-)


> > 
> > But on first read, that patch looks good to me -- although it'd be
> > good
> > to note the uninitialized value fix in the comit log. Any reason that
> > didn't end up getting merged? It looks like it got reviewed, and
> > you're
> > a thermal subsystem maintainer...
> > 

I do not remember why Rui postponed it. A note of clarification, for
things that touch thermal core, I agree with Rui that they go through
his tree. Besides, I tend to avoid acking and sending my own patches
without proper review, which was not the case of that patch, that was
just postponed and fell into the cracks somehow.

> hmmm, I forgot why I missed this one in the end.
> Eduardo,
> would you mind refresh and resend the patch?

Yeah sure. I have at least three extra patch sets on thermal core on
my queue. But I would like to get first the thermal sysfs reorg in
first. This fix is one of the changes that will go on top of the thermal
sysfs reorg.

BR,

Eduardo 
