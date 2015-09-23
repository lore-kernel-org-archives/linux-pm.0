From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 0/6] Add support for additional bq27xxx devices
Date: Wed, 23 Sep 2015 18:42:18 +0200
Message-ID: <20150923164217.GA27606@earth>
References: <1442950511-16122-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442950511-16122-1-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,

On Tue, Sep 22, 2015 at 02:35:05PM -0500, Andrew F. Davis wrote:
> This series adds support for several additional bq27xxx devices and
> makes a few related fixes.

Thanks, I queued all remaining patches. I wonder if this driver
should be converted to regmap. It supports lots of chips now and
it might be useful to get register dumps from debugfs.

-- Sebastian

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAtZnAAoJENju1/PIO/qaEecP/iZe36hBdFBqbKXk+afpSaOV
94OJGPNawf0lnlJvWARwbgxjRjAe9wIp94oCDBxj7Cc3q1wuqB2KEcmVLniooOld
/pQ35J2cGOsP3XSAQrN5WKbafP+Ioqav+ibhElilDOjwIKKDpRtvktlb22lDXdD6
vmBe1d11YODnlNP0zdd+F43XhWx+4iCFnHwj+BJbZHVMS/DqqRB849vKfeKpzW1+
WgDoMg5v1FN+l1x73eYj1yBlwc2ShiPQikyj4pW9iY2/mojjgUSknRiKCE3YORRB
J37HQBTxWSLHN1t8GIZKNRmTKitf0p+C74YhidZ7RVLxNlshr3mLqEGiKQv9J9mF
IptN4oO5siEIDgDCIy6Gn7hXN7z601VqkYjHVH4X78CoLlu2hhEkF8+9cgVc7GcM
5MF78v4lmnsZ6NpWmjHd6SyVe7BAANlRB9b3uTYxSobgtt7+9iT3RdqvDdMHa4Eo
oNZ5b6xIecSsljj0c36I8Fab/4qzbBPv515accEhbwTam+ArlnjyvilTYT10GFTt
wmZWywxi0T52tbX/wW5W6A6daYHdfuqtvz4OlL74qwGR+5qsrVTlSTrrmiJkspjQ
VOuUrKS7mcfI335u+jdZ/CH+PYtkxSB15W+kdkMT1t2hikO+a4FvPmhz78v8Yjx3
EAk/rFciZ/0db+hKxq8I
=vyI4
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
