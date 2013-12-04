From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [RFC] PM / hibernate: Call platform_leave in suspend path too
Date: Wed,  4 Dec 2013 16:06:58 +0100
Message-ID: <1386169618-6417-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:54396 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178Ab3LDPHo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Dec 2013 10:07:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq@vger.kernel.org, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>

The system can continue running after the image is created, for
example because userspace cancelled the hibernation or only
saved the image for a dual mode disk + ram suspend. We must
restore the platform to the pre_snapshot state in this case.

This fixes a long standing bug in the acpi_cpufreq driver
which would fail after a cancelled hibernate because the
system then was running with the EC blocked:

 cpufreq: adding CPU 1
 acpi_cpufreq_cpu_init
 cpufreq: FREQ: 1401000 - CPU: 0
 ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for [EmbeddedCon=
trol] (20130725/evregion-287)
 ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPC_.EC__.LPMD] =
(Node ffff88023249ab28), AE_BAD_PARAMETER (20130725/psparse-536)
 ACPI Error: Method parse/execution failed [\_PR_.CPU0._PPC] (Node ffff=
88023270e3f8), AE_BAD_PARAMETER (20130725/psparse-536)
 ACPI Error: Method parse/execution failed [\_PR_.CPU1._PPC] (Node ffff=
88023270e290), AE_BAD_PARAMETER (20130725/psparse-536)
 ACPI Exception: AE_BAD_PARAMETER, Evaluating _PPC (20130725/processor_=
perflib-140)
 cpufreq: initialization failed
 CPU1 is up

Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
This is posted as RFC because I am unsure whether this is the correct
way to fix the problem.  We definitely need to undo some of the
pre_snapshot work to have a fully functional system when create_image
returns, but I guess there can be unwanted side effects of unconditiona=
lly
calling platform_leave() like this.

=46WIW, this works for me.

Testing and verifying the original acpi_cpufreq problem should be easy =
on
any system using that driver and having an EC, which should include mos=
t
laptops:
  - Start a userspace hibernation and cancel it, for example by using
    s2disk from uswsusp and pressing backspace.

The cpufreq device will disappear from all non-boot cores, and the abov=
e
ACPI exceptions will be logged.

Comments and/or alternative solutions are appreciated.

Note that the final solution to this problem should be backported to al=
l
maintained stable kernels.  I've verified that the problem exists and t=
hat
this proposed patch applies to 3.2, 3.4, 3.10 and 3.12


Bj=C3=B8rn

 kernel/power/hibernate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 0121dab83f43..59fb7e82f818 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -293,10 +293,10 @@ static int create_image(int platform_mode)
 			error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
-	if (!in_suspend) {
+	if (!in_suspend)
 		events_check_enabled =3D false;
-		platform_leave(platform_mode);
-	}
+
+	platform_leave(platform_mode);
=20
  Power_up:
 	syscore_resume();
--=20
1.7.10.4

