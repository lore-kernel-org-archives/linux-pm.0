From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 09/29] x86: assembly, use DATA_SIMPLE for data
Date: Thu, 27 Apr 2017 13:53:58 +0200
Message-ID: <20170427115358.GB23352@amd>
References: <20170421141305.25180-1-jslaby@suse.cz>
 <20170421141305.25180-9-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39436 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966853AbdD0LyB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2017 07:54:01 -0400
Content-Disposition: inline
In-Reply-To: <20170421141305.25180-9-jslaby@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> @@ -91,11 +91,11 @@ ENDPROC(do_suspend_lowlevel)
> =20
>  .data
>  ALIGN
> -ENTRY(saved_magic)	.long	0
> -ENTRY(saved_eip)	.long	0
> +SYM_DATA_SIMPLE(saved_magic, .long 0)
> +SYM_DATA_SIMPLE_LOCAL(saved_eip, .long 0)
> =20
>  # saved registers
> -saved_idt:	.long	0,0
> -saved_ldt:	.long	0
> -saved_tss:	.long	0
> +SYM_DATA_SIMPLE_LOCAL(saved_idt, .long 0,0)
> +SYM_DATA_SIMPLE_LOCAL(saved_ldt, .long 0)
> +SYM_DATA_SIMPLE_LOCAL(saved_tss, .long 0)

Do we really need to mark local data like that? It complicates the
source code a bit...
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkB29YACgkQMOfwapXb+vLl6wCcCkqeLalIpZynYd2Besd0xTl6
3rcAoIpa9xht5uOde59k1pP8xjVCzuP4
=wnKU
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
