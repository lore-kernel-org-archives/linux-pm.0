From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [BUG] schedutil governor produces regular max freq spikes
 because of lockup detector watchdog threads
Date: Mon, 8 Jan 2018 15:20:22 +0200
Message-ID: <1515417622.3207.5.camel@nxp.com>
References: <1515184652.6892.26.camel@nxp.com>
         <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com>
         <20180108040121.GB4003@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180108040121.GB4003@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-01-08 at 09:31 +0530, Viresh Kumar wrote:
> On 05-01-18, 23:18, Rafael J. Wysocki wrote:
> > On Fri, Jan 5, 2018 at 9:37 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:

> > > When using the schedutil governor together with the softlockup detector
> > > all CPUs go to their maximum frequency on a regular basis. This seems
> > > to be because the watchdog creates a RT thread on each CPU and this
> > > causes regular kicks with:
> > > 
> > >     cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
> > > 
> > > The schedutil governor responds to this by immediately setting the
> > > maximum cpu frequency, this is very undesirable.
> > > 
> > > The issue can be fixed by this patch from android:
> > > 
> > > The patch stalled in a long discussion about how it's difficult for
> > > cpufreq to deal with RT and how some RT users might just disable
> > > cpufreq. It is indeed hard but if the system experiences regular power
> > > kicks from a common debug feature they will end up disabling schedutil
> > > instead.

> > Patrick has a series of patches dealing with this problem area AFAICS,
> > but we are currently integrating material from Juri related to
> > deadline tasks.

> I am not sure if Patrick's patches would solve this problem at all as
> we still go to max for RT and the RT task is created from the
> softlockup detector somehow.

I assume you're talking about the series starting with
"[PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates"

I checked and they have no effect on this particular issue (not
surprising).

--
Regards,
Leonard
