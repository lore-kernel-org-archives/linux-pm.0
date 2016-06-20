From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 0/3] firmware: scpi: add device power domain support
Date: Mon, 20 Jun 2016 10:56:15 -0700
Message-ID: <m24m8nbv7k.fsf@baylibre.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34006 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbcFTR4X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 13:56:23 -0400
Received: by mail-pf0-f176.google.com with SMTP id h14so41085539pfe.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 10:56:17 -0700 (PDT)
In-Reply-To: <1466073481-697-1-git-send-email-sudeep.holla@arm.com> (Sudeep
	Holla's message of "Thu, 16 Jun 2016 11:37:58 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>

Sudeep Holla <sudeep.holla@arm.com> writes:

> This series add support for SCPI based device device power state
> management using genpd.
>
> Regards,
> Sudeep
>
> v1[1]->v2:
> 	- Fixed the endianness handling in scpi_device_get_power_state
> 	  as spotted by Tixy
> 	- Renamed scpi_pd.c to scpi_pm_domain.c as suggested by Ulf
> 	- Added Mark's ack on DT binding
>
> [1] https://marc.info/?l=linux-kernel&m=146522850003483&w=2
>
> Sudeep Holla (3):
>   firmware: arm_scpi: add support for device power state management
>   Documentation: add DT bindings for ARM SCPI power domains
>   firmware: scpi: add device power domain support using genpd

Other than the couple nits on specific patches,

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

And just a[nother] reminder to be sure to keep things that are Juno
specific well described since we know other vendors will be (and are
being) "creative" in their implementations of SCPI.

Kevin
