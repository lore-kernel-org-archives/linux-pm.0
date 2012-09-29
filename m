From: "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 1/6] Introduce acpi_match_device_id().
Date: Sat, 29 Sep 2012 13:31:52 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926322C156@SHSMSX101.ccr.corp.intel.com>
References: <1348817910.10877.321.camel@rui.sh.intel.com>
 <20120928141347.GC15548@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120928141347.GC15548-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Len, Brown" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Friday, September 28, 2012 10:14 PM
> To: Zhang, Rui
> Cc: LKML; linux-pm; linux-i2c; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Len, Brown;
> Rafael J. Wysocki; Grant Likely; Dirk Brandewie
> Subject: Re: [RFC PATCH 1/6] Introduce acpi_match_device_id().
> Importance: High
> 
> On Fri, Sep 28, 2012 at 03:38:30PM +0800, Zhang Rui wrote:
> > >From 72df5d1f51fb27a4ba7f70a3b07df759d32b8288 Mon Sep 17 00:00:00
> > >2001
> > From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Date: Thu, 27 Sep 2012 15:11:55 +0800
> > Subject: [RFC PATCH 1/6] Introduce acpi_match_device_id().
> >
> > This API is used to check if a device id string is compatible with an
> > ACPI device, either PNP id exported via _HID or compatible ids
> > exported via _CID control method.
> >
> > Signed-off-by: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/acpi/scan.c     |   22 ++++++++++++++++++++++
> >  include/acpi/acpi_bus.h |    6 ++++++
> >  2 files changed, 28 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c index
> > d1ecca2..936a7c9 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -312,6 +312,28 @@ int acpi_match_device_ids(struct acpi_device
> > *device,  }  EXPORT_SYMBOL(acpi_match_device_ids);
> >
> > +int acpi_match_device_id(const struct device *dev, const char *id)
> 
> Would be good idea to implement this in terms of of_match_device() so
> that it returns pointer to the matched id. This way drivers can get the
> ->driver_data pretty easily if needed.
>
Good idea.
Will do that in v2.
 
> > +{
> > +	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
> 
> If the device is not bound to an ACPI handle this will return NULL. And
> I don't see you doing that in this series meaning that..
> 


You're right, I should set pdev->archdata.acpi_handle to the I2C controller in i2c_root.c.

Thanks,
rui
