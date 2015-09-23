From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v5 05/11] power: bq24257: Add SW-based approach for Power
 Good determination
Date: Wed, 23 Sep 2015 15:02:56 -0500
Message-ID: <20150923200255.GC32687@beast>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-6-git-send-email-dannenberg@ti.com>
 <20150922193719.GD9949@earth>
 <20150923193427.GA32687@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45654 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbbIWUDp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Sep 2015 16:03:45 -0400
Content-Disposition: inline
In-Reply-To: <20150923193427.GA32687@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 23, 2015 at 02:34:27PM -0500, Andreas Dannenberg wrote:
> On Tue, Sep 22, 2015 at 09:37:20PM +0200, Sebastian Reichel wrote:
> > 
> > I guess you can just handle this like an optional gpio
> > 
> > if(bq->pg)
> >     state->power_good = !gpiod_get_value_cansleep(bq->pg);
> > else
> >     ...
> 
> What happens when somebody wants to use GPIO number 0? According to
> gpio_is_valid() this is a valid GPIO so technically I should not use a
> check against zero to see whether the user has configured a GPIO for
> this purpose and wants to use it, no?

Ok never mind I figured it out. bq->pg is of type gpio_desc and not the
actual GPIO number. Together with your suggestion of how to use gpiod_*
in combination with platform data this will be a nice simplification!

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

