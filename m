From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v3 2/6] drivers/cpufreq: implement
 init_cpu_capacity_default()
Date: Thu, 4 Feb 2016 09:36:00 +0000
Message-ID: <20160204093559.GA14099@e105550-lin.cambridge.arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-3-git-send-email-juri.lelli@arm.com>
 <CAKfTPtDGk5BC25WqHdhDYDOBgUsuidAMhrXS=eDi6wJPZjfrwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39662 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbcBDJek (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Feb 2016 04:34:40 -0500
Content-Disposition: inline
In-Reply-To: <CAKfTPtDGk5BC25WqHdhDYDOBgUsuidAMhrXS=eDi6wJPZjfrwA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On Wed, Feb 03, 2016 at 10:04:37PM +0100, Vincent Guittot wrote:
> On 3 February 2016 at 12:59, Juri Lelli <juri.lelli@arm.com> wrote:
> > To get default values for CPUs capacity we profile a simple (bogus)
> > integer benchmark on such CPUs; then we normalize results to 1024
> > (highest capacity in the system).
> >
> > Architectures that want this during boot have to define a weak function
> > (arch_wants_init_cpu_capacity) to return true.
> >
> > Also, kernel has to boot with init_cpu_capacity parameter if profiling
> > is needed, as it can be expensive and might add ~1 sec to boot time.
> >
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> >  Changes since v1:
> >  - add kernel command line parameter to enable profiling
> >  - add define for max trials
> >
> >  Documentation/kernel-parameters.txt |   4 +
> >  arch/arm/kernel/topology.c          |   2 +-
> >  arch/arm64/kernel/topology.c        |  12 +++
> >  drivers/cpufreq/Makefile            |   2 +-
> >  drivers/cpufreq/cpufreq.c           |   1 +
> >  drivers/cpufreq/cpufreq_capacity.c  | 174 ++++++++++++++++++++++++++++++++++++
> >  include/linux/cpufreq.h             |   2 +
> >  7 files changed, 195 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/cpufreq/cpufreq_capacity.c
> >
> > diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> > index 87d40a7..fad2b89 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -1570,6 +1570,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >
> >         initrd=         [BOOT] Specify the location of the initial ramdisk
> >
> > +       init_cpu_capacity
> > +                       [KNL,ARM] Enables dynamic CPUs capacity benchmarking
> > +                       at boot.
> > +
> >         inport.irq=     [HW] Inport (ATI XL and Microsoft) busmouse driver
> >                         Format: <irq>
> >
> > diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> > index ec279d1..c9c87a5 100644
> > --- a/arch/arm/kernel/topology.c
> > +++ b/arch/arm/kernel/topology.c
> > @@ -47,7 +47,7 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
> >         return per_cpu(cpu_scale, cpu);
> >  }
> >
> > -static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
> > +void set_capacity_scale(unsigned int cpu, unsigned long capacity)
> >  {
> >         per_cpu(cpu_scale, cpu) = capacity;
> >  }
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 694f6de..3b75d63 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -23,6 +23,18 @@
> >  #include <asm/cputype.h>
> >  #include <asm/topology.h>
> >
> > +static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> > +
> > +unsigned long arm_arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
> > +{
> > +       return per_cpu(cpu_scale, cpu);
> > +}
> > +
> > +void set_capacity_scale(unsigned int cpu, unsigned long capacity)
> > +{
> > +       per_cpu(cpu_scale, cpu) = capacity;
> > +}
> > +
> >  static int __init get_cpu_for_node(struct device_node *node)
> >  {
> >         struct device_node *cpu_node;
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 9e63fb1..c4025fd 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -1,5 +1,5 @@
> >  # CPUfreq core
> > -obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
> > +obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o cpufreq_capacity.o
> 
> Do you really want to have the calibration of capacity dependent of
> cpufreq ? It means that we can't use it without a cpufreq driver.
> IMHO, this creates a unnecessary dependency. I understand that you
> must ensure that core runs at max fequency if a driver is present but
> you should be able to calibrate the capacity if cpufreq is not
> available but you have different capacity because micro architecture

We could remove the dependency on cpufreq, but it would make things more
complicated for systems which do have frequency scaling as we would have
to either:

1) Run the calibration again once cpufreq has been initialized.

2) Know the frequency of all cpus at calibration time so we can
determine the correct micro-archicture difference. This option would
however mean that we have to provide a frequency scaling factor even for
systems that don't have cpufreq.

3) Find a way to do the calibration anyway if cpufreq doesn't
initialize. I'm not sure how that would work though.
