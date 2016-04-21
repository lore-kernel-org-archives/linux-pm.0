From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH v2] Force cppc_cpufreq to report values in KHz to fix
 user space reporting
Date: Thu, 21 Apr 2016 15:53:10 +0100
Message-ID: <20160421145310.GA26655@arm.com>
References: <1461024699-13734-1-git-send-email-ahs3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55761 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbcDUOxU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Apr 2016 10:53:20 -0400
Content-Disposition: inline
In-Reply-To: <1461024699-13734-1-git-send-email-ahs3@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahs3@redhat.com
Cc: viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


On Tue, Apr 19, 2016 at 1:11 AM, Al Stone <ahs3@redhat.com> wrote:
> 
> When CPPC is being used by ACPI on arm64, user space tools such as
> cpupower report CPU frequency values from sysfs that are incorrect.
> 
> What the driver was doing was reporting the values given by ACPI tables
> in whatever scale was used to provide them.  However, the ACPI spec
> defines the CPPC values as unitless abstract numbers.  Internal kernel
> structures such as struct perf_cap, in contrast, expect these values
> to be in KHz.  When these struct values get reported via sysfs, the
> user space tools also assume they are in KHz, causing them to report
> incorrect values (for example, reporting a CPU frequency of 1MHz when
> it should be 1.8GHz).
> 
> While the investigation for a long term fix proceeds (several options
> are being explored, some of which may require spec changes or other
> much more invasive fixes), this patch forces the values read by CPPC
> to be read in KHz, regardless of what they actually represent.
> 
> The downside is that this approach has some assumptions:
> 
>    (1) It relies on SMBIOS3 being used, *and* that the Max Frequency
>    value for a processor is set to a non-zero value.
> 
>    (2) It assumes that all processors run at the same speed.  This

Sometimes short-term solution becomes long-term. It's worth to place
comment in code about this assumption.

>    patch retrieves the first CPU Max Frequency from a type 4 DMI
>    record that it can find.  This may not be an issue, however, as a
>    sampling of DMI data on x86 and arm64 indicates there is often only
>    one such record regardless.
> 
> For arm64 servers, this may be sufficient, but it does rely on
> firmware values being set correctly.  Hence, other approaches are
> also being considered.
> 
> This has been tested on three arm64 servers, with and without DMI, with
> and without CPPC support.
> 
> Changes for v2:
>     -- Corrected thinko: needed to have DEPENDS on DMI in Kconfig.arm,
>        not SELECT DMI (found by build daemon)
> 
> Signed-off-by: Al Stone <ahs3@redhat.com>
> ---
>  drivers/acpi/cppc_acpi.c    | 61 +++++++++++++++++++++++++++++++++++++++++----
>  drivers/cpufreq/Kconfig.arm |  1 +
>  2 files changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 8adac69..d61ced6 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -40,6 +40,9 @@
>  #include <linux/cpufreq.h>
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
> +#include <linux/dmi.h>
> +
> +#include <asm/unaligned.h>
> 
>  #include <acpi/cppc_acpi.h>
>  /*
> @@ -709,6 +712,47 @@ static int cpc_write(struct cpc_reg *reg, u64 val)
>         return ret_val;
>  }
> 
> +static u64 cppc_dmi_khz;
> +
> +static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
> +{
> +       u16 *mhz = (u16 *)private;
> +       const u8 *dmi_data = (const u8 *)dm;
> +
> +       if (dm->type == DMI_ENTRY_PROCESSOR && dm->length >= 48)
> +               *mhz = (u16)get_unaligned((const u16 *)(dmi_data + 0x14));
> +}
> +
> +
> +static u64 cppc_get_dmi_khz(void)
> +{
> +       u16 mhz;
> +
> +       dmi_walk(cppc_find_dmi_mhz, &mhz);
> +
> +       /*
> +        * Real stupid fallback value, just in case there is no
> +        * actual value set.
> +        */
> +       mhz = mhz ? mhz : 1;
> +
> +       return (1000 * mhz);
> +}
> +
> +static u64 cppc_unitless_to_khz(u64 min, u64 max, u64 val)
> +{
> +       /*
> +        * The incoming val should be min <= val <= max.  Our
> +        * job is to convert that to KHz so it can be properly
> +        * reported to user space via cpufreq_policy.
> +        */
> +
> +       if (!cppc_dmi_khz)
> +               cppc_dmi_khz = cppc_get_dmi_khz();
> +
> +       return ((val - min) * cppc_dmi_khz) / (max - min);

How pedantic should the kernel be while dealing with this values?

This 1) can potentially divide by zero (extra care is required to
perform this in Solar System) and 2) can return 0.

Not sure if there is some benefit for firmware to export such
values.

[..]

Best regards,
Alexey

