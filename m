From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 3/5] thermal: rockchip: fixes invalid temperature case
Date: Tue, 29 Nov 2016 21:59:28 -0800
Message-ID: <20161130055927.GA125421@google.com>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
 <20161129014553.GA3097@localhost.localdomain>
 <20161129215744.GA99997@google.com>
 <20161130050239.GA27079@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36807 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755173AbcK3F7c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 00:59:32 -0500
Received: by mail-pf0-f174.google.com with SMTP id 189so36963777pfz.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Nov 2016 21:59:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161130050239.GA27079@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, rui.zhang@intel.com, heiko@sntech.de, smbarber@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

On Tue, Nov 29, 2016 at 09:02:42PM -0800, Eduardo Valentin wrote:
> On Tue, Nov 29, 2016 at 01:57:45PM -0800, Brian Norris wrote:
> > I was thinking while reviewing that the binary search serves more to
> > complicate things than to help -- it's much harder to read (and validate
> > that the loop termination logic is correct). And searching through a few
> > dozen table entries doesn't really get much benefit from a O(n) ->
> > O(log(n)) speed improvement.
> 
> true. but if in your code path you do several walks in the table just to
> check if parameters are valid, given that you could simply decide if
> they are valid or not with simpler if condition, then, still worth, no?
> :-)

Yes, your suggestions seems like they would have made the code both (a
little) more straightforward and efficient. But...

> > Anyway, I'm not sure if you were thinking along the same lines as me.
> > 
> 
> Something like that, except I though of something even simpler:
> +	if ((temp % table->step) != 0)
> +		return -ERANGE;
> 
> If temp passes that check, then you go to the temp -> code conversion.

...that check isn't valid as of patch 4, where Caesar adds handling for
intermediate steps. We really never should have been strictly snapping
to the 5C steps in the first place; intermediate values are OK.

So, we still need some kind of search to find the right step -- or
closest bracketing range, to compute the interpolated value. We should
only reject temperatures that are too high or too low for the ADC to
represent.


--- Side track ---

BTW, when we're considering rejecting temperatures here: shouldn't this
be fed back to the upper layers more nicely? We're improving the error
handling for this driver in this series, but it still leaves things
behaving a little odd. When I tested, I can do:

## set something obviously way too high
echo 700000 > trip_point_X_temp

and get a 0 (success) return code from the sysfs write() syscall, even
though the rockchip driver rejected it with -ERANGE. Is there really no
way to feed back thermal range limits of a sensor to the of-thermal
framework?

Brian
