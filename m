From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap/rapl: handle domain energy unit
Date: Thu, 12 Mar 2015 14:24:13 -0700
Message-ID: <20150312142413.7bd42863@icelake>
References: <1426078509-3767-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<5500B2E0.9000107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15706 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbbCLVZI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 Mar 2015 17:25:08 -0400
In-Reply-To: <5500B2E0.9000107@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kazutomo <kazutomo.yoshii@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>

On Wed, 11 Mar 2015 16:25:52 -0500
kazutomo <kazutomo.yoshii@gmail.com> wrote:

> Hi Jacob,
> 
> Wow, this is a really pitfall for people who are writing their own
> RAPL tool.
> Anyway, I've tested your patch on a Haswell system (2699v3), running a
> dgemm
> benchmark. NOTE: userspace governor is selected. All core are set to
> 2.3 GHz.
> No power cap is set.
>  
> # before the patch is applied
> $ cd /sys/class/powercap/intel-rapl:0:0
> $ cat name
> dram
> $ for i in 1 2 3 ; do a=`cat energy_uj` ; sleep 1 ; b=`cat
> energy_uj` ; expr $b - $a ; done
> 16853445
> 16829355
> 16666320
>  
> # after the patch is applied
> $ for i in 1 2 3 ; do a=`cat energy_uj` ; sleep 1 ; b=`cat
> energy_uj` ; expr $b - $a ; done 
> 69751487
> 68153897
> 69689816
> 
thanks for testing, but i thought the results should be the other way
around. counting 15uJ vs 61uJ after the patch is applied. I will double
check once i get a machine again.
> 
> I have a couple of questions. 
>  
> 1. Is it possible to retrieve the DRAM energy unit from some MSRs
> *eventually* like the domain energy unit? 
>  
according to the document, future DRAM energy unit will always be
hardcoded to 15.3uJ, no enumeration since there is no domain specific
MSR for energy unit.
> 2. Will the Intel software developer's manual (vol3b) be updated
> accordingly if you know? I'm assuming that you are working at Intel.
>  
I don't know. Let me get back to you later. 
> 3. Is get_max_energy_range_uj still the same as other counters?
>  
good catch. max energy is obtained from parent package domain which
still uses MSR enumerated unit. now it has to be per domain.
> 4. The current driver maintains the unit as an integer, instead of a
> shift value, and the multiplier is a relatively small number.  I guess
> the DRAM energy unit is technically ~15.2587 uJ = (0.5 ** 16) * 1e6,
> so it always reports a approx. 2 % smaller energy number, while the
> pkg energy unit is ~61.0351, so the error is ~0.5 %.  An easier
> solution would be to maintain the unit in pJ, instead of uJ. 
> or am I worrying too much? I guess the RAPL energy estimation may
> have some error, so maybe canceling out.
> 
yes, you are right. using pJ or more precise shift would be a better.
let me add that also.

Thanks,

Jacob
> - kaz
> 
> On 03/11/2015 07:55 AM, Jacob Pan wrote:
> > The current driver assumes all RAPL domains within a CPU package
> > have the same energy unit. This is no longer true for HSW server
> > CPUs since DRAM domain has is own fixed energy unit which can be
> > different than the package energy unit enumerated by package
> > power MSR. In fact, the default HSW EP package power unit is 61uJ
> > whereas DRAM domain unit is 15.3uJ. The result is that DRAM power
> > consumption is counted 4x more than real power reported by energy
> > counters.
> >
> > This patch adds domain specific energy unit per cpu type, it allows
> > domain energy unit to override package energy unit if non zero.
> >
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/powercap/intel_rapl.c | 35
> > ++++++++++++++++++++++++++++------- 1 file changed, 28
> > insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c index 97b5e4e..af4c61e 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -158,6 +158,7 @@ struct rapl_domain {
> >  	struct rapl_power_limit rpl[NR_POWER_LIMITS];
> >  	u64 attr_map; /* track capabilities */
> >  	unsigned int state;
> > +	unsigned int domain_energy_unit;
> >  	int package_id;
> >  };
> >  #define power_zone_to_rapl_domain(_zone) \
> > @@ -190,6 +191,7 @@ struct rapl_defaults {
> >  	void (*set_floor_freq)(struct rapl_domain *rd, bool mode);
> >  	u64 (*compute_time_window)(struct rapl_package *rp, u64
> > val, bool to_raw);
> > +	unsigned int dram_domain_energy_unit;
> >  };
> >  static struct rapl_defaults *rapl_defaults;
> >  
> > @@ -227,7 +229,8 @@ static int rapl_read_data_raw(struct
> > rapl_domain *rd, static int rapl_write_data_raw(struct rapl_domain
> > *rd, enum rapl_primitives prim,
> >  			unsigned long long value);
> > -static u64 rapl_unit_xlate(int package, enum unit_type type, u64
> > value, +static u64 rapl_unit_xlate(struct rapl_domain *rd, int
> > package,
> > +			enum unit_type type, u64 value,
> >  			int to_raw);
> >  static void package_power_limit_irq_save(int package_id);
> >  
> > @@ -305,7 +308,8 @@ static int get_energy_counter(struct
> > powercap_zone *power_zone, u64 *energy_raw) 
> >  static int get_max_energy_counter(struct powercap_zone *pcd_dev,
> > u64 *energy) {
> > -	*energy = rapl_unit_xlate(0, ENERGY_UNIT,
> > ENERGY_STATUS_MASK, 0);
> > +	/* package domain is the largest */
> > +	*energy = rapl_unit_xlate(NULL, 0, ENERGY_UNIT,
> > ENERGY_STATUS_MASK, 0); return 0;
> >  }
> >  
> > @@ -639,6 +643,11 @@ static void rapl_init_domains(struct
> > rapl_package *rp) rd->msrs[4] = MSR_DRAM_POWER_INFO;
> >  			rd->rpl[0].prim_id = PL1_ENABLE;
> >  			rd->rpl[0].name = pl1_name;
> > +			rd->domain_energy_unit =
> > +
> > rapl_defaults->dram_domain_energy_unit;
> > +			if (rd->domain_energy_unit)
> > +				pr_info("DRAM domain energy unit
> > %duj\n",
> > +					rd->domain_energy_unit);
> >  			break;
> >  		}
> >  		if (mask) {
> > @@ -648,7 +657,8 @@ static void rapl_init_domains(struct
> > rapl_package *rp) }
> >  }
> >  
> > -static u64 rapl_unit_xlate(int package, enum unit_type type, u64
> > value, +static u64 rapl_unit_xlate(struct rapl_domain *rd, int
> > package,
> > +			enum unit_type type, u64 value,
> >  			int to_raw)
> >  {
> >  	u64 units = 1;
> > @@ -663,7 +673,11 @@ static u64 rapl_unit_xlate(int package, enum
> > unit_type type, u64 value, units = rp->power_unit;
> >  		break;
> >  	case ENERGY_UNIT:
> > -		units = rp->energy_unit;
> > +		/* per domain unit takes precedence */
> > +		if (rd && rd->domain_energy_unit)
> > +			units = rd->domain_energy_unit;
> > +		else
> > +			units = rp->energy_unit;
> >  		break;
> >  	case TIME_UNIT:
> >  		return rapl_defaults->compute_time_window(rp,
> > value, to_raw); @@ -773,7 +787,7 @@ static int
> > rapl_read_data_raw(struct rapl_domain *rd, final = value & rp->mask;
> >  	final = final >> rp->shift;
> >  	if (xlate)
> > -		*data = rapl_unit_xlate(rd->package_id, rp->unit,
> > final, 0);
> > +		*data = rapl_unit_xlate(rd, rd->package_id,
> > rp->unit, final, 0); else
> >  		*data = final;
> >  
> > @@ -799,7 +813,7 @@ static int rapl_write_data_raw(struct
> > rapl_domain *rd, "failed to read msr 0x%x on cpu %d\n", msr, cpu);
> >  		return -EIO;
> >  	}
> > -	value = rapl_unit_xlate(rd->package_id, rp->unit, value,
> > 1);
> > +	value = rapl_unit_xlate(rd, rd->package_id, rp->unit,
> > value, 1); msr_val &= ~rp->mask;
> >  	msr_val |= value << rp->shift;
> >  	if (wrmsrl_safe_on_cpu(cpu, msr, msr_val)) {
> > @@ -1017,6 +1031,13 @@ static const struct rapl_defaults
> > rapl_defaults_core = { .compute_time_window =
> > rapl_compute_time_window_core, };
> >  
> > +static const struct rapl_defaults rapl_defaults_hsw_server = {
> > +	.check_unit = rapl_check_unit_core,
> > +	.set_floor_freq = set_floor_freq_default,
> > +	.compute_time_window = rapl_compute_time_window_core,
> > +	.dram_domain_energy_unit = 15,
> > +};
> > +
> >  static const struct rapl_defaults rapl_defaults_atom = {
> >  	.check_unit = rapl_check_unit_atom,
> >  	.set_floor_freq = set_floor_freq_atom,
> > @@ -1037,7 +1058,7 @@ static const struct x86_cpu_id rapl_ids[] = {
> >  	RAPL_CPU(0x3a, rapl_defaults_core),/* Ivy Bridge */
> >  	RAPL_CPU(0x3c, rapl_defaults_core),/* Haswell */
> >  	RAPL_CPU(0x3d, rapl_defaults_core),/* Broadwell */
> > -	RAPL_CPU(0x3f, rapl_defaults_core),/* Haswell */
> > +	RAPL_CPU(0x3f, rapl_defaults_hsw_server),/* Haswell
> > servers */ RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
> >  	RAPL_CPU(0x4C, rapl_defaults_atom),/* Braswell */
> >  	RAPL_CPU(0x4A, rapl_defaults_atom),/* Tangier */
> 

[Jacob Pan]
