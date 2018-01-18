From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: AMD: Ignore the check for ProcFeedback in ST/CZ
Date: Thu, 18 Jan 2018 16:12:51 +0530
Message-ID: <20180118104251.GJ3012@vireshk-i7>
References: <1516270890-1224-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40103 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754617AbeARKmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jan 2018 05:42:54 -0500
Received: by mail-pg0-f65.google.com with SMTP id g16so7166196pgn.7
        for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2018 02:42:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1516270890-1224-1-git-send-email-akshu.agrawal@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, satyajit.sahu@amd.com

On 18-01-18, 15:51, Akshu Agrawal wrote:
> In ST/CZ CPUID 8000_0007_EDX[11, ProcFeedbackInterface] is 0,
> but the mechanism is still available and can be used.
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  drivers/cpufreq/amd_freq_sensitivity.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
> index 042023bbbf62..be926d9a66e5 100644
> --- a/drivers/cpufreq/amd_freq_sensitivity.c
> +++ b/drivers/cpufreq/amd_freq_sensitivity.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
> +#include <linux/pci.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/init.h>
>  #include <linux/mod_devicetable.h>
> @@ -109,12 +110,18 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
>  static int __init amd_freq_sensitivity_init(void)
>  {
>  	u64 val;
> +	struct pci_dev *pcidev;
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>  		return -ENODEV;
>  
> -	if (!static_cpu_has(X86_FEATURE_PROC_FEEDBACK))
> -		return -ENODEV;
> +	pcidev = pci_get_device(PCI_VENDOR_ID_AMD,
> +			PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
> +
> +	if (!pcidev) {
> +		if (!static_cpu_has(X86_FEATURE_PROC_FEEDBACK))
> +			return -ENODEV;
> +	}
>  
>  	if (rdmsrl_safe(MSR_AMD64_FREQ_SENSITIVITY_ACTUAL, &val))
>  		return -ENODEV;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
