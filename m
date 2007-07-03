From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 16:08:05 +1000
Message-ID: <200707031608.06348.nigel__42072.0837465071$1183443173$gmane$org@nigel.suspend2.net>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031454.42078.nigel@nigel.suspend2.net>
	<1183441706.10386.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5112930147938006373=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183441706.10386.73.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============5112930147938006373==
Content-Type: multipart/signed; boundary="nextPart2975534.L3divhfVm0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2975534.L3divhfVm0
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 03 July 2007 15:48:26 Benjamin Herrenschmidt wrote:
>=20
> > Note, though, that this won't help at all when people use=20
the "suspend-to-ram=20
> > instead of powering down after writing a hibernation image" feature in=
=20
> > (uswsusp | tuxonice). Fuse is just a broken idea in the first place, bu=
t=20
> > given that it exists, we still need to find the underlying cause.
>=20
> No, Fuse is not a broken idea in the first place. It's the freezer that
> is a totally broken idea. It has proven many times to be racy by design
> and cannot be made right. Ther usermode helper mess is just part of
> that, fuse is another example, etc etc ...

To some extent, I agree. I think the ideal solution would be to simply not=
=20
schedule processes that are supposed to be frozen. But who wants to play wi=
th=20
scheduler code? Not me!

> So I think Matthew is totally right. In fact, the presence of the
> freezer is the main reason why Paulus so far NACKed Johannes attempts at
> merging the PPC PM code with the generic code in kernel/power.c
>=20
> We've been doing fine without it so far and intend to continue to do so.

=46use depends on !PPC?
=20
> As for suspend-to-disk, I refer you to the discussions we had in the
> past with Linus, where he explains I think quite clearly how wrong the
> current implementation of STR is :-)

I assume you mean STD. The problem there is that Linus doesn't care about S=
TD.=20
If he did, I dare say he'd think through the issues more thoroughly than he=
=20
apparently has.
=20
> Thing is, if you're going to do snapshots, you should probably not sync
> after you have "frozen" anyway.

=46ully agree. But how do you stop things syncing while you're writing the =
image=20
if you don't have a freezer or equivalent? (scheduler based, kexec.. they'r=
e=20
all workarounds for this issue).

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart2975534.L3divhfVm0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGiefGN0y+n1M3mo0RAiEeAJ94S+oGv0gxhaFcS58q3ZVyQY4w7ACfWxSN
WaNQiea+1QXaap3L53odQeY=
=HVz8
-----END PGP SIGNATURE-----

--nextPart2975534.L3divhfVm0--

--===============5112930147938006373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5112930147938006373==--
