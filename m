From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/3] firmware: scpi: add device power domain support using
 genpd
Date: Fri, 10 Jun 2016 17:19:27 +0100
Message-ID: <575AE88F.5020901@arm.com>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
 <1465228439-13457-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39506 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbcFJQTb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jun 2016 12:19:31 -0400
In-Reply-To: <1465228439-13457-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, linux-pm@vger.kernel.org

Hi,

On 06/06/16 16:53, Sudeep Holla wrote:
> This patch hooks up the support for device power domain provided by
> SCPI using the Linux generic power domain infrastructure.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/firmware/Kconfig   |   8 +++
>   drivers/firmware/Makefile  |   1 +
>   drivers/firmware/scpi_pd.c | 152 +++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 161 insertions(+)
>   create mode 100644 drivers/firmware/scpi_pd.c
>
> Hi,
>
> Since most of the power controller drivers are place in drivers/soc/<soc_name>,
> I am not sure where to put this SCPI power domain code as it can be used
> on multiple SoC. I have placed it in drivers/firmware temporarily for
> review. Please suggest the most apt place to put this driver.
>

Any suggestions ? Or drivers/firmware is OK for now ?

-- 
Regards,
Sudeep
