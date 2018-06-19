From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 04/10] PM / EM: Expose the Energy Model in sysfs
Date: Tue, 19 Jun 2018 14:06:20 +0100
Message-ID: <20180619130620.GZ17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-5-quentin.perret@arm.com>
 <20180619121643.GR2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619121643.GR2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 Jun 2018 at 14:16:43 (+0200), Peter Zijlstra wrote:
> On Mon, May 21, 2018 at 03:24:59PM +0100, Quentin Perret wrote:
> > This exposes the Energy Model (read-only) of all frequency domains in
> > sysfs for convenience. To do so, a parent kobject is added to the CPU
> > subsystem under the umbrella of which a kobject for each frequency
> > domain is attached.
> > 
> > The resulting hierarchy is as follows for a platform with two frequency
> > domains for example:
> > 
> >    /sys/devices/system/cpu/energy_model
> >    ├── fd0
> >    │   ├── capacity
> >    │   ├── cpus
> >    │   ├── frequency
> >    │   └── power
> >    └── fd4
> >        ├── capacity
> >        ├── cpus
> >        ├── frequency
> >        └── power
> > 
> 
> Given that each FD can have multiple {freq,power} tuples and sysfs has a
> one value per file policy, how does this work?

This is meant to look a little bit like the sysfs entries of CPUFreq
policies, so you get something like this:

$ cat /sys/devices/system/cpu/energy_model/fd0/capacity 
133 250 351 428 462 
$ cat /sys/devices/system/cpu/energy_model/fd0/frequency 
533000 999000 1402000 1709000 1844000 
$ cat /sys/devices/system/cpu/energy_model/fd0/power 
28 70 124 187 245 
$ cat /sys/devices/system/cpu/energy_model/fd0/cpus
0-3


For example, CPUFreq exposes available governors and frequencies as:

$ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors 
conservative ondemand userspace powersave performance schedutil

$ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies 
533000 999000 1402000 1709000 1844000
