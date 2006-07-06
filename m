From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 6 Jul 2006 17:15:30 +1000
Message-ID: <200607061715.38499.ncunningham@linuxmail.org>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<20060706011510.GC5303@elf.ucw.cz>
	<200607061152.08755.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0824894308=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607061152.08755.ncunningham@linuxmail.org>
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

--===============0824894308==
Content-Type: multipart/signed; boundary="nextPart16701156.HmQQAHb1MZ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart16701156.HmQQAHb1MZ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 06 July 2006 11:52, Nigel Cunningham wrote:
> Hi.
>
> On Thursday 06 July 2006 11:15, Pavel Machek wrote:
> > I have seen that before: Atomic snapshot used fpu copy in some wrong
> > variants. Symptom was exactly that -- elevated preempt count --
> > because fpu copy routine elevated it, then copied the task struct.
> >
> > But I thought we solved that problem...?
>
> We did. We don't use memcpy for precisely that reason. 3DNOW memcpy was o=
ne
> of the problem children. This would be a different creature though,
> wouldn't it?

Hmm. Aparently we had a parting of ways on this at some point. Memcpy is be=
ing=20
used by swsusp, and it has been used since before 2.6.12-rc1. (This is when=
=20
doing the atomic copy, not resuming).

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart16701156.HmQQAHb1MZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErLiaN0y+n1M3mo0RAgKuAJ9pI04fdQS7pjL2SJE1flZs7mDeoQCfXOVw
sTigIPN4xlLn/EkZA4AAFts=
=4tPm
-----END PGP SIGNATURE-----

--nextPart16701156.HmQQAHb1MZ--

--===============0824894308==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0824894308==--
