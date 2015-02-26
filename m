From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 5/7] thermal: add trace events to the power allocator
 governor
Date: Thu, 26 Feb 2015 17:18:25 -0400
Message-ID: <20150226211823.GA29288@developer.amazonguestwifi.org>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
 <1424977233-15965-6-git-send-email-javi.merino@arm.com>
 <20150226143845.67e00224@gandalf.local.home>
 <20150226194633.GC4941@developer.amazonguestwifi.org>
 <20150226175259.57d65960@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44770 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbbBZXd5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 18:33:57 -0500
Content-Disposition: inline
In-Reply-To: <20150226175259.57d65960@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Javi Merino <javi.merino@arm.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, broonie@kernel.org, tixy@linaro.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Steve,

On Thu, Feb 26, 2015 at 05:52:59PM -0500, Steven Rostedt wrote:
> On Thu, 26 Feb 2015 15:46:34 -0400
> Eduardo Valentin <edubezval@gmail.com> wrote:
>=20
> =20
> > I am planing to apply this series to my thermal soc tree. Do you have
> > any concerns if I send this patch, which touches the tracing files, via
> > my tree?
> >=20
>=20
> Which tracing files?

I am referring to:
include/trace/events/thermal.h                 | 58 +++++++++++++++++
include/trace/events/thermal_power_allocator.h | 87
++++++++++++++++++++++++++

I know they are new files anyway, but just checking if those can go
altogether via the thermal tree.

BR,

Eduardo Valentin

>=20
> -- Steve

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU741+AAoJEMLUO4d9pOJWqNAH/351w1VgKOD5zvoB4II4m2TX
bNltxAJA6B0VZZUIqbAQ2XQ+C8Of3uNU6a2ehBOVj7L7KHrXsUF8kH8ogtq3TEQv
UhkJ+9Oq6O32kAMGgF6AXavRC/Hthtpq4TsjK+M0r10r+9KuaeZH/R0bDTDXLbDK
Vnhhysh3yZsgiVB1Xsau3LDWgU4JFNUGv4L539/RC3vI05xI5K//FNP2+tSLC8F1
/NKI15J3uKLI25pRddV8j9hOgPvXdSkBY7enP32oXOAfnx0nOF+b3ADNDF6BQf+6
ho+/7AfALgdqAiQLfdWS7L2jBXEUn+0aHYivNREGQkAL4Ke5V3bnX7v/JIjI9/w=
=CCHD
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
