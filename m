From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 02/10] x86: assembly, FUNC_START for fn,
 DATA_START for data
Date: Tue, 21 Mar 2017 15:08:41 +0100
Message-ID: <20170321140840.GA23311@amd>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-2-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5168699477915138554=="
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20170320123222.15453-2-jslaby@suse.cz>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, hpa@zytor.com, linux-pm@vger.kernel.org, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mingo@redhat.com, jpoimboe@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-pm@vger.kernel.org


--===============5168699477915138554==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> -ENTRY(saved_rbp)	.quad	0
> -ENTRY(saved_rsi)	.quad	0
> -ENTRY(saved_rdi)	.quad	0
> -ENTRY(saved_rbx)	.quad	0
> +SYM_DATA_START(saved_rbp)		.quad	0
> +SYM_DATA_START(saved_rsi)		.quad	0
> +SYM_DATA_START(saved_rdi)		.quad	0
> +SYM_DATA_START(saved_rbx)		.quad	0

Does it make sense to call it SYM_DATA_*START* when there's no
corresponding end?

Plus... it looks like saved_rsi (and friends) are only used inside
wakeup_64.S. Could we just delete the "ENTRY" annotations?

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljRM+gACgkQMOfwapXb+vKgVACdGCXFP24IJi5TzHp3JSy+qrsi
zHkAnjG3GFxgL+GH0ngTUOcZyv/nGLH/
=IcHn
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


--===============5168699477915138554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVs
IG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5v
cmcveGVuLWRldmVsCg==

--===============5168699477915138554==--
