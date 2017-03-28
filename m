From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE enter
Date: Wed, 29 Mar 2017 00:18:05 +0200
Message-ID: <1642681.8y9FrPCKVW@aspire.rjw.lan>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com> <1488469507-32463-2-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56354 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752106AbdC1WXr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2017 18:23:47 -0400
In-Reply-To: <1488469507-32463-2-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On Thursday, March 02, 2017 03:45:02 PM Patrick Bellasi wrote:
> Currently, sg_cpu's flags are set to the value defined by the last call of
> the cpufreq_update_util()/cpufreq_update_this_cpu(); for RT/DL classes
> this corresponds to the SCHED_CPUFREQ_{RT/DL} flags always being set.
> 
> When multiple CPU shares the same frequency domain it might happen that a
> CPU which executed an RT task, right before entering IDLE, has one of the
> SCHED_CPUFREQ_RT_DL flags set, permanently, until it exits IDLE.

But if it is idle, it won't be taken into account by sugov_next_freq_shared(), will it?

Thanks,
Rafael
