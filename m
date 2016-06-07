From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH 3/3] firmware: scpi: add device power domain support
 using genpd
Date: Tue, 07 Jun 2016 14:18:57 +0100
Message-ID: <1465305537.2833.28.camel@linaro.org>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
	 <1465228439-13457-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465228439-13457-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-06-06 at 16:53 +0100, Sudeep Holla wrote:
> This patch hooks up the support for device power domain provided by
> SCPI using the Linux generic power domain infrastructure.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/Kconfig   |   8 +++
>  drivers/firmware/Makefile  |   1 +
>  drivers/firmware/scpi_pd.c | 152 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 161 insertions(+)
>  create mode 100644 drivers/firmware/scpi_pd.c
> 
> Hi,
> 
> Since most of the power controller drivers are place in drivers/soc/<soc_name>,
> I am not sure where to put this SCPI power domain code as it can be used
> on multiple SoC. I have placed it in drivers/firmware temporarily for
> review. Please suggest the most apt place to put this driver.
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 41abdc54815e..80c963c60f13 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -27,6 +27,14 @@ config ARM_SCPI_PROTOCOL
>  	  This protocol library provides interface for all the client drivers
>  	  making use of the features offered by the SCP.
> 
> +config ARM_SCPI_POWER_DOMAIN
> +	tristate "SCPI power domain driver"
> +	depends on (ARM_SCPI_PROTOCOL && PM) || COMPILE_TEST
> +	select PM_GENERIC_DOMAINS_OF

That select doesn't work for me and gives:

warning: (ARM_SCPI_POWER_DOMAIN) selects PM_GENERIC_DOMAINS_OF which has unmet direct dependencies (PM_GENERIC_DOMAINS && OF)

Followed by link errors due to missing symbols.

I think you need to select PM_GENERIC_DOMAINS as well. Or perhaps just
instead of, as PM_GENERIC_DOMAINS_OF defaults 'y' and isn't user
selectable. From kernel/power/Kconfig ...

config PM_GENERIC_DOMAINS_OF
	def_bool y
	depends on PM_GENERIC_DOMAINS && OF

[...]

-- 
Tixy
