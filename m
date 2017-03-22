From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 02/10] x86: assembly, FUNC_START for fn, DATA_START
 for data
Date: Wed, 22 Mar 2017 16:52:45 +0100
Message-ID: <20170322155245.GA27894@amd>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-2-jslaby@suse.cz>
 <20170321140840.GA23311@amd>
 <fd0cb783-b07f-f636-04a8-d8a115de1a17@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34756 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdCVPwt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 11:52:49 -0400
Content-Disposition: inline
In-Reply-To: <fd0cb783-b07f-f636-04a8-d8a115de1a17@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-03-22 13:06:54, Jiri Slaby wrote:
> Hi,
>=20
> On 03/21/2017, 03:08 PM, Pavel Machek wrote:
> >> -ENTRY(saved_rbp)	.quad	0
> >> -ENTRY(saved_rsi)	.quad	0
> >> -ENTRY(saved_rdi)	.quad	0
> >> -ENTRY(saved_rbx)	.quad	0
> >> +SYM_DATA_START(saved_rbp)		.quad	0
> >> +SYM_DATA_START(saved_rsi)		.quad	0
> >> +SYM_DATA_START(saved_rdi)		.quad	0
> >> +SYM_DATA_START(saved_rbx)		.quad	0
> >=20
> > Does it make sense to call it SYM_DATA_*START* when there's no
> > corresponding end?
> >=20
> > Plus... it looks like saved_rsi (and friends) are only used inside
> > wakeup_64.S. Could we just delete the "ENTRY" annotations?
>=20
>=20
> So, now I have:
>=20
> =3D=3D=3D linkage.h =3D=3D=3D
>=20
> /* SYM_DATA_SIMPLE -- start+end wrapper around simple global data */
> #ifndef SYM_DATA_SIMPLE
> #define SYM_DATA_SIMPLE(name, data)                             \
>         SYM_DATA_START(name) ASM_NL                             \
>         data ASM_NL                                             \
>         SYM_DATA_END(name)
> #endif
>=20
> /* SYM_DATA_SIMPLE_LOCAL -- start+end wrapper around simple local data */
> #ifndef SYM_DATA_SIMPLE_LOCAL
> #define SYM_DATA_SIMPLE_LOCAL(name, data)                       \
>         SYM_DATA_START_LOCAL(name) ASM_NL                       \
>         data ASM_NL                                             \
>         SYM_DATA_END(name)
> #endif
>=20
> =3D=3D=3D wakeup_64.S =3D=3D=3D
>=20
> SYM_DATA_SIMPLE_LOCAL(saved_rbp, .quad 0)
> SYM_DATA_SIMPLE_LOCAL(saved_rsi, .quad 0)
> SYM_DATA_SIMPLE_LOCAL(saved_rdi, .quad 0)
> SYM_DATA_SIMPLE_LOCAL(saved_rbx, .quad 0)
>=20
> SYM_DATA_SIMPLE_LOCAL(saved_rip, .quad 0)
> SYM_DATA_SIMPLE_LOCAL(saved_rsp, .quad 0)
>=20
> SYM_DATA_SIMPLE_LOCAL(saved_magic, .quad 0)
>=20
> =3D=3D=3D original =3D=3D=3D
>=20
>     10: 0000000000000060     0 NOTYPE  GLOBAL DEFAULT    3 saved_magic
>     11: 0000000000000050     0 NOTYPE  GLOBAL DEFAULT    3 saved_rsp
>     12: 0000000000000030     0 NOTYPE  GLOBAL DEFAULT    3 saved_rbx
>     13: 0000000000000020     0 NOTYPE  GLOBAL DEFAULT    3 saved_rdi
>     14: 0000000000000010     0 NOTYPE  GLOBAL DEFAULT    3 saved_rsi
>     15: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    3 saved_rbp
>     16: 0000000000000040     0 NOTYPE  GLOBAL DEFAULT    3 saved_rip
>=20
> =3D=3D=3D new =3D=3D=3D
>=20
>      4: 0000000000000030     8 OBJECT  LOCAL  DEFAULT    3 saved_magic
>      6: 0000000000000028     8 OBJECT  LOCAL  DEFAULT    3 saved_rsp
>      7: 0000000000000018     8 OBJECT  LOCAL  DEFAULT    3 saved_rbx
>      8: 0000000000000010     8 OBJECT  LOCAL  DEFAULT    3 saved_rdi
>      9: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    3 saved_rsi
>     10: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    3 saved_rbp
>     11: 0000000000000020     8 OBJECT  LOCAL  DEFAULT    3 saved_rip
>=20
> =3D=3D=3D EOF =3D=3D=3D
>=20
> BTW, ENTRY() aligned the data to 2^4 =3D 16 as we can see in the original.
> But I see no point aligning data like this.

Yep, that's a bug, too. I guess it hurts even more on 32-bit....

Thanks for fixing this,
									Pavel

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljSnc0ACgkQMOfwapXb+vLEDQCfXqt2Dj6Nc+r/aqSduyqwokvE
HTwAoKiVoBBUWg35ppAEPd1XftRjDDWb
=HS1e
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
