From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/4] mfd: da9150: Add support for Fuel-Gauge
Date: Fri, 19 Jun 2015 18:47:41 +0200
Message-ID: <1434732461.2385.162.camel@x220>
References: <cover.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
	 <8d8f583fee9313f261efa96a038874e552995c17.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lb3-smtp-cloud6.xs4all.net ([194.109.24.31]:50729 "EHLO
	lb3-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752130AbbFSQrs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 12:47:48 -0400
In-Reply-To: <8d8f583fee9313f261efa96a038874e552995c17.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

On Thu, 2015-06-18 at 17:06 +0100, Adam Thomson wrote:
> --- /dev/null
> +++ b/include/linux/mfd/da9150/fg.h

> +/*
> + * Function template to provide battery temperature. Should provide
> + * 0.1 degrees C resolution return values.
> + */
> +typedef int (*da9150_read_temp_t)(void *context);
> +
> +/* Register temp callback function */
> +void da9150_fg_register_temp_cb(struct power_supply *psy, da9150_read_temp_t cb,
> +				void *cb_context);

The pedant in me noticed that this function is actually added in 3/4. So
this chunk might be moved to 3/4, if you like to entertain pedantry like
that, that is. (But see my remark on 3/4 too.)


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
