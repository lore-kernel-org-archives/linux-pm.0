From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ignore_nice vs. ignore_nice_load
Date: Mon, 05 Aug 2013 15:00:31 +0200
Message-ID: <1941712.NtnbsfnCbY@vostro.rjw.lan>
References: <51FC1935.5030702@gmx.net> <CAOh2x=kriqCRp9x+f5f5onDVoyfxVHSPDF5HrM_sFSsQ1ucktw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56478 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab3HEMuO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 5 Aug 2013 08:50:14 -0400
In-Reply-To: <CAOh2x=kriqCRp9x+f5f5onDVoyfxVHSPDF5HrM_sFSsQ1ucktw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Martin von Gagern <Martin.vGagern@gmx.net>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Monday, August 05, 2013 12:31:40 PM Viresh Kumar wrote:
> On Sat, Aug 3, 2013 at 2:10 AM, Martin von Gagern
> <Martin.vGagern@gmx.net> wrote:
> > I just noticed that recently (apparently since 4d5dcc4211f9def4) the
> > sysfs file that used to be called ignore_nice_load is now called
> > ignore_nice. I don't know why this was renamed, but what has me
> > worried even more is the fact that the documentation in
> > Documentation/cpu-freq/governors.txt wasn't updated accordingly: it
> > still talks about ignore_nice_load. It would be beter to synchronize
> > these two again.
> 
> It was an unintentional change... And so we have a bug in our code
> now.
> 
> > Investigating this issue, I also found that the file used to be called
> > ignore_nice in the past, but at that point apparently had an inverted
> > meaning. The node was renamed deliberately in 001893cda2f280ab when
> > the semantics changed. I can't help but wonder whether anyone might
> > now get confused with this old name popping up again, after all this
> > time. Either name is fine by me, but I am surprised nevertheless.
> 
> Please try following patch (attached for applying).
> @Rafael: This bug got introduced recently 3.10, so we may consider it
> as a fix for 3.11?

Yes.

Thanks,
Rafael


> ------------x----------------x---------------------
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Mon, 5 Aug 2013 12:28:02 +0530
> Subject: [PATCH] cpufreq: rename ignore_nice as ignore_nice_load
> 
> This sysfs file was earlier called ignore_nice_load and by mistake was changed
> to ignore_nice during this patch:
> 
> commit 4d5dcc4211f9def4281eafb54b8ed483862e8135
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Wed Mar 27 15:58:58 2013 +0000
> 
>     cpufreq: governor: Implement per policy instances of governors
> 
> Lets get it renamed back to its original name.
> 
> Reported-by: Martin von Gagern <Martin.vGagern@gmx.net>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 20 ++++++++++----------
>  drivers/cpufreq/cpufreq_governor.c     |  8 ++++----
>  drivers/cpufreq/cpufreq_governor.h     |  4 ++--
>  drivers/cpufreq/cpufreq_ondemand.c     | 20 ++++++++++----------
>  4 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c
> b/drivers/cpufreq/cpufreq_conservative.c
> index c400924..7f67a75 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -209,8 +209,8 @@ static ssize_t store_down_threshold(struct
> dbs_data *dbs_data, const char *buf,
>  	return count;
>  }
> 
> -static ssize_t store_ignore_nice(struct dbs_data *dbs_data, const char *buf,
> -		size_t count)
> +static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
> +		const char *buf, size_t count)
>  {
>  	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>  	unsigned int input, j;
> @@ -223,10 +223,10 @@ static ssize_t store_ignore_nice(struct dbs_data
> *dbs_data, const char *buf,
>  	if (input > 1)
>  		input = 1;
> 
> -	if (input == cs_tuners->ignore_nice) /* nothing to do */
> +	if (input == cs_tuners->ignore_nice_load) /* nothing to do */
>  		return count;
> 
> -	cs_tuners->ignore_nice = input;
> +	cs_tuners->ignore_nice_load = input;
> 
>  	/* we need to re-evaluate prev_cpu_idle */
>  	for_each_online_cpu(j) {
> @@ -234,7 +234,7 @@ static ssize_t store_ignore_nice(struct dbs_data
> *dbs_data, const char *buf,
>  		dbs_info = &per_cpu(cs_cpu_dbs_info, j);
>  		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
>  					&dbs_info->cdbs.prev_cpu_wall, 0);
> -		if (cs_tuners->ignore_nice)
> +		if (cs_tuners->ignore_nice_load)
>  			dbs_info->cdbs.prev_cpu_nice =
>  				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
>  	}
> @@ -267,7 +267,7 @@ show_store_one(cs, sampling_rate);
>  show_store_one(cs, sampling_down_factor);
>  show_store_one(cs, up_threshold);
>  show_store_one(cs, down_threshold);
> -show_store_one(cs, ignore_nice);
> +show_store_one(cs, ignore_nice_load);
>  show_store_one(cs, freq_step);
>  declare_show_sampling_rate_min(cs);
> 
> @@ -275,7 +275,7 @@ gov_sys_pol_attr_rw(sampling_rate);
>  gov_sys_pol_attr_rw(sampling_down_factor);
>  gov_sys_pol_attr_rw(up_threshold);
>  gov_sys_pol_attr_rw(down_threshold);
> -gov_sys_pol_attr_rw(ignore_nice);
> +gov_sys_pol_attr_rw(ignore_nice_load);
>  gov_sys_pol_attr_rw(freq_step);
>  gov_sys_pol_attr_ro(sampling_rate_min);
> 
> @@ -285,7 +285,7 @@ static struct attribute *dbs_attributes_gov_sys[] = {
>  	&sampling_down_factor_gov_sys.attr,
>  	&up_threshold_gov_sys.attr,
>  	&down_threshold_gov_sys.attr,
> -	&ignore_nice_gov_sys.attr,
> +	&ignore_nice_load_gov_sys.attr,
>  	&freq_step_gov_sys.attr,
>  	NULL
>  };
> @@ -301,7 +301,7 @@ static struct attribute *dbs_attributes_gov_pol[] = {
>  	&sampling_down_factor_gov_pol.attr,
>  	&up_threshold_gov_pol.attr,
>  	&down_threshold_gov_pol.attr,
> -	&ignore_nice_gov_pol.attr,
> +	&ignore_nice_load_gov_pol.attr,
>  	&freq_step_gov_pol.attr,
>  	NULL
>  };
> @@ -326,7 +326,7 @@ static int cs_init(struct dbs_data *dbs_data)
>  	tuners->up_threshold = DEF_FREQUENCY_UP_THRESHOLD;
>  	tuners->down_threshold = DEF_FREQUENCY_DOWN_THRESHOLD;
>  	tuners->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
> -	tuners->ignore_nice = 0;
> +	tuners->ignore_nice_load = 0;
>  	tuners->freq_step = DEF_FREQUENCY_STEP;
> 
>  	dbs_data->tuners = tuners;
> diff --git a/drivers/cpufreq/cpufreq_governor.c
> b/drivers/cpufreq/cpufreq_governor.c
> index 556064e..8742736 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -41,9 +41,9 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
>  	unsigned int j;
> 
>  	if (dbs_data->cdata->governor == GOV_ONDEMAND)
> -		ignore_nice = od_tuners->ignore_nice;
> +		ignore_nice = od_tuners->ignore_nice_load;
>  	else
> -		ignore_nice = cs_tuners->ignore_nice;
> +		ignore_nice = cs_tuners->ignore_nice_load;
> 
>  	policy = cdbs->cur_policy;
> 
> @@ -284,12 +284,12 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>  		cs_tuners = dbs_data->tuners;
>  		cs_dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
>  		sampling_rate = cs_tuners->sampling_rate;
> -		ignore_nice = cs_tuners->ignore_nice;
> +		ignore_nice = cs_tuners->ignore_nice_load;
>  	} else {
>  		od_tuners = dbs_data->tuners;
>  		od_dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
>  		sampling_rate = od_tuners->sampling_rate;
> -		ignore_nice = od_tuners->ignore_nice;
> +		ignore_nice = od_tuners->ignore_nice_load;
>  		od_ops = dbs_data->cdata->gov_ops;
>  		io_busy = od_tuners->io_is_busy;
>  	}
> diff --git a/drivers/cpufreq/cpufreq_governor.h
> b/drivers/cpufreq/cpufreq_governor.h
> index 264e509..a02d78b 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -164,7 +164,7 @@ struct cs_cpu_dbs_info_s {
> 
>  /* Per policy Governers sysfs tunables */
>  struct od_dbs_tuners {
> -	unsigned int ignore_nice;
> +	unsigned int ignore_nice_load;
>  	unsigned int sampling_rate;
>  	unsigned int sampling_down_factor;
>  	unsigned int up_threshold;
> @@ -173,7 +173,7 @@ struct od_dbs_tuners {
>  };
> 
>  struct cs_dbs_tuners {
> -	unsigned int ignore_nice;
> +	unsigned int ignore_nice_load;
>  	unsigned int sampling_rate;
>  	unsigned int sampling_down_factor;
>  	unsigned int up_threshold;
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c
> b/drivers/cpufreq/cpufreq_ondemand.c
> index 117278a..87f3305 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -372,8 +372,8 @@ static ssize_t store_sampling_down_factor(struct
> dbs_data *dbs_data,
>  	return count;
>  }
> 
> -static ssize_t store_ignore_nice(struct dbs_data *dbs_data, const char *buf,
> -		size_t count)
> +static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
> +		const char *buf, size_t count)
>  {
>  	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
>  	unsigned int input;
> @@ -388,10 +388,10 @@ static ssize_t store_ignore_nice(struct dbs_data
> *dbs_data, const char *buf,
>  	if (input > 1)
>  		input = 1;
> 
> -	if (input == od_tuners->ignore_nice) { /* nothing to do */
> +	if (input == od_tuners->ignore_nice_load) { /* nothing to do */
>  		return count;
>  	}
> -	od_tuners->ignore_nice = input;
> +	od_tuners->ignore_nice_load = input;
> 
>  	/* we need to re-evaluate prev_cpu_idle */
>  	for_each_online_cpu(j) {
> @@ -399,7 +399,7 @@ static ssize_t store_ignore_nice(struct dbs_data
> *dbs_data, const char *buf,
>  		dbs_info = &per_cpu(od_cpu_dbs_info, j);
>  		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
>  			&dbs_info->cdbs.prev_cpu_wall, od_tuners->io_is_busy);
> -		if (od_tuners->ignore_nice)
> +		if (od_tuners->ignore_nice_load)
>  			dbs_info->cdbs.prev_cpu_nice =
>  				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
> 
> @@ -430,7 +430,7 @@ show_store_one(od, sampling_rate);
>  show_store_one(od, io_is_busy);
>  show_store_one(od, up_threshold);
>  show_store_one(od, sampling_down_factor);
> -show_store_one(od, ignore_nice);
> +show_store_one(od, ignore_nice_load);
>  show_store_one(od, powersave_bias);
>  declare_show_sampling_rate_min(od);
> 
> @@ -438,7 +438,7 @@ gov_sys_pol_attr_rw(sampling_rate);
>  gov_sys_pol_attr_rw(io_is_busy);
>  gov_sys_pol_attr_rw(up_threshold);
>  gov_sys_pol_attr_rw(sampling_down_factor);
> -gov_sys_pol_attr_rw(ignore_nice);
> +gov_sys_pol_attr_rw(ignore_nice_load);
>  gov_sys_pol_attr_rw(powersave_bias);
>  gov_sys_pol_attr_ro(sampling_rate_min);
> 
> @@ -447,7 +447,7 @@ static struct attribute *dbs_attributes_gov_sys[] = {
>  	&sampling_rate_gov_sys.attr,
>  	&up_threshold_gov_sys.attr,
>  	&sampling_down_factor_gov_sys.attr,
> -	&ignore_nice_gov_sys.attr,
> +	&ignore_nice_load_gov_sys.attr,
>  	&powersave_bias_gov_sys.attr,
>  	&io_is_busy_gov_sys.attr,
>  	NULL
> @@ -463,7 +463,7 @@ static struct attribute *dbs_attributes_gov_pol[] = {
>  	&sampling_rate_gov_pol.attr,
>  	&up_threshold_gov_pol.attr,
>  	&sampling_down_factor_gov_pol.attr,
> -	&ignore_nice_gov_pol.attr,
> +	&ignore_nice_load_gov_pol.attr,
>  	&powersave_bias_gov_pol.attr,
>  	&io_is_busy_gov_pol.attr,
>  	NULL
> @@ -509,7 +509,7 @@ static int od_init(struct dbs_data *dbs_data)
>  	}
> 
>  	tuners->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
> -	tuners->ignore_nice = 0;
> +	tuners->ignore_nice_load = 0;
>  	tuners->powersave_bias = default_powersave_bias;
>  	tuners->io_is_busy = should_io_be_busy();
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
