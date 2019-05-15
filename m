From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
Date: Wed, 15 May 2019 10:46:09 +0200
Message-ID: <2f598ea3-752d-0f1d-fd33-f07cda3b7bd0@linaro.org>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-2-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515082318.7993-2-quentin.perret@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com
Cc: dietmar.eggemann@arm.com, ionela.voinescu@arm.com, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 15/05/2019 10:23, Quentin Perret wrote:
> The recently introduced Energy Model (EM) framework manages power cost
> tables for the CPUs of the system. Its only user right now is the
> scheduler, in the context of Energy Aware Scheduling (EAS).
> 
> However, the EM framework also offers a generic infrastructure that
> could replace subsystem-specific implementations of the same concepts,
> as this is the case in the thermal framework.
> 
> So, in order to prepare the migration of the thermal subsystem to use
> the EM framework, enable it in the default arm64 defconfig, which is the
> most commonly used architecture for IPA. This will also compile-in all
> of the EAS code, although it won't be enabled by default -- EAS requires
> to use the 'schedutil' CPUFreq governor while arm64 defaults to
> 'performance'.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2d9c39033c1a..4881a752ab3f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -97,6 +97,7 @@ CONFIG_XEN=y
>  CONFIG_COMPAT=y
>  CONFIG_HIBERNATION=y
>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> +CONFIG_ENERGY_MODEL=y
>  CONFIG_ARM_CPUIDLE=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_STAT=y
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
