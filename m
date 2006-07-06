From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 6 Jul 2006 11:52:05 +1000
Message-ID: <200607061152.08755.ncunningham@linuxmail.org>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607051603.29787.david-b@pacbell.net>
	<20060706011510.GC5303@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0856902745=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060706011510.GC5303@elf.ucw.cz>
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
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============0856902745==
Content-Type: multipart/signed; boundary="nextPart1657859.piBg41A7ZO";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1657859.piBg41A7ZO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 06 July 2006 11:15, Pavel Machek wrote:
> I have seen that before: Atomic snapshot used fpu copy in some wrong
> variants. Symptom was exactly that -- elevated preempt count --
> because fpu copy routine elevated it, then copied the task struct.
>
> But I thought we solved that problem...?

We did. We don't use memcpy for precisely that reason. 3DNOW memcpy was one=
 of=20
the problem children. This would be a different creature though, wouldn't i=
t?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1657859.piBg41A7ZO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErGzIN0y+n1M3mo0RAnypAJ9k1+5SyP6Us853od6bEyr7N+HV1wCeOFn+
FYto4ZgqG7YjhOY9p9XcSGY=
=cUEG
-----END PGP SIGNATURE-----

--nextPart1657859.piBg41A7ZO--

--===============0856902745==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0856902745==--
