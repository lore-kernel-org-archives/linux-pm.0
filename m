From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH v3 5/6] Documentation: kernel_parameters for Intel P
 state driver
Date: Tue, 13 Oct 2015 13:39:32 -0700
Message-ID: <20151013133932.7d6881e2@kcaccard-desk.amr.corp.intel.com>
References: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1443567248-27134-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32370 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbbJMUje (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Oct 2015 16:39:34 -0400
In-Reply-To: <1443567248-27134-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Tue, 29 Sep 2015 15:54:07 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Added new option "no_acpi" for not using ACPI processor performance
> control objects in Intel P state driver.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Kristen Carlson Accardi <kristen@linux.intel.com>

> ---
>  Documentation/kernel-parameters.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 22a4b68..9b75e2a 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1546,6 +1546,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  		hwp_only
>  			Only load intel_pstate on systems which support
>  			hardware P state control (HWP) if available.
> +		no_acpi
> +			Don't use ACPI processor performance control objects
> +			_PSS and _PPC specified limits.
>  
>  	intremap=	[X86-64, Intel-IOMMU]
>  			on	enable Interrupt Remapping (default)

