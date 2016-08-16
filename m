From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 4/4] power: sbs-battery: Use gpio_desc and sleeping
 calls for battery detect
Date: Tue, 16 Aug 2016 12:26:34 +0200
Message-ID: <20160816102634.74drhjmmy2pfytqg@earth>
References: <1469414580-14121-1-git-send-email-preid@electromag.com.au>
 <1469414580-14121-5-git-send-email-preid@electromag.com.au>
 <20160815210850.hd7p6blg7rbuzd7d@earth>
 <b25aaed0-59ec-e5b8-0096-67d8118f8b79@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lyvued6w5uvppxm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37780 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbcHPK0j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Aug 2016 06:26:39 -0400
Content-Disposition: inline
In-Reply-To: <b25aaed0-59ec-e5b8-0096-67d8118f8b79@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org


--2lyvued6w5uvppxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phil,

On Tue, Aug 16, 2016 at 05:35:09PM +0800, Phil Reid wrote:
> On 16/08/2016 05:08, Sebastian Reichel wrote:
> > Hi Phil,
> >=20
> > On Mon, Jul 25, 2016 at 10:43:00AM +0800, Phil Reid wrote:
> > > Switch to using new gpio_desc interface and devm gpio get calls to
> > > automatically manage gpio resource. Use gpiod_get_value which handles
> > > active high / low calls.
> > >=20
> > > If gpio_detect is set then force loading of the driver as it is
> > > reasonable to assume that the battery may not be present.
> > >=20
> > > Update the is_present flag immediately in the IRQ.
> >=20
> > I queued PATCH 1-3. Please send a new revision for PATCH 4 (this
> > one) with the following changes:
> >=20
> >  * add the correct gpiod include: <include/linux/gpio/consumer.h>
> >  * rebase on power-supply's next branch
> >  * remove battery_detect and battery_detect_present from the
> >    struct sbs_platform_data and always use the gpiod API. It's
> >    data can also come from platform data, see
> >    Documentation/gpio/board.txt and Documentation/gpio/consumer.txt
> >=20
> > -- Sebastian
> >=20
> G'day Sebastian,
>=20
> Thanks, I'll have a look at how that works.
> I wasn't sure it was acceptable to change the interface to
> sbs_platform_data.

Yes, that API is not exposed by the kernel, so it can be changed.
Since there are no users as far as I can see, changing it should
be quite simple. Thanks for the driver cleanup.

-- Sebastian

--2lyvued6w5uvppxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsupXAAoJENju1/PIO/qaEPUP/1H5wRbGtDEqTQeZAC9SNRcc
FUrOBDzDXlWtg0wXH/oRoUdzZSdYgbOjQUNKslC3MkNASurwhpSxjVDLeqThaLc5
lCCrNFzoasE1CDYEXV80Du4RpgleGw796vjlWrPKfEGhBfoSQnHaBpO4uOFN11gt
r7U5Mh/hThCvFlxNe6Sv1elBWNUcAWTE8GFjs5S36rOARrbm7EkiXHsolZA4zD91
+fRQn7GLo1034QhadEG4sctehQTxZIWIaEoh6Zat8hf7BrxgOIUsAxPkVXzoArSh
5b53HctmZ/alx+Y4QohkRq72gei/07cGoLKpDd8ZKuqJbdRUOwYyd4I3ow7m3WP0
M4CfRtStc/7esUH6k7urFhsUZrZ8PTFvobxjvjwi30Qte4dn7Fh9m19F1H1BMNqx
HyB0/fpcPCh4HTVA6dMMxcHcKS36dvVewIh+h3RoSrudfl4l9WMT9pZTMr/QpQ+V
/eOTXvGcD3N5MVAkgP/hsBxauPzuR0WYK7dEiENDSK2EQrZht3AZQVi9dtbOvXUu
fzZIjNHvvz/ZwdNlH4BtK4SqbTCDj4wp7ql/X0qk6jJxJeaWu3uX2YXIBuFHHs5c
vd9V37B6K70f4aufjS9OCzRB/4aHXOxzaFsZbnBX4DRWGG7NOebvw2rx0LCRILQz
QKuBFJ+aVdezbXz3U7R9
=iglT
-----END PGP SIGNATURE-----

--2lyvued6w5uvppxm--
