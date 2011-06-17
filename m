From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Sat, 18 Jun 2011 00:33:29 +0600
Message-ID: <20110617183329.GH4307__30912.8500674435$1308335758$gmane$org@belkar.wrar.name>
References: <20110617155739.GE4307@belkar.wrar.name>
	<Pine.LNX.4.44L0.1106171206480.2143-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1349289691832120746=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106171206480.2143-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============1349289691832120746==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Content-Disposition: inline


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2011 at 12:11:52PM -0400, Alan Stern wrote:
> > After "usb 1-1.1: usb suspend" I see a full "start hub_suspend,
> > hub_quiesce, rest of hub_suspend" path for 1-1:1.0 (I've used &intf->dev
> > in suspend and hub->intfdev in quiesce as a 1st arg for dev_info()), th=
en
> > "usb 1-1: usb suspend" and after that it hangs.
> Ah, okay.  I feel stupid; I should have realized that would happen.
> Anyway, the next place to look is in usb_port_suspend(), also in hub.c.
After "usb 1-1: usb suspend" I have a message after
usb_set_device_state(udev, USB_STATE_SUSPENDED); but not the message after
the next line (msleep(10);). This is at the end of usb_port_suspend();

--=20
WBR, wRAR

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN+534AAoJEDNi9wMaSZLh2MIP/0xf1HODgzfn47rZS4doDmLP
7sVR4bUOkPlMY6mbq6DValWrdMMKTxeMDB+LB6oqt3mUAM5HdBdtK97sELUUyl4D
vH+7f/2CZJkizdUOMFB64+OYTdzNdHFd1gSgc9GpExiBQDCQpN0oq7dluQkT/OZk
hkQTXUHDZGFr+3fBQyfGbWdredkEogEScZt0WUohCyBJQV3pbhx+eubmcS0aris/
rRWY2sJIKi0rOoikeNEdzVd+EBZpCvVs0471vj3cK4IexQtpJBMPEum201H4A8Wu
2J784YMPE6oGTPul7sCEHVfUTnvSgIMx7ta5PphA1Q838sZYRHmMLnEgTCmuqSwZ
Vkk/geUsA2CeZIDYrmxIs+j8/dpmkIq+Wpj/pfzbcJibem8qpHDeyThSYySUDdBB
9MMy2k7i8UD5QGNPjnvYBKzJz/igvXQ90oUO+GvHHxBzeZXdxHW/DNRUDKxdRthr
kxtudVfoR4JtrR/i/J++I3fvpzkrd6k7k7hqXOa/Xj5WVW+cgGu+KWtiFoVPIG3K
TszHkYxxWnhm71fyDW+pMMxMTG1d5jBVyuVIiNTIw6p3P5mtMOlb9u9K3zoH2gpp
GIAL6AKJvjhKqPxTSY1BQ3xHoXsopp2onxP5R/X+9EB3TJ3IxVn8yZpSDsBgAznB
7NaznetF2ZCnG7WFwKCs
=SU9t
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--

--===============1349289691832120746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1349289691832120746==--
