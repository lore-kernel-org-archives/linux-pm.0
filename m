From: NeilBrown <neilb@suse.de>
Subject: [PATCH - RE-RESEND] IRQ: don't suspend nested_thread irqs over
 system suspend.
Date: Sun, 17 May 2015 15:19:34 +1000
Message-ID: <20150517151934.2393e8f8@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/_BU=vkL60t2MhoYOk8ydP+x"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
List-Id: linux-pm@vger.kernel.org

--Sig_/_BU=vkL60t2MhoYOk8ydP+x
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
to just never suspend nested interrupts.

Signed-off-by: NeilBrown <neil@brown.name>

---
At Rafael's request I'm resending this.  No response last time (except from=
 Rafael),
no change in the code.

This change will fix a bug so that the work-around introduced by=20
  8b41669ceba0 ("mfd: twl4030: Fix chained irq handling on resume from susp=
end")
can be reverted.  This work-around misuses the IRQF_EARLY_RESUME flag, and =
triggers
a warning on resume:

[   56.095825] WARNING: CPU: 0 PID: 3 at ../kernel/irq/manage.c:661 irq_nes=
ted_primary_handler+0x18/0x28()

(though the line number might have changed).

NeilBrown


diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 5204a6d1b985..d22786a6dbde 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -123,6 +123,8 @@ void suspend_device_irqs(void)
 		unsigned long flags;
 		bool sync;
=20
+		if (irq_settings_is_nested_thread(desc))
+			continue;
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		sync =3D suspend_device_irq(desc, irq);
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
@@ -163,6 +165,8 @@ static void resume_irqs(bool want_early)
=20
 		if (!is_early && want_early)
 			continue;
+		if (irq_settings_is_nested_thread(desc))
+			continue;
=20
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		resume_irq(desc, irq);

--Sig_/_BU=vkL60t2MhoYOk8ydP+x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVVgk5znsnt1WYoG5AQLIZw//UzYK5i54lvvA/lQMLB8By/UIASbRwA3s
i/y0i1MbiwK/58HQyvR0GTVxzVAy7EJ1YCqkLxVj1ri1GnCEb6NihZ82iAUefsC2
vTsMcp62lAqZ4B1+PbD1J/BNmNbRWZv5PkFQZYjlpwZH3aHL9OmWB3RQqDGNCWwF
7+kQ563D1BCTDWq2NzLCE7IFksACJrk70oj2LlXN3QA1+EDIg1J+zyRjEzOUpq3u
JFc8Y7TGW2H5TC2mccRN+q8ZPLBBb+JT0+gSk79UkjQ/koKHIEwl+eZNQw9A9pXQ
wR0s2MI5Da9KaIFpj+A40bN0oOngzvTqsa8BP7Mv1/OhUVR30HK57+ix2xC455JJ
eSBQGo+NyD3ne7w2uIip1MSl82X4tjX3FEQx+qaB1K7pUqHmI6bRuH2wT4Z6DESB
SDIaGgHyFL2JzBXyFpQwGF/lrsof8xj5BT9WjVK3k1NhCQPomlPdHRxCuX4zAI3e
r6kdhcf5L6/RPAOwDZcg2cttnRXyJV6Vl3WrjXX9PCJ+73s9tB5BdIAgkyhJtzVz
grVeB84cnYSvEFRbT7f2oH5sWPTH0b0gr6+7Tp39BhU381tsM5Z2hhmhJq36U+Dv
WIMGPr+CTwVcMlU7IztcyGESlYnyysQ97kkEjSmA9eF54mlK/Gq/b38FcupnpbWr
mLwqDbUlqvA=
=CeEJ
-----END PGP SIGNATURE-----

--Sig_/_BU=vkL60t2MhoYOk8ydP+x--
