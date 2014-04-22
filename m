From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] kernel/power/hibernate.c: use 'u64' instead of
 's64' to avoid warning
Date: Tue, 22 Apr 2014 09:21:12 +0200
Message-ID: <20140422072112.GB14108@amd.pavel.ucw.cz>
References: <5355C5F0.6020606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52432 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaDVHVP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 03:21:15 -0400
Content-Disposition: inline
In-Reply-To: <5355C5F0.6020606@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, len.brown@intel.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue 2014-04-22 09:29:20, Chen Gang wrote:
> For do_div(), it need 'u64' type, which means the outside must be sur=
e
> of 'start' is not bigger than 'stop', or it will report warning.
>=20
> Even if 'start' was really bigger than 'stop', it would print incorre=
ct
> information, but for kernel, it still can continue, so use WARN_ON() =
is
> enough.
>=20
> The related warning (with allmodconfig for unicore32):
>=20
>     CC      kernel/power/hibernate.o
>   kernel/power/hibernate.c: In function =E2=80=98swsusp_show_speed=E2=
=80=99:
>   kernel/power/hibernate.c:237: warning: comparison of distinct point=
er types lacks a cast
>=20
>=20

Certainly better, but

> -	s64 elapsed_centisecs64;
> +	u64 elapsed_centisecs64;
>  	int centisecs;
>  	int k;
>  	int kps;
> =20
>  	elapsed_centisecs64 =3D timeval_to_ns(stop) - timeval_to_ns(start);
> +	WARN_ON((s64)elapsed_centisecs64 < 0);
>  	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
>  	centisecs =3D elapsed_centisecs64;

=2E..do we need to do the WARN_ON()? Only result of underflow will be
very long elapsed time reported... that does not sound too
bad. ... and it will be quite obvious what went wrong.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
