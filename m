From: Andrey Rahmatullin <wrar@altlinux.org>
Subject: Re: [TuxOnIce-devel] Swsusp patches applied to
	suspend-2.6#linux-next
Date: Mon, 27 Sep 2010 17:16:31 +0600
Message-ID: <20100927111631.GA6759__19531.2003292658$1285586336$gmane$org@wrars-comp.wrarsdomain>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<20100927080000.GA7032@wrars-comp.wrarsdomain>
	<4CA055EF.6050608@tuxonice.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5262475612364101186=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CA055EF.6050608@tuxonice.net>
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
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org


--===============5262475612364101186==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2010 at 06:29:35PM +1000, Nigel Cunningham wrote:
> >> On my laptop, single-threaded compression actually slows writing down =
=66rom
> >> 175MB/s to around 100-120MB/s (depending on how well the image compres=
ses).
> >> Reading speed improves from 218MB/s to around 245MB/s. I expect that
> >> multithreaded writing would bring the writing (and reading) speeds back
> >> up. It's on my swsusp to do list :)
> > Works here.
> What sort of speeds are you seeing?
[  343.549378] PM: Image written at 107 MB/s.
[  343.549379] PM: Image read at 205 MB/s.
Latest ToI (on .35; with the lzo compressor; no clue about
multithreadedness, though there are 4 CPUs here): I/O speed: Write 166
MB/s, Read 192 MB/s.

--=20
WBR, wRAR (ALT Linux Team)

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJMoH0PAAoJEOih81koZvPBhGEH+wav+J+hTqqeDBUJx/NQMRXJ
NH98KNmAgaLLJ1+yzeNTfnNBUp/e4z2QMSjW6y659V086S+p3iEpvzhjN0L2iYI4
tmRF851ouLeS2gaX+zytitoz3Z1lbFVC4hO7Xvc9SEXqJVV2282/lJHwfouDJZ0L
kRP5hEEjZ57BWSOlP33o5Is8Thu+YVxDT6kfRwuTLCgR7wMHaqTYDrhYs0Qn3zpI
gBJ1QjidOR91FTst/IX3Dk8nOLi+aHbmlBn0lAv0AQii7JwZmkYTxi50U8VPbvYK
7f/g6cMytHMaPSI7TYszjfJTE1ipfwGjgykO6QXgdDUEVOWKvNEN+Oep4xppdaI=
=Yt10
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--===============5262475612364101186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5262475612364101186==--
