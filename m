From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v10 04/15] PM / EM: Expose the Energy Model in sysfs
Date: Tue, 11 Dec 2018 15:04:11 +0000
Message-ID: <20181211150409.vn25xlmzonqhd4fi@queper01-lin>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-5-quentin.perret@arm.com>
 <20181211141827.GA85618@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211141827.GA85618@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 11 Dec 2018 at 15:18:28 (+0100), Ingo Molnar wrote:
> 
> * Quentin Perret <quentin.perret@arm.com> wrote:
> 
> > Expose the Energy Model (read-only) of all performance domains in sysfs
> > for convenience. To do so, add a kobject to the CPU subsystem under the
> > umbrella of which a kobject for each performance domain is attached.
> > 
> > The resulting hierarchy is as follows for a platform with two
> > performance domains for example:
> > 
> >    /sys/devices/system/cpu/energy_model
> >    ├── pd0
> >    │   ├── cost
> >    │   ├── cpus
> >    │   ├── frequency
> >    │   └── power
> >    └── pd4
> >        ├── cost
> >        ├── cpus
> >        ├── frequency
> >        └── power
> > 
> > In this implementation, the kobject abstraction is only used as a
> > convenient way of exposing data to sysfs. However, it could also be
> > used in the future to allocate and release performance domains in a more
> > dynamic way using reference counting.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> >  include/linux/energy_model.h |  2 +
> >  kernel/power/energy_model.c  | 90 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 92 insertions(+)
> 
> Why is a read-only ABI added for 'convenience'? We really don't do that 
> as ABIs are final and they come with responsibilities.
> 
> I think if this is for debug purposes it should be declared and put into 
> debugfs or so.
> 
> If it's for some other purpose that purpose should be declared.

This is basically supposed to look like the CPUFreq policy entries.
You can get things like this for CPUFreq:

  $ cat /sys/devices/system/cpu/cpufreq/policy1/scaling_available_frequencies
  450000 625000 800000 950000 1100000

And things like this for the EM:

$ cat /sys/devices/system/cpu/energy_model/pd1/power
  160 239 343 454 583

In general, I expect these two interfaces to be used for similar
purposes. Now, whether or not they should be exposed in debugfs is a
good question. I went for sysfs for consistency with CPUFreq, but I'm
not opposed to a change in this area for the EM if you feel it's
preferable.

Also, I'm happy to just drop this patch for now and to begin by not
exposing the EM at all. It's easier to expose it later than to remove it
once userspace tools depend on it.

Thanks,
Quentin
