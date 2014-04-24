From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: CPUFREQ: Try to load pcc driver on HP ProLiants automatically
Date: Thu, 24 Apr 2014 09:34:40 +0530
Message-ID: <CAKohpokrtVQP80Go+Y3KX45t6P5Vj0tpDu-7f=84puE+6SfwZg@mail.gmail.com>
References: <7669060.dKLoxkfpfu@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <7669060.dKLoxkfpfu@skinner>
Sender: cpufreq-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, thomas.mingarelli@hp.com
List-Id: linux-pm@vger.kernel.org

As Rafael picks patches from patchworks, you may need to resend it to
linux-pm, for now I have cc'id it.

On 23 April 2014 19:19, Thomas Renninger <trenn@suse.de> wrote:
> HP ProLiants are sold with CPU frequency controlled by BIOS by default.
> The pcc-cpufreq driver still exports some frequency info to userspace and
> should be tried to get loaded on these platforms.
>
> Successfully tested on a recent ProLiant machine:
>   - without this patch no pcc-cpufreq driver loaded, no frequency info
>   - with this patch the driver got autoloaded
>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
>
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 728a2d8..ff1ebd0 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -603,6 +603,8 @@ static void __exit pcc_cpufreq_exit(void)
>         free_percpu(pcc_cpu_info);
>  }
>
> +MODULE_ALIAS("dmi:*:svnHP:pnProLiant*:*");
> +
>  MODULE_AUTHOR("Matthew Garrett, Naga Chumbalkar");
>  MODULE_VERSION(PCC_VERSION);
>  MODULE_DESCRIPTION("Processor Clocking Control interface driver");
>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
