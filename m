From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 16/16] MAINTAINERS: Add AXP288 PMIC entry
Date: Tue, 9 Jan 2018 17:53:59 +0100
Message-ID: <20180109165359.vz73iwrgdbrqinbr@earth.universe>
References: <20171226125914.10235-1-hdegoede@redhat.com>
 <20171226125914.10235-16-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ivqul4p3sfd4wx3w"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934494AbeAIQyC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jan 2018 11:54:02 -0500
Content-Disposition: inline
In-Reply-To: <20171226125914.10235-16-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org


--ivqul4p3sfd4wx3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 26, 2017 at 01:59:14PM +0100, Hans de Goede wrote:
> Add an entry for the AXP288 PMIC drivers with myself as maintainer.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, I queued the series.

-- Sebastian

>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0749864ee655..95e99695f919 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14857,6 +14857,12 @@ F:	include/linux/workqueue.h
>  F:	kernel/workqueue.c
>  F:	Documentation/core-api/workqueue.rst
> =20
> +X-POWERS AXP288 PMIC DRIVERS
> +M:	Hans de Goede <hdegoede@redhat.com>
> +S:	Maintained
> +N:	axp288
> +F:	drivers/acpi/pmic/intel_pmic_xpower.c
> +
>  X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS
>  M:	Chen-Yu Tsai <wens@csie.org>
>  L:	linux-kernel@vger.kernel.org
> --=20
> 2.14.3
>=20

--ivqul4p3sfd4wx3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpU86AACgkQ2O7X88g7
+pqwgQ//dsmG4grFjq9G+NAIzPN0/193qVgFzLlNrbZU9ieZ+f520pqcKh8LkhXv
Ss4lAUWq0JfSUx8nn/Y4N855a4NQG0bKF3+qqQC3TEkbmR3IXTetpGPBoYPKrmM5
2Ed7C+gzxPg05y781y6ihKdp6bWgRQi9s60Qn2s0IADX1aUTNZpbRyBmYT4ODwHh
TAVD4RIT3ATEZb2iUS9cHcpGwhL3ycmTCJa+yLKOMPCLnLlXfHhNH+xDCAVAzWIj
PYGAiPNW49yiVInCux/8Jmw/ov0TqJ+7VahprtV0l/D6Hz9gvkt/Xv/OGf7WW1b/
Wb2Sh9odTIAcMW8x+4o/XAVDtfOPeeaxsgc6ADFpjVdTu+xduT5CTaaZh6QWWxOG
C8+wPDilD8c6wxKpMLrnEWMUAhEbFfGqrrz7Vg94G7qhv1+dJUUu2jVa7vhQBgnh
A7uBzsymjdKViSjUdKzlqYTezpmGzqUyJrE8VdFQcWHmOlCmNvydsIkoh4YIdayp
6539VdPo50YcIxA4LNLuPF/6YM/MMKGuZtmCMf0nKzq4OHu1oULH6quYBe/02NJr
8rWNdy+5YpaSr5jpMzsCIHRVJSfLcgmyxPYbU6mGB25eUY2NzgWHvCNXWFCp7N0u
iBTrS/a4RVMfwDC7V4MCwZUGfZsXFKWOwN18KoJDGInqV7SQHSk=
=MUaM
-----END PGP SIGNATURE-----

--ivqul4p3sfd4wx3w--
