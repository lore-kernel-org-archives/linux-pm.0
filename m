From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: BUG in bleeding edge c560f3d
Date: Tue, 05 Feb 2013 11:08:08 +0100
Message-ID: <1708503.DiTTyRLM9i@vostro.rjw.lan>
References: <511033EA.7090604@gmail.com> <CAKohpo=-A+VTxsrMQk5SthHZLywrO-E3EHQnSs3_jG593cJzUw@mail.gmail.com> <CAKohpomDLWFP5tTnhTidOOrkEhW_z5Ht_MzbbnzDaq-i+-1aEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43995 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab3BEKBu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Feb 2013 05:01:50 -0500
In-Reply-To: <CAKohpomDLWFP5tTnhTidOOrkEhW_z5Ht_MzbbnzDaq-i+-1aEg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, February 05, 2013 12:38:44 PM Viresh Kumar wrote:
> On 5 February 2013 11:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 5 February 2013 08:13, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> On Monday, February 04, 2013 04:05:27 PM Dirk Brandewie wrote:
> >
> >>> Rebased a couple of hours ago testing now.  ATM it looks like it is related to
> >>> cpufreq_stats handling of the sysfs files
> >>
> >> This looks like a problem with commit b8eed8a.  Viresh?
> >
> > I had some direct chat with Dirk to understand his problem. He has got lots
> > of minor changes, which by themselves looks incorrect, for ex:
> > - He is required to cpufreq_frequency_table_put_attr() from his drivers
> >   init() code to make it NULL... But it should already have been NULL as per
> >   my understanding. I really want him to test his driver without any additional
> >   target/set_policy() patches he has.. to see if linux-next works for
> > him or not.
> >
> > He will do this testing tomorrow and will let us know of any issues he faces.
> >
> > We have already tested linux-next and these patches on ARM TC2 and STE
> > u8500 (by Fabio), with reboots and lots of hotplugging.
> >
> > Though i am still going to review my own patches once more to see if there is
> > scope for improvement.
> 
> The system on which Dirk is testing his patches has following configuration:
> 1 Package, 4 cpus, 8 virtual cores...
> 
> Though they share their clock line in some way, it is handled by the
> cpufreq driver
> only and for the outside world (cpufreq core), it looks as there are 8
> independent cpus,
> and so 8 policy structures.
> 
> I tried to reproduce the issue at my end by removing extra cpus from
> my clusters and
> just keeping one per cluster alive from DT.
> 
> And i *wasn't* able to reproduce the problem. Though i was able to
> find a small bug/issue
> in the current code for which i have following patch (attached too):

Thanks for working on this!

> @Dirk: Please give this one a try. Atleast on my system with various
> configurations, i
> couldn't see any different this patch has made, but is more logical to me.

It looks good, I'm going to take it.

Thanks,
Rafael


> commit 9bdd6d47403e696d05953870019e791806f8d6bf
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Tue Feb 5 12:28:18 2013 +0530
> 
>     cpufreq: Don't remove sysfs link for policy->cpu
> 
>     "cpufreq" directory in policy->cpu is never created using
> sysfs_create_link(),
>     but using kobject_init_and_add(). And so we shouldn't call
> sysfs_remove_link()
>     for policy->cpu(). sysfs stuff for policy->cpu is automatically
> removed when we
>     call kobject_put() for dying policy.
> 
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7aacfbf..9567451 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1047,7 +1047,9 @@ static int __cpufreq_remove_dev(struct device
> *dev, struct subsys_interface *sif
>         cpus = cpumask_weight(data->cpus);
>         cpumask_clear_cpu(cpu, data->cpus);
> 
> -       if (unlikely((cpu == data->cpu) && (cpus > 1))) {
> +       if (cpu != data->cpu) {
> +               sysfs_remove_link(&dev->kobj, "cpufreq");
> +       } else if (cpus > 1) {
>                 /* first sibling now owns the new sysfs dir */
>                 cpu_dev = get_cpu_device(cpumask_first(data->cpus));
>                 sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
> @@ -1072,7 +1074,6 @@ static int __cpufreq_remove_dev(struct device
> *dev, struct subsys_interface *sif
>         pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
>         cpufreq_cpu_put(data);
>         unlock_policy_rwsem_write(cpu);
> -       sysfs_remove_link(&dev->kobj, "cpufreq");
> 
>         /* If cpu is last user of policy, free policy */
>         if (cpus == 1) {
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
