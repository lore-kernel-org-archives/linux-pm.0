From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state
 binding
Date: Fri, 2 Dec 2016 16:17:17 +0530
Message-ID: <20161202104717.GC22049@vireshk-i7>
References: <m260nfz8mr.fsf@baylibre.com>
 <CAKfTPtDR6Y5UgaqJ+D5T0yBeFRSYWm6OT1+r4ZABrtqtvF2D0w@mail.gmail.com>
 <m2wpfuw5wq.fsf@baylibre.com>
 <CAKfTPtBMro7+UruF0-E26TJPu6pEAvkjF9V7SKriNBm5q+K9+A@mail.gmail.com>
 <m2fumhx21h.fsf@baylibre.com>
 <20161124020322.GI6095@codeaurora.org>
 <20161124044020.GC9376@vireshk-i7>
 <4f815e31-22d0-fef7-953c-257fa2bbcb9d@codeaurora.org>
 <20161129065726.GG3288@vireshk-i7>
 <20161130010804.GI6095@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34439 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbcLBKrV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 05:47:21 -0500
Received: by mail-pf0-f180.google.com with SMTP id c4so52422939pfb.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Dec 2016 02:47:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161130010804.GI6095@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nayak Rajendra <rnayak@codeaurora.org>

On 29-11-16, 17:08, Stephen Boyd wrote:
> Perhaps. One question is if we consider a shared regulator as a
> regulator in the kernel, or if we want to hide the regulator
> behind some other API that aggregates the users of the voltage. I
> don't see how to draw the line clearly between a regulator and a

Neither do I :)

> power domain that modifies a regulator underneath. It seems like
> everything that's using a regulator on the SoC could be using a
> power domain instead and then we could be aggregating the voltage
> requirements outside of the regulator APIs.

If I am not wrong the regulator API chooses an intersection instead of the max
requested voltage and so it may not fit very well in the use-case we are trying
to solve.

> The only other way I can think of doing it is by having the
> voltages in the OPP tables for each device. That gets sort of
> messy though because all the devices calling
> regulator_set_voltage() have to set the min voltage to be their
> required voltage and the max to be the global max voltage on the
> system. Otherwise a higher voltage may not be used while it may
> be required. Of course, we could encode that as the last value in
> the triplet and everything works.

Where will we get the performance levels in this case ?

> What do we do if the device is part of multiple domains? For
> example it may be part of two power domains for different pieces
> of the silicon within one device, and we may want to
> independently control those domains depending on the clock
> frequency.

I thought the best way to handle would be to add a virtual domain for such a
device. That domain shall be responsible for changing its parent based on the
performance level selected, and at that point only the recalculations for both
the parents should happen to select the new best performance level.

@Rob / Kevin: Do you have any inputs on the things we are discussing here? I
want to involve you guys as early as possible, or we will come back to this
again :(

-- 
viresh
