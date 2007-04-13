From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:59:07 +0200
Message-ID: <1176501547.7052.130.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl> <20070413205837.GG28264@elf.ucw.cz>
	<1176498368.7052.117.camel@johannes.berg>
	<20070413211232.GJ28264@elf.ucw.cz>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>
	<1176500749.7052.127.camel@johannes.berg>
	<20070413215241.GO28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1952580133=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413215241.GO28264@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============1952580133==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1jXZydiReobIXIn7ycI8"


--=-1jXZydiReobIXIn7ycI8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-13 at 23:52 +0200, Pavel Machek wrote:

> Look again, this sequence is before taking system snapshot, and then
> we have to recover and save the snapshot, too.

I know. But that doesn't make us care.

As I explained previously, the decrementer exception is pending until it
is taken. It doesn't matter one bit whether it is pending during the
snapshot, but it does matter if we need the CPU to go to sleep later
because it won't when the exception is pending.

johannes

--=-1jXZydiReobIXIn7ycI8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGH/0r/ETPhpq3jKURAqimAJ9PcnpqvZSX2tHhW4avbSmjpAbnoACgrmRw
2/exeoU0dvmj6O1TWGQ/Hww=
=he/P
-----END PGP SIGNATURE-----

--=-1jXZydiReobIXIn7ycI8--


--===============1952580133==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1952580133==--
