From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq27xxx_battery: Add I2C module check dependency
 in Kconfig
Date: Tue, 10 Nov 2015 04:50:02 +0100
Message-ID: <20151110035002.GB2712@earth>
References: <1447104183-13556-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59376 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125AbbKJDuG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 22:50:06 -0500
Content-Disposition: inline
In-Reply-To: <1447104183-13556-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Pali Rohar <pali.rohar@gmail.com>, Xiong Zhou <jencce.kernel@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 09, 2015 at 03:23:03PM -0600, Andrew F. Davis wrote:
> Check if I2C core has been built as a module when BATTERY_BQ27XXX
> is built-in. If so disable I2C functionality.
>=20
> Fixes: 6bd03ce3c12a ("power: bq27xxx_battery: Remove unneeded dependency =
in Kconfig")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Thanks, queued.

-- Sebastian

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWQWlnAAoJENju1/PIO/qao1oP+gKOKjch1kEcSW/T+/waLEER
7Fd47X/miI2+gDWAuu6aD1TMk10guKYwDzHrOYNqlM3+KIdS7j6vox3exNuvLzho
GrXc4+dp8l/ejiyJfal/SCyJYu45QXJZUV7qWOIzXUCrJQnC/vXTEpS7M8XGSYZt
hS5xJpwi+WfdtNerhdGmh3Zj/ZMsAjDyOGTF9teJH/UD2AtXNzIA4bKh73huKJ8N
OwJo5h8SoMar9+q0E2D+B6gZcpI0l0Q8hzo+K9tKW0Hne752vwglDMDCswDtGIHw
89lW3xh0vG6XOqcbiRVqM6qTGBZ1e2vTuIvO687tKNclVaw9IkDt2WEwrcDRt+B9
ojmQyVZbVsdVjc8XUweuLu9fbsCobjiRiQRNY6F548UwbVTyqg7iC3JX0QTzmOOl
JLou/2XmcrZaDftr3IoBsEn88qR0uirhtjoXwKPyTQCJC8Z5uxlyo3wZ3qJGu/a9
AegKCUMtuMHd0EJNGF+GbjmTD7UudA1H+N4lgaU+3A9GHLJykJOeD4ZnAENYNASI
dZtkaANwDMmJYpR+TAwwv2Z9B9nTWqOaol1scqVUTmCKb6ZJavGJ9nrNR22yyild
N0ypHWCgpXCtsI/1C1qIXK2NqDUwrNDOsi9dvT1jh7K/HX326SdOPZMB6WuQYFIO
LS7Y+hp74No94X6G3A1J
=jjdh
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
