From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix possible integer overflow
Date: Tue, 22 Oct 2013 00:47:18 +0200
Message-ID: <1734089.XZ0ga7sQd1@vostro.rjw.lan>
References: <1382239876-12688-1-git-send-email-geyslan@gmail.com> <52654EA6.6020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52654EA6.6020805@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: "Geyslan G. Bem" <geyslan@gmail.com>, kernel-br@googlegroups.com, Viresh Kumar <viresh.kumar@linaro.org>, "open list:CPU FREQUENCY DRI..." <cpufreq@vger.kernel.org>, "open list:CPU FREQUENCY DRI..." <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, October 21, 2013 08:56:22 AM Dirk Brandewie wrote:
> On 10/19/2013 08:31 PM, Geyslan G. Bem wrote:
> > The expression 'pstate << 8' is evaluated using 32-bit arithmetic while
> > 'val' expects an expression of type u64.
> >
> > Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
> Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

Actually, isn't (pstate << 8) guaranteed not to overflow?

> > ---
> >   drivers/cpufreq/intel_pstate.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index badf620..43446b5 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -395,7 +395,7 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
> >   	trace_cpu_frequency(pstate * 100000, cpu->cpu);
> >
> >   	cpu->pstate.current_pstate = pstate;
> > -	val = pstate << 8;
> > +	val = (u64)pstate << 8;
> >   	if (limits.no_turbo)
> >   		val |= (u64)1 << 32;
> >
> >
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
