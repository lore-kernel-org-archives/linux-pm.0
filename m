From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Wed, 11 Apr 2007 13:15:18 +0200
Message-ID: <1176290118.14149.20.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
	<1175849322.3489.64.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
	<1175852652.3489.67.camel@johannes.berg>
	<20070406191903.GD2583@elf.ucw.cz>
	<1175896767.8459.6.camel@johannes.berg>
	<20070410113623.GF8239@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1628376055=="
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


--===============1628376055==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MCqAHk6CKURAPrPRUGGM"


--=-MCqAHk6CKURAPrPRUGGM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-10 at 13:36 +0200, Pavel Machek wrote:

> Hmm, and can't you simply create sysdev for decrementer and special
> platform handling? sysdevs should be suspended last...

So I looked again and noticed that my earlier statement was wrong.

The special platform handling can well be done with platform devices, I
can simply insert them into the power management list early by using a
quite early initcall when registering them, that way they'll be
suspended last. So contrary to what I said, those aren't a problem.

The decrementer, however, I looked at again and noticed that I had a
wrong assumption. Let me give a short description of how the decrementer
works first:

The decrementer is a 32-bit register that counts down based on an
implementation-dependent clock, on my powerbook it's somewhere around
18MHz, on my powermac 32MHz (IIRC). When the most significant bit
transitions from 0 to 1 the decrementer exception is raised, when
exceptions are enabled it's taken. However, when exceptions are
disabled, it stays pending until it is taken when exceptions are enabled
again.

Because the exception stays pending, we need to set the decrementer to
the highest possible value before interrupts are disabled so we can be
sure that the exception is not pending. This is to ensure that the
processor can later go to sleep properly to be turned off.

Since we only have a limited amount of time after setting the
decrementer to such a high value (granted, it's at least a minute in all
cases I've seen so far) we like to do it right before disabling
interrupts.

johannes

--=-MCqAHk6CKURAPrPRUGGM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGHMND/ETPhpq3jKURAtaHAJ9LpF4Rw/UmaRHU4bx8QIeAZ7qhswCfffVz
oDOj/C1n4kdutRUKdGsArKs=
=EMgs
-----END PGP SIGNATURE-----

--=-MCqAHk6CKURAPrPRUGGM--


--===============1628376055==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1628376055==--
