From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Tue, 10 Mar 2015 09:57:07 +0800
Message-ID: <CALx668Ue7Q2Xj=f+TN3bpybL6+8bmTVTFOgOy3ouurb7jMJS9g@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
	<1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
	<20150309162809.GY8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150309162809.GY8656-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chen Fan <fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joe.C
List-Id: linux-pm@vger.kernel.org

On 10 March 2015 at 00:28, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Wed, Mar 04, 2015 at 04:49:15PM +0800, pi-cheng.chen wrote:
>> +static int cpu_opp_table_get_freq_index(unsigned int freq)
>> +{
>> +     struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
>> +     int i;
>> +
>> +     for (i = 0; opp_tbl[i].freq != 0; i++) {
>> +             if (opp_tbl[i].freq >= freq)
>> +                     return i;
>> +     }
>> +
>> +     return -1;
>
> My "return -1" detector fired on this...
>
>> +static int cpu_opp_table_get_volt_index(unsigned int volt)
>> +{
>> +     struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
>> +     int i;
>> +
>> +     for (i = 0; opp_tbl[i].vproc != -1; i++)
>> +             if (opp_tbl[i].vproc >= volt)
>> +                     return i;
>> +
>> +     return -1;
>
> And this.
>
>> +static int mtk_cpufreq_notify(struct notifier_block *nb,
>> +                           unsigned long action, void *data)
>> +{
>> +     struct cpufreq_freqs *freqs = data;
>> +     struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
>> +     int old_vproc, new_vproc, old_index, new_index;
>> +
>> +     if (!cpumask_test_cpu(freqs->cpu, &dvfs_info->cpus))
>> +             return NOTIFY_DONE;
>> +
>> +     old_vproc = regulator_get_voltage(dvfs_info->proc_reg);
>> +     old_index = cpu_opp_table_get_volt_index(old_vproc);
>> +     new_index = cpu_opp_table_get_freq_index(freqs->new * 1000);
>> +     new_vproc = opp_tbl[new_index].vproc;
>
> Let's say that cpu_opp_table_get_freq_index() returns -1.  We then
> do no error checking on this, and access the memory immediately
> preceding opp_tbl[0].
>
> Since we'll be loading garbage from opp_tbl[-1], this probably means
> that mtk_cpufreq_voltage_trace() will go wrong.  Your method of using
> the vproc values to work out which direction we should walk between
> old_index...new_index means that we could end up walking through
> almost the whole UINT_MAX range to wrap around to the new index.
>
> Yet again, "return -1" proves to be a sure sign of a bug.

Hi Russell,

Thanks for your reviewing. I'll fix it in next version.

Best Regards,
Pi-Cheng

>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
