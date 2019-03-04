From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH resend] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date: Mon, 04 Mar 2019 15:58:31 -0800
Message-ID: <8736o2qjiw.fsf@anholt.net>
References: <1548755757-79270-1-git-send-email-phil@raspberrypi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548755757-79270-1-git-send-email-phil@raspberrypi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Elwell <phil@raspberrypi.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <stefan.wahren@i2se.com>, Geert Uytterhoeven <geert+renesas@glider.be>Phil Elwell <phil@raspberrypi.org>, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Phil Elwell <phil@raspberrypi.org> writes:

> "cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
> dereference in bcm2835_thermal_debugfs. The driver makes use of the
> implementation details of the thermal framework to retrieve a pointer
> to its private data from a struct thermal_zone_device, and gets it
> wrong - leading to the crash. Instead, store its private data as the
> drvdata and retrieve the thermal_zone_device pointer from it.
>
> Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 So=
C")
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Acked-by: Eric Anholt <eric@anholt.net>

From=20the thread that missed Ccing the maintainers there was also:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlx9u6cACgkQtdYpNtH8
nuhpSQ//feRJqNfXmXK1TTSvE4FlARA8oPQVS+whGt9s9uTUiFn9jKwfstx2krTr
vEeod0LslKwR6bzPDkdti93SOf7WtGCIYl6olQtfkSMW7JxFPCwpTsZMqWxxde4L
29iiTJiKWsraGTiSQeudfJfARCi69+s0PdVIIQxeoENwOCOXoARcotFvIJNMp+i/
JH5iJLgch5lADC1naf4mz21WQnY6OsfiIgt+tLe0xHzfdLINhSLaQFHQneSvjZE/
EW0zwZ6ZNMa93IUN3lGXDFx5c/9q9CCdC+Gv4bY9oUxu06rOydPwrC5ZXF9VQtap
4uAO9OzQaDitWZNZKhEBlr2fJsFrg1xIRDam/0sTosGiX+V65ZiO6KLCcXR8qbng
UuQQnsFCuudL4BioiGNWB+dUZ1UuWOw6SYTfbVwc+bmYZ2E5G+BuObBkQM3nYcVX
aY6SKJabbIVZGJQ+0s+zIYm+3qG00u1WFWJcvTUTTaBn3q0DN3O873QZHWMNzKQE
VOmCiRobHCq/SQ0oMWBkqHG5isdsrsXJ1X7vIxS3u80ttM7Qupah2x6raneE+A8M
GES7uBtz67L4m6juya5GCdglR75vch9J0XwAVgbmh5Uf/KiINy56RYRn1pzgWHw+
Rb3nB02b4u5NUIxBfmS5Qo50Hu644kQXKX/x3Dl8QMUf3XoWJ20=
=BorT
-----END PGP SIGNATURE-----
--=-=-=--
