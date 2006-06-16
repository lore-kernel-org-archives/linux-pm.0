From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 13:36:34 +1000
Message-ID: <200606161336.38370.ncunningham@linuxmail.org>
References: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<200606161250.05076.ncunningham@linuxmail.org>
	<Pine.LNX.4.64.0606152017240.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1967241271=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606152017240.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============1967241271==
Content-Type: multipart/signed; boundary="nextPart2265068.yTTynu0N4i";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2265068.yTTynu0N4i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 16 June 2006 13:22, Linus Torvalds wrote:
> On Fri, 16 Jun 2006, Nigel Cunningham wrote:
> > > You don't _need_ to save a consistent system image. There's no "single
> > > snapshot in time" needed.
> >
> > Yes, you do. If you save an image that has, say, pages in the lru that
> > are also in the free lists or a similar situation with driver data,
> > you're going to get an oops some time after resume at best, and possibly
> > ruin your filesystem at worst.
>
> Absolutely. I've acknowledged this several times. But that's not a "device
> state" thing, that's a MM state thing.
>
> I 100% agree that we must have a consistent image of free memory after
> resume. That's not in question at all. What I dispute is that this is
> "device state" and has anything to do with suspending devices..

Ok.

> The fact that this only affects STD and not STR should make people realize
> that it's not a "device" issue. STR suspends/resumes devices too, so if
> STR doesn't have that issue, then clearly it's not actually tied to the
> notion of device suspend/resume per se.

It seems me that STR has an advantage because for most devices, S3 !=3D pow=
er=20
off. Where S3 does involve powering off (some video cards, especially), the=
=20
problem does become the same as for suspend to disk. This makes me fail to=
=20
see your logic. Perhaps I'm being muddle headed, or we're again saying the=
=20
same thing in different ways, but if you need to do different things for=20
different hardware depending on what the hardware does when you enter S3 (o=
r=20
S5), then isn't it by nature a device/driver issue?

> It's really not at all different from _any_ memory allocation after the
> start of writing the image to memory, is it?

In this area, I agree.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart2265068.yTTynu0N4i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkidGN0y+n1M3mo0RAkmgAKDGHoH+NJoRYh/ly5Iaisr6bzbR7QCfQp5M
aVkxMOdqjptzcBSKGMbM5sI=
=O9Yg
-----END PGP SIGNATURE-----

--nextPart2265068.yTTynu0N4i--

--===============1967241271==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1967241271==--
