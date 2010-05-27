From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: please pull "idle-test" branch into linux-next
Date: Thu, 27 May 2010 13:08:32 +1000
Message-ID: <20100527130832.acbb19ee.sfr@canb.auug.org.au>
References: <alpine.LFD.2.00.1005262231570.4039@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__27_May_2010_13_08_32_+1000_tkFV3T/fWYN4Jfn="
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1005262231570.4039@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--Signature=_Thu__27_May_2010_13_08_32_+1000_tkFV3T/fWYN4Jfn=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Len,

On Wed, 26 May 2010 22:35:52 -0400 (EDT) Len Brown <lenb@kernel.org> wrote:
>
> The idle patches currently in linux-acpi are unrelated to ACPI,
> so I'm moving them to a new home.  Please add the new home
> to your linux-next pull list:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git idl=
e-test

I will add it tomorrow (assuming that it is for 2.6.35).

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Thu__27_May_2010_13_08_32_+1000_tkFV3T/fWYN4Jfn=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkv94jAACgkQjjKRsyhoI8whRgCfSp1+EPye/TLLxzmU2ljmLu9F
GToAn2b+TMq4o5oWMF2pVyFkMn0Jx31M
=tIN7
-----END PGP SIGNATURE-----

--Signature=_Thu__27_May_2010_13_08_32_+1000_tkFV3T/fWYN4Jfn=--
