From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 3/6] cpufreq: schedutil: update CFS util only if used
Date: Thu, 7 Dec 2017 14:19:27 +0000
Message-ID: <20171207141927.GR31247@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-4-patrick.bellasi@arm.com>
 <20171130132234.GC9903@localhost.localdomain>
 <20171130155728.GF31247@e110439-lin>
 <20171207051540.larfamrdflctn5pn@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207051540.larfamrdflctn5pn@vireshk-mac-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 07-Dec 10:45, Viresh Kumar wrote:
> On 30-11-17, 15:57, Patrick Bellasi wrote:
> > Yes, that's a pretty trivial update with a confusing changelog.
> > 
> > If we think it's worth to keep (and correct as well) I'll update the
> > commit message.
> 
> We also need to update the commit log based on feedback from Vikram on
> V2. Which said that the utilization can't change around the lock here
> as we are within rq lock section, though max can change (maybe). So
> this patch only takes care of locking before reading max.

Ok, right... will do.

Thus you are still of the opinion to keep this patch in the series?

-- 
#include <best/regards.h>

Patrick Bellasi
