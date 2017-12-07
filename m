From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 3/6] cpufreq: schedutil: update CFS util only if used
Date: Thu, 7 Dec 2017 10:45:40 +0530
Message-ID: <20171207051540.larfamrdflctn5pn@vireshk-mac-ubuntu>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-4-patrick.bellasi@arm.com>
 <20171130132234.GC9903@localhost.localdomain>
 <20171130155728.GF31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:38701 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdLGFPp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Dec 2017 00:15:45 -0500
Received: by mail-pf0-f180.google.com with SMTP id u25so3854129pfg.5
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2017 21:15:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171130155728.GF31247@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 30-11-17, 15:57, Patrick Bellasi wrote:
> Yes, that's a pretty trivial update with a confusing changelog.
> 
> If we think it's worth to keep (and correct as well) I'll update the
> commit message.

We also need to update the commit log based on feedback from Vikram on
V2. Which said that the utilization can't change around the lock here
as we are within rq lock section, though max can change (maybe). So
this patch only takes care of locking before reading max.

-- 
viresh
