From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/8] power: Add devm_power_supply_get_by_phandle() helper
 function
Date: Wed, 10 Jun 2015 16:49:02 +0200
Message-ID: <20150610144902.GD11618@earth>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-4-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52905 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278AbbFJOtH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Jun 2015 10:49:07 -0400
Content-Disposition: inline
In-Reply-To: <1433885881-19809-4-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Jun 09, 2015 at 11:37:56PM +0200, Hans de Goede wrote:
> This commit adds a resource-managed version of the
> power_supply_get_by_phandle() function.

Thanks, queued.

-- Sebastian

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVeE5eAAoJENju1/PIO/qahjQQAI2sxsXDey13qkHTP95/hX9w
B7ug/FWXbVSIjwFSsSVcFSQDMyvsjT2OBOyxm4YoTaN76cHj9ZZDpKIzm6qKtxur
z+Pb9tME+ExqjcKUsiH8zGs/de9eg1UMUHXSsFn8/GoYRMppzCYrkljkad0RvXtQ
J3SxYZmjP4LgpStRm1kmnY0dd08KSgberO6yNgtQ30qExGF2salShZswhPsPQmZF
jwzvlDWp265ksmyYdo3S4zX/GistcZHnkfRpBaRgLRtGhgO9YqI9jgM2CfQhEc2w
gcc1f/DbIKM8Af37P6k0fzJ46+ZSCzD7nqEVDKQz4AjADZaGxSkcN7PtX8hy4m/V
eH9x7csCtWlAQkVtHSKwOZZC0YCDX7KF0mjjUqVnvtvQ/Rf2ATaDfvGtzIPO7hTB
Nop9RbK77nMNQn1gx3w/Y+hHlPXt3pIKvfkJnlX36tvVYnYxJ7Nl7CtQvbpBfkqR
d7Hw0xcfRAp3tzAKcpPJ52mGO5IvCJ1XNKHybNuiqJweJbILWrQi67m+ahfvlCG1
JgVJJDe0uyEltO9wYKstg+sLAZvwE1+I4zam0jZ6PCX2vBnai7mmeV1upmq62mDX
Zt0fi3Vn3RpIoKCq7GCx5oM4yLBdp+wxNpHcbVKyzMz+APDA2WUCoe4aWEdWlC6B
jzlV6Gtg3YS9QpveRn86
=LU5i
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
