From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to
 driver frequency
Date: Mon, 30 May 2016 09:35:47 -0700
Message-ID: <20160530163547.GG9864@graphite.smuckle.net>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-4-git-send-email-smuckle@linaro.org>
 <20160526071629.GW17585@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160526071629.GW17585@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 26, 2016 at 12:46:29PM +0530, Viresh Kumar wrote:
> On 25-05-16, 19:53, Steve Muckle wrote:
> > The slow-path frequency transition path is relatively expensive as it
> > requires waking up a thread to do work. Should support be added for
> > remote CPU cpufreq updates that is also expensive since it requires an
> > IPI. These activities should be avoided if they are not necessary.
> > 
> > To that end, calculate the actual driver-supported frequency required by
> > the new utilization value in schedutil by using the recently added
> > cpufreq_driver_resolve_freq callback. If it is the same as the
> > previously requested driver frequency then there is no need to continue
> > with the update assuming the cpu frequency limits have not changed. This
> > will have additional benefits should the semantics of the rate limit be
> > changed to apply solely to frequency transitions rather than to
> > frequency calculations in schedutil.
> 
> Maybe mention here that this patch isn't avoiding those IPIs yet, I
> got an impression earlier that they are avoided with it.

Perhaps the problem is that my cover letter should have more clearly
specified that the earlier referenced series was an unaccepted draft?
I'll be more careful to note that in the future.

The text above (the second sentence) seems okay to me in that it
mentions remote updates are not currently supported. Let me know if
there is specific text you would like included.

thanks,
Steve
