From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] powercap/rapl: add support for ValleyView Soc
Date: Sun, 22 Dec 2013 02:06:33 +0100
Message-ID: <1553570.ISCzPqBYzN@vostro.rjw.lan>
References: <1386801567-26661-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56867 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755818Ab3LVAxJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Dec 2013 19:53:09 -0500
In-Reply-To: <1386801567-26661-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Gavin Hindman <gavin.hindman@intel.com>, "Triplett, Josh" <josh.triplett@intel.com>

On Wednesday, December 11, 2013 02:39:27 PM Jacob Pan wrote:
> This patch adds support for RAPL on Intel ValleyView based SoC
> platforms, such as Baytrail.
> 
> Besides adding CPU ID, special energy unit encoding is handled
> for ValleyView.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Queued up for 3.14, thanks!

> ---
>  drivers/powercap/intel_rapl.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 2a786c5..3c67683 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -833,6 +833,11 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
>  	return 0;
>  }
>  
> +static const struct x86_cpu_id energy_unit_quirk_ids[] = {
> +	{ X86_VENDOR_INTEL, 6, 0x37},/* VLV */
> +	{}
> +};
> +
>  static int rapl_check_unit(struct rapl_package *rp, int cpu)
>  {
>  	u64 msr_val;
> @@ -853,8 +858,11 @@ static int rapl_check_unit(struct rapl_package *rp, int cpu)
>  	 * time unit: 1/time_unit_divisor Seconds
>  	 */
>  	value = (msr_val & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
> -	rp->energy_unit_divisor = 1 << value;
> -
> +	/* some CPUs have different way to calculate energy unit */
> +	if (x86_match_cpu(energy_unit_quirk_ids))
> +		rp->energy_unit_divisor = 1000000 / (1 << value);
> +	else
> +		rp->energy_unit_divisor = 1 << value;
>  
>  	value = (msr_val & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
>  	rp->power_unit_divisor = 1 << value;
> @@ -941,6 +949,7 @@ static void package_power_limit_irq_restore(int package_id)
>  static const struct x86_cpu_id rapl_ids[] = {
>  	{ X86_VENDOR_INTEL, 6, 0x2a},/* SNB */
>  	{ X86_VENDOR_INTEL, 6, 0x2d},/* SNB EP */
> +	{ X86_VENDOR_INTEL, 6, 0x37},/* VLV */
>  	{ X86_VENDOR_INTEL, 6, 0x3a},/* IVB */
>  	{ X86_VENDOR_INTEL, 6, 0x45},/* HSW */
>  	/* TODO: Add more CPU IDs after testing */
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
