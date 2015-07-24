From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/8] power: bq27x00_battery: Checkpatch fixes
Date: Fri, 24 Jul 2015 17:37:30 +0200
Message-ID: <20150724153730.GN27569@earth>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
 <1437601920-13045-5-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="muT+E17Lr9urPYYJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37988 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497AbbGXPhh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 11:37:37 -0400
Content-Disposition: inline
In-Reply-To: <1437601920-13045-5-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--muT+E17Lr9urPYYJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jul 22, 2015 at 04:51:56PM -0500, Andrew F. Davis wrote:
> Remove space before tab.
> Remove unnecessary line continuations.
> Add braces to else statement.
> Remove unnecessary parentheses.
> Remove unneeded blank lines.
> Remove unnecessary 'out of memory' message.
> Add missing line after declarations.
> Change use of printk to pr_err.

Thanks, queued.

-- Sebastian

--muT+E17Lr9urPYYJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVslu5AAoJENju1/PIO/qaW5gP/2fY3D32h6460TuK+7GOng/0
Sf9BDBbZRkROWrOX8EOp5oBx92xhRXkXlq+TIxJ1sbrZ9WMWPJ13ikY+2io5mNLg
+yxsiU10gqjtc27N2iDBB1NSHdbjCmk9H11pSQYq0MZr4VBHO+5OtnCCOhdYCSwn
/eiEDW+4/DMjeEeLxZHUXMuh5aKxJnrol5Ek5clt8Uc37NvrHilw1HAsk3EGtHhq
X/kf2tyTvhk7n8lvHHFuRfsVMtoWuTnuApp8ZAjxzCSWAJmgDrIGGbRY/G+Y1XPG
jvwDBcOtKuq4zLNF7IQ/qLpcsHMniWg2bjRVN8IXzijW4Cr6UtOqfxhpEibAE6+s
ZiD5Si5ER6+0pWijnV8MtIorNtXDm7Q/QOjDyTxxNQ9FlVts8sJZIOXWlUQDJbkE
exi6hVpKT7SKRXTC3k1fkFCxX3Hl9/+QtKgJTxYcPxai0YjS6U1LaEmincq21O8H
E533QsRwKQ14xNxz7ZIehIbZMoHHx9+IlRvs3ggvAONA2idcjpS5g9tMxf+O7NMU
47qvvgDXWi1dPYOz0xTvc/POA4mQT6CSGrW4BsF4paN7vlHmVxBr8OLe5WGNYumV
vZ49GVsfQYU9rNNaSR3Ye52wQSRkar78PEOekwmAPINFjxem+/kcweWriNTk8G/U
I2NTYC8xlpdbjzJsf3t+
=zQqi
-----END PGP SIGNATURE-----

--muT+E17Lr9urPYYJ--
