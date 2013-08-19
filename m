From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 07/11] cpufreq: Use cpufreq_policy_list for iterating
 over policies
Date: Mon, 19 Aug 2013 16:57:19 +0530
Message-ID: <CAKohponkLac2GzZ5-PRoTzdx8EhuCWT-eafRtYhkJ6cN_WrXSA@mail.gmail.com>
References: <cover.1375809311.git.viresh.kumar@linaro.org>
	<e54ce908bb964d643a2bbb945ed4a8dcb3ea00bf.1375809311.git.viresh.kumar@linaro.org>
	<1582060.zfvsylJcxu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1582060.zfvsylJcxu@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 18 August 2013 19:36, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> I noticed that the current linux-next branch of linux-pm.git caused the
> BUG_ON() in lock_policy_rwsem_##mode() to trigger when user space tried to
> access cpufreq sysfs attributes before system suspend and after system
> resume.

Hmm...

> I tried to debug that and it turned out that this patch caused resume
> to block indefinitely on one of my test machines and after reverting it the
> BUG_ON() stopped triggering, so I've just reverted it in my tree (it is not an
> important change).
>
> I don't have the time to figure out why this change breaks things

It wasn't my patch actually.. It only made it visible that's it :)
The problem is:
- On suspend all CPUs are removed and so governors are
stopped.
- On resume, handle_update() is called for the boot cpu and
cpu_add_dev for all others.

handle_update() doesn't start governor but only plays with
CPUFREQ_GOV_LIMITS.. when we start adding other
CPUs and call: cpufreq_add_policy_cpu() which fails in
following call:

__cpufreq_governor(policy, CPUFREQ_GOV_STOP);

and so cpufreq_policy_cpu never gets initialized to
policy->cpu and stays at -1, and hence the crash.

So, there are few problems with core at this point:
- I don't understand how does the work done in
cpufreq_add_dev() gets done for boot cpu during
resume ? And so how does Srivatsa's "frozen" solution
really works (I haven't had time to investigate, its not
that I couldn't understand it :) )..

- We need to start governor boot cpu in handle_update()
and things would be solved...

> and I would
> appreciate it if you tested stuff like suspend/resume on an x86 laptop or
> similar with your patches applied before posting them for merging.

suspend/resume is broken on my ARM board and that's why
didn't test it..

Testing anything on my thinkpad (with ubuntu) is a pain.. it takes
more than an hour to compile/test a single image... I currently follow
below steps for doing that, don't know if something much
simpler/faster is available :)

https://wiki.ubuntu.com/KernelTeam/GitKernelBuild

Whole day I was able to boot test only 4-5 kernel builds.
Its too slow :(
