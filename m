From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 06 Apr 2007 02:09:18 +0200
Message-ID: <1175818158.3489.47.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060130.52885.rjw@sisk.pl>
	<1175815737.3489.37.camel@johannes.berg>
	<200704060202.13597.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0435090830=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704060202.13597.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0435090830==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-drCxAhNiLqNQrBz2b63t"


--=-drCxAhNiLqNQrBz2b63t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-06 at 02:02 +0200, Rafael J. Wysocki wrote:

> Well, this seems to be more natural ("if you want to do something before/=
after
> disabling the IRQs, define it" instead of "you can do something instead o=
f
> calling local_irq_save(), but please remember to disable the IRQs yoursel=
f
> in that case").

Heh. Yeah, I guess. It just didn't seem worth it. I personally don't
care, I just need to be able to get at those spots.

> BTW, it need not be in pm_ops (actually, why should it be there?).
> Alternatively, you can define something like arch_prepare_for_disabling_i=
rqs()
> and/or arch_prepare_device_power_down() that will be empty on x86, for
> example.

Not sure, it might be different for different suspend methods. We
actually need to do some platform-function stuff inbetween, and if we
ever want some S4-like state then we might need to do it differently.

> BTW2, I think BUG_ON(irqs_enabled) is needed after the arch does somethin=
g
> instead of or after local_irq_save().

Sure, I can add that. Probably also in the resume path.

johannes

--=-drCxAhNiLqNQrBz2b63t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGFY+u/ETPhpq3jKURAk1rAKCVu7aG7agSbWA719Om+DMCyjyXeACfXh9X
qQLEgO4U3ZWQyerM1aP5UqY=
=1ioR
-----END PGP SIGNATURE-----

--=-drCxAhNiLqNQrBz2b63t--


--===============0435090830==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0435090830==--
