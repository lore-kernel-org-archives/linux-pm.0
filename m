From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: cpu_cooling: Replace kmalloc with kmalloc_array
Date: Wed, 24 May 2017 09:21:17 +0530
Message-ID: <20170524035117.GN6510@vireshk-i7>
References: <1495521460.2303.4.camel@intel.com>
 <eff10695c92ff2d2e9733987d1b06adf559c07b0.1495522926.git.viresh.kumar@linaro.org>
 <20170524022706.GA11529@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33930 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937996AbdEXDvW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 23:51:22 -0400
Received: by mail-pg0-f51.google.com with SMTP id u28so59134737pgn.1
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2017 20:51:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170524022706.GA11529@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 23-05-17, 19:27, Eduardo Valentin wrote:
> Hello,
> 
> On Tue, May 23, 2017 at 12:33:06PM +0530, Viresh Kumar wrote:
> > Checkpatch reports following:
> > 
> > WARNING: Prefer kmalloc_array over kmalloc with multiply
> > +	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) * i,
> > 
> > Fix that.
> 
> That is how the patch would apply. Enter to continue
> 
> WARNING: line over 80 characters
> #159: FILE: drivers/thermal/cpu_cooling.c:783:
> +	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) * i,
> 
> WARNING: Prefer kmalloc_array over kmalloc with multiply
> #159: FILE: drivers/thermal/cpu_cooling.c:783:
> +	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) * i,
> +					  GFP_KERNEL);
> 
> WARNING: line over 80 characters
> #190: FILE: include/linux/cpufreq.h:859:
> +static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)

I am not sure what you meant here. Above doesn't looks something that
this patch can generate. This was fixing the problem that you reported
above.
 
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/thermal/cpu_cooling.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index 1305020790b2..908a8014cf76 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -724,8 +724,9 @@ __cpufreq_cooling_register(struct device_node *np,
> >  	/* max_level is an index, not a counter */
> >  	cpufreq_cdev->max_level = i - 1;
> >  
> > -	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) * i,
> > -					  GFP_KERNEL);
> > +	cpufreq_cdev->freq_table = kmalloc_array(i,
> > +					sizeof(*cpufreq_cdev->freq_table),
> > +					GFP_KERNEL);
> >  	if (!cpufreq_cdev->freq_table) {

-- 
viresh
