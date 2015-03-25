From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: add __init / __exit
 annotations
Date: Wed, 25 Mar 2015 14:40:01 -0700
Message-ID: <20150325144001.2fba5799@ultegra>
References: <1427318184-21843-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44884 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbbCYVkD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Mar 2015 17:40:03 -0400
In-Reply-To: <1427318184-21843-1-git-send-email-minipli@googlemail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mathias Krause <minipli@googlemail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>

On Wed, 25 Mar 2015 22:16:24 +0100
Mathias Krause <minipli@googlemail.com> wrote:

> Mark the module init / exit functions with __init / __exit accodingly.
> This allows making the intel_powerclamp_ids[] array __initconst, too,
> as it only gets referenced from powerclamp_probe(). This is safe as
> file2alias doesn't care about the section, but the symbol name for the
> MODULE_DEVICE_TABLE alias.
> 
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> ---
>  drivers/thermal/intel_powerclamp.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c
> b/drivers/thermal/intel_powerclamp.c index 12623bc02f46..b0f7ced5c3ef
> 100644 --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -667,7 +667,7 @@ static struct thermal_cooling_device_ops
> powerclamp_cooling_ops = { };
>  
>  /* runs on Nehalem and later */
> -static const struct x86_cpu_id intel_powerclamp_ids[] = {
> +static const struct x86_cpu_id intel_powerclamp_ids[] __initconst = {
>  	{ X86_VENDOR_INTEL, 6, 0x1a},
>  	{ X86_VENDOR_INTEL, 6, 0x1c},
>  	{ X86_VENDOR_INTEL, 6, 0x1e},
> @@ -694,7 +694,7 @@ static const struct x86_cpu_id
> intel_powerclamp_ids[] = { };
>  MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
>  
> -static int powerclamp_probe(void)
> +static int __init powerclamp_probe(void)
>  {
>  	if (!x86_match_cpu(intel_powerclamp_ids)) {
>  		pr_err("Intel powerclamp does not run on family %d
> model %d\n", @@ -760,7 +760,7 @@ file_error:
>  	debugfs_remove_recursive(debug_dir);
>  }
>  
> -static int powerclamp_init(void)
> +static int __init powerclamp_init(void)
>  {
>  	int retval;
>  	int bitmap_size;
> @@ -809,7 +809,7 @@ exit_free:
>  }
>  module_init(powerclamp_init);
>  
> -static void powerclamp_exit(void)
> +static void __exit powerclamp_exit(void)
>  {
>  	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
>  	end_power_clamp();
> -- 
> 1.7.10.4
> 




-- 
Jacob Pan
