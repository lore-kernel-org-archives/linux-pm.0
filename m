From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sat, 24 Mar 2007 22:01:41 +0100
Message-ID: <1174770101.9161.20.camel@johannes.berg>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703231057.16539.david-b@pacbell.net>
	<200703232139.38721.rjw@sisk.pl>
	<200703241349.19964.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0206560830=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703241349.19964.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org


--===============0206560830==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Bbu9tXzHxtP7DNdkSoGb"


--=-Bbu9tXzHxtP7DNdkSoGb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-03-24 at 13:49 -0700, David Brownell wrote:

> You seem to have overlooked the clk_must_disable() patches I
> recently re-sent.  In conjunction with the driver model wakeup
> flags, that can solve the problem on every SOC platform I've
> had a reason to look at ... see how it works for AT91 USB.

In fact, I looked at those, and it's actually useful on powermac laptops
(powerbooks/ibooks) as well, there are some sound clocks that could be
managed with it.

> No, let's not complexify that pm_message_t mistake any further.

I second that. Drivers can't really know what the precise semantics of
any state are across platforms, especially drivers that are shared
between different platforms but where the hw could be wired up
differently.

johannes

--=-Bbu9tXzHxtP7DNdkSoGb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGBZG1/ETPhpq3jKURAqWrAJ4wP64souM15nsZkcE14MY82oEtUgCgmEG2
2bqdv7hakjIgV8za2DESetg=
=kyz3
-----END PGP SIGNATURE-----

--=-Bbu9tXzHxtP7DNdkSoGb--


--===============0206560830==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0206560830==--
