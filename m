From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] cpupower: Fix turbo frequency reporting for pre-Sandy Bridge
 cores
Date: Tue, 11 Apr 2017 00:29:44 +0100
Message-ID: <20170410232944.GA4152@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L977DYpOHGH1NqKf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49651 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751738AbdDJX3q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 19:29:46 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, GSR <gsr.bugs@infernal-iceberg.com>, 859978@bugs.debian.org


--L977DYpOHGH1NqKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The switch that conditionally sets CPUPOWER_CAP_HAS_TURBO_RATIO and
CPUPOWER_CAP_IS_SNB flags is missing a break, so all cores get both
flags set and an assumed base clock of 100 MHz for turbo values.

Reported-by: GSR <gsr.bugs@infernal-iceberg.com>
Tested-by: GSR <gsr.bugs@infernal-iceberg.com>
References: https://bugs.debian.org/859978
Fixes: 8fb2e440b223 ("cpupower: Show Intel turbo ratio support via ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/power/cpupower/utils/helpers/cpuid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 93b0aa74ca03..39c2c7d067bb 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -156,6 +156,7 @@ int get_cpu_info(unsigned int cpu, struct cpupower_cpu_info *cpu_info)
 					 */
 			case 0x2C:	/* Westmere EP - Gulftown */
 				cpu_info->caps |= CPUPOWER_CAP_HAS_TURBO_RATIO;
+				break;
 			case 0x2A:	/* SNB */
 			case 0x2D:	/* SNB Xeon */
 			case 0x3A:	/* IVB */

--L977DYpOHGH1NqKf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWOwVaOe/yOyVhhEJAQr2dxAAkN0P5xBktyoTkkcItHkVsF0KqQCpfHpT
xUMOE9fkdRrooyqq9Up8uqag/g7pgyniCfY+qs2wRLR3yS40o7mU1Wo0xrBXQFZO
6ftnqJlGqOG4F8SV0ZfQGt/0FlbWSEjwqlf1FBlmRC2JT9Y5HQyEUwzGtot5Y0dU
sf0O1RfzDJ8kocN0RnCRiEL0Uobh5FhKNOWmL9I3QrjlbfEscO/RmTDh/7iN4JVz
f8cmCkk+/Uy6LseJRRKJ6Pw9GJagTioNsTh1uPkBiSq8RU2oEE6mCr9zi6tVwpn7
dc9MSxwIZZSZC+b50CzlgjVBpEqQY18fpMngP5mkjdFN0rjP0e1eJURldZW0uP0S
OrwxRRcD4BukO2gaoeWEiwO0SHgtA0SF4oM2atXUKBiqvFhaq5TVsxN1GH51cby3
8bN8hF7sXvFvI8ZjX+0Ihw0ZHEIRnzHc6Rpw0gQ6jA7C4RV/juQB7f1ZFTxlQdl2
y39QW4CDg1vv1bCU5uhPSpV8fXCMtdQD1Zxhkeuj6mMO4yxGZjr4OboxP1SUENW/
/j6b/vJKA2yGjf5Hvv1cl7VFu/rPHRE6DCSYI3EdJUvaV2Giur15yZ3ZuC5ODc67
JOQul3DgXTIIGbD7zP4riyKpXalJUixc/376UYDZIIgEROw6/KuviBmgtrnVhmSS
GTjq/GW5Ftg=
=YmIB
-----END PGP SIGNATURE-----

--L977DYpOHGH1NqKf--
