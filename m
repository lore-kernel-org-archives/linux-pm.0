From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] freezer: Fix typo in commnent to function
 freezable_schedule_timeout()
Date: Sat, 4 Nov 2017 23:02:56 +0100
Message-ID: <20171104220256.GA7012@amd>
References: <1509832652-1552-1-git-send-email-himanshujha199640@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55680 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdKDWC7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2017 18:02:59 -0400
Content-Disposition: inline
In-Reply-To: <1509832652-1552-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2017-11-05 03:27:32, Himanshu Jha wrote:
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

ACK.

But note you have typo in the subject ;-).

Plus this kind of bug is usually called thinko.
								Pavel


> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index 3995df1..21f5aa0 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -182,7 +182,7 @@ static inline void freezable_schedule_unsafe(void)
>  }
> =20
>  /*
> - * Like freezable_schedule_timeout(), but should not block the freezer. =
 Do not
> + * Like schedule_timeout(), but should not block the freezer.  Do not
>   * call this with locks held.
>   */
>  static inline long freezable_schedule_timeout(long timeout)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAln+ORAACgkQMOfwapXb+vKvTgCgnlsEradG5rBaREtOT6PxbfcU
9tkAn003AfPUArFEeJ0M0xXGC+cOWiHx
=ks8D
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
