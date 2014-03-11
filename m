From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: enable ARM drivers on arm64
Date: Tue, 11 Mar 2014 12:27:01 +0000
Message-ID: <531F0115.4000109@arm.com>
References: <1393208877-15797-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48961 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbaCKM1F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Mar 2014 08:27:05 -0400
In-Reply-To: <1393208877-15797-1-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Mark Brown <broonie@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rob.herring@linaro.org" <rob.herring@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Mark,

Sorry for late response, looks like Rafael has pulled this change, but ...

On 24/02/14 02:27, Mark Brown wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Enable cpufreq and power kconfig menus on arm64 along with arm cpufreq
> drivers. The power menu is needed for OPP support. At least on Calxeda
> systems, the same cpufreq driver is used for arm and arm64 based
> systems.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>   arch/arm64/Kconfig      | 8 ++++++++
>   drivers/cpufreq/Kconfig | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fea7b47..939e95a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -327,6 +327,14 @@ source "drivers/cpuidle/Kconfig"
>
>   endmenu
>
> +menu "Power management options"
> +
> +source "kernel/power/Kconfig"
> +
> +source "drivers/cpufreq/Kconfig"
> +
> +endmenu
> +

Is this patch based on recent kernels ? If so, either it should have caused
conflicts or silently duplicated the entries. "Power management options" are
already present.

Also to be more consistent it with menu options, I would prefer this to be
placed under "CPU Power Management" like CPUIdle.

Regards,
Sudeep

