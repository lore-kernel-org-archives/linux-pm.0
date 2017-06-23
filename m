From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] cpupower: Add support for new AMD family 0x17
Date: Fri, 23 Jun 2017 16:04:05 +0200
Message-ID: <1905899.xLaMjPbpYo@skinner>
References: <20170620065708.21434.80154.stgit@Diesel2540.amd.com> <20170620070742.21434.99857.stgit@Diesel2540.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36881 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753447AbdFWOEM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Jun 2017 10:04:12 -0400
In-Reply-To: <20170620070742.21434.99857.stgit@Diesel2540.amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tuesday, June 20, 2017 02:08:42 AM Sherry Hurwitz wrote:
> Add support for new AMD family 0x17
> - Add bit field changes to the msr_pstate structure
> - Add the new formula for the  calculation of cof
> - Changed method to access to CpbDis
> 
> Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>

I have to trust you with the HW bits and get_did() func fiddling
with them.

Rest looks like properly embedded code, no risk for other families.

Thanks!

Acked-by: Thomas Renninger <trenn@suse.com>


> ---
>  tools/power/cpupower/utils/helpers/amd.c     |   31 
+++++++++++++++++++-------
>  tools/power/cpupower/utils/helpers/helpers.h |    2 ++
>  tools/power/cpupower/utils/helpers/misc.c    |   22 ++++++++++++++++--
>  3 files changed, 44 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c 
b/tools/power/cpupower/utils/helpers/amd.c
> index 6437ef3..5fd5c5b 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -26,6 +26,15 @@
>  		unsigned res3:21;
>  		unsigned en:1;
>  	} bits;
> +	struct {
> +		unsigned fid:8;
> +		unsigned did:6;
> +		unsigned vid:8;
> +		unsigned iddval:8;
> +		unsigned idddiv:2;
> +		unsigned res1:30;
> +		unsigned en:1;
> +	} fam17h_bits;
>  	unsigned long long val;
>  };
>  
> @@ -35,6 +44,8 @@ static int get_did(int family, union msr_pstate pstate)
>  
>  	if (family == 0x12)
>  		t = pstate.val & 0xf;
> +	else if (family == 0x17)
> +		t = pstate.fam17h_bits.did;
>  	else
>  		t = pstate.bits.did;
>  
> @@ -44,16 +55,20 @@ static int get_did(int family, union msr_pstate pstate)
>  static int get_cof(int family, union msr_pstate pstate)
>  {
>  	int t;
> -	int fid, did;
> +	int fid, did, cof;
>  
>  	did = get_did(family, pstate);
> -
> -	t = 0x10;
> -	fid = pstate.bits.fid;
> -	if (family == 0x11)
> -		t = 0x8;
> -
> -	return (100 * (fid + t)) >> did;
> +	if (family == 0x17) {
> +		fid = pstate.fam17h_bits.fid;
> +		cof = 200 * fid / did;
> +	} else {
> +		t = 0x10;
> +		fid = pstate.bits.fid;
> +		if (family == 0x11)
> +			t = 0x8;
> +		cof = (100 * (fid + t)) >> did;
> +	}
> +	return cof;
>  }
>  
>  /* Needs:
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h 
b/tools/power/cpupower/utils/helpers/helpers.h
> index afb66f8..799a18b 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -70,6 +70,8 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, 
X86_VENDOR_INTEL,
>  #define CPUPOWER_CAP_IS_SNB		0x00000020
>  #define CPUPOWER_CAP_INTEL_IDA		0x00000040
>  
> +#define CPUPOWER_AMD_CPBDIS		0x02000000
> +
>  #define MAX_HW_PSTATES 10
>  
>  struct cpupower_cpu_info {
> diff --git a/tools/power/cpupower/utils/helpers/misc.c 
b/tools/power/cpupower/utils/helpers/misc.c
> index 6952a6a..601d719 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -2,11 +2,14 @@
>  
>  #include "helpers/helpers.h"
>  
> +#define MSR_AMD_HWCR	0xc0010015
> +
>  int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>  			int *states)
>  {
>  	struct cpupower_cpu_info cpu_info;
>  	int ret;
> +	unsigned long long val;
>  
>  	*support = *active = *states = 0;
>  
> @@ -16,9 +19,22 @@ int cpufreq_has_boost_support(unsigned int cpu, int 
*support, int *active,
>  
>  	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CBP) {
>  		*support = 1;
> -		ret = amd_pci_get_num_boost_states(active, states);
> -		if (ret)
> -			return ret;
> +
> +		/* AMD Family 0x17 does not utilize PCI D18F4 like prior
> +		 * families and has no fixed discrete boost states but
> +		 * has Hardware determined variable increments instead.
> +		 */
> +
> +		if (cpu_info.family == 0x17) {
> +			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
> +				if (!(val & CPUPOWER_AMD_CPBDIS))
> +					*active = 1;
> +			}
> +		} else {
> +			ret = amd_pci_get_num_boost_states(active, states);
> +			if (ret)
> +				return ret;
> +		}
>  	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
>  		*support = *active = 1;
>  	return 0;
> 

-- 
Thomas Renninger
Software Developer

+++++++
3 important things to remember:

OPENSOURCE is going to rule the world
LINUX was, is and will stay the most important OpenSource Software stack
SUSE is a steady part of Linux ... from the very beginnings and forever.
+++++++

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Dilip Upmanyu, Graham 
Norton, HRB 21284 (AG Nürnberg) 
