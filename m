From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Thu, 08 Jun 2017 13:08:52 +0300
Message-ID: <1496916532.12882.2.camel@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
         <20170430182727.24412-5-contact@paulk.fr>
         <20170528191619.GA20159@xo-6d-61-c0.localdomain>
         <1496249719.1774.1.camel@paulk.fr> <20170531173207.GA10763@amd>
         <1496258936.2038.8.camel@paulk.fr> <1496819733.927.16.camel@paulk.fr>
         <20170607075218.GA6268@amd> <1496848839.5534.7.camel@paulk.fr>
         <20170607195023.GA4083@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:61204 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdFHKJI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 06:09:08 -0400
In-Reply-To: <20170607195023.GA4083@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>

Hey,

On Wed, 2017-06-07 at 21:50 +0200, Pavel Machek wrote:
> Hi!
> 
> > On Wed, 2017-06-07 at 09:52 +0200, Pavel Machek wrote:
> > > > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > > > comm
> > > > it/?
> > > > h=v4.12-rc4&id=7f93e1fa032bb5ee19b868b9649bc98c82553003
> > > 
> > > Is there some documentation that explains what different power supply
> > > statuses mean? Because without that, we can have long and useless
> > > discussions.
> > 
> > Well, I couldn't really find much except the following from Documentation/
> > (which is not that helpful, and the BATTERY_STATUS_* don't seem to exist
> > anymore):
> > 
> > " STATUS - this attribute represents operating status (charging, full,
> > discharging (i.e. powering a load), etc.). This corresponds to
> > BATTERY_STATUS_* values, as defined in battery.h. "
> > 
> > Generally speaking, I think the question to be asked is what information
> > users
> > will be interested in in each scenario we have to consider.
> 
> Hmm. We really should add some documentation :-(.

Maybe we should start a new thread about this to give it more visibility.
That way, PM maintainers could weigh-in and share thoughts.

I definitely agree there is a need to clarify what we want to report to
userspace given the various scenarios we've been discussing.

> > > If you have 40Wh battery, and you are charging it with 1mW, I don't
> > > believe you should be indicating "charging". That battery is
> > > full. Yes, even full batteries are sometimes charged with very low
> > > currents to keep them full.
> > 
> > That makes sense. Note that this patch was however designed to solve the
> > problem
> > the other way round: my device will report full battery when the PSU was
> > disconnected and that it is, in fact, drawing significant current.
> 
> That is documented / correct behaviour sometimes. Thinkpad batteries
> have thresholds -- lets say 100% and 95%. They charge battery to full
> (as expected), but then they won't start charging battery again unless
> it drops below 95%. So you can have "battery full, charger
> disconnected" state.
> 
> [Design like this prolongs longevity of li-ion batteries.]

That is definitely good to know.

> > > And I'm not sure what this is supposed to do, but its quite strange
> > > code.
> > 
> > Could you comment on what is strange about it? This function corrects the
> > status
> > based on the current flow as explained through this thread.
> > 
> > > +static int sbs_status_correct(struct i2c_client *client, int *intval)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = sbs_read_word_data(client, sbs_data[REG_CURRENT].addr);
> > > +	if (ret < 0)
> > > +	   return ret;
> > > +
> > > +	ret = (s16)ret;
> 
> The last line ... is strange.

The trick here is that sbs_read_word_data will return a negative value (on 32
bits) when an error (say, I/O related) happens, but the current (returned
directly by the call) can also have a legit negative value (current draw).

However, the current value is stored on 16 bytes, so the trick is the use the
upper 2 remaining bytes for error reporting and if there's no error, cast the
value to a signed 16-bit value to get the (legit) signed current value.

-- 
Paul Kocialkowski, developer of free digital technology and hardware support

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
