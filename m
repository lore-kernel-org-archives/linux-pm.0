From: NeilBrown <neilb@suse.de>
Subject: [PATCH] IRQ: don't suspend nested_thread irqs over system suspend.
Date: Sat, 31 Jan 2015 09:25:45 +1100
Message-ID: <20150131092545.33ed35b8@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/oRn7yYFoFFvMGvjIp64gdkT"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38473 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbbA3WZ6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Jan 2015 17:25:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>

--Sig_/oRn7yYFoFFvMGvjIp64gdkT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



Nested IRQs can only fire when the parent irq fires.
So when the parent is suspended, there is no need to suspend
the child irq.

Suspending nested irqs can cause a problem is they are suspended or
resumed in the wrong order.
If an interrupt fires while the parent is active but the child is
suspended, then the interrupt will not be acknowledged properly
and so an interrupt storm can result.
This is particularly likely if the parent is resumed before
the child, and the interrupt was raised during suspend.

Ensuring correct ordering would be possible, but it is simpler
to just never suspend nested interrupts.  This patch does that.

This patch allows the IRQF_EARLY_RESUME to be removed from
twl4030_sih_setup().  That flag attempts to fix the same problem
is a very different way, but causes

[   56.095825] WARNING: CPU: 0 PID: 3 at ../kernel/irq/manage.c:661 irq_nes=
ted_primary_handler+0x18/0x28()
[   56.095825] Primary handler called for nested irq 348

warnings on resume.

Signed-off-by: NeilBrown <neil@brown.name>

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 3ca532592704..40cbcfb7fc43 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -118,6 +118,8 @@ void suspend_device_irqs(void)
 		unsigned long flags;
 		bool sync;
=20
+		if (irq_settings_is_nested_thread(desc))
+			continue;
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		sync =3D suspend_device_irq(desc, irq);
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
@@ -158,6 +160,8 @@ static void resume_irqs(bool want_early)
=20
 		if (!is_early && want_early)
 			continue;
+		if (irq_settings_is_nested_thread(desc))
+			continue;
=20
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		resume_irq(desc, irq);

--Sig_/oRn7yYFoFFvMGvjIp64gdkT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVMwE6jnsnt1WYoG5AQLHaBAAv2wsX1KOJO+hBYqs6PiHs02dgoelp/LL
QQ7eVNQYtjVRo/qtwpFYFDYdvn4kYXcuEzQ3YNeEy7qt3r2IzBa7bsd7IX4/Aqox
d+YXpGA8FdjX26kKtAr1QTk+bwlMPoZYVPEoUVe9OpX3Oet3io1Ilxjv4/fH+QJ0
CoHaOiwUTQhoNMhaavxGhsyvbJrVRFjIBIR7mnXlyinfelLfZuNCVcn4GQ6Gp4rH
Zicqb8Z4LxJA5bYjn9WvXHFQy/1F9V01Pb5+cLkh8x0FZO6y3Dc/TH2kjwH5hRDm
ntzU+UXkjwBOUPzZtoh5vHpbhdXkENhl7ltMZUbwdIbzwY2QK7LxydwPQFs3BLmE
MaDXsqNKmf4snYOdJDUzoSq+0sf9th9/kW6HT4GKXSfAg2hKoDrmfJWxiF4eylrh
PYdZQ9DRe5GhNt6i3ARwKXaoUPn03W/B7o44oD7CApQMnrQqiAATjTVQA5cU45QP
JgYnNjnn2qb8qJumYd7dlTfw874EN3PNHCEB0Aken5P2AUK5FoIiMt/GGP+cTdlr
Io2Lzy7C1H2Pp6NLM22cLwt5OplVvQiTkuLNELEHBMT+LyKSlA3Al8ylUL/dmte3
XJE78LHq3Q63XZlN1Mcw2A+XNzkPceYzxxESytv7br+arJYC+jW1WqfDz5IJzSv3
0KqepiKbS/M=
=BPz5
-----END PGP SIGNATURE-----

--Sig_/oRn7yYFoFFvMGvjIp64gdkT--
