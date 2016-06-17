From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: regression caused by 08f511fd41c3 ("cpufreq: Reduce
 cpufreq_update_util() overhead a bit")
Date: Fri, 17 Jun 2016 16:40:54 +0800
Message-ID: <20160617164054.6339c5d4@xhacker>
References: <20160617163023.5bb374f8@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160617163023.5bb374f8@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear all,

On Fri, 17 Jun 2016 16:30:23 +0800 Jisheng Zhang wrote:

> Dear all,
> 
> I found one regression: In an idle system, wakeups/s (reported by powertop)
> is increased a lot, e.g on a intel snb 4 core platform, the wakeup event
> number is increased from 8 wakeups/s to 24 wakeup/s. bisect points to
> this commit. I could send detailed bisect log if it's wanted.
> 

more information maybe useful: after the commit, the top two wakeup source
are

        Process        [rcu_sched]

        Timer          tick_sched_timer

thanks
