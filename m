From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0122/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 09:57:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1608020955530.1940-100000@iolanthe.rowland.org>
References: <20160802104220.21883-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160802104220.21883-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, jslaby@suse.cz, peter@korsgaard.com, lee.jones@linaro.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2 Aug 2016, Baole Ni wrote:

> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.

This reasoning is highly questionable.  How does using a macro improve 
either robustness or readability?

> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/cpufreq/powernow-k7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index 9f013ed..2c7d73a 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -683,7 +683,7 @@ static void __exit powernow_exit(void)
>  	cpufreq_unregister_driver(&powernow_driver);
>  }
>  
> -module_param(acpi_force,  int, 0444);
> +module_param(acpi_force,  int, S_IRUSR | S_IRGRP | S_IROTH);

This is an excellent example.  To me, 0444 is _much_ more readable and 
understandable than S_IRUSR | S_IRGRP | S_IROTH.

Alan Stern
