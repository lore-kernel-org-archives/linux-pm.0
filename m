From: Matthew Longnecker <mlongnecker@nvidia.com>
Subject: Re: [PATCHv9 02/20] thermal: introduce device tree parser
Date: Thu, 2 Jan 2014 09:50:06 -0800
Message-ID: <52C5A6CE.5060904@nvidia.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-3-git-send-email-eduardo.valentin@ti.com> <52C4D612.2090808@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3628 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaABRuO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2014 12:50:14 -0500
In-Reply-To: <52C4D612.2090808@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>, Eduardo Valentin <eduardo.valentin@ti.com>, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com
Cc: grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


> I think the platform driver may set governor for the thermal zone,
> so how about to add a property named as "governor",
> and parse it to tzp->governor_name,
> something like:
>                  ret = of_property_read_string(child, "governor", &str);
>                  if (ret == 0)
>                          if (strlen(str) < THERMAL_NAME_LENGTH)
>                                  strcpy(tzp->governor_name, str);
>
> Thanks.
> Wei.

DT is supposed to describe the hardware, right? The governor isn't 
hardware -- it's a software control policy. On the other hand, that 
control policy must be tuned according to the behaviors of the platform 
hardware otherwise the system will be unstable.

Is it appropriate to be naming the governor in DT? If so, is it equally 
appropriate to describe any governor-specific parameters in DT (even 
though they are pure software constructs)?

-Matt
