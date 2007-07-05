From: Johannes Berg <johannes@sipsolutions.net>
Subject: RE: Power event notification patch
Date: Thu, 05 Jul 2007 15:28:00 +0200
Message-ID: <1183642080.3818.46.camel@johannes.berg>
References: <67670A5CEA5C374B8E7B16D7DC55F95301247453@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0666695523297051656=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F95301247453@bgsmsx413.gar.corp.intel.com>
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
To: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0666695523297051656==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4TA2svh8Y6chM2CMZ0D0"


--=-4TA2svh8Y6chM2CMZ0D0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-05 at 18:47 +0530, V, Sankara Narayanan wrote:
> We have to confirm that. And even if that does, running just linux
> kernel as OS without these applications/libraries does not guarantee the
> power notification.=20

True.

> It means that I have to run these apps/libraries
> wherever I want power event notification (example embedded devices).

Well, if you have a truly embedded device then likely you don't care
about this at all since the applications will work together much closer
than on a desktop system. Also, you likely have much stricter
requirements in that each application *must* be able to do exactly steps
1/2/3 before the system is suspended. Also, suspend will likely be
*much* faster too.

If it's pseudo-embedded like Nokia's N770/800 then you can very well run
things like hal to handle it.

johannes

--=-4TA2svh8Y6chM2CMZ0D0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjPHf/ETPhpq3jKURAk4mAJ9wd7Rv+6bGapMmu/3tkRd4RKqHOACfdGaL
bvS6DxJuipdtGcVep7gTw8Y=
=4MT0
-----END PGP SIGNATURE-----

--=-4TA2svh8Y6chM2CMZ0D0--


--===============0666695523297051656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0666695523297051656==--
