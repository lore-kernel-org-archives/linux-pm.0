From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v2] sched: cpufreq: Fix long idle judgement logic in load calculation
Date: Tue, 12 Jun 2018 17:05:46 +0200
Message-ID: <3199989.mUnO823ZlS@aspire.rjw.lan>
References: <1528420053-22884-1-git-send-email-yu.c.chen@intel.com> <20180608040413.2pjfr6by3me5qymk@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608040413.2pjfr6by3me5qymk@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Chen Yu <yu.c.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, Artem S Tashkinov <t.artem@mailcity.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 8, 2018 6:04:13 AM CEST Viresh Kumar wrote:
> On 08-06-18, 09:07, Chen Yu wrote:
> > According to current code implementation, detecting the long
> > idle period is done by checking if the interval between two
> > adjacent utilization update handers is long enough. Although
> > this mechanism can detect if the idle period is long enough
> > (no utilization hooks invoked during idle period), it might
> > not contain a corner case: if the task has occupied the cpu
> > for too long which causes no context switch during that
> > period, then no utilization handler will be launched until this
> > high prio task is switched out. As a result, the idle_periods
> > field might be calculated incorrectly because it regards the
> > 100% load as 0% and makes the conservative governor who uses
> > this field confusing.
> > 
> > Change the judgement to compare the idle_time with sampling_rate
> > directly.
> > 
> > Reported-by: Artem S. Tashkinov <t.artem@mailcity.com>
> > Cc: Artem S Tashkinov <t.artem@mailcity.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v2: Per Viresh's suggestion, ignore idle_time longer than 30mins and
> >     simplify the code.
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!
