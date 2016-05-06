From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq governors broken with !CONFIG_SMP?
Date: Fri, 06 May 2016 02:09:07 +0200
Message-ID: <1961527.dEtpL4HAvs@vostro.rjw.lan>
References: <20160505234922.GA14673@sky.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160505234922.GA14673@sky.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, May 05, 2016 04:49:22 PM Steve Muckle wrote:
> While working on a few patches for schedutil I noticed that the CFS
> cpufreq hooks depend on PELT, which depends on CONFIG_SMP.
> 
> I compiled and ran a UP kernel with intel_pstate. Running a cpu-bound
> task did not result in the frequency increasing beyond fmin. For some reason
> ondemand is working for me with the same test, not sure why yet.
> 
> It appears dbs/intel-pstate/schedutil have a dependency on CONFIG_SMP
> now. Or am I missing something?

You're right AFAICS.

For governors other than schedutil fixing that would be a matter of
adding a !CONFIG_SMP variant of update_load_avg() that will call
cpufreq_update_util() and do nothing else.  It doesn't matter what
is passed via util and max then.

In turn, schedutil should probably depend on CONFIG_SMP.

Peter?
