From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 06/10] powerpc: MPIC sys_device & suspend/resume
Date: Wed, 07 Feb 2007 13:24:04 +0100
Message-ID: <1170851044.6798.33.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185837.244398000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1870158400=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205185837.244398000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1870158400==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vS00IDSQWYIfotlZzLxw"


--=-vS00IDSQWYIfotlZzLxw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:
> plain text document attachment (mpic-suspend.patch)
> This adds mpic to the system devices and implements suspend
> and resume for them. This is necessary to get interrupts for
> modules back to where they were before a suspend to disk.

This patch isn't enough, I forgot about the broken u3 ht interrupt
stuff. Will resend with code that restores those as well which actually
makes all interrupts on my powermac work after resume.

johannes

--=-vS00IDSQWYIfotlZzLxw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFycTk/ETPhpq3jKURAjcZAJ9vVqD0gI3mqfpQOSomSoaovnxTLwCgrHk5
SeSSDpLgU9vgGii9zzRNEC8=
=YLVe
-----END PGP SIGNATURE-----

--=-vS00IDSQWYIfotlZzLxw--


--===============1870158400==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1870158400==--
