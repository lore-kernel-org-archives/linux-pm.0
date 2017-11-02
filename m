From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [RFC PATCH 3/7] typec: tcpm: Add SDB header for Status message
 handling
Date: Thu, 2 Nov 2017 11:41:35 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1AACCB@SW-EX-MBX01.diasemi.com>
References: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
 <4199ae7655886b8ba7a436d3a9938220d2e14f0b.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
 <20171101172042.GB14585@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171101172042.GB14585@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On 01 November 2017 17:21, Greg Kroah-Hartman wrote:

> On Wed, Nov 01, 2017 at 05:03:11PM +0000, Adam Thomson wrote:
> > This commit adds a header providing definitions for handling
> > Status messages. Currently the header only focuses on handling
> > incoming Status messages.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> >  include/linux/usb/pd_ext_sdb.h | 40
> ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 include/linux/usb/pd_ext_sdb.h
> >
> > diff --git a/include/linux/usb/pd_ext_sdb.h b/include/linux/usb/pd_ext_sdb.h
> > new file mode 100644
> > index 0000000..6d6da31
> > --- /dev/null
> > +++ b/include/linux/usb/pd_ext_sdb.h
> > @@ -0,0 +1,40 @@
> > +/*
> > + * Copyright (c) 2017 Dialog Semiconductor
> > + *
> > + * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
>
> Same license question here.
>
>
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __LINUX_USB_PD_EXT_SDB_H
> > +#define __LINUX_USB_PD_EXT_SDB_H
>
> No need for __LINUX_ right?

As for patch 2, was following existing TCPM code but can remove the LINUX part
if that's preferred.
