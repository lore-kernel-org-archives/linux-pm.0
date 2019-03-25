From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface
Date: Mon, 25 Mar 2019 11:01:08 +0100
Message-ID: <CAJZ5v0iML0dvzLszSnZjBPKc=2fWp4aUxEjAYWjJnz41Kz8w1g@mail.gmail.com>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1762575.ER2xjzr9E1@aspire.rjw.lan>
 <20190322144629.GC12472@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322144629.GC12472@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2019 at 3:46 PM Borislav Petkov <bp@alien8.de> wrote:
>
> First of all, thanks a lot for doing that!
>
> This is a good example for how we should convert all the /dev/msr
> accessing tools.
>
> Nitpicks below.
>
> On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The Performance and Energy Bias Hint (EPB) is expected to be set by
> > user space through the generic MSR interface, but that interface is
> > not particularly nice and there are security concerns regarding it,
> > so it is not always available.
> >
> > For this reason, add a sysfs interface for reading and updating the
> > EPB, in the form of a new attribute, energy_perf_bias, located
> > under /sys/devices/system/cpu/cpu#/power/ for online CPUs that
> > support the EPB feature.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-devices-system-cpu |   18 ++++
> >  Documentation/admin-guide/pm/intel_epb.rst         |   27 ++++++
> >  arch/x86/kernel/cpu/intel_epb.c                    |   93 ++++++++++++++++++++-
> >  3 files changed, 134 insertions(+), 4 deletions(-)
>
> ...
>
> > +static ssize_t energy_perf_bias_show(struct device *dev,
> > +                                  struct device_attribute *attr,
> > +                                  char *buf)
> > +{
> > +     unsigned int cpu = dev->id;
> > +     u64 epb;
> > +     int ret;
> > +
> > +     ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
>
> That's an IPI and an MSR read each time. You could dump saved_epb
> instead, no?

No, because the MSR can change in ways beyond control of this code sometimes.

Generally, saved_epb only is the right value at the CPU online time.

> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return sprintf(buf, "%llu\n", epb);
> > +}
> > +
> > +static ssize_t energy_perf_bias_store(struct device *dev,
> > +                                   struct device_attribute *attr,
> > +                                   const char *buf, size_t count)
> > +{
> > +     unsigned int cpu = dev->id;
> > +     u64 epb, val;
> > +     int ret;
> > +
> > +     ret = __sysfs_match_string(energy_perf_strings,
> > +                                ARRAY_SIZE(energy_perf_strings), buf);
> > +     if (ret >= 0)
> > +             val = energ_perf_values[ret];
> > +     else if (kstrtou64(buf, 0, &val) || val > MAX_EPB)
>
> Range is 0 - 15 but u64? Maybe make it an u8? :)

At the cost of an extra conversion below, right?

> > +             return -EINVAL;
> > +
> > +     ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
> > +                         (epb & ~EPB_MASK) | val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return count;
> > +}
>
> --
