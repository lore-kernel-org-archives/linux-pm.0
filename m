From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/7] MAINTAINERS: Update files for PSCI
Date: Thu, 28 Feb 2019 15:35:04 +0100
Message-ID: <cc5bd1b9-1aa1-496a-9e16-3e6a8e321067@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228135919.3747-3-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28/02/2019 14:59, Ulf Hansson wrote:
> The files for the PSCI firmware driver were moved to a sub-directory, let's
> update MAINTAINERS to reflect that.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32b76cb95f57..ff998605b773 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12182,7 +12182,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
>  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
> -F:	drivers/firmware/psci*.c
> +F:	drivers/firmware/psci/
>  F:	include/linux/psci.h
>  F:	include/uapi/linux/psci.h
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
