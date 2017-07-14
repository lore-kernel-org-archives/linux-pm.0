From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Eas-dev] [PATCH V3 2/3] cpufreq: schedutil: Process remote
 callback for shared policies
Date: Fri, 14 Jul 2017 10:33:20 +0530
Message-ID: <20170714050320.GJ352@vireshk-i7>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <3fbaa9aaba19bfff5ff25d2c4141e88fb83f1ea9.1499927699.git.viresh.kumar@linaro.org>
 <5968263D.1020801@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5968263D.1020801@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 13-07-17, 19:02, Saravana Kannan wrote:
> Honestly, this seems like such a chip/platform specific decision. There's no
> reason that one can't have a chip where you can change the frequency of any
> CPU from any other CPU. If there's such a limitation, we should let that be
> handled at the CPU freq driver level instead of having to know about any of
> that at the scheduler. Heck, at worst case, the CPU freq driver can send an
> IPI and execute that work on the CPU of interest.
> 
> In all Qualcomm chipsets (well, at least the ones that have been used in
> Android devices so far), we can switch the frequency of any CPU from any
> other CPU. If we can do that even without fast switching, why wouldn't any
> theoretical fast switching be incapable of supporting this? Is this a
> limitation specific to x86 that we are assuming all architectures and
> platforms are going to have?

The default assumption in cpufreq core is that any CPU from a policy
can change freq for that policy. Yes, we surely have cases where any
CPU can change freq of any other CPU (even in different policies).
Perhaps all ARM platforms are like that, not sure.

And so I added a special flag for that in my previous version, but the
idea here is to get a simple solution merged first and then we can
have a separate patch later to support freq switching from all CPUs.

-- 
viresh
