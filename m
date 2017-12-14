From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 3/6] cpufreq: schedutil: update CFS util only if used
Date: Thu, 14 Dec 2017 10:15:23 +0530
Message-ID: <20171214044523.GV3322@vireshk-i7>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-4-patrick.bellasi@arm.com>
 <20171130132234.GC9903@localhost.localdomain>
 <20171130155728.GF31247@e110439-lin>
 <20171207051540.larfamrdflctn5pn@vireshk-mac-ubuntu>
 <20171207141927.GR31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39588 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbdLNEp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 23:45:26 -0500
Received: by mail-pf0-f193.google.com with SMTP id l24so2836860pfj.6
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 20:45:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171207141927.GR31247@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 07-12-17, 14:19, Patrick Bellasi wrote:
> On 07-Dec 10:45, Viresh Kumar wrote:
> > On 30-11-17, 15:57, Patrick Bellasi wrote:
> > > Yes, that's a pretty trivial update with a confusing changelog.
> > > 
> > > If we think it's worth to keep (and correct as well) I'll update the
> > > commit message.
> > 
> > We also need to update the commit log based on feedback from Vikram on
> > V2. Which said that the utilization can't change around the lock here
> > as we are within rq lock section, though max can change (maybe). So
> > this patch only takes care of locking before reading max.

I have more doubts on the max reason as well. Max isn't protected by the
sg_policy lock of schedutil and it can change any time. So even after moving
code around with this patch, we wouldn't fix any race and so I am not sure this
patch helps at all. But, I have sent the same diff for another reason now in my
series. Maybe I should have kept you as the author of that patch, but I forgot.
Will do that if I need to send a V2.

> Ok, right... will do.
> 
> Thus you are still of the opinion to keep this patch in the series?

Yes, but we need a good reason for that :)

-- 
viresh
