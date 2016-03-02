From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V6 00/10] Add generic PM domain support for Tegra
Date: Wed, 2 Mar 2016 16:35:56 +0100
Message-ID: <20160302153556.GB21035@ulmo.nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36328 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbcCBPgD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 10:36:03 -0500
Content-Disposition: inline
In-Reply-To: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 03:48:34PM +0000, Jon Hunter wrote:
> Adds generic PM domain support for Tegra SoCs but this series only
> enables support for it on Tegra 64-bit devices. There is no reason why
> this cannot be enable for Tegra 32-bit devices, but to keep the patch
> series to a minimum only 64-bit devices are enabled so far.
>=20
> This series has been boot tested on Tegra210 as well as various 32-bit
> Tegra platforms.
>=20
> Summary of changes since V5 [2]:
> - Split series into 2 series, separating PMC fixes [3] from genpd changes
> - This series is based upon fixes series (which is now in -next)
> - Added patch to fix removal of genpd subdomain
> - Added patch to get last genpd that was added
> - Fixed locking in function to remove genpd
> - Updated Tegra PMC driver to ensure power-domains cannot be controlled
>   by both legacy Tegra APIs and generic PM domain framework
> - Removed powergate list from Tegra PMC driver and updated removal of
>   power domains to use new genpd APIs.
>=20
> Summary of changes since V4 [1]:
> - Re-worked fix to handle base address on probe failure
> - Added patch to lock around simultaneuous accesses to PMC registers
> - Added patch to change powergate and rail IDs to unsigned type
> - Added patch to fix testing of powergate state
> - Updated patch to check for valid powergates to use a bitmap
> - Updated Tegra DT PMC bindings per Rob H's feedback
> - Updated Tegra power domains binding per Thierry's feedback
> - Updated Tegra generic power domain support per Thierry's feedback
>=20
> Summary of changes since V3 [0]:
> - Dropped tegra124 support for now
> - Removed MC flush support per feedback from Thierry
> - Cleaned up the PMC changes per feedback from Thierry
> - Added support for tegra210
>=20
> [0] http://comments.gmane.org/gmane.linux.ports.tegra/22944
> [1] http://marc.info/?l=3Dlinux-tegra&m=3D144924153600529&w=3D2
> [2] http://marc.info/?l=3Dlinux-tegra&m=3D145399885003830&w=3D2
> [3] http://marc.info/?l=3Dlinux-tegra&m=3D145521381331144&w=3D2
>=20
> Jon Hunter (10):
>   PM / Domains: Fix removal of a subdomain
>   PM / Domains: Add function to get the last domain added
>   PM / Domains: Add function to remove a pm-domain

Ulf, Kevin, Rafael,

It's too late to take these patches through the Tegra tree for v4.6, but
if Jon can get the above three patches ready before the merge window,
would you be willing to pick them up into your trees for v4.6? Doing so
might make it easier to deal with the dependencies. The prerequisites
would already be in Linus' tree when I apply the Tegra bits for v4.7.

I don't mind taking all of it through the Tegra tree for v4.7, though. I
can provide a stable branch with the PM / Domains patches for you to
pull in, in case there are any conflicts.

Thierry

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW1whaAAoJEN0jrNd/PrOh5CYP/3mV/pjBqUJXxbPSXsJltGy6
VbbpGS3qvLr0swfTBOJ9vpqistchZayQBJUSlE0DOcIaeqGb9BHRjejJRi01qPz3
+/XZ98V8FkLX3+zN1J21Zdpt1Bg+X+/4+qbezt703tc9TaMsypeTOfqUqUFLEc7R
y+bmwyLUAxQquy0XIBZhYX1c6rtw7f/tKVdZNSEGpSPdB6YxkCQUgzf41PHbVpan
0Z5EBCBm4GNwe8pDhqcidaM/rQ3vxhg367GIWy9EegBb55W4zoHk5YGC3zq1Cl1U
Ua5WikeDLh2dSo5c9NvOPA2Gq9mp9zZ6zG9glubf6etaW/0BtlExXd2RP+hV4KZ3
lWpEBag6a3BXMp5z3qGnvCe9eXGBXgXagQnqfn3fXxuvhrZrLYUbFUq8sabVQnLW
yENxugB5nsvInj3SeDsg07iUqfKk49ClR1CMTS3UubusZSC/VxOm49opgpZ6MAJ9
Cb+Lwd3RVaupc23Szmr26XlipivSJt+DdIJuFkm9DzNedaCmqZQl5SIP5xxPcEaK
L5coVaejYQNZKPFxWzwsnqYxfmcWVd7SQdptxCln9wBSuYbj4oMM2vk9FxUoZMkG
HwT5HF5eiDMuHrmMP1Xv2AF6kAnqxVMRgrpTQBmr8KW3wDFQm0X6KPezv8oexk21
Q9RAPqqIyyd9TAmljNih
=LrDH
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
