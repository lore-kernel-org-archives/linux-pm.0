From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/3] x86/cpuid: Make cpuinfo_x86.x86_model_id global
Date: Tue, 27 Nov 2018 17:55:49 +0200
Message-ID: <CAHp75Vca7Vn5To5GWb_EtZ1ZKyzWnL2Wv3M3wrKVX=X8qmxUfw@mail.gmail.com>
References: <20181114212843.16954-1-bp@alien8.de> <20181114212843.16954-4-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114212843.16954-4-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 14, 2018 at 11:29 PM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> ... and __ro_after_init. Since the brand string is being read earlier
> now, in early_identify_cpu(), get_model_name() needs to read out the
> extended CPUID level for the brand string. This is temporary only, until
> the full CPUID read out has been added.

>  drivers/platform/x86/intel_ips.c     |  6 +++---
>  15 files changed, 35 insertions(+), 35 deletions(-)



> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index 225638a1b09e..4309f198cbad 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1367,11 +1367,11 @@ static struct ips_mcp_limits *ips_detect_cpu(struct ips_driver *ips)
>         else
>                 ips->turbo_toggle_allowed = false;
>
> -       if (strstr(boot_cpu_data.x86_model_id, "CPU       M"))
> +       if (strstr(x86_model_id, "CPU       M"))
>                 limits = &ips_sv_limits;
> -       else if (strstr(boot_cpu_data.x86_model_id, "CPU       L"))
> +       else if (strstr(x86_model_id, "CPU       L"))
>                 limits = &ips_lv_limits;
> -       else if (strstr(boot_cpu_data.x86_model_id, "CPU       U"))
> +       else if (strstr(x86_model_id, "CPU       U"))
>                 limits = &ips_ulv_limits;
>         else {
>                 dev_info(ips->dev, "No CPUID match found.\n");

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for PDx86 bits

--
With Best Regards,
Andy Shevchenko
