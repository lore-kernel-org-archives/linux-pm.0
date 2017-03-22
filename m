From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: Always trace frequency if it does
 not change
Date: Wed, 22 Mar 2017 15:26:15 +0530
Message-ID: <20170322095615.GB12094@vireshk-i7>
References: <10655562.4O9KtquB0A@aspire.rjw.lan>
 <20170322092951.GX5680@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170322092951.GX5680@worktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 22-03-17, 10:29, Peter Zijlstra wrote:
> On Wed, Mar 22, 2017 at 01:56:53AM +0100, Rafael J. Wysocki wrote:

> > However, the same problem may occur for a cpufreq driver that doesn't
> > support fast frequency switching and implements the ->target callback
> > (that is, it doesn't use frequency tables), but trace_cpu_frequency()
> > is not called if frequency updates are skipped in that case.
> 
> I'm having trouble parsing that; am I right in understanding this is the
> exact same scenario where only superfluous changes are omitted?

Yes. Just for a different driver type.

-- 
viresh
