From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state
 binding
Date: Thu, 24 Nov 2016 10:10:20 +0530
Message-ID: <20161124044020.GC9376@vireshk-i7>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
 <cce951c7159aa235792959ce27546be3aaa554ec.1479459752.git.viresh.kumar@linaro.org>
 <20161121150708.j4gosfr2uetc7mwp@rob-hp-laptop>
 <20161122031717.GE10014@vireshk-i7>
 <m260nfz8mr.fsf@baylibre.com>
 <CAKfTPtDR6Y5UgaqJ+D5T0yBeFRSYWm6OT1+r4ZABrtqtvF2D0w@mail.gmail.com>
 <m2wpfuw5wq.fsf@baylibre.com>
 <CAKfTPtBMro7+UruF0-E26TJPu6pEAvkjF9V7SKriNBm5q+K9+A@mail.gmail.com>
 <m2fumhx21h.fsf@baylibre.com>
 <20161124020322.GI6095@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33796 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755549AbcKXEkY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 23:40:24 -0500
Received: by mail-pg0-f45.google.com with SMTP id x23so13864151pgx.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2016 20:40:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161124020322.GI6095@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nayak Rajendra <rnayak@codeaurora.org>

On 23-11-16, 18:03, Stephen Boyd wrote:
> On 11/23, Kevin Hilman wrote:
> > Vincent Guittot <vincent.guittot@linaro.org> writes:
> > > On 23 November 2016 at 16:51, Kevin Hilman <khilman@baylibre.com> wrote:

> > >> Then, at least for this use case, we're talking about voltage, not some
> > >> unspecified units.
> 
> In some cases we actually know the voltage of the domain and
> would want to put some voltage mapping in DT. For example, level
> 1 is voltage 2V and level 2 is voltage 2.5V.

But even in these cases we wouldn't be using the voltage values within the
kernel as we will be giving only a performance state to the M3 core, right?

> In other cases we
> don't know the voltage, all we know is the voltage "corner" which
> is a number from 0 to N that is translated into a voltage by the
> firmware but is otherwise unknown what that is outside of the
> firmware. In this case we've lost the units, but otherwise we're
> still interested in requesting some 'level' that the domain be
> operating in.

> > >> But that makes me wonder, this performance state sounds like something
> > >> that is changing dynamically at runtime, so why do you want to describe
> > >> this statically in DT?

Each frequency a device can operate in has the requirement of minimum
performance state of the domain and so we need these values in the DT.

> > >>
> > >> This sounds to me like the job of the genpd.  When any device in the
> > >> domain does its pm_runtime_get(), the domain could check the device
> > >> frequency and see if it needs to change the domain voltage in order for
> > >> that device to operate at that frequency.

Also note that the performance index may be required to be changed before
updating the frequency in case we are increasing the frequency which needs a
higher performance index to be set.

> How do we check the device frequency? Does the domain need to
> know about the clocks for all devices that are in the domain and
> what clocks in there are contributing to the voltage requirement?
> 
> In out of tree solutions we've 'bucketized' the requirements of
> the devices into an array sized to the number of levels of the
> voltage domain. When a device requires a new level, we increment
> the new level and decrement the old level and then look for the
> largest non-zero index in the array.

For such a design we need to know the index-size in advance and I am not sure if
we should get anything like that from the DT.

> This is the inverse design
> of iterating over all devices in the domain to see what frequency
> they're running at to determine the voltage requirement. I guess
> using PM QoS would be similar here to do the aggregation and then
> tell the domain to go to that level.
> 
> > >> When the device goes away
> > >> (using pm_runtime_put()) the domain can check again if it could lower
> > >> the voltage and still meet the requirements of the remaining devices.

This will be done nevertheless.

> > >
> > > That's only part of the job. The device can change its frequency and
> > > as a result ask for a new voltage index while it is already running
> > 
> > That's fine.  Use clock notifiers, or better use QoS (with notifiers) so
> > that the genpd knows when any of those change.

Yes genpd will be handling it all but it will surely need to know the
performance index for each individual clock rate we support.

The way I have written the code for now is this with another QOS request type
DEV_PM_QOS_PERFORMANCE:

+static int _generic_set_opp_pd(...)
+{
+
	...

+       /* Scaling up? Scale voltage before frequency */
+       if (freq > old_freq)
+               dev_pm_qos_update_request(req, perf);
+
+       clk_set_rate(...);
+
+       if (freq < old_freq)
+               dev_pm_qos_update_request(req, perf);
+
+       return 0;
+}

And genpd is registering its notifier for DEV_PM_QOS_PERFORMANCE request type
where it accumulates requests from all the devices and selects the highest one.

-- 
viresh
