From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 6/8] mfd: make mfd_remove_devices() iterate in
 reverse order
Date: Mon, 06 Jul 2015 12:10:03 +0300
Message-ID: <1436173803.8279.1.camel@linux.intel.com>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1434362256-239992-7-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150624113144.GL15013@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42361 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725AbbGFJKJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 Jul 2015 05:10:09 -0400
In-Reply-To: <20150624113144.GL15013@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>

On Wed, 2015-06-24 at 12:31 +0100, Lee Jones wrote:
> On Mon, 15 Jun 2015, Andy Shevchenko wrote:
>=20
> > The newly introduced device_for_each_child_reverse() would be used=20
> > when MFD
> > core removes the device.
> >=20
> > After this patch applied the devices will be removed in a reversed=20
> > order. This
> > behaviour is useful when devices have implicit dependency on order,=
=20
> > i.e.
> > consider MFD device with serial bus controller, such as SPI, and=20
> > DMA IP that is
> > attached to serial bus controller: before remove the DMA driver we=20
> > have to be
> > ensured that no DMA transfers is ongoing and the requested channel=20
> > are unused.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/mfd-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Applied, thanks.

Hmm=E2=80=A6 Seems kinda mistake. I can't see this applied (and require=
d
previous patches 4 and 5) to any of your branch neither in (today's)
linux-next.

>=20
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 1aed3b7..79eeaa5 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -300,7 +300,7 @@ void mfd_remove_devices(struct device *parent)
> >  {
> >  	atomic_t *cnts =3D NULL;
> > =20
> > -	device_for_each_child(parent, &cnts,=20
> > mfd_remove_devices_fn);
> > +	device_for_each_child_reverse(parent, &cnts,=20
> > mfd_remove_devices_fn);
> >  	kfree(cnts);
> >  }
> >  EXPORT_SYMBOL(mfd_remove_devices);
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
