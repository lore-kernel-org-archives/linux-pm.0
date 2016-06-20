From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 3/3] firmware: scpi: add device power domain support using genpd
Date: Mon, 20 Jun 2016 10:53:33 -0700
Message-ID: <m2eg7rbvc2.fsf@baylibre.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
	<1466073481-697-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35373 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbcFTSAT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 14:00:19 -0400
Received: by mail-pa0-f42.google.com with SMTP id hl6so52895868pac.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 11:00:18 -0700 (PDT)
In-Reply-To: <1466073481-697-4-git-send-email-sudeep.holla@arm.com> (Sudeep
	Holla's message of "Thu, 16 Jun 2016 11:38:01 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Sudeep Holla <sudeep.holla@arm.com> writes:

> This patch hooks up the support for device power domain provided by
> SCPI using the Linux generic power domain infrastructure.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

[...]

> +static int scpi_pd_power(struct scpi_pm_domain *pd, bool power_on)
> +{
> +	int ret;
> +	enum scpi_power_domain_state state;
> +
> +	if (power_on)
> +		state = SCPI_PD_STATE_ON;
> +	else
> +		state = SCPI_PD_STATE_OFF;
> +
> +	ret = pd->ops->device_set_power_state(pd->domain, state);

There should probably be some sanity checks here that these function
pointers are non-NULL.

> +	if (ret)
> +		return ret;
> +
> +	return !(state == pd->ops->device_get_power_state(pd->domain));
> +}

Kevin
