From: jacob <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/2] powercap/rapl: handle missing msrs
Date: Mon, 13 Jun 2016 11:53:10 -0700
Message-ID: <20160613115310.00bbaf18@jacob-VB>
References: <1464727290-5400-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1464727290-5400-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464727290-5400-2-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Any feedback? It that is OK, can you take this patch independent of the
second patch (which is going into tip tree)?
[PATCH 2/2] powercap/rapl: add support for denverton

This patch affects some Broxton/Apollo Lake where the missing MSR will
cause the driver fail to load.

On Tue, 31 May 2016 13:41:29 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Some RAPL MSRs may not exist on some CPUs, we need to continue
> the topology detection and enumerate what is available.
> 
> This patch handles the missing MSRs then report to powercap
> layer only the features available.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 103
> ++++++++++++++++++++++++++++++++---------- 1 file changed, 79
> insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c
> b/drivers/powercap/intel_rapl.c index b0a2dc4..d51a8d4 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -329,14 +329,14 @@ static int release_zone(struct powercap_zone
> *power_zone) 
>  static int find_nr_power_limit(struct rapl_domain *rd)
>  {
> -	int i;
> +	int i, nr_pl = 0;
>  
>  	for (i = 0; i < NR_POWER_LIMITS; i++) {
> -		if (rd->rpl[i].name == NULL)
> -			break;
> +		if (rd->rpl[i].name)
> +			nr_pl++;
>  	}
>  
> -	return i;
> +	return nr_pl;
>  }
>  
>  static int set_domain_enable(struct powercap_zone *power_zone, bool
> mode) @@ -411,15 +411,38 @@ static const struct powercap_zone_ops
> zone_ops[] = { },
>  };
>  
> -static int set_power_limit(struct powercap_zone *power_zone, int id,
> +
> +/*
> + * Constraint index used by powercap can be different than power
> limit (PL)
> + * index in that some  PLs maybe missing due to non-existant MSRs.
> So we
> + * need to convert here by finding the valid PLs only (name
> populated).
> + */
> +static int contraint_to_pl(struct rapl_domain *rd, int cid)
> +{
> +	int i, j;
> +
> +	for (i = 0, j = 0; i < NR_POWER_LIMITS; i++) {
> +		if ((rd->rpl[i].name) && j++ == cid) {
> +			pr_debug("%s: index %d\n", __func__, i);
> +			return i;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int set_power_limit(struct powercap_zone *power_zone, int cid,
>  			u64 power_limit)
>  {
>  	struct rapl_domain *rd;
>  	struct rapl_package *rp;
>  	int ret = 0;
> +	int id;
>  
>  	get_online_cpus();
>  	rd = power_zone_to_rapl_domain(power_zone);
> +	id = contraint_to_pl(rd, cid);
> +
>  	rp = rd->rp;
>  
>  	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
> @@ -446,16 +469,18 @@ set_exit:
>  	return ret;
>  }
>  
> -static int get_current_power_limit(struct powercap_zone *power_zone,
> int id, +static int get_current_power_limit(struct powercap_zone
> *power_zone, int cid, u64 *data)
>  {
>  	struct rapl_domain *rd;
>  	u64 val;
>  	int prim;
>  	int ret = 0;
> +	int id;
>  
>  	get_online_cpus();
>  	rd = power_zone_to_rapl_domain(power_zone);
> +	id = contraint_to_pl(rd, cid);
>  	switch (rd->rpl[id].prim_id) {
>  	case PL1_ENABLE:
>  		prim = POWER_LIMIT1;
> @@ -477,14 +502,17 @@ static int get_current_power_limit(struct
> powercap_zone *power_zone, int id, return ret;
>  }
>  
> -static int set_time_window(struct powercap_zone *power_zone, int id,
> +static int set_time_window(struct powercap_zone *power_zone, int cid,
>  								u64
> window) {
>  	struct rapl_domain *rd;
>  	int ret = 0;
> +	int id;
>  
>  	get_online_cpus();
>  	rd = power_zone_to_rapl_domain(power_zone);
> +	id = contraint_to_pl(rd, cid);
> +
>  	switch (rd->rpl[id].prim_id) {
>  	case PL1_ENABLE:
>  		rapl_write_data_raw(rd, TIME_WINDOW1, window);
> @@ -499,14 +527,17 @@ static int set_time_window(struct powercap_zone
> *power_zone, int id, return ret;
>  }
>  
> -static int get_time_window(struct powercap_zone *power_zone, int id,
> u64 *data) +static int get_time_window(struct powercap_zone
> *power_zone, int cid, u64 *data) {
>  	struct rapl_domain *rd;
>  	u64 val;
>  	int ret = 0;
> +	int id;
>  
>  	get_online_cpus();
>  	rd = power_zone_to_rapl_domain(power_zone);
> +	id = contraint_to_pl(rd, cid);
> +
>  	switch (rd->rpl[id].prim_id) {
>  	case PL1_ENABLE:
>  		ret = rapl_read_data_raw(rd, TIME_WINDOW1, true,
> &val); @@ -525,15 +556,17 @@ static int get_time_window(struct
> powercap_zone *power_zone, int id, u64 *data) return ret;
>  }
>  
> -static const char *get_constraint_name(struct powercap_zone
> *power_zone, int id) +static const char *get_constraint_name(struct
> powercap_zone *power_zone, int cid) {
> -	struct rapl_power_limit *rpl;
>  	struct rapl_domain *rd;
> +	int id;
>  
>  	rd = power_zone_to_rapl_domain(power_zone);
> -	rpl = (struct rapl_power_limit *) &rd->rpl[id];
> +	id = contraint_to_pl(rd, cid);
> +	if (id >= 0)
> +		return rd->rpl[id].name;
>  
> -	return rpl->name;
> +	return NULL;
>  }
>  
>  
> @@ -1305,6 +1338,37 @@ static int rapl_check_domain(int cpu, int
> domain) return 0;
>  }
>  
> +
> +/*
> + * Check if power limits are available. Two cases when they are not
> available:
> + * 1. Locked by BIOS, in this case we still provide read-only access
> so that
> + *    users can see what limit is set by the BIOS.
> + * 2. Some CPUs make some domains monitoring only which means PLx
> MSRs may not
> + *    exist at all. In this case, we do not show the contraints in
> powercap.
> + *
> + * Called after domains are detected and initialized.
> + */
> +static void rapl_detect_powerlimit(struct rapl_domain *rd)
> +{
> +	u64 val64;
> +	int i;
> +
> +	/* check if the domain is locked by BIOS, ignore if MSR
> doesn't exist */
> +	if (!rapl_read_data_raw(rd, FW_LOCK, false, &val64)) {
> +		if (val64) {
> +			pr_info("RAPL package %d domain %s locked by
> BIOS\n",
> +				rd->rp->id, rd->name);
> +			rd->state |= DOMAIN_STATE_BIOS_LOCKED;
> +		}
> +	}
> +	/* check if power limit MSRs exists, otherwise domain is
> monitoring only */
> +	for (i = 0; i < NR_POWER_LIMITS; i++) {
> +		int prim = rd->rpl[i].prim_id;
> +		if (rapl_read_data_raw(rd, prim, false, &val64))
> +			rd->rpl[i].name = NULL;
> +	}
> +}
> +
>  /* Detect active and valid domains for the given CPU, caller must
>   * ensure the CPU belongs to the targeted package and CPU hotlug is
> disabled. */
> @@ -1313,7 +1377,6 @@ static int rapl_detect_domains(struct
> rapl_package *rp, int cpu) int i;
>  	int ret = 0;
>  	struct rapl_domain *rd;
> -	u64 locked;
>  
>  	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
>  		/* use physical package id to read counters */
> @@ -1338,17 +1401,9 @@ static int rapl_detect_domains(struct
> rapl_package *rp, int cpu) }
>  	rapl_init_domains(rp);
>  
> -	for (rd = rp->domains; rd < rp->domains + rp->nr_domains;
> rd++) {
> -		/* check if the domain is locked by BIOS */
> -		ret = rapl_read_data_raw(rd, FW_LOCK, false,
> &locked);
> -		if (ret)
> -			return ret;
> -		if (locked) {
> -			pr_info("RAPL package %d domain %s locked by
> BIOS\n",
> -				rp->id, rd->name);
> -			rd->state |= DOMAIN_STATE_BIOS_LOCKED;
> -		}
> -	}
> +	for (rd = rp->domains; rd < rp->domains + rp->nr_domains;
> rd++)
> +		rapl_detect_powerlimit(rd);
> +
>  
>  
>  done:
