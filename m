From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Date: Mon, 23 May 2016 11:24:16 +0200
Message-ID: <20160523092416.GE15728@worktop.ger.corp.intel.com>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
 <20160519114029.GW3193@twins.programming.kicks-ass.net>
 <201605201223.u4KCNWn9028105@mx0a-001b2d01.pphosted.com>
 <20160522103912.GN3193@twins.programming.kicks-ass.net>
 <20160522204252.GH15383@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160522204252.GH15383@graphite.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Sun, May 22, 2016 at 01:42:52PM -0700, Steve Muckle wrote:

> > So does it actually matter what the frequency is when you idle? Isn't
> > the whole thing clock gated anyway?
> > 
> > Because this seems to generate contradictory requirements, on the one
> > hand we want to stay idle as long as possible while on the other hand
> > you seem to want to clock down while idle, which requires not being
> > idle.
> > 
> > If it matters; should not your idle state muck explicitly set/restore
> > frequency?
> 
> AFAIK this is very platform dependent. Some will waste more power than
> others when a CPU idles above fmin due to things like resource (bus
> bandwidth, shared cache freq etc) voting.

Oh agreed, completely platform dependent. 'Luckily' all this cpuidle is
already very platform dependent.

> It is also true that there is power spent going to fmin (and then
> perhaps restoring the frequency when idle ends) which will be in part a
> function of how slow the frequency change operation is on that platform.

Agreed.

> I think Daniel Lezcano (added) was exploring the idea of having cpuidle
> drivers take the expected idle duration and potentially communicate to
> cpufreq to reduce the frequency depending on a platform-specific
> cost/benefit analysis.

Right; that's along the lines I was thinking. If the idle guestimate and
the idle QoS both allow (ie. it wins on power and doesn't violate
wake-up latency) muck with DVSF on the idle path.
