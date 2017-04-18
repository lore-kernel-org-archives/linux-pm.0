From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] cpupower: Fix checks for CPU existence
Date: Tue, 18 Apr 2017 03:31:18 +0100
Message-ID: <20170418023118.GD4152@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1DcFzFXxI6Ykdyz3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45131 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754831AbdDRCbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 22:31:20 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org


--1DcFzFXxI6Ykdyz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Calls to cpufreq_cpu_exists(cpu) were converted to
cpupower_is_cpu_online(cpu) when libcpupower was introduced and the
former function was deleted.  However, cpupower_is_cpu_online()
returns 1 on success whereas cpufreq_cpu_exists() returned 0 on
success.  It also does not distinguish physically absent and offline
CPUs, and does not set errno.

cpufreq-set has already been fixed (commit c25badc9ceb6).

In cpufreq-bench, which prints an error message for offline CPUs,
properly distinguish and report the zero and negative cases.

Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/tools/power/cpupower/bench/system.c
+++ b/tools/power/cpupower/bench/system.c
@@ -58,12 +58,19 @@ long long int get_time()
=20
 int set_cpufreq_governor(char *governor, unsigned int cpu)
 {
+	int rc;
=20
 	dprintf("set %s as cpufreq governor\n", governor);
=20
-	if (cpupower_is_cpu_online(cpu) !=3D 0) {
-		perror("cpufreq_cpu_exists");
-		fprintf(stderr, "error: cpu %u does not exist\n", cpu);
+	rc =3D cpupower_is_cpu_online(cpu);
+	if (rc !=3D 1) {
+		if (rc < 0)
+			fprintf(stderr, "cpupower_is_cpu_online: %s\n",
+				strerror(-rc));
+		else
+			fprintf(stderr,
+				"error: cpu %u is offline or does not exist\n",
+				cpu);
 		return -1;
 	}
=20

--1DcFzFXxI6Ykdyz3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWPV6due/yOyVhhEJAQrSsw//T+7Ab7XX4De6EIDSDTS658DLBgLFGXs0
NfouUH66vF8vPMECfu6adUGAOUkHI49KrtCftzwcf32uOUMH3tD4ibtH5navwmT9
uM5KkKzhcU5UY3T7ALlayLCPy69Glvn9kDkjL7e54vvAXtA+qKiTvFXZOkbvL46T
i+ZaaJ2u+kcn77QDwDPQwWYOTdgsKzgFLL++ItbO/s7F8GlpOGnbHbqldnJFmC+j
cl5Z+B4AkKjB3ja3lBsHJSp3t20rxlSqnc99PCaJI6j1VKnY62Z3HOVVCpMB04NQ
horFezNNsvFUI1rD65UjIk1oe11Woj1al3h3RG2XJm3WIs0ClLPm5wqwY92WoFZV
6oWJ75nPJRz4CXvldmOAvLWpa7eWn5a44gtDbK26yx6rycD+g+M4/lHTiRpO6dOb
L/fqH5weVRr0hD4iRwnYe8blbn1B3rUHn6HhsxYYbIw3KO9+7zwDFXRlbg44+l15
NfV1KfjpwEGRdRoZNSbg1eM3U4CBkBGiCeN4EFoRdhcXbu78doHt3RvpFGAZn10n
M32E3KOym8S5bt7yZF6nYX6EfOEfC2buGpVtm46s4PHO3vrkUzn+miA8V6OQiGvf
PisRnFX981nWYm38PgMMdw/b80S7GmW/m3NXIDJx3davZgaUEcCPV8ksYruYZoK/
aNubV6776Zw=
=/XUs
-----END PGP SIGNATURE-----

--1DcFzFXxI6Ykdyz3--
