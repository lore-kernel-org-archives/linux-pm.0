From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH RFC 01/12] Documentation: Introduce Linux Kernel Thermal
 Framework DocBook
Date: Mon, 16 Feb 2015 11:17:43 -0400
Message-ID: <20150216151742.GC8648@developer.hsd1.ca.comcast.net>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
 <1423517653-11359-2-git-send-email-edubezval@gmail.com>
 <54DA8B3C.9040607@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32858 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbbBPUOr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 15:14:47 -0500
Content-Disposition: inline
In-Reply-To: <54DA8B3C.9040607@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2015 at 02:50:36PM -0800, Randy Dunlap wrote:
> On 02/09/15 13:34, Eduardo Valentin wrote:
>=20
> > +	<chapter id=3D"introduction">
> > +		<title>Introduction</title>
> > +		<para>Thermal management is any method or technique implied to
> > +		mitigate emergencies caused by operating devices within
> > +		unsupported temperatures. The challenge consists of designing a
>=20
> I would flip the ending of that sentence:
> 		                     caused by operating devices outside of
> 		supported temperatures.
>=20
> > +		product keeping the junction temperature of the IC components.
> > +		The operating temperature of IC components used on products must
> > +		operate within their design limits. Besides, temperature towards
> > +		device enclosure must be in a comfort level for the user.
> > +		Therefore, thermal management, by the time of this writing,
> > +		starts in very early device design phase. Managing thermal may
> > +		involve different disciplines, at different stages, such as
> > +		temperature monitoring, floorplanning, microarchitectural
> > +		techniques, compiler techniques, OS techniques, liquid cooling,
> > +		and thermal reliability or security. This document covers what
> > +		the Linux Kernel Thermal Framework provides as abstraction to
> > +		users with respect to thermal management. =20
> > +		</para>
> > +		<para>One of the first proposals to provide a solution to cover
> > +		the thermal problem appears in the Advanced Configuration and
> > +		Power Interface (ACPI) specification. ACPI provides an open
> > +		standard for device configuration and power management by the
> > +		operating system. However, several computing devices which may
> > +		have thermal issues in the market disregard the ACPI standard.
> > +		Therefore, the Linux Kernel Thermal Framework has been designed
> > +		to serve as abstraction for ACPI and non-ACPI systems. The core
> > +		concepts applies in both types of systems.=20
> > +		</para>
> > +		<para>The Linux Kernel Thermal Framework has a design which
> > +		represents the different thermal constraints found in an
>=20
> drop:		                                                      an^^
>=20
> > +		end-products. The thermal constraints exist to serve different
> > +		purposes. There two major types of thermal constraints. The
>=20
> 		          There are two
>=20
> > +		first is related to components junction temperature. The second
> > +		is related to the level of comfort while end users are handling
> > +		devices.
> > +		</para>
> > +
> > +  </chapter>
> > +</book>
> >=20
>=20
>=20
> --=20
> ~Randy

Thanks Randy for checking this up. I apologize for forgetting Ccing you
in my original post. I will fix the text as per your suggestions and
also copy you in next version.

Thanks for you time.

Eduardo Valentin


--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU4goNAAoJEMLUO4d9pOJWCAUH/RAdiF0LwFKECqfTDfZPg8qq
uLh64LhCU638ANvOk1tMzdT6JCGHrPWJgELtT2ynzvP17x3wC7/RgbvnZR3h5CaI
1fRrP1ej++W2L0gTyE2JJcwnX/DBdPSfkYKXRS8GGz1GyhqrS0rM4bbSGXzVtD4H
vuQnBJEghs9HQS22xdaPiJVYNRtm78urrol9Qasm8U7GXxpmLFql0lZNkn0HCqYO
KXNcjlAC2iHNRYdxlkzgE5+FwR7lY6S+5ZprQvgu0zJsGwYLQ3YbLPPn9AIgPTD3
8NxsMb7eJ3cn1oKobXKZJT2gbjWwWgGKLc3qHo20oEoi/notaJI4dRA3r9KxZeQ=
=U8rp
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
