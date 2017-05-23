From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 03/17] thermal: cpu_cooling: Name cpufreq cooling
 devices as cpufreq_cdev
Date: Tue, 23 May 2017 12:34:32 +0530
Message-ID: <20170523070432.GK6510@vireshk-i7>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
 <323c25bfc9454e54102b0956bae049365f1ba2bb.1493115651.git.viresh.kumar@linaro.org>
 <1495521460.2303.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35389 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753555AbdEWHEf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 03:04:35 -0400
Received: by mail-pf0-f171.google.com with SMTP id n23so105453835pfb.2
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2017 00:04:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1495521460.2303.4.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

On 23-05-17, 14:37, Zhang Rui wrote:
> On Tue, 2017-04-25 at 15:57 +0530, Viresh Kumar wrote:
> > Objects of "struct cpufreq_cooling_device" are named a bit
> > inconsistently. Lets use cpufreq_cdev everywhere. Also note that the
> > lists containing such devices is renamed similarly too.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> > ---
> >  drivers/thermal/cpu_cooling.c | 248 +++++++++++++++++++++-----------
> > ----------
> >  1 file changed, 124 insertions(+), 124 deletions(-)
> > 
> > 
> 
> >  
> >  	num_cpus = cpumask_weight(clip_cpus);
> > -	cpufreq_dev->time_in_idle = kcalloc(num_cpus,
> > -					    sizeof(*cpufreq_dev-
> > >time_in_idle),
> > +	cpufreq_cdev->time_in_idle = kcalloc(num_cpus,
> > +					    sizeof(*cpufreq_cdev-
> > >time_in_idle),
> >  					    GFP_KERNEL);
> 
> checkpatch complains about this line

Not about this line, but the one present below it.

> WARNING: Prefer kmalloc_array over kmalloc with multiply
> #544: FILE: drivers/thermal/cpu_cooling.c:827:
> +	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev-
> >freq_table) *
> +					  cpufreq_cdev->max_level,
> GFP_KERNEL);
> 
> total: 0 errors, 1 warnings, 614 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-
> inplace.
> 
> and also patch 8/17.
> 
> It's better to get this fixed.

Sure. As this was existing code and nothing new that I added, I have
sent a separate patch in reply to your email to get that fixed. You
can apply this series followed by that patch now.

-- 
viresh
