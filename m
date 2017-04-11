From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC/RFT][PATCH 2/2] cpufreq: schedutil: Utilization aggregation
Date: Mon, 10 Apr 2017 18:57:17 -0700
Message-ID: <CAJWu+ookm9iEupdS+ZLU_1KwcqFMyqV5HAC4mpyCgdkcBy-_Mg@mail.gmail.com>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2242635.g1ACnTm5vK@aspire.rjw.lan>
 <CAJWu+orhpeirhB1u-KTOBjWTQoTEJdStR3BP14WxkB=RZP49sg@mail.gmail.com> <CAJZ5v0gePrW+hnR4UdGnxuibhcUvcfHSfULFok3tYEsOvD7eLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gePrW+hnR4UdGnxuibhcUvcfHSfULFok3tYEsOvD7eLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 10, 2017 at 1:59 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
[..]
>>> +               sg_cpu->util = cfs_util;
>>> +               sg_cpu->max = cfs_max;
>>> +       }
>>>  }
>
>
> Well, that's the idea. :-)
>
> During the discussion at the OSPM-summit we concluded that discarding
> all of the utilization changes between the points at which frequency
> updates actually happened was not a good idea, so they needed to be
> aggregated somehow.
>
> There are a few ways to aggregate them, but the most straightforward
> one (and one which actually makes sense) is to take the maximum as the
> aggregate value.
>
> Of course, this means that we skew things towards performance here,
> but I'm not worried that much. :-)

Does this increase the chance of going to idle at higher frequency?
Say in the last rate limit window, we have a high request followed by
a low request. After the window closes, by this algorithm we ignore
the low request and take the higher valued request, and then enter
idle. Then, wouldn't we be idling at higher frequency? I guess if you
enter "cluster-idle" then probably this isn't a big deal (like on the
ARM64 platforms I am working on). But I wasn't sure how expensive is
entering C-states at higher frequency on Intel platforms is or if it
is even a concern. :-D

Thanks,
Joel
