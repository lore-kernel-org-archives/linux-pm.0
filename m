From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Thu, 12 Apr 2007 12:47:27 +0200
Message-ID: <1176374847.7052.47.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176306867.19348.4.camel@johannes.berg> <461D494D.3080808@gmail.com>
	<1176367352.5764.2.camel@localhost.localdomain>
	<20070412101653.GB26473@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1629610333=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070412101653.GB26473@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1629610333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yHmZETDiZ0IzoHWDeS5k"


--=-yHmZETDiZ0IzoHWDeS5k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 12:16 +0200, Pavel Machek wrote:

> Adding platform hook to disable interrupts just because we need one
> platform device last is not nice, either. (And does decrementer even
> need to come last?)

But the hack is classifying the decrementer as a platform device in the
first place. And then we'd still need to have one platform device and
one sysdev since we want to wake up the decrementer before enabling IRQs
but set it to a high value before disabling IRQs. Or we'd need some sort
of special foo device that has hooks both before and after and comes
last/first, just for one user?

Besides, we can always rewrite it later when somebody introduces a foo
device that fits above model. Since this patch essentially changes
nothing, I'd been hoping to get it into .22 so we can finally start
having a sane userspace interface for suspend on powermac. I can dream,
right?

Besides, disabling IRQs really seems like a platform issue and as such
pm_ops should be able to control it. Why are you so much opposed to that
idea? Would a patch that says

  Introduce pm_ops.quiesce and pm_ops.activate to make platforms
  control IRQ disabling and enabling (respectively).

and doesn't mention powermac be more acceptable?

johannes

--=-yHmZETDiZ0IzoHWDeS5k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGHg4//ETPhpq3jKURAqnIAKC30wRkYljHdsVyiXMGp+kkN/yvhACfZiu9
Sn+qOjdzq9Xw80hQlXUp8Ww=
=yW8T
-----END PGP SIGNATURE-----

--=-yHmZETDiZ0IzoHWDeS5k--


--===============1629610333==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1629610333==--
