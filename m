From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Fri, 2 Oct 2015 12:27:30 -0500
Message-ID: <20151002172730.GK5552@saruman.tx.rr.com>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151002054107.GB18406@kroah.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37140 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbbJBR2O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Oct 2015 13:28:14 -0400
Content-Disposition: inline
In-Reply-To: <20151002054107.GB18406@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, Baolin Wang <baolin.wang@linaro.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org

--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 02, 2015 at 07:41:07AM +0200, Greg KH wrote:
> On Thu, Oct 01, 2015 at 12:29:32PM -0500, Felipe Balbi wrote:
> > On Thu, Sep 24, 2015 at 10:39:23AM -0700, Baolin Wang wrote:
> > > The usb charger framework is based on usb gadget. The usb charger
> > > need to be notified the state changing of usb gadget to confirm the
> > > usb charger state.
> > >=20
> > > Thus this patch adds a notifier mechanism for usb gadget to report a
> > > event to usb charger when the usb gadget state is changed.
> > >=20
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  drivers/usb/gadget/udc/udc-core.c | 32 +++++++++++++++++++++++++++++=
+++
> > >  include/linux/usb/gadget.h        | 18 ++++++++++++++++++
> > >  2 files changed, 50 insertions(+)
> > >=20
> > > diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/u=
dc/udc-core.c
> > > index f660afb..4238fc3 100644
> > > --- a/drivers/usb/gadget/udc/udc-core.c
> > > +++ b/drivers/usb/gadget/udc/udc-core.c
> > > @@ -129,6 +129,32 @@ void usb_gadget_giveback_request(struct usb_ep *=
ep,
> > >  }
> > >  EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
> > > =20
> > > +int usb_gadget_register_notify(struct usb_gadget *gadget,
> > > +			       struct notifier_block *nb)
> > > +{
> > > +	int ret;
> > > +
> > > +	mutex_lock(&gadget->lock);
> > > +	ret =3D raw_notifier_chain_register(&gadget->nh, nb);
> > > +	mutex_unlock(&gadget->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(usb_gadget_register_notify);
> > > +
> > > +int usb_gadget_unregister_notify(struct usb_gadget *gadget,
> > > +				 struct notifier_block *nb)
> > > +{
> > > +	int ret;
> > > +
> > > +	mutex_lock(&gadget->lock);
> > > +	ret =3D raw_notifier_chain_unregister(&gadget->nh, nb);
> >=20
> > Greg, this is the kind of thing I wanted to avoid adding more of.
> >=20
> > I was wondering if you would accept subsystems using kdbus for
> > this sort of notification. I'm okay waiting for kdbus for another
> > couple merge windows (if we have to) before that's merged, but
> > if we take this raw notifier approach now, we will end up having
> > to support it forever.
>=20
> kdbus is userspace <-> userspace messages, it doesn't do kernel <->
> userspace messages, sorry.

oh well, tough luck :-)

having a more well-constructed notification method to userspace would be a
little better, but I guess we will have to resort to sysfs_notify() or some=
thing
like that.

> > Also, because soon enough we will have to support USB Power Delivery
> > with Type C connector, this is bound to change in the coming months.
> >=20
> > Frankly, I wanted all of this to be decided in userland with the
> > kernel just providing notification and basic safety checks (we don't
> > want to allow a bogus userspace daemon frying anybody's devices).
> >=20
> > How would you feel about that ?
>=20
> I agree I don't like new notifier chains being added, but as this is all
> in-kernel, we can change the api in the future and there would not be a
> problem, right?

not necessarily. This will, eventually, get exposed to userspace. At minimu=
m for
adding eye candy to the UI. Chaging battery icon or whatever. The danger he=
re is
that when that something gets exposed, we will have to support it for the n=
ext
30 years :-)

> And yeah, I'm worried about the USB Power delivery patches, I haven't
> seen them yet, but I hear about different groups doing different things
> here, and that worries me.

my worries exactly :-) This is why I'm looking for a flexible enough approa=
ch
which puts as little into the kernel as necessary.

--=20
balbi

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDr6CAAoJEIaOsuA1yqREmKUP/3VI05RXSfxykmHDywaM7lxR
/8qiIx/tc8KBmdultdTxF9boD6WtHI5Artd0WReDughwcujo8+mo77eUDEJ2u5c6
iPO7w8nUL16v2Kq5flUxFx9FTE6+x8vsr2JijcqAdO1acefRzJxiDAzGwO2MXvfS
U7O+oj/WFpxVzPUrR/CN6y8Kx3Tc0XGSIjN9e59pln4hdrtVJO5wtMD3lYbFrEvZ
8PN1K8EJNQjCGxVXs41v2QXvjoiBRx+ybTvQgPAPbSq5We73drMjyW9bq8tLvirc
LhZnHyW2S7OEWHQ+4X/JkEL4jXUGlSgU9YmpEFSPoraf4WlZcx+i3f/6kf8VG3uw
R8ZOv/c/L/livmiAastFyYvpDkliXcXhUoUnGDe8sU39ts24a2/DNeS2lR0wV8df
UfvfhH9JlVW3kQxw9qwpSQjmS4ekIJRMQSrGt9Nqe8axoL0r0ZWaGCt4qivDcAFN
zVR5DkX2t7bc3v8izc0j4F69xkxvSbcrHNitKKEXPRcQHkK9c2xuILlfGfqeP47j
vnORcuuduEqqqBuazzEp0rY6Nn5m2I4Ab8j3x9dTc7QDiSzL5BW0cxNZqGKOPMBL
ABOlKaf4kj8jT5FDSq9ISpvCXRBDz6HH8LPSP8lE3CXX/7VYUVeuIBNKdzkK3zTG
iSec1P2IPMq8PAtyyYyq
=9+Ly
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--
