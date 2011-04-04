From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [SUBMIT REQUEST] cpupowerutils for linux-next
Date: Tue, 5 Apr 2011 00:40:11 +1000
Message-ID: <20110405004011.0628991a.sfr__17260.4662403048$1301928155$gmane$org@canb.auug.org.au>
References: <201104041510.56570.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3342685529050154263=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104041510.56570.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: Greg Kroah-Hartman <gregkh@novell.com>, Andreas Herrmann <andreas.herrmann3@amd.com>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Linus <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============3342685529050154263==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__5_Apr_2011_00_40_11_+1000_+9cxAH9rKqU2TUWx"

--Signature=_Tue__5_Apr_2011_00_40_11_+1000_+9cxAH9rKqU2TUWx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, 4 Apr 2011 15:10:56 +0200 Thomas Renninger <trenn@suse.de> wrote:
>
> this is about the recently announced cpupowerutils project
> based on or say an enhancement of the well know
> cpufrequtils project:
> http://www.spinics.net/lists/cpufreq/msg02137.html

Has integration of this into the kernel sources been discussed anywhere
generally (like lkml)?  Has the work been done to integrate it into the
kernel build system (I am not sure what this involves for the tools
directory).  At a first glance, it doesn't need it own copy of the
COPYING file (for example).

I see that you asked Linus about this, but have receibed no reply (on
list).

Code being merged into linux-next should be basically ready for merging
into Linus' tree (apart from integration testing) and you need to be
pretty sure that it will be merged by Linus into the next release (i.e.
2.6.40).  In this case that is not such a big issue as the code is
(currently) all in a new directory, so will not interfere with other code.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Apr_2011_00_40_11_+1000_+9cxAH9rKqU2TUWx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNmdhLAAoJEDMEi1NhKgbs4J4H/3J/vmumomNKLKywxkowU/nf
X7yHqlr3siXhzzIgwY3klGW2a7mbP/sE81DyhW02IaJZXtqud7vso4FiB+ZDdT8a
hSaNEQYYw0FywRwOP0BothZ5WzSzwFNJcErv5Br2pKnUvj975p+GwHEeYYdNXHsV
l5ltNT6eeOPg61mnZTvqTf5zd4m1vvuJ4KOKrzsCKgwmR3thct3uRUMU32IBcSQt
ChLd2p5OZ0QHA43tEm1mtO04FeEfTSN1tXMfL/QrRdj/b+EBNitb5lNI3YijMzkU
83EhqfbcbUUY1iDSutdpTXN87fu4752j8wMpSFJwP0/0TiY8xQ//ONMnDMsbkYA=
=VuoL
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Apr_2011_00_40_11_+1000_+9cxAH9rKqU2TUWx--

--===============3342685529050154263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3342685529050154263==--
