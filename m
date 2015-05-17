From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] twl4030_charger: find associated phy by more
 reliable means.
Date: Sun, 17 May 2015 11:56:12 +0200
Message-ID: <20150517095610.GA2612@earth>
References: <20150322225053.22311.45510.stgit@notabene.brown>
 <20150322225248.22311.50385.stgit@notabene.brown>
 <20150508161205.GE16571@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150508161205.GE16571-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 08, 2015 at 11:12:05AM -0500, Felipe Balbi wrote:
> On Mon, Mar 23, 2015 at 09:52:48AM +1100, NeilBrown wrote:
> > From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> >=20
> > twl4030_charger currently finds the associated phy
> > using usb_get_phy() which will return the first USB2 phy.
> > If your platform has multiple such phys (as mine does),
> > this is not reliable (and reliably fails on the GTA04).
> >=20
> > Change to use devm_usb_get_phy_by_node(), having found the
> > node by looking for an appropriately named sibling in
> > device-tree.
> >=20
> > This makes usb-charging dependent on correct device-tree
> > configuration.
> >=20
> > Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> > ---
>=20
> Sebastian, can I get your Acked-by here ?

Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVWGW3AAoJENju1/PIO/qaztsP/jNWefxwkayLwpQTxDlRTzv9
qVUFeUFQTWOeXX7Ci3czk8tDvII8y3eoLPHH4aYkQx5UUmj/QZt/whkgJyzntEqv
SNEBw8sKUS8oQHm+LYrM6OTQNo0BoRhzfVlW3gIY3k3KvI1D1hIa5qFgCMA76P2N
g7fk/r1A8AE8z1fQ1izFAi2KyZmNJ37m3Xb6JJ5VzP9YLBIGft5aR0qzwI6o7CQN
HHEzR4gmQkaTz3AFGc6ybBxso04HDPHLR0NwJWhKlBx/5G5EA1Q04bd8F1qe2aD3
gXI7Tebag2ASM543Cn+XdFSF5AAv813GvTyALlMMiufjbypvVTHz0fuZdqGaK3q/
0544s8Vw2kpR7Mc4mRixN9xs/DyX0PmgOXNTQ8pxQKUgPjaYBk6Wx/eR59pet0kD
Lf/lX6rrjMHvCXIQbiISgTE+mQBE+4WJF06bsvHrtz+86nGUSy3H/qqcI0y2jdkW
khSoHmJCIQ1PDF0BtnhXC8gd+paC3TLcWuK1OUgUj3im+nPcup+CxYwGa6yBZq8r
scOS7W3DHVtLx69uZz39NmtccBX9uEmOoAofmK5GRmSPcdGEPnpzPPsXBI6Qh7J+
tvpooXJPYQKru2dpW+q2DhUoKjUwHlqVUzQAXqSIETYpN9G/XsV65USxsXAMyCFt
d3YBrgA5mg1Dofc0Y0Hh
=EkTw
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
