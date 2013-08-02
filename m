From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update][PATCH] cpufreq: Do not hold driver module references for
 additional policy CPUs
Date: Fri, 2 Aug 2013 16:00:47 +0530
Message-ID: <CAKohpokbd=xX-DqVeEZOnGftZuE-54RDShpMJgFPskRc3CkZ5w@mail.gmail.com>
References: <2362640.pUofnXyzOi@vostro.rjw.lan>
	<51FAC46D.1000703@linux.vnet.ibm.com>
	<1757496.qSuJuAun9Z@vostro.rjw.lan>
	<2298639.F0Qv2QqRnZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2298639.F0Qv2QqRnZ@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, cpufreq@vger.kernel.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 2 August 2013 02:23, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> To remove that inconsistency make cpufreq_add_policy_cpu() execute
> cpufreq_cpu_put() for the given policy before returning, which
> decrements the driver module refcount so that it will be 0 after
> __cpufreq_add_dev() returns.  Moreover, remove the cpufreq_cpu_get()
> call from cpufreq_add_dev_symlink(), since both the policy refcount
> and the driver module refcount are nonzero when it is called and they
> don't need to be bumped up by it.

Sorry for creating so many problems but my concerns with this patch
aren't yet over :(

Should we increment policy refcount or kobj refcount for every cpu it
is used on? I think yes, that's probably the right way of doing it.

And so we simply can't remove calls to cpufreq_cpu_get() from
cpufreq_add_dev_symlink() routine and also from
cpufreq_add_policy_cpu()..
