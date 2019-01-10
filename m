From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Date: Thu, 10 Jan 2019 12:32:08 +0530
Message-ID: <20190110070208.lvnrcd2nld3zthmk@vireshk-i7>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08-01-19, 21:05, Paweł Chmiel wrote:
> This commit enables cpufreq support for all s5pv210 devices.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
> index 951196bdf008..fd4f28aabda6 100644
> --- a/arch/arm/configs/s5pv210_defconfig
> +++ b/arch/arm/configs/s5pv210_defconfig
> @@ -11,6 +11,12 @@ CONFIG_ARCH_S5PV210=y
>  CONFIG_VMSPLIT_2G=y
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> +CONFIG_CPU_FREQ_GOV_USERSPACE=m
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

You don't want to use schedutil ? That is the default governor for
everyone now a days.

-- 
viresh
