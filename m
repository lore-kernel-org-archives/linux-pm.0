From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/6] ARM: cpuidle: Add a cpuidle ops structure to be used
 for DT
Date: Fri, 20 Mar 2015 17:23:54 +0000
Message-ID: <20150320172353.GJ3421@e104818-lin.cambridge.arm.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40760 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbbCTRX6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Mar 2015 13:23:58 -0400
Content-Disposition: inline
In-Reply-To: <1425385777-14766-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lina.iyer@linaro.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 03, 2015 at 01:29:33PM +0100, Daniel Lezcano wrote:
> diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
> index 0710654..1bee287 100644
> --- a/arch/arm64/include/asm/cpuidle.h
> +++ b/arch/arm64/include/asm/cpuidle.h
> @@ -15,5 +15,8 @@ static inline int cpu_suspend(unsigned long arg)
>  	return -EOPNOTSUPP;
>  }
>  #endif
> -
> +static inline int arm_cpuidle_suspend(int index)
> +{
> +	return cpu_suspend(index);
> +}
>  #endif

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
