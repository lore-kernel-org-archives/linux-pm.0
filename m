From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86, acpi: Handle xapic/x2apic entries in MADT
Date: Tue, 21 Jul 2015 10:27:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507211017590.18576@nanos>
References: <55A3D7A3.90609@linaro.org> <1436861209-4047-1-git-send-email-lukasz.anaczkowski@intel.com> <1436861209-4047-2-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1436861209-4047-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 14 Jul 2015, Lukasz Anaczkowski wrote:
> This patch is based on work of "Yinghai Lu <yinghai@kernel.org>"
> previously published at https://lkml.org/lkml/2013/1/21/563.
> 
> In case when BIOS is populating MADT wiht both x2apic and local apic
> entries (as per ACPI spec), e.g. for Xeon Phi Knights Landing,
> kernel builds it's processor table in the following order:
> BSP, X2APIC, local APIC, resulting in processors on the same core
> are not separated by core count, i.e.

You are missing to explain WHY this is the wrong ordering.
 
> Core LCpu   ApicId    LCpu    ApicId     LCpu    ApicId    LCpu    ApicId
> 0    0 (  0 [0000]),   97 (  1 [0001]),  145 (  2 [0002]),  193 (  3 [0003])
> 1   50 (  4 [0004]),   98 (  5 [0005]),  146 (  6 [0006]),  194 (  7 [0007])
> 2   51 ( 16 [0010]),   99 ( 17 [0011]),  147 ( 18 [0012]),  195 ( 19 [0013])
> 3   52 ( 20 [0014]),  100 ( 21 [0015]),  148 ( 22 [0016]),  196 ( 23 [0017])
> 4   53 ( 24 [0018]),  101 ( 25 [0019]),  149 ( 26 [001a]),  197 ( 27 [001b])
> 5   54 ( 28 [001c]),  102 ( 29 [001d]),  150 ( 30 [001e]),  198 ( 31 [001f])
> ...
> 
> Please note, how LCpu are mixed for physical cores (Core).
> 
> This patch fixes this behavior and resulting assignment is
> consistent with other Xeon processors, i.e.

You are missing to explain HOW you fix it. It's completely non obvious
why the conversion to an parse array makes it work.

>  	if (!count) {
> -		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
> -					acpi_parse_x2apic, MAX_LOCAL_APIC);
> -		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
> -					acpi_parse_lapic, MAX_LOCAL_APIC);
> +		memset(madt_proc, 0, sizeof(madt_proc));
> +		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
> +		madt_proc[0].handler = acpi_parse_lapic;
> +		madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
> +		madt_proc[1].handler = acpi_parse_x2apic;

Here you revert the parse order.

> +		acpi_table_parse_entries_array(ACPI_SIG_MADT,
> +			    sizeof(struct acpi_table_madt),
> +			    madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
> +		count = madt_proc[0].count;
> +		x2count = madt_proc[1].count;
>  	}
>  	if (!count && !x2count) {
>  		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
> @@ -1019,10 +1026,16 @@ static int __init acpi_parse_madt_lapic_entries(void)
>  		return count;
>  	}
>  
> -	x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
> -					acpi_parse_x2apic_nmi, 0);
> -	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
> -				      acpi_parse_lapic_nmi, 0);
> +	memset(madt_proc, 0, sizeof(madt_proc));
> +	madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC_NMI;
> +	madt_proc[0].handler = acpi_parse_lapic_nmi;
> +	madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC_NMI;
> +	madt_proc[1].handler = acpi_parse_x2apic_nmi;

Ditto

>  int __init acpi_numa_init(void)
> @@ -331,10 +337,18 @@ int __init acpi_numa_init(void)
>  
>  	/* SRAT: Static Resource Affinity Table */
>  	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> -		acpi_table_parse_srat(ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY,
> -				     acpi_parse_x2apic_affinity, 0);
> -		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
> -				     acpi_parse_processor_affinity, 0);
> +		struct acpi_subtable_proc srat_proc[2];
> +
> +		memset(srat_proc, 0, sizeof(srat_proc));
> +		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
> +		srat_proc[0].handler = acpi_parse_processor_affinity;
> +		srat_proc[1].id = ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY;
> +		srat_proc[1].handler = acpi_parse_x2apic_affinity;

Once more.

Please add proper explanations why the array parser is required and
why the parse order needs to be reverse.

Thanks,

	tglx
