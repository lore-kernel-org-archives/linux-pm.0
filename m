From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] powercap/rapl: add support for cpu model 0x3f
Date: Tue, 02 Sep 2014 01:49:15 +0200
Message-ID: <2447035.ZSkeOUhJMy@vostro.rjw.lan>
References: <20140814142608.5A9A38004B@prod-mail-relay07.akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59179 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752844AbaIAX35 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Sep 2014 19:29:57 -0400
In-Reply-To: <20140814142608.5A9A38004B@prod-mail-relay07.akamai.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Baron <jbaron@akamai.com>
Cc: jacob.jun.pan@linux.intel.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, durgadoss.r@intel.com, srinivas.pandruvada@linux.intel.com

On Thursday, August 14, 2014 02:26:08 PM Jason Baron wrote:
> I've confirmed that monitoring the package power usage as well as setting power
> limits appear to be working as expected. Supports the package and dram domains.
> 
> Tested aginst cpu:
> 
> Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>

Has this been ACKed by Jacob?

> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index b1cda6f..a362dcc 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -953,6 +953,7 @@ static const struct x86_cpu_id rapl_ids[] = {
>  	{ X86_VENDOR_INTEL, 6, 0x3a},/* Ivy Bridge */
>  	{ X86_VENDOR_INTEL, 6, 0x3c},/* Haswell */
>  	{ X86_VENDOR_INTEL, 6, 0x3d},/* Broadwell */
> +	{ X86_VENDOR_INTEL, 6, 0x3f},/* Haswell */
>  	{ X86_VENDOR_INTEL, 6, 0x45},/* Haswell ULT */
>  	/* TODO: Add more CPU IDs after testing */
>  	{}
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
