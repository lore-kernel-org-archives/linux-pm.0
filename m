From: Pierre Ossman <pierre-list@ossman.eu>
Subject: [PATCH] cpufreq: fix current freq check on policy update
Date: Fri, 14 Feb 2014 07:26:23 +0100
Message-ID: <20140214072623.3dd67851@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_saehrimnir-13075-1392359188-0001-2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from saehrimnir.ossman.eu ([193.12.253.10]:51186 "EHLO
	smtp-relay.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaBNGbd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2014 01:31:33 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_saehrimnir-13075-1392359188-0001-2
Content-Type: multipart/mixed; boundary="MP_/KilhiHyBQnnXFZ_ImD_rCv6"

--MP_/KilhiHyBQnnXFZ_ImD_rCv6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

See attached patch. Discussed in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=3D70311

Not clear why this cpufreq bug causes that breakage to r8169 and to the
pci bus. Input welcome. :)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--MP_/KilhiHyBQnnXFZ_ImD_rCv6
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=0001-cpufreq-fix-current-freq-check-on-policy-update.patch

=46rom de497de3fcd81e8340498cd0b34b3388fe75cc19 Mon Sep 17 00:00:00 2001
From: Pierre Ossman <pierre@ossman.eu>
Date: Fri, 14 Feb 2014 07:17:02 +0100
Subject: [PATCH] cpufreq: fix current freq check on policy update

There was some variable confusion in cpufreq_update_policy()
when we tried to get a current reading of the CPU frequency.
If it failed to get the frequency, a current frequency of
0 kHz would be stored which in turn screwed up other parts
of the kernel.

In particular it somehow disoriented the r8169 driver and
this entire issue was handled on this bug:

  https://bugzilla.kernel.org/show_bug.cgi?id=3D70311

Signed-off-by: Pierre Ossman <pierre@ossman.eu>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 08ca8c9..1b61310 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2151,9 +2151,9 @@ int cpufreq_update_policy(unsigned int cpu)
 	 */
 	if (cpufreq_driver->get) {
 		new_policy.cur =3D cpufreq_driver->get(cpu);
-		if (!policy->cur) {
+		if (!new_policy.cur) {
 			pr_debug("Driver did not initialize current freq");
-			policy->cur =3D new_policy.cur;
+			new_policy.cur =3D policy->cur;
 		} else {
 			if (policy->cur !=3D new_policy.cur && has_target())
 				cpufreq_out_of_sync(cpu, policy->cur,
--=20
1.8.5.3


--MP_/KilhiHyBQnnXFZ_ImD_rCv6--

--=_saehrimnir-13075-1392359188-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iF4EAREIAAYFAlL9txIACgkQopDLsoqlmEJhjAD7BVCgjaX1gYc4cElle4Lwv3dt
R8ODDjvLNl0WAqaZk4sBALetuAKYL/MFf0NziBojYHo4MSAH5eq4tTbPzLD19+Tn
=LzJM
-----END PGP SIGNATURE-----

--=_saehrimnir-13075-1392359188-0001-2--
