From: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Subject: Re: [PATCH 3/4] thermal/powerclamp: add cpu id for skylake h/s
Date: Fri, 31 Jul 2015 17:06:28 -0700
Message-ID: <20150731170628.70e0c073@radivoje-desk2>
References: <1438355265-124508-1-git-send-email-radivoje.jovanovic@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438355265-124508-1-git-send-email-radivoje.jovanovic@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, rui.zhang@intel.com
List-Id: linux-pm@vger.kernel.org

+ Rui

On Fri, 31 Jul 2015 08:07:45 -0700
Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com> wrote:

> From: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> 
> Add support for Intel Skylake H/S
> 
> Signed-off-by: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> ---
>  drivers/thermal/intel_powerclamp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c
> b/drivers/thermal/intel_powerclamp.c index 5820e85..63879a1 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -698,6 +698,7 @@ static const struct x86_cpu_id
> intel_powerclamp_ids[] __initconst = { { X86_VENDOR_INTEL, 6, 0x4f},
>  	{ X86_VENDOR_INTEL, 6, 0x56},
>  	{ X86_VENDOR_INTEL, 6, 0x57},
> +	{ X86_VENDOR_INTEL, 6, 0x5e},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
