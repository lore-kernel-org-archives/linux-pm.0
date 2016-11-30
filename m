From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 3/5] thermal: rockchip: fixes invalid temperature case
Date: Tue, 29 Nov 2016 21:02:42 -0800
Message-ID: <20161130050239.GA27079@localhost.localdomain>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
 <20161129014553.GA3097@localhost.localdomain>
 <20161129215744.GA99997@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36784 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750700AbcK3FCw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 00:02:52 -0500
Content-Disposition: inline
In-Reply-To: <20161129215744.GA99997@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, rui.zhang@intel.com, heiko@sntech.de, smbarber@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

Hey Brian,

On Tue, Nov 29, 2016 at 01:57:45PM -0800, Brian Norris wrote:
> Hi Eduardo,
> 
> I'm not sure I completely understand what you're asking, but I'll see
> what I can answer.
> 
> On Mon, Nov 28, 2016 at 05:45:54PM -0800, Eduardo Valentin wrote:
> > On Mon, Nov 28, 2016 at 07:12:02PM +0800, Caesar Wang wrote:
> > > The temp_to_code function will return 0 when we set the temperature to a
> > > invalid value (e.g. 61C, 62C, 63C....), that's unpractical. This patch
> > > will prevent this case happening. That will return the max analog value to
> > > indicate the temperature is invalid or over table temperature range.
> > 
> > <cut>
> > 
> > >  
> > >  	/* Make sure the value is valid */
> > >  	alarm_value = rk_tsadcv2_temp_to_code(table, temp);
> > 
> > dummy question here, looking at your tables, if I did not miss
> > something, looks like we have an accuracy of 5C steps. Not only, that,
> > we also support only multiples of 5C temperatures. If that observation
> 
> Currently, that's true I think. But patch 4 actually supports doing the
> linear interpolation that is claimed (but not fully implemented) in the
> comments today. So with that patch, we roughly support temperatures in
> between the 5C intervals.
> 
> > is correct, would it make more sense to simply check for this property,
> 
> I'm not quite sure what you mean by "this property." Do you mean to just
> assume that there will be 5C intervals, and jump ahead in the table
> accordingly? Seems a bit fragile; nothing really guarantees that a
> future ADC supported by this driver won't have 1, 2, 6, or 7C accuracy
> (and therefore a different set of steps).

I was thinking something even simpler. I just thought that you could
avoid going into the binary search on the temp to code function by simply
checking if the temperature in the temp parameter is a multiple of the
table step.

I agree that might be a bit of a strong assumption, but then again, one
should avoid over engineering for future hardware, unless you already
know that the coming ADC versions will have different steps, or even
worse, no step pattern at all.

> 
> > and min and max temperature check, instead of going through the binary
> > search to check for valid temperature? 
> 
> I was thinking while reviewing that the binary search serves more to
> complicate things than to help -- it's much harder to read (and validate
> that the loop termination logic is correct). And searching through a few
> dozen table entries doesn't really get much benefit from a O(n) ->
> O(log(n)) speed improvement.

true. but if in your code path you do several walks in the table just to
check if parameters are valid, given that you could simply decide if
they are valid or not with simpler if condition, then, still worth, no?
:-)

> 
> Anyway, I'm not sure if you were thinking along the same lines as me.
> 

Something like that, except I though of something even simpler:
+	if ((temp % table->step) != 0)
+		return -ERANGE;

If temp passes that check, then you go to the temp -> code conversion.

> Brian
