From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/9] power/reset: brcmstb: Use the DT "compatible" string
 to indicate bit positions
Date: Thu, 22 Jan 2015 02:46:58 +0100
Message-ID: <20150122014657.GN13715@earth.universe>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
 <1416962994-27095-3-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zl+NncWK+U5aSfTo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47373 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057AbbAVBrI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 Jan 2015 20:47:08 -0500
Content-Disposition: inline
In-Reply-To: <1416962994-27095-3-git-send-email-cernekee@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, f.fainelli@gmail.com, grant.likely@linaro.org, robh+dt@kernel.org, computersforpeace@gmail.com, marc.ceeeee@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mips@linux-mips.org


--Zl+NncWK+U5aSfTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Nov 25, 2014 at 04:49:47PM -0800, Kevin Cernekee wrote:
> Some of the older chips used different bits to arm and trigger the reset.
> Add the infrastructure needed to specify this through the "compatible"
> string.

Thanks, applied.

-- Sebastian

--Zl+NncWK+U5aSfTo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwFaRAAoJENju1/PIO/qaLt8P/0Q5i/OKkKBdYs15ALcT6k/y
RKc5nl/s7PiQbGf0ZvjzTzRbDu0enXgiRECQbHDhJ+HRbOzoT3d9XqQ82PcH2mHL
TOo1Aaa7hMhj6ekkNbMei8RvfJ3QeMzYqUm7LLXOWsZgUMUaekjGQO8t48nMjk3A
mKJ7RsrTNgGGVJVPDBKfoOVlcTvY6bacYo+a8ioVLUv5Zp4kI5VZNPiS79bxkkN+
gifIK4YF3kCSJI/1DWKzDzGs9QWh4BhAN0oDEsvTKfmGOBEY567ZWOv8euJcdvtu
7Vv5MFOklf6wAxJiEaQ17n4veVlzoc8CLtSHvdJnoqnbB2+bXIsSxT2q/PaGhJY7
Tdz3bNI79J4Bp1EwbpC/NjzJlpYyF8poP7jUpJ84WChAvwWZhP238Kg3VmV+OZkO
iuqrnYvRDPZmqyiZoce97DhPw/ukG2fJHGtxLvZi/FT/TX0ISLvbuOiV9omXfNLh
5CD1WlB60Xco4rPNF7/Ng63NlCy5NCcup0FD1S3Bangw3yuIZsD4C8WoHSxsigwv
lZMWQ8ajlwa2OgT0PUpCjawu6NWIvHrF4VmjlMOTUC7uhROfCzdXhqMUoU4BQ8xK
bv7scdzIJINa5cgGivTB4i+698Jv78NGJiWDrjl2EtV7DQFSSC50Pd4EY6gX6bJI
IWFWAmCkeruZpjHLfmx5
=MOzI
-----END PGP SIGNATURE-----

--Zl+NncWK+U5aSfTo--
