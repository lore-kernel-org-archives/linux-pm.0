From: "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 1/6] Introduce acpi_match_device_id().
Date: Mon, 1 Oct 2012 13:56:17 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926322D93C@SHSMSX101.ccr.corp.intel.com>
References: <1348817910.10877.321.camel@rui.sh.intel.com>
 <20120928141347.GC15548@intel.com>
 <744357E9AAD1214791ACBA4B0B90926322C156@SHSMSX101.ccr.corp.intel.com>
 <20121001063753.GE15548@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121001063753.GE15548-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Len, Brown" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Monday, October 01, 2012 2:38 PM
> To: Zhang, Rui
> Cc: LKML; linux-pm; linux-i2c; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Len, Brown;
> Rafael J. Wysocki; Grant Likely; Dirk Brandewie
> Subject: Re: [RFC PATCH 1/6] Introduce acpi_match_device_id().
> Importance: High
> 
> On Sat, Sep 29, 2012 at 01:31:52PM +0000, Zhang, Rui wrote:
> >
> > > > +{
> > > > +	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
> > >
> > > If the device is not bound to an ACPI handle this will return NULL.
> > > And I don't see you doing that in this series meaning that..
> > >
> >
> >
> > You're right, I should set pdev->archdata.acpi_handle to the I2C
> > controller in i2c_root.c.
> 
> There already is an API for that - check drivers/acpi/glue.c.

Do you mean acpi_bind?
acpi_bind_one will bind the physical device node to the ACPI device,
But for the i2c controller ACPI device, the physical node is the I2C
adapter in the I2C bus.
If we introduce I2C bus ACPI binding, which is what we're doing now,
the i2c_adapter->dev.archdata.acpi_handle will be set to the ACPI
i2c controller handle by acpi_bind_one.

Thanks,
rui
