From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: Drop owner assignment from i2c_driver
Date: Mon, 13 Jul 2015 13:49:05 +0200
Message-ID: <20150713114904.GA9128@earth>
References: <1436506762-29166-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37659 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbbGMLtK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jul 2015 07:49:10 -0400
Content-Disposition: inline
In-Reply-To: <1436506762-29166-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jul 10, 2015 at 02:39:22PM +0900, Krzysztof Kozlowski wrote:
> i2c_driver does not need to set an owner because
> i2c_register_driver() will set it.

Thanks, queued.

-- Sebastian

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVo6WtAAoJENju1/PIO/qat6QP/1nAMp0Nl9MA+f/uveEgJeFk
fq5kSfxHZ1jJtEYUGpkAzz11oloICWR07jqQxr4SzNt+FgAMiT5drYOzeyXc8+17
LAXCIX2NkNuwtcigL8kxWhzSNAJLjnvfPsKh6UrzJBdTF+1KmIHwKrj77xS9IeDm
097ETN7v0oxmiDHVu/RENETgcjFwoF5eyAlefFZSJ/eWI0MEAwJV9AjCPc5T+3si
xZlNxBpFfhMc7IEsM8enbZxyNFe3cX/OrtWebv1VxssE5fl6srRw/RIQ0yjDpfj+
mhRCsyGkLtp7WrsW9wHqeHnNT0Ht6PkOXfFTIaYGWvM3BvIWL93USZGZsUUDviMY
Ctak0osyyGr8LPSipVvoNwyZpaBFzT7QSJQmwD2N//AcUJNyzIySGcEsIs4rWKMB
fdfQCeFjo/eXDjHpzHN3hXC9vtc9pQs/4k3DA8RPiGv/sPmaV0rRrTemo9VOTKr8
eAIS/ueHlFD2CbF57XuZfQ+AapumWjcQA9ASQYiyJSBPKvYivfXTd28HFSwnZQNw
R8pIU3H3Rz9jF4RGlATuXwBNfgpBMxV6lqyfUhGCcD9yDFEA6h26ioqyC4/8KEBZ
lKe7EctaavO4Y8vVUcp7xQy9gdBTlvagZ4mHrT2eVc6qbheN5kL+HUph7rIgUwXj
rDJNYyoVyB0vgNbcJ8/M
=uZEE
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
