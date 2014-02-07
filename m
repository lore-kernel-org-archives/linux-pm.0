From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 35/51] acpi-cpufreq: Fix CPU hotplug callback registration
Date: Fri, 7 Feb 2014 09:39:36 +0530
Message-ID: <CAKohpok4XOS19XVfpth+8AYnL3D_35=VMMqefSnQLFy1DRDDrQ@mail.gmail.com>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
	<20140205221052.19080.77507.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140205221052.19080.77507.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, oleg@redhat.com, rusty@rustcorp.com.au, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>, walken@google.com, ego@linux.vnet.ibm.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 6 February 2014 03:40, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:
>
>         get_online_cpus();
>
>         for_each_online_cpu(cpu)
>                 init_cpu(cpu);
>
>         register_cpu_notifier(&foobar_cpu_notifier);
>
>         put_online_cpus();
>
> This is wrong, since it is prone to ABBA deadlocks involving the
> cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
> with CPU hotplug operations).
>
> Instead, the correct and race-free way of performing the callback
> registration is:
>
>         cpu_maps_update_begin();
>
>         for_each_online_cpu(cpu)
>                 init_cpu(cpu);
>
>         /* Note the use of the double underscored version of the API */
>         __register_cpu_notifier(&foobar_cpu_notifier);
>
>         cpu_maps_update_done();
>
>
> Fix the acpi-cpufreq code by using this latter form of callback registration.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: cpufreq@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
