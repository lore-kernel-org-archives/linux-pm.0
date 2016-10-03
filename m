From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] coredump: fix unfreezable coredumping task
Date: Mon, 3 Oct 2016 11:41:41 +0200
Message-ID: <20161003094141.GB9131@amd>
References: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50986 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbcJCJlp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Oct 2016 05:41:45 -0400
Content-Disposition: inline
In-Reply-To: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Oleg Nesterov <oleg@redhat.com>, linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2016-09-30 11:50:34, Andrey Ryabinin wrote:
> It could be not possible to freeze coredumping task when it waits
> for 'core_state->startup' completion, because threads are frozen
> in get_signal() before they got a chance to complete 'core_state->startup=
'.
>=20
> Use freezer_do_not_count() to tell freezer to ignore coredumping
> task while it waits for core_state->startup completion.
>=20
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: stable@vger.kernel.org

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlfyJ9UACgkQMOfwapXb+vLyJACgid8YNv4A2Ku2M20tEfF17B0x
b8oAoIl11GnYHnRm+XvEjWPnAYMCMlO5
=0LK7
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
