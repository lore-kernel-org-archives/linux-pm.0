From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq: schedutil: do not update rate limit ts when
 freq is unchanged
Date: Thu, 19 May 2016 16:34:08 -0700
Message-ID: <20160519233408.GC15383@graphite.smuckle.net>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
 <1462828814-32530-6-git-send-email-smuckle@linaro.org>
 <CAJZ5v0iwz3d6dxY-sUxbU8q1EzcO0gKX1pp-rDb8Www46Fg1uw@mail.gmail.com>
 <20160519194635.GG17223@graphite.smuckle.net>
 <CAJZ5v0gF07sox1+84eLeYPK6Ksj26s7iKU6zc=+pMOQimwUYog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gF07sox1+84eLeYPK6Ksj26s7iKU6zc=+pMOQimwUYog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 19, 2016 at 11:15:52PM +0200, Rafael J. Wysocki wrote:
> But anyway this change again seems to be an optimization that might be
> done later to me.
> 
> I guess there are many things that might be optimized in schedutil,
> but I'd prefer to address one item at a time, maybe going after the
> ones that appear most relevant first?

Calling the last two patches in this series optimizations is a stretch
IMO. Issuing frequency change requests that result in the same
target-supported frequency is clearly unnecessary and ends up delaying
more urgent frequency changes, which I think is more like a bug. These
patches are also needed in conjunction with the first three to address
the remote wakeup delay.

Are there specific items you want to see addressed before these patches
could go in? I'm aware of the RT/DL support that needs improving, though
that should be orthogonal.

Also if it helps, I can provide a test case and/or traces to show the
need for the last two patches.

thanks,
Steve
