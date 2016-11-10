From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC v7] timekeeping: Ignore the bogus sleep time if
 pm_trace is enabled
Date: Thu, 10 Nov 2016 17:32:25 +0100
Message-ID: <20161110163225.GB28832@amd>
References: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56220 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934621AbcKJQc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 11:32:28 -0500
Content-Disposition: inline
In-Reply-To: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2016-11-10 12:55:53, Chen Yu wrote:
> Previously we encountered some memory overflow issues due to
> the bogus sleep time brought by inconsistent rtc, which is
> triggered when pm_trace is enabled, and we have fixed it
> in recent kernel. However it's improper in the first place
> to call __timekeeping_inject_sleeptime() in case that pm_trace
> is enabled simply because that "hash" time value will wreckage
> the timekeeping subsystem.
>=20
> This patch is originally written by Thomas, which would bypass
> the bogus rtc interval when pm_trace is enabled.
> Meanwhile, if system succeed to resume back with pm_trace set, the
> users are warned to adjust the bogus rtc either by ntp-date or rdate,
> by resetting pm_trace_rtc_abused to false, otherwise above tools might
> not work as expected.
>=20
> Originally-from: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Xunlei Pang <xlpang@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgkoRkACgkQMOfwapXb+vInGwCeO/tO7n3b6h8UqrwbTEfHFJao
ffMAoKKMmCqR94o6UdIZCOUM3/97FfGu
=m3m3
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
