From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [RFC PATCH 2/7] typec: tcpm: Add ADO header for Alert message
 handling
Date: Thu, 2 Nov 2017 17:34:22 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1AB290@SW-EX-MBX01.diasemi.com>
References: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
 <fed055cbecd4666d5a49a19c6a48958720045b40.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
 <20171101172007.GA14585@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1AACB5@SW-EX-MBX01.diasemi.com>
 <20171102164915.GA18566@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102164915.GA18566@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On 02 November 2017 16:49, Greg Kroah-Hartman wrote:

> On Thu, Nov 02, 2017 at 11:40:12AM +0000, Adam Thomson wrote:
> > On 01 November 2017 17:20, Greg Kroah-Hartman wrote:
> >
> > > On Wed, Nov 01, 2017 at 05:03:10PM +0000, Adam Thomson wrote:
> > > > This commit adds a header providing definitions for handling Alert
> > > > messages. Currently the header only focuses on handling incoming
> > > > alerts.
> > > >
> > > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > > ---
> > > >  include/linux/usb/pd_ado.h | 49
> > > ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 49 insertions(+)
> > > >  create mode 100644 include/linux/usb/pd_ado.h
> > > >
> > > > diff --git a/include/linux/usb/pd_ado.h b/include/linux/usb/pd_ado.h
> > > > new file mode 100644
> > > > index 0000000..edcbcfa
> > > > --- /dev/null
> > > > +++ b/include/linux/usb/pd_ado.h
> > > > @@ -0,0 +1,49 @@
> > > > +/*
> > > > + * Copyright (c) 2017 Dialog Semiconductor
> > > > + *
> > > > + * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License as published by
> > > > + * the Free Software Foundation; either version 2 of the License, or
> > > > + * (at your option) any later version.
> > >
> > > I have to ask, do you _really_ mean "any later version"?
> >
> > Many thanks for the prompt comments.
> >
> > So this is the same copyright header applied for the other PD related code
> > (bit of a copy and paste to follow existing tcpm practice), and have tended to
> > use this header for other driver development as well. Within the context of the
> > Linux kernel I believe this should be fine and will resolve to GPLv2, and should
> > someone use the code elsewhere then they can choose a later GPL license, not
> > that I suspect many would. Do you see any problems here as am happy to be
> > corrected? :)
>
> Please consult your lawyers as to what license you should use for new
> kernel code.  Never just blindly copy/paste without knowing what you are
> supposed to be doing :)

Yes, our legal department are aware of the use of this header, from previous
driver submissions, and have no problems. I certainly wouldn't have applied this
otherwise, but completely understand why you raised this :)

> > > > + *
> > > > + * This program is distributed in the hope that it will be useful,
> > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > + * GNU General Public License for more details.
> > > > + */
> > > > +
> > > > +#ifndef __LINUX_USB_PD_ADO_H
> > > > +#define __LINUX_USB_PD_ADO_H
> > > > +
> > > > +/* ADO : Alert Data Object */
> > > > +#define ADO_TYPE_SHIFT			24
> > > > +#define ADO_TYPE_MASK			0xff
> > > > +#define ADO_FIXED_BATT_SHIFT		20
> > > > +#define ADO_FIXED_BATT_MASK		0xf
> > > > +#define ADO_HOT_SWAP_BATT_SHIFT		16
> > > > +#define ADO_HOT_SWAP_BATT_MASK		0xf
> > >
> > > USB_ prefixes perhaps?
> >
> > Again here I was following the existing TCPM approach, but if it's a problem
> > then I can update this.
>
> What does TCPM use here?  I missed those defines...

For example, include/linux/usb/pd_bdo.h uses defines such as:

#define BDO_MODE_TRANSMIT	(1 << 28)

and include/linux/usb/pd.h has defines such as:

#define PDO_FIXED_DUAL_ROLE	BIT(29)

>
> > > > +
> > > > +#define ADO_TYPE_BATT_STATUS_CHANGE	BIT(1)
> > > > +#define ADO_TYPE_OCP			BIT(2)
> > > > +#define ADO_TYPE_OTP			BIT(3)
> > > > +#define ADO_TYPE_OP_COND_CHANGE		BIT(4)
> > > > +#define ADO_TYPE_SRC_INPUT_CHANGE	BIT(5)
> > > > +#define ADO_TYPE_OVP			BIT(6)
> > > > +
> > > > +static inline unsigned int ado_type(u32 ado)
> > > > +{
> > > > +	return (ado >> ADO_TYPE_SHIFT) & ADO_TYPE_MASK;
> > > > +}
> > >
> > > usb_ prefix for this and the other inline functions as well?
> >
> > Same comment here.
>
> But it would make more sense, right?

I'm happy with that. Actually I'd probably opt for 'usb_pd_' if I was going that
route as it's PD specific information. Would that be reasonable?
