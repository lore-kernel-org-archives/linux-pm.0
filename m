From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 21:15:43 +1000
Message-ID: <200606142115.52560.ncunningham@linuxmail.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<200606131620.45156.david-b@pacbell.net>
	<20060614102806.GB28536@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1260243348=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614102806.GB28536@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============1260243348==
Content-Type: multipart/signed; boundary="nextPart3557865.04NUhSrfqx";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3557865.04NUhSrfqx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 14 June 2006 20:28, Pavel Machek wrote:
> Hi!
>
> > Here's a related patch (well, "hack") I found helpful ... specifically =
to
> > help let _serial_ consoles be more useful.  As a rule, RS-232 lines will
> > get shut down right before the most interesting point in the system
> > suspend process, so that the debug messages I'm most interested in seei=
ng
> > will then be thrown into the bitbucket (especially when resume breaks).=
=20
> > But this *cough* elegant patch lets you toss that bitbucket into itself.
> >
> > Although I must say I like Nigel's "BDI-2000 per developer" hack better.
> > Even though not all boxes can hook up to a JTAG module.  :(
>
> I guess I missed something, where is BDI-2000/developer hack?

"One BDI-2000 per developer" is the hack :)

Regards,

Nigel

=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart3557865.04NUhSrfqx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEj+/oN0y+n1M3mo0RAihjAJ9Pe6tlHvGjr0niyKC2KrRk4AJBDwCeMQFE
qosKfJ7fHgIFT1ggBWN/WJk=
=/dzb
-----END PGP SIGNATURE-----

--nextPart3557865.04NUhSrfqx--

--===============1260243348==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1260243348==--
