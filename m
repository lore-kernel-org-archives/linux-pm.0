From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: stable 3-10-3: strange output of "lsmod | grep ^acpi_cpufreq"
Date: Tue, 30 Jul 2013 10:53:57 +0530
Message-ID: <CAKohpo=QwTyMnXmzzk1yE6swVuhQHwyMWDiLCgQ1A=9Cy5bp9Q@mail.gmail.com>
References: <51F40612.2050403@gmx.de>
	<51F638D9.7050904@linux.vnet.ibm.com>
	<CAOh2x=nQL+8DNaSFOnvq9eVMse8-gDvW1gPqFtu+CT52JsG15A@mail.gmail.com>
	<1462209.u176D8q1Fr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1462209.u176D8q1Fr@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29 July 2013 17:24, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: cpufreq: Fix cpufreq driver module refcount balance after su=
spend/resume
>
> Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
> driver module refcount, __cpufreq_remove_dev() causes that refcount
> to become negative for the cpufreq driver after a suspend/resume
> cycle.
>
> This is not the only bad thing that happens there, however, because
> kobject_put() should only be called for the policy kobject at this
> point if the CPU is not the last one for that policy.
>
> Namely, if the given CPU is the last one for that policy, the
> policy kobject's refcount should be 1 at this point, as set by
> cpufreq_add_dev_interface(), and only needs to be dropped once for
> the kobject to go away.  This actually happens under the cpu =3D=3D 1
> check, so it need not be done before by cpufreq_cpu_put().
>
> On the other hand, if the given CPU is not the last one for that
> policy, this means that cpufreq_add_policy_cpu() has been called
> at least once for that policy and cpufreq_cpu_get() has been
> called for it too.  To balance that cpufreq_cpu_get(), we need to
> call cpufreq_cpu_put() in that case.
>
> Thus, to fix the described problem and keep the reference
> counters balanced in both cases, move the cpufreq_cpu_get() call
> in __cpufreq_remove_dev() to the code path executed only for
> CPUs that share the policy with other CPUs.
>
> Reported-by: Toralf F=F6rster <toralf.foerster@gmx.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Looks fine.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
