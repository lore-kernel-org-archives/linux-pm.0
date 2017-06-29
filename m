From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: add const to
 thermal_cooling_device_ops structure
Date: Thu, 29 Jun 2017 11:26:26 +0530
Message-ID: <CAOH+1jHKLf+PVY=g4iXZcT5mKbskuVki5Lcwb1w=AgnVRtksYg@mail.gmail.com>
References: <1498028988-12916-1-git-send-email-bhumirks@gmail.com>
 <1498705219.2510.4.camel@intel.com> <CAOH+1jGUxFVakQxBnr2Hm+8aY2fFTGLrJ2WEi8d-YHAmrFiZsw@mail.gmail.com>
 <1498714351.2510.35.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33609 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdF2F42 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 01:56:28 -0400
In-Reply-To: <1498714351.2510.35.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>

On Thu, Jun 29, 2017 at 11:02 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Thu, 2017-06-29 at 10:41 +0530, Bhumika Goyal wrote:
>> On Thu, Jun 29, 2017 at 8:30 AM, Zhang Rui <rui.zhang@intel.com>
>> wrote:
>> >
>> > On Wed, 2017-06-21 at 12:39 +0530, Bhumika Goyal wrote:
>> > >
>> > > Declare thermal_cooling_device_ops structure as const as it is
>> > > only
>> > > passed
>> > > as an argument to the function thermal_cooling_device_register
>> > > and
>> > > this
>> > > argument is of type const. So, declare the structure as const.
>> > >
>> > I checked the source and the code is written in this way as well in
>> > some other drivers, why not fix them altogether?
>> >
>> Hey,
>>
>> I have already sent the patches for the drivers requiring this
>> change.
>> Some of them got applied as well.
>
> I mean the other drivers that use thermal_cooling_device_ops.
>

Actually, I also meant the same but maybe I wasn't clear enough :)

> Surely I can applied this patch, but still it would be nice if you can
> check the other places that defines thermal_cooling_device_ops and fix
> all of them in one time. :)
>

I checked again and there remains only one file in power/supply where
thermal_cooling_device_ops can be made const. I will submit a patch
for it but I think I will have to create a separate patch because the
maintainers are different.
All other places are either already const or I have submitted patches
for them or cannot be made const.

Thanks,
Bhumika

> thanks,
> rui
>>
>> Thanks,
>> Bhumika
>>
>> >
>> > thanks,
>> > rui
>> > >
>> > > Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>> > > ---
>> > >  drivers/thermal/intel_powerclamp.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/thermal/intel_powerclamp.c
>> > > b/drivers/thermal/intel_powerclamp.c
>> > > index d718cd1..e4c68b7 100644
>> > > --- a/drivers/thermal/intel_powerclamp.c
>> > > +++ b/drivers/thermal/intel_powerclamp.c
>> > > @@ -659,7 +659,7 @@ static int powerclamp_set_cur_state(struct
>> > > thermal_cooling_device *cdev,
>> > >  }
>> > >
>> > >  /* bind to generic thermal layer as cooling device*/
>> > > -static struct thermal_cooling_device_ops powerclamp_cooling_ops
>> > > = {
>> > > +static const struct thermal_cooling_device_ops
>> > > powerclamp_cooling_ops = {
>> > >       .get_max_state = powerclamp_get_max_state,
>> > >       .get_cur_state = powerclamp_get_cur_state,
>> > >       .set_cur_state = powerclamp_set_cur_state,
