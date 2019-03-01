From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/7] MAINTAINERS: Update files for PSCI
Date: Fri, 1 Mar 2019 17:04:15 +0000
Message-ID: <20190301170415.GP15517@lakrids.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228135919.3747-3-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 28, 2019 at 02:59:14PM +0100, Ulf Hansson wrote:
> The files for the PSCI firmware driver were moved to a sub-directory, let's
> update MAINTAINERS to reflect that.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

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
> -- 
> 2.17.1
> 
