From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH 2/2] power_supply: Add support for TI BQ25890 charger chip
Date: Wed, 24 Jun 2015 10:32:54 +0300
Message-ID: <20150624073254.GD10146@lpalcu-linux>
References: <1431698778-29462-1-git-send-email-laurentiu.palcu@intel.com>
 <1431698778-29462-3-git-send-email-laurentiu.palcu@intel.com>
 <20150502145933.GA1331@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31808 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbbFXHcu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Jun 2015 03:32:50 -0400
Content-Disposition: inline
In-Reply-To: <20150502145933.GA1331@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sat, May 02, 2015 at 04:59:34PM +0200, Pavel Machek wrote:
> 
> Should this link....
> 
> > More details about the chip can be found here:
> > http://www.ti.com/product/bq25890
> 
> > @@ -0,0 +1,998 @@
> > +/*
> > + * TI BQ25890 charger driver
> > + *
> > + * Copyright (C) 2015 Intel Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> 
> > + *
> > + */
> 
> Go here?
Where exactly? Was 'here' supposed to be a hyperlink that, for some
reason, is missing? Anyway, if you're asking why the link I provided
doesn't go directly to the documentation, but to the product page,
here's the answer: the documentation for this chip was not released
publicly, yet, by TI. I was told they intend to do so in the near
future. So, for the time being, this link will do. I'll update it when
they'll release the docs.

laurentiu
