From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Tue, 10 Apr 2007 13:45:07 +0200
Message-ID: <1176205508.8459.89.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
	<1175849322.3489.64.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
	<1175852652.3489.67.camel@johannes.berg>
	<20070406191903.GD2583@elf.ucw.cz>
	<1175896767.8459.6.camel@johannes.berg>
	<20070410113623.GF8239@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1753274816=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070410113623.GF8239@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1753274816==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Odqj8S0ndhe3uayMy8/9"


--=-Odqj8S0ndhe3uayMy8/9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-10 at 13:36 +0200, Pavel Machek wrote:

> Hmm, and can't you simply create sysdev for decrementer and special
> platform handling? sysdevs should be suspended last...

In theory, yes.

In practise, however, it seems to be impossible to get a sysdev into the
queue that is suspended before any other sysdevs are suspended (i.e.
right after interrupts are disabled)

And then there are the platform functions. In theory, they could be done
with a regular struct device, but in practice they need to be the very
last thing before interrupts are disabled, and that again is impossible
to achieve.

johannes

--=-Odqj8S0ndhe3uayMy8/9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGG3jD/ETPhpq3jKURArSkAJ9hyBhGJUZ/wotZ7oN0r7hF0rZTAwCffQrS
bIVrfkuN+FNTTfCO/Yo3dc4=
=LHYQ
-----END PGP SIGNATURE-----

--=-Odqj8S0ndhe3uayMy8/9--


--===============1753274816==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1753274816==--
