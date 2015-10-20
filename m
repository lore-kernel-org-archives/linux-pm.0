From: Sebastian Reichel <sre@kernel.org>
Subject: Re: where in sysfs should I put the ability to power down a board
 for a specific time?
Date: Tue, 20 Oct 2015 23:21:27 +0200
Message-ID: <20151020212127.GA25882@earth>
References: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47421 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbbJTVVe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Oct 2015 17:21:34 -0400
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-pm@vger.kernel.org, rtc-linux@googlegroups.com


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 20, 2015 at 08:12:09AM -0700, Tim Harvey wrote:
> There is a system controller [1] on a set of embedded boards I support
> that allows disabling the board's primary power supply. It can disable
> it (until a physical pushbutton event occurs) and/or disable it for a
> certain number of seconds (up to 2^16 seconds).
>=20
> I've been in the process of writing a mfd driver to fully support this
> device and I'm a bit stumped on how to handle the power management
> capabilities.
>=20
> What is the correct API for this type of device in sysfs? I'm thinking
> it needs a power-supply class driver, but after looking over the docs
> and code I'm not seeing examples of similar devices. Can anyone point
> me to an example or provide some suggestions?

Usually this is an RTC feature exposed as wakealarm. See for example
this article for the description of the userspace interface:

https://www.linux.com/learn/docs/672849-wake-up-linux-with-an-rtc-alarm-clo=
ck

-- Sebastian

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWJrBRAAoJENju1/PIO/qaCCYP/RoUJbjBTOvL+Rl9oWLlC6w+
IWgLIDpt11+aYaCZN1jKG7nWBn5h9G6E+FLgYbJ4+qojjcMD0BMqFPaKqFHVYG0R
YUqjF/dQdbi9GCF6iFQ8Yk8/oXGI8GbCsSzqBOyowRhbWuXPNc27veK6X2ANzcf3
FQgmxYhnECFc5dp9qwW79prwtO1VWTNbAyiyXTwGJXnWtPTwUGfOSTky5UddK0yJ
3UubV3qwp61Y7etibb5BNJsHKZJq5ilyFC46NZirs3IP6aYouDwfOQJAJmiN48+z
LfYJlzJ9Xcr+CbehQHPC962W775QEOeM2TxoqdmQ2bdOtZ4FPSu6TFhlmzyd5cYw
mRjtF3D4g5YpS365luxWAHwYYlFywBdrOvo6WVum73GLnSRToG3JLAKrqw9XWrrt
RsiQW5AYos/ayjehbplPsxt7GGWq7y0plBdrh3uj7POi6j3xtkUEvsegNETlg0mJ
xHtrjEh2b++Asg7+j5Zoa5IfRC7zoi9GuKb333Cl2P8aDvjg5m4WcKRb+HU1RFFn
iswqVIdJqreaRpbAE5ze+3LDCCOpElX5jKwphQ67fO25svAyjIcHZz0+7gXrg8Ij
4w5OLlqjpm1fRUApwLBRgh/R2Fr7Ycn9f1f+4lsLwuUiufCEWG9dAkQaIDgDTq+W
SJOowHmJCuk2ooXtOnki
=WJ26
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
