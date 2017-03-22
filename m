From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v2 02/10] x86: assembly, FUNC_START for fn, DATA_START for
 data
Date: Wed, 22 Mar 2017 13:06:54 +0100
Message-ID: <fd0cb783-b07f-f636-04a8-d8a115de1a17@suse.cz>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-2-jslaby@suse.cz> <20170321140840.GA23311@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Jk9RwNf315HV4omTjjBatMF11GKTiE8iC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35287 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934121AbdCVMHC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 08:07:02 -0400
In-Reply-To: <20170321140840.GA23311@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jk9RwNf315HV4omTjjBatMF11GKTiE8iC
Content-Type: multipart/mixed; boundary="IStvp4RNMuu9a782H8koEmXh9KPAOc1po";
 protected-headers="v1"
From: Jiri Slaby <jslaby@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org,
 jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross
 <jgross@suse.com>, xen-devel@lists.xenproject.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org
Message-ID: <fd0cb783-b07f-f636-04a8-d8a115de1a17@suse.cz>
Subject: Re: [PATCH v2 02/10] x86: assembly, FUNC_START for fn, DATA_START for
 data
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-2-jslaby@suse.cz> <20170321140840.GA23311@amd>
In-Reply-To: <20170321140840.GA23311@amd>

--IStvp4RNMuu9a782H8koEmXh9KPAOc1po
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/21/2017, 03:08 PM, Pavel Machek wrote:
>> -ENTRY(saved_rbp)	.quad	0
>> -ENTRY(saved_rsi)	.quad	0
>> -ENTRY(saved_rdi)	.quad	0
>> -ENTRY(saved_rbx)	.quad	0
>> +SYM_DATA_START(saved_rbp)		.quad	0
>> +SYM_DATA_START(saved_rsi)		.quad	0
>> +SYM_DATA_START(saved_rdi)		.quad	0
>> +SYM_DATA_START(saved_rbx)		.quad	0
>=20
> Does it make sense to call it SYM_DATA_*START* when there's no
> corresponding end?
>=20
> Plus... it looks like saved_rsi (and friends) are only used inside
> wakeup_64.S. Could we just delete the "ENTRY" annotations?


So, now I have:

=3D=3D=3D linkage.h =3D=3D=3D

/* SYM_DATA_SIMPLE -- start+end wrapper around simple global data */
#ifndef SYM_DATA_SIMPLE
#define SYM_DATA_SIMPLE(name, data)                             \
        SYM_DATA_START(name) ASM_NL                             \
        data ASM_NL                                             \
        SYM_DATA_END(name)
#endif

/* SYM_DATA_SIMPLE_LOCAL -- start+end wrapper around simple local data */=

#ifndef SYM_DATA_SIMPLE_LOCAL
#define SYM_DATA_SIMPLE_LOCAL(name, data)                       \
        SYM_DATA_START_LOCAL(name) ASM_NL                       \
        data ASM_NL                                             \
        SYM_DATA_END(name)
#endif

=3D=3D=3D wakeup_64.S =3D=3D=3D

SYM_DATA_SIMPLE_LOCAL(saved_rbp, .quad 0)
SYM_DATA_SIMPLE_LOCAL(saved_rsi, .quad 0)
SYM_DATA_SIMPLE_LOCAL(saved_rdi, .quad 0)
SYM_DATA_SIMPLE_LOCAL(saved_rbx, .quad 0)

SYM_DATA_SIMPLE_LOCAL(saved_rip, .quad 0)
SYM_DATA_SIMPLE_LOCAL(saved_rsp, .quad 0)

SYM_DATA_SIMPLE_LOCAL(saved_magic, .quad 0)

=3D=3D=3D original =3D=3D=3D

    10: 0000000000000060     0 NOTYPE  GLOBAL DEFAULT    3 saved_magic
    11: 0000000000000050     0 NOTYPE  GLOBAL DEFAULT    3 saved_rsp
    12: 0000000000000030     0 NOTYPE  GLOBAL DEFAULT    3 saved_rbx
    13: 0000000000000020     0 NOTYPE  GLOBAL DEFAULT    3 saved_rdi
    14: 0000000000000010     0 NOTYPE  GLOBAL DEFAULT    3 saved_rsi
    15: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    3 saved_rbp
    16: 0000000000000040     0 NOTYPE  GLOBAL DEFAULT    3 saved_rip

=3D=3D=3D new =3D=3D=3D

     4: 0000000000000030     8 OBJECT  LOCAL  DEFAULT    3 saved_magic
     6: 0000000000000028     8 OBJECT  LOCAL  DEFAULT    3 saved_rsp
     7: 0000000000000018     8 OBJECT  LOCAL  DEFAULT    3 saved_rbx
     8: 0000000000000010     8 OBJECT  LOCAL  DEFAULT    3 saved_rdi
     9: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    3 saved_rsi
    10: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    3 saved_rbp
    11: 0000000000000020     8 OBJECT  LOCAL  DEFAULT    3 saved_rip

=3D=3D=3D EOF =3D=3D=3D

BTW, ENTRY() aligned the data to 2^4 =3D 16 as we can see in the original=
=2E
But I see no point aligning data like this.

thanks,
--=20
js
suse labs


--IStvp4RNMuu9a782H8koEmXh9KPAOc1po--

--Jk9RwNf315HV4omTjjBatMF11GKTiE8iC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCAAtFiEE1pWBVg1LlveO4uo2vSWxBAa0cEkFAljSaN4PHGpzbGFieUBz
dXNlLmN6AAoJEL0lsQQGtHBJKW8P/itsVqEokN91qSugRFINVz7lBuWgKZEmyi+T
JRp6EAxvvVvM8HRtMhzEAxXqiMfWc/7hAYmBHCb/I1/rkzHgw4rJkBGkZ+I2zGQN
4bwye0PVvSWcP++6SeYABAFtW3IHePGtrL5a8SQk6SkHfaUQ5FR/uUY6/x2plST4
5NUYMsZXenG1xqtT48ZvYCHRUfnNobFxe/bQDmIyWDcqY0C9ZPSLXsQtLGv5pnYb
GMVfniFyf/JlBSmhxfjkuIdOHjyxfnLTKpLgSKNbTTUWgaWdO2d6QH3ddkO81v/N
R8E/TJbUjfGNEK1JFrao/revuZd2Wsg5ZRpyGzMAlG0JJ5vjqnlfm3tb9i6oP3mz
IrHpxQabaFcK59uTbUG0tP46uHF/KnqHhzOJ9je3/PhEXLprvCH1P852dQiNYE8G
bpOCpa+3qNjM8H8V1eMFtpCq+VPSugnOB2HA3xjw4tiGZJgWjCtcGIPFFr2apAXv
BcR9u3R+C18WMDnQoKbIpuc46gnUMmQkKyyvxb1dIPU2Ha9cnTdsadEsAgO3pIp9
zkMtxXTZL1HmXYTT+djWqQ9ipcKmyYrN+w71VP8x9kUOxQ9RY9E7Bj0T9Rhx6AQL
S0wNce4S7i475PtYd2z6IzWvEDx0B7HAQoZE34oIA/8WUAerj+W/wdEtjDnZTkhg
EeIjrl2V
=I8cx
-----END PGP SIGNATURE-----

--Jk9RwNf315HV4omTjjBatMF11GKTiE8iC--
