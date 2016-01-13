From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 10:47:26 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601131042590.3575@nanos>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com> <1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48021 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbcAMJs0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 04:48:26 -0500
In-Reply-To: <1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>

On Tue, 12 Jan 2016, Jacob Pan wrote:
> @@ -805,30 +809,18 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
>  			enum rapl_primitives prim,
>  			unsigned long long value)
>  {
> -	u64 msr_val;
> -	u32 msr;
>  	struct rapl_primitive_info *rp = &rpi[prim];
>  	int cpu;
> +	u64 bits;
>  
>  	cpu = find_active_cpu_on_package(rd->package_id);
>  	if (cpu < 0)
>  		return cpu;
> -	msr = rd->msrs[rp->id];
> -	if (rdmsrl_safe_on_cpu(cpu, msr, &msr_val)) {
> -		dev_dbg(&rd->power_zone.dev,
> -			"failed to read msr 0x%x on cpu %d\n", msr, cpu);
> -		return -EIO;
> -	}
> -	value = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
> -	msr_val &= ~rp->mask;
> -	msr_val |= value << rp->shift;
> -	if (wrmsrl_safe_on_cpu(cpu, msr, msr_val)) {
> -		dev_dbg(&rd->power_zone.dev,
> -			"failed to write msr 0x%x on cpu %d\n", msr, cpu);
> -		return -EIO;
> -	}
>  
> -	return 0;
> +	bits = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
> +	bits |= bits << rp->shift;
> +
> +	return rmwmsrl_safe_on_cpu(cpu, rd->msrs[rp->id], rp->mask, bits);

So here you actually use that new (misnomed) function, but for 

> +static void power_limit_irq_save_cpu(void *info)

and

> +static void power_limit_irq_restore_cpu(void *info)

you use a bog standard smp function call. What's the benefit of adding that
rmw function over a bog standard smp function call if you can only use it for
one instance of the same pattern?

Boris asked you the same question here

      https://lkml.kernel.org/r/20151220152749.GA29805@pd.tnic

but you decided to ignore it.

Thanks,

	tglx




