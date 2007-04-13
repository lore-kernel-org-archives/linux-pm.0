From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 00:01:47 +0200
Message-ID: <1176501707.7052.132.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl> <20070413205837.GG28264@elf.ucw.cz>
	<1176498368.7052.117.camel@johannes.berg>
	<20070413211232.GJ28264@elf.ucw.cz>
	<1176499130.5764.94.camel@localhost.localdomain>
	<20070413215609.GP28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0581049259=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413215609.GP28264@elf.ucw.cz>
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


--===============0581049259==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ubGJKnPe+h3mRF6MF7aH"


--=-ubGJKnPe+h3mRF6MF7aH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-13 at 23:56 +0200, Pavel Machek wrote:

> There are about 7 places where we do stop_platform_devices()
> local_irq_disable() stop_sysdevs().

I can only find three of those.

> You call your hook from one of
> them and I suspect you need to call it from more than one. Plus, the
> hook needs to have documented semantics, so people know if they should
> do local_irq_disable() or if they should call your hook.

All but one are related to suspend to disk. I don't see anybody
inventing yet another entry point to the kernel that actually uses
pm_ops internally, but if they do surely they'll follow the code that is
there.

johannes

--=-ubGJKnPe+h3mRF6MF7aH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGH/3K/ETPhpq3jKURAtouAJ90bqaOyTmTMYci2sModjGY14CAKQCgnTkn
kQZcky0exiAyvdqnETzywuY=
=NOOJ
-----END PGP SIGNATURE-----

--=-ubGJKnPe+h3mRF6MF7aH--


--===============0581049259==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0581049259==--
