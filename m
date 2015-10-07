From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/2] cpufreq: acpi_cpufreq: prevent crash on reading
 freqdomain_cpus
Date: Wed, 07 Oct 2015 08:34:15 -0700
Message-ID: <1444232055.3514.0.camel@spandruv-desk3.jf.intel.com>
References: <1443738182-4077-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151007121910.GF902@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27111 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753874AbbJGPfm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 11:35:42 -0400
In-Reply-To: <20151007121910.GF902@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Wed, 2015-10-07 at 17:49 +0530, Viresh Kumar wrote:
> On 01-10-15, 15:23, Srinivas Pandruvada wrote:
> > When freqdomain_cpus attribute is read from an offlined cpu, it will
> > cause crash. This change prevents calling cpufreq_show_cpus when
> > mask is NULL.
> 
> Not exactly, you prevent it when the driver_data is NULL and not the
> mask.
correct, I will change the description.
> 
> > Alternatively we can add this NULL check in
> > cpufreq_show_cpus function.
> 
> That will be a different change then, as we aren't comparing the mask
> now. I will just remove the above line from the commit log, to say
> what we are doing, not what we can also do.
> 
> > Crash info:
> > 
> > [  170.814949] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
> > [  170.814990] IP: [<ffffffff813b2490>] _find_next_bit.part.0+0x10/0x70
> > [  170.815021] PGD 227d30067 PUD 229e56067 PMD 0
> > [  170.815043] Oops: 0000 [#2] SMP
> > [  170.816022] CPU: 3 PID: 3121 Comm: cat Tainted: G      D    OE   4.3.0-rc3+ #33
> > ...
> > ...
> > [  170.816657] Call Trace:
> > [  170.816672]  [<ffffffff813b2505>] ? find_next_bit+0x15/0x20
> > [  170.816696]  [<ffffffff8160e47c>] cpufreq_show_cpus+0x5c/0xd0
> > [  170.816722]  [<ffffffffa031a409>] show_freqdomain_cpus+0x19/0x20 [acpi_cpufreq]
> > [  170.816749]  [<ffffffff8160e65b>] show+0x3b/0x60
> > [  170.816769]  [<ffffffff8129b31c>] sysfs_kf_seq_show+0xbc/0x130
> > [  170.816793]  [<ffffffff81299be3>] kernfs_seq_show+0x23/0x30
> > [  170.816816]  [<ffffffff81240f2c>] seq_read+0xec/0x390
> > [  170.816837]  [<ffffffff8129a64a>] kernfs_fop_read+0x10a/0x160
> > [  170.816861]  [<ffffffff8121d9b7>] __vfs_read+0x37/0x100
> > [  170.816883]  [<ffffffff813217c0>] ? security_file_permission+0xa0/0xc0
> > [  170.816909]  [<ffffffff8121e2e3>] vfs_read+0x83/0x130
> > [  170.816930]  [<ffffffff8121f035>] SyS_read+0x55/0xc0
> > ...
> > ...
> > [  170.817185] ---[ end trace bc6eadf82b2b965a ]---
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index 7982772..cec1ee2 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -149,6 +149,9 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
> >  {
> >  	struct acpi_cpufreq_data *data = policy->driver_data;
> >  
> > +	if (unlikely(!data))
> > +		return -ENODEV;
> > +
> >  	return cpufreq_show_cpus(data->freqdomain_cpus, buf);
> >  }
> 
> Change looks fine though.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 


