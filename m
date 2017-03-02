From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 0/6] cpufreq: schedutil: fixes for flags updates
Date: Thu, 2 Mar 2017 17:11:39 +0000
Message-ID: <20170302171139.GE28760@e110439-lin>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <CAKfTPtAkCiXy_21FrL-e0NrMb9zraAfW_DJrnrvZy0GY_r=ddA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbdCBRVv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Mar 2017 12:21:51 -0500
Content-Disposition: inline
In-Reply-To: <CAKfTPtAkCiXy_21FrL-e0NrMb9zraAfW_DJrnrvZy0GY_r=ddA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>

On 02-Mar 17:09, Vincent Guittot wrote:
> On 2 March 2017 at 16:45, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > The current version of schedutil has some issues related to the management
> > of update flags used by systems with frequency domains spawning multiple CPUs.
> >
> > Each time a CPU utilisation update is issued by the scheduler a set of flags
> > are configured to define (mainly) which class is asking for a utilisation
> > update. These flags are then used by the frequency selection policy to
> > identify the OPP to choose.
> >
> > In the current implementation, CPU flags are overridden each time the
> > scheduler calls schedutil for an update. Such a behaviour produces issues
> > in these scenarios, where we assume CPU1 and CPU2 share the same frequency
> > domain:
> > a) a RT task which executed on CPU1 can keep the domain at an high frequency
> >    for a long period of time, even if there are no longer RT tasks on
> >    CPUs in that domain
> 
> Normally this is dropped after a tick.
> Nevertheless, there is an issue if the freq_update_delay_ns is shorter
> than a tick because of sugov RT thread

Indeed, I've noticed that a small FAIR task running on CPU2 is quite
likely to be running at an higher OPP just because on the other CPU of
the same frequency domain (i.e. CPU1) sometimes we have the sugov RT
thread running.

In this case, the RT flag in CPU1 is never cleared when that core is
always idle but for the execution of the sugov thread.

-- 
#include <best/regards.h>

Patrick Bellasi
