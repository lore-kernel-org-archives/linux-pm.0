From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH_2/2=5D_Fix_console_handling_du?=
	=?iso-8859-1?q?ring=09suspend/resume?=
Date: Fri, 16 Jun 2006 12:53:08 +1000
Message-ID: <200606161253.14627.ncunningham@linuxmail.org>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
	<1150421516.7725.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0685873670=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150421516.7725.88.camel@localhost.localdomain>
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

--===============0685873670==
Content-Type: multipart/signed; boundary="nextPart2300311.TmgbEm0Mb3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2300311.TmgbEm0Mb3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 16 June 2006 11:31, Benjamin Herrenschmidt wrote:
> > Why are people being dense and stupid? I told you in the very first
> > explanation that the IO state isn't suspended by "save_state()".
> >
> > "save_state()" would not disable the device. It would not disable the
> > queues. The device would remain usable, and 100% functional.
>
> But what is the point ? What is the relevance of a state saved if it can
> be made invalid right away by processing of IOs ? I can save state at
> any time and suspend 2 hours later, how relevant that state is ? Why not
> save the state at boot and re-use it later ? Doesn't make sense to me :)

That would be right for some drivers, but not for all (scsi request ids, eg=
).=20
The knowledge of what to do needs to be in the driver.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart2300311.TmgbEm0Mb3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkh0aN0y+n1M3mo0RAnhFAJwIJK38Sw+Cgf+vI+6ztefR600jigCfR61W
GaoJS762u7zYXkBcYT/etlI=
=acHo
-----END PGP SIGNATURE-----

--nextPart2300311.TmgbEm0Mb3--

--===============0685873670==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0685873670==--
