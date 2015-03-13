From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] powercap/rapl: handle domain energy unit
Date: Fri, 13 Mar 2015 23:45:40 +0100
Message-ID: <8455620.QseysGaAJi@vostro.rjw.lan>
References: <1426243736-9732-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62293 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751820AbbCMWVx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 18:21:53 -0400
In-Reply-To: <1426243736-9732-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, kazutomo yoshii <kazutomo.yoshii@gmail.com>, lenb@vger.kernel.org

On Friday, March 13, 2015 03:48:56 AM Jacob Pan wrote:
> The current driver assumes all RAPL domains within a CPU package
> have the same energy unit. This is no longer true for HSW server
> CPUs since DRAM domain has is own fixed energy unit which can be
> different than the package energy unit enumerated by package
> power MSR. In fact, the default HSW EP package power unit is 61uJ
> whereas DRAM domain unit is 15.3uJ. The result is that DRAM power
> consumption is counted 4x more than real power reported by energy
> counters, similarly for max_energy_range_uj of DRAM domain.
> 
> This patch adds domain specific energy unit per cpu type, it allows
> domain energy unit to override package energy unit if non zero.
> 
> Please see this document for details.
> "Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, Volume 2
> of 2. Datasheet, September 2014, Reference Number: 330784-001 "
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Queued up this one for 4.0-rc5, thanks!

> ---
>  drivers/powercap/intel_rapl.c | 54 +++++++++++++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 97b5e4e..63d4033 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -73,7 +73,7 @@
>  
>  #define TIME_WINDOW_MAX_MSEC 40000
>  #define TIME_WINDOW_MIN_MSEC 250
> -
> +#define ENERGY_UNIT_SCALE    1000 /* scale from driver unit to powercap unit */
>  enum unit_type {
>  	ARBITRARY_UNIT, /* no translation */
>  	POWER_UNIT,
> @@ -158,6 +158,7 @@ struct rapl_domain {
>  	struct rapl_power_limit rpl[NR_POWER_LIMITS];
>  	u64 attr_map; /* track capabilities */
>  	unsigned int state;
> +	unsigned int domain_energy_unit;
>  	int package_id;
>  };
>  #define power_zone_to_rapl_domain(_zone) \
> @@ -190,6 +191,7 @@ struct rapl_defaults {
>  	void (*set_floor_freq)(struct rapl_domain *rd, bool mode);
>  	u64 (*compute_time_window)(struct rapl_package *rp, u64 val,
>  				bool to_raw);
> +	unsigned int dram_domain_energy_unit;
>  };
>  static struct rapl_defaults *rapl_defaults;
>  
> @@ -227,7 +229,8 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
>  static int rapl_write_data_raw(struct rapl_domain *rd,
>  			enum rapl_primitives prim,
>  			unsigned long long value);
> -static u64 rapl_unit_xlate(int package, enum unit_type type, u64 value,
> +static u64 rapl_unit_xlate(struct rapl_domain *rd, int package,
> +			enum unit_type type, u64 value,
>  			int to_raw);
>  static void package_power_limit_irq_save(int package_id);
>  
> @@ -305,7 +308,9 @@ static int get_energy_counter(struct powercap_zone *power_zone, u64 *energy_raw)
>  
>  static int get_max_energy_counter(struct powercap_zone *pcd_dev, u64 *energy)
>  {
> -	*energy = rapl_unit_xlate(0, ENERGY_UNIT, ENERGY_STATUS_MASK, 0);
> +	struct rapl_domain *rd = power_zone_to_rapl_domain(pcd_dev);
> +
> +	*energy = rapl_unit_xlate(rd, 0, ENERGY_UNIT, ENERGY_STATUS_MASK, 0);
>  	return 0;
>  }
>  
> @@ -639,6 +644,11 @@ static void rapl_init_domains(struct rapl_package *rp)
>  			rd->msrs[4] = MSR_DRAM_POWER_INFO;
>  			rd->rpl[0].prim_id = PL1_ENABLE;
>  			rd->rpl[0].name = pl1_name;
> +			rd->domain_energy_unit =
> +				rapl_defaults->dram_domain_energy_unit;
> +			if (rd->domain_energy_unit)
> +				pr_info("DRAM domain energy unit %dpj\n",
> +					rd->domain_energy_unit);
>  			break;
>  		}
>  		if (mask) {
> @@ -648,11 +658,13 @@ static void rapl_init_domains(struct rapl_package *rp)
>  	}
>  }
>  
> -static u64 rapl_unit_xlate(int package, enum unit_type type, u64 value,
> +static u64 rapl_unit_xlate(struct rapl_domain *rd, int package,
> +			enum unit_type type, u64 value,
>  			int to_raw)
>  {
>  	u64 units = 1;
>  	struct rapl_package *rp;
> +	u64 scale = 1;
>  
>  	rp = find_package_by_id(package);
>  	if (!rp)
> @@ -663,7 +675,12 @@ static u64 rapl_unit_xlate(int package, enum unit_type type, u64 value,
>  		units = rp->power_unit;
>  		break;
>  	case ENERGY_UNIT:
> -		units = rp->energy_unit;
> +		scale = ENERGY_UNIT_SCALE;
> +		/* per domain unit takes precedence */
> +		if (rd && rd->domain_energy_unit)
> +			units = rd->domain_energy_unit;
> +		else
> +			units = rp->energy_unit;
>  		break;
>  	case TIME_UNIT:
>  		return rapl_defaults->compute_time_window(rp, value, to_raw);
> @@ -673,11 +690,11 @@ static u64 rapl_unit_xlate(int package, enum unit_type type, u64 value,
>  	};
>  
>  	if (to_raw)
> -		return div64_u64(value, units);
> +		return div64_u64(value, units) * scale;
>  
>  	value *= units;
>  
> -	return value;
> +	return div64_u64(value, scale);
>  }
>  
>  /* in the order of enum rapl_primitives */
> @@ -773,7 +790,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
>  	final = value & rp->mask;
>  	final = final >> rp->shift;
>  	if (xlate)
> -		*data = rapl_unit_xlate(rd->package_id, rp->unit, final, 0);
> +		*data = rapl_unit_xlate(rd, rd->package_id, rp->unit, final, 0);
>  	else
>  		*data = final;
>  
> @@ -799,7 +816,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
>  			"failed to read msr 0x%x on cpu %d\n", msr, cpu);
>  		return -EIO;
>  	}
> -	value = rapl_unit_xlate(rd->package_id, rp->unit, value, 1);
> +	value = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
>  	msr_val &= ~rp->mask;
>  	msr_val |= value << rp->shift;
>  	if (wrmsrl_safe_on_cpu(cpu, msr, msr_val)) {
> @@ -818,7 +835,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
>   * calculate units differ on different CPUs.
>   * We convert the units to below format based on CPUs.
>   * i.e.
> - * energy unit: microJoules : Represented in microJoules by default
> + * energy unit: picoJoules  : Represented in picoJoules by default
>   * power unit : microWatts  : Represented in milliWatts by default
>   * time unit  : microseconds: Represented in seconds by default
>   */
> @@ -834,7 +851,7 @@ static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
>  	}
>  
>  	value = (msr_val & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
> -	rp->energy_unit = 1000000 / (1 << value);
> +	rp->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
>  
>  	value = (msr_val & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
>  	rp->power_unit = 1000000 / (1 << value);
> @@ -842,7 +859,7 @@ static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
>  	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
>  	rp->time_unit = 1000000 / (1 << value);
>  
> -	pr_debug("Core CPU package %d energy=%duJ, time=%dus, power=%duW\n",
> +	pr_debug("Core CPU package %d energy=%dpJ, time=%dus, power=%duW\n",
>  		rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
>  
>  	return 0;
> @@ -859,7 +876,7 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
>  		return -ENODEV;
>  	}
>  	value = (msr_val & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
> -	rp->energy_unit = 1 << value;
> +	rp->energy_unit = ENERGY_UNIT_SCALE * 1 << value;
>  
>  	value = (msr_val & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
>  	rp->power_unit = (1 << value) * 1000;
> @@ -867,7 +884,7 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
>  	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
>  	rp->time_unit = 1000000 / (1 << value);
>  
> -	pr_debug("Atom package %d energy=%duJ, time=%dus, power=%duW\n",
> +	pr_debug("Atom package %d energy=%dpJ, time=%dus, power=%duW\n",
>  		rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
>  
>  	return 0;
> @@ -1017,6 +1034,13 @@ static const struct rapl_defaults rapl_defaults_core = {
>  	.compute_time_window = rapl_compute_time_window_core,
>  };
>  
> +static const struct rapl_defaults rapl_defaults_hsw_server = {
> +	.check_unit = rapl_check_unit_core,
> +	.set_floor_freq = set_floor_freq_default,
> +	.compute_time_window = rapl_compute_time_window_core,
> +	.dram_domain_energy_unit = 15300,
> +};
> +
>  static const struct rapl_defaults rapl_defaults_atom = {
>  	.check_unit = rapl_check_unit_atom,
>  	.set_floor_freq = set_floor_freq_atom,
> @@ -1037,7 +1061,7 @@ static const struct x86_cpu_id rapl_ids[] = {
>  	RAPL_CPU(0x3a, rapl_defaults_core),/* Ivy Bridge */
>  	RAPL_CPU(0x3c, rapl_defaults_core),/* Haswell */
>  	RAPL_CPU(0x3d, rapl_defaults_core),/* Broadwell */
> -	RAPL_CPU(0x3f, rapl_defaults_core),/* Haswell */
> +	RAPL_CPU(0x3f, rapl_defaults_hsw_server),/* Haswell servers */
>  	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
>  	RAPL_CPU(0x4C, rapl_defaults_atom),/* Braswell */
>  	RAPL_CPU(0x4A, rapl_defaults_atom),/* Tangier */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
