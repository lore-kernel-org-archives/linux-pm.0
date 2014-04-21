From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] kernel/power/hibernate.c: be sure of 'start' is not
 bigger than 'stop'
Date: Mon, 21 Apr 2014 22:09:30 +0200
Message-ID: <20140421200930.GA9880@amd.pavel.ucw.cz>
References: <53551FCB.3030109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38398 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaDUUJc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Apr 2014 16:09:32 -0400
Content-Disposition: inline
In-Reply-To: <53551FCB.3030109@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, len.brown@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon 2014-04-21 21:40:27, Chen Gang wrote:
> For do_div(), it need 'u64' type, which means the outside must be sur=
e
> of 'start' is not bigger than 'stop', or it will report warning.
>=20
> The related warning (with allmodconfig for unicore32):
>=20
>     CC      kernel/power/hibernate.o
>   kernel/power/hibernate.c: In function =E2=80=98swsusp_show_speed=E2=
=80=99:
>   kernel/power/hibernate.c:237: warning: comparison of distinct point=
er types lacks a cast
>=20
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>

>  {
> -	s64 elapsed_centisecs64;
> +	u64 elapsed_centisecs64;
>  	int centisecs;
>  	int k;
>  	int kps;
> =20
>  	elapsed_centisecs64 =3D timeval_to_ns(stop) - timeval_to_ns(start);
> +	if ((s64)elapsed_centisecs64 < 0) {
> +		printk(KERN_ERR "PM: stop: %llu < start %llu\n",
> +			timeval_to_ns(stop), timeval_to_ns(start));
> +		return;
> +	}
>  	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
>  	centisecs =3D elapsed_centisecs64;
>  	if (centisecs =3D=3D 0)

Quite a lot of code to shut up warning in mostly debugging
function... is there alternative method of shutting it up? Have you
seen < 0 values in wild? Is it worth handing that situation?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
