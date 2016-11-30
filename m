From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 3/5] thermal: rockchip: fixes invalid temperature case
Date: Tue, 29 Nov 2016 22:26:59 -0800
Message-ID: <20161130062658.GA28498@localhost.localdomain>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
 <20161129014553.GA3097@localhost.localdomain>
 <20161129215744.GA99997@google.com>
 <20161130050239.GA27079@localhost.localdomain>
 <20161130055927.GA125421@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33888 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756461AbcK3G1P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 01:27:15 -0500
Content-Disposition: inline
In-Reply-To: <20161130055927.GA125421@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, rui.zhang@intel.com, heiko@sntech.de, smbarber@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

Hello,

On Tue, Nov 29, 2016 at 09:59:28PM -0800, Brian Norris wrote:
> On Tue, Nov 29, 2016 at 09:02:42PM -0800, Eduardo Valentin wrote:
> > On Tue, Nov 29, 2016 at 01:57:45PM -0800, Brian Norris wrote:
> > > I was thinking while reviewing that the binary search serves more to
> > > complicate things than to help -- it's much harder to read (and validate
> > > that the loop termination logic is correct). And searching through a few
> > > dozen table entries doesn't really get much benefit from a O(n) ->
> > > O(log(n)) speed improvement.
> > 
> > true. but if in your code path you do several walks in the table just to
> > check if parameters are valid, given that you could simply decide if
> > they are valid or not with simpler if condition, then, still worth, no?
> > :-)
> 
> Yes, your suggestions seems like they would have made the code both (a
> little) more straightforward and efficient. But...
> 
> > > Anyway, I'm not sure if you were thinking along the same lines as me.
> > > 
> > 
> > Something like that, except I though of something even simpler:
> > +	if ((temp % table->step) != 0)
> > +		return -ERANGE;
> > 
> > If temp passes that check, then you go to the temp -> code conversion.
> 
> ...that check isn't valid as of patch 4, where Caesar adds handling for
> intermediate steps. We really never should have been strictly snapping
> to the 5C steps in the first place; intermediate values are OK.
> 
> So, we still need some kind of search to find the right step -- or
> closest bracketing range, to compute the interpolated value. We should
> only reject temperatures that are too high or too low for the ADC to
> represent.

Ok. got it. check small comment on patch 4 then.

> 
> 
> --- Side track ---
> 
> BTW, when we're considering rejecting temperatures here: shouldn't this
> be fed back to the upper layers more nicely? We're improving the error
> handling for this driver in this series, but it still leaves things
> behaving a little odd. When I tested, I can do:
> 
> ## set something obviously way too high
> echo 700000 > trip_point_X_temp
> 
> and get a 0 (success) return code from the sysfs write() syscall, even
> though the rockchip driver rejected it with -ERANGE. Is there really no
> way to feed back thermal range limits of a sensor to the of-thermal
> framework?
> 

well, that is a bit strange to me. Are you sure you are returning the
-ERANGE? Because, my assumption is that the following of-thermal code
path would return the error code back to core:
 328         if (data->ops->set_trip_temp) {
 329                 int ret;
 330 
 331                 ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
 332                 if (ret)
 333                         return ret;
 334         }

And this part of thermal core would return it back to sysfs layer:
 757         ret = tz->ops->set_trip_temp(tz, trip, temperature);
 758         if (ret)
 759                 return ret;

or am I missing something?

> Brian
