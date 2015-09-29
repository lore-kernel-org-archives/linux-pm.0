From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: cpu_cooling: Remove usage of devm functions
Date: Tue, 29 Sep 2015 17:39:07 +0100
Message-ID: <20150929163907.GC2717@e104805>
References: <20150819062219.GA10032@localhost>
 <CAOh2x=mN2dnuGD7BfbrrKa7_LgzDo0n5+b7KbfQg_6e7tpoMNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOh2x=mN2dnuGD7BfbrrKa7_LgzDo0n5+b7KbfQg_6e7tpoMNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Vaishali Thakkar <vthakkar1994@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo, Rui,

On Thu, Aug 27, 2015 at 02:57:08AM +0100, Viresh Kumar wrote:
> On Wed, Aug 19, 2015 at 11:52 AM, Vaishali Thakkar
> <vthakkar1994@gmail.com> wrote:
> > In the function cpufreq_get_requested_power, the memory allocated
> > for load_cpu is live within the function only. And after the
> > allocation it is immediately freed with devm_kfree. There is no
> > need to allocate memory for load_cpu with devm function so replace
> > devm_kcalloc with kcalloc and devm_kfree with kfree.
> >
> > Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> > ---
> > This patch is having one checkpatch.pl warning which suggests that
> > kfree(NULL) is safe. But I think leaving code with if is nice
> > because it reflects the fact that kcalloc was under an if. So, I
> > have ignored checkpatch. If maintainer wants me to go for changing
> > things, I am fine with it too.
> > ---
> >  drivers/thermal/cpu_cooling.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index 620dcd4..babf8b3 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -584,8 +584,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
> >         if (trace_thermal_power_cpu_get_power_enabled()) {
> >                 u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
> >
> > -               load_cpu = devm_kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
> > -                                       GFP_KERNEL);
> > +               load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
> >         }
> >
> >         for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
> > @@ -609,7 +608,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
> >         ret = get_static_power(cpufreq_device, tz, freq, &static_power);
> >         if (ret) {
> >                 if (load_cpu)
> > -                       devm_kfree(&cdev->device, load_cpu);
> > +                       kfree(load_cpu);
> >                 return ret;
> >         }
> >
> > @@ -618,7 +617,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
> >                         &cpufreq_device->allowed_cpus,
> >                         freq, load_cpu, i, dynamic_power, static_power);
> >
> > -               devm_kfree(&cdev->device, load_cpu);
> > +               kfree(load_cpu);
> >         }
> >
> >         *power = static_power + dynamic_power;
> 
> Acked-by: Javi Merino <javi.merino@arm.com>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Eduardo: Ignore V2 and apply this one :)

Looks like this fell through the cracks.  Can you pick it up?

Cheers,
Javi
