Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958843934F;
	Mon, 13 Jul 2026 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954578; cv=none; b=nzNoBlUeZMUgvIXQbFLAaJB4CdHXkyVA49+z/hAoVZHa9y6aTWl6Df8aiXEYusdF/8N+Nh4kq9jZLmgBJk72MlVrQG0MvMb1eRZSy5ZPacsVYuELvyXM8t1ZrSwU4mq2OMIBt8fXzFN4eVTk+4Ci7GLpTcwHsKuI3Y/cQvNuOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954578; c=relaxed/simple;
	bh=xXhR+YQhbHeSxj9QTNBYPUuyrnFL7pkl2lTIj7/UPEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+DlB8Ivblz8BSptTTH8WdaYM79Afyd5/lTJoxBekd1PFCXr1E3PLRIF4Cpi71EaxjB9OOVr9cGM1V3rnwQ5BAMZAg6Iax0WdsZlaeuqJN5U87MgUHBjvdEL+R0ow+PxyysAbBEmSttE5fQmMJ+5H29Ezo7NUXlTy8kgVVW6w1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz1QN26l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz1QN26l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E897B1F00A3A;
	Mon, 13 Jul 2026 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783954576;
	bh=SG4pmBvSs0sNLwcnEn1kcaoWBVt60QEROp/eB+0WTP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pz1QN26lzHpBg0ACofz5Zp4Ni1gGTAcrL8Hhl/KOuvJ2f4vsB7YrAb+h3j4+tbmuS
	 YcLtxLbXwk3hXVhUSINxvDqJn7CGRftE1xBdyS92spHjoIcHiMC9EjkOKomwqb/r+w
	 Wi4mJda7posjB3T/o3WFScokLurYZ4vmib48LKD+G8jwu6mMHz8czjvPdZ9L7S5bW5
	 NYk0++n/qmehckA0aJeIPBYNO2ZlD9sXy7arqvLfMLIn2wVrwR2MLJr6spqWNqpEhg
	 qxmp83Or9NiXpqxlnGY9pm3VwdvnbgsLJjZGFh5p4h2A36eK6kmkI8U4C0YTUnVH2+
	 9K91guI/zFGSg==
Date: Mon, 13 Jul 2026 15:56:13 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 17/17] intel_idle: Add ACPI _LPI support
Message-ID: <20260713-aquatic-okapi-of-wind-9e657c@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <2280567.Icojqenx9y@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2280567.Icojqenx9y@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:44:23PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Allow intel_idle to use idle states information coming from ACPI _LPI
> objects by making it call acpi_processor_extract_lpi_info() and, if
> that is successful, using the list of idle states produced by that
> function instead of the one coming from acpi_processor_evaluate_cst().
> 

May be it is lack of my knowledge. I always assumed intel_idle is fine
tuned with for specific intel cores. But now if the information is being
fetched from _LPI, what is the difference between intel_idle driver
and ACPI processor idle if the FFH backend can be MWAIT.

Couple of more questions below, all just for my understanding and it
doesn't add as a review comment.

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/idle/intel_idle.c | 160 ++++++++++++++++++++++++++++++++------
>  1 file changed, 138 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index fedaa8142121..bcc2725769c5 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1779,6 +1779,7 @@ module_param_named(no_native, no_native, bool, 0444);
>  MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states in lieu of ACPI idle states");
>  
>  static struct acpi_processor_power acpi_state_table __initdata;
> +static bool acpi_lpi_available __initdata;
>  
>  /**
>   * intel_idle_cst_usable - Check if the _CST information can be used.
> @@ -1803,18 +1804,37 @@ static bool __init intel_idle_cst_usable(void)
>  	return true;
>  }
>  
> -static bool __init intel_idle_acpi_cst_extract(void)
> +static bool __init intel_idle_acpi_extract_lpi_cstates(void)
>  {
>  	unsigned int cpu;
>  
> -	if (no_acpi) {
> -		pr_debug("Not allowed to use ACPI _CST\n");
> -		return false;
> +	for_each_possible_cpu(cpu) {
> +		struct acpi_processor *pr;
> +
> +		pr = per_cpu(processors, cpu);
> +		if (!pr)
> +			continue;
> +
> +		if (acpi_processor_extract_lpi_info(pr->handle,
> +						    &acpi_state_table, true))
> +			continue;
> +
> +		acpi_lpi_available = true;
> +		return true;

On the first CPU for which acpi_processor_extract_lpi_info() returns 0,
it sets acpi_lpi_available and immediately returns true.

Consequently, one CPU’s _LPI data populates the global acpi_state_table,
which initializes the single intel_idle_driver. Remaining CPUs are neither
queried nor compared which is fine IIUC on x86. But then the questions is
why does this needs to be in a loop as you? Can't it be just the boot CPU
for instance.

>  	}
>  
> +	pr_debug("No ACPI _LPI idle states\n");
> +	return false;
> +}
> +
> +static bool __init intel_idle_acpi_extract_cst_cstates(void)
> +{
> +	unsigned int cpu;
> +
>  	for_each_possible_cpu(cpu) {
> -		struct acpi_processor *pr = per_cpu(processors, cpu);
> +		struct acpi_processor *pr;
>  
> +		pr = per_cpu(processors, cpu);
>  		if (!pr)
>  			continue;
>  
> @@ -1826,14 +1846,36 @@ static bool __init intel_idle_acpi_cst_extract(void)
>  		if (!intel_idle_cst_usable())
>  			continue;
>  
> -		if (!acpi_processor_claim_cst_control())
> -			break;
> +		return true;
> +	}
> +
> +	pr_debug("ACPI _CST not found or not usable\n");
> +	return false;
> +}
>  
> +static bool __init intel_idle_acpi_extract_cstates(void)
> +{
> +	if (intel_idle_acpi_extract_lpi_cstates())
> +		return true;
> +
> +	if (intel_idle_acpi_extract_cst_cstates())
>  		return true;
> +
> +	return false;
> +}
> +
> +static bool __init intel_idle_acpi_probe(void)
> +{
> +	if (no_acpi) {
> +		pr_debug("Not allowed to use ACPI for C-states extraction\n");
> +		return false;
>  	}
> 

The intel_idle documentation and module parameter descriptions should be
updated to reflect _LPI support IMO.

Documentation/admin-guide/pm/intel_idle.rst should no longer imply that
intel_idle only looks for _CST or only uses _CST-derived state
names/construction rules.

-- 
Regards,
Sudeep
