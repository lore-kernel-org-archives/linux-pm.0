From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v5 05/11] power: bq24257: Add SW-based approach for Power
 Good determination
Date: Wed, 23 Sep 2015 14:34:27 -0500
Message-ID: <20150923193427.GA32687@beast>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-6-git-send-email-dannenberg@ti.com>
 <20150922193719.GD9949@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37501 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbbIWTfA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Sep 2015 15:35:00 -0400
Content-Disposition: inline
In-Reply-To: <20150922193719.GD9949@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 22, 2015 at 09:37:20PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Sep 18, 2015 at 04:39:53PM -0500, Andreas Dannenberg wrote:
> > -	state->power_good = !gpiod_get_value_cansleep(bq->pg);
> > +	if (bq->pg_gpio_disable)
> > +		/*
> > +		 * If we have a chip without a dedicated power-good GPIO or
> > +		 * some other explicit bit that would provide this information
> > +		 * assume the power is good if there is no supply related
> > +		 * fault - and not good otherwise. There is a possibility for
> > +		 * other errors to mask that power in fact is not good but this
> > +		 * is probably the best we can do here.
> > +		 */
> > +		switch (state->fault) {
> > +		case FAULT_INPUT_OVP:
> > +		case FAULT_INPUT_UVLO:
> > +		case FAULT_INPUT_LDO_LOW:
> > +			state->power_good = false;
> > +			break;
> > +		default:
> > +			state->power_good = true;
> > +		}
> > +	else
> > +		state->power_good = !gpiod_get_value_cansleep(bq->pg);
> 
> I guess you can just handle this like an optional gpio
> 
> if(bq->pg)
>     state->power_good = !gpiod_get_value_cansleep(bq->pg);
> else
>     ...

What happens when somebody wants to use GPIO number 0? According to
gpio_is_valid() this is a valid GPIO so technically I should not use a
check against zero to see whether the user has configured a GPIO for
this purpose and wants to use it, no?

Regards,

--
Andreas Dannenberg
Texas Instruments Inc
