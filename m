From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] power_supply: Add support for TI BQ25890 charger chip
Date: Wed, 24 Jun 2015 12:20:50 +0300
Message-ID: <20150624092050.GE10146@lpalcu-linux>
References: <1431698778-29462-1-git-send-email-laurentiu.palcu@intel.com>
 <1431698778-29462-3-git-send-email-laurentiu.palcu@intel.com>
 <20150502145933.GA1331@xo-6d-61-c0.localdomain>
 <20150624073254.GD10146@lpalcu-linux>
 <20150624083058.GA17732@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150624083058.GA17732@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 24, 2015 at 10:30:58AM +0200, Pavel Machek wrote:
> On Wed 2015-06-24 10:32:54, Laurentiu Palcu wrote:
> > On Sat, May 02, 2015 at 04:59:34PM +0200, Pavel Machek wrote:
> > > 
> > > Should this link....
> > > 
> > > > More details about the chip can be found here:
> > > > http://www.ti.com/product/bq25890
> > > 
> > > > @@ -0,0 +1,998 @@
> > > > +/*
> > > > + * TI BQ25890 charger driver
> > > > + *
> > > > + * Copyright (C) 2015 Intel Corporation
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License as published by
> > > > + * the Free Software Foundation; either version 2 of the License, or
> > > > + * (at your option) any later version.
> > > > + *
> > > > + * This program is distributed in the hope that it will be useful,
> > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > + * GNU General Public License for more details.
> > > 
> > > > + *
> > > > + */
> > > 
> > > Go here?
> > Where exactly? Was 'here' supposed to be a hyperlink that, for some
> > reason, is missing? Anyway, if you're asking why the link I provided
> 
> 
> Put the link to the comment at top of the driver, not into the
> changelog.
I see now what you meant. :) I'll do that once the documentation is
public.

laurentiu

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
