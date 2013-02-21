From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] blackfin idle: Fix compile error
Date: Thu, 21 Feb 2013 10:56:43 +0100
Message-ID: <1361440603-7209-1-git-send-email-lars@metafoo.de>
References: <1449748.lzaK5NRLYV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1636 "EHLO
	smtp-out-106.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752738Ab3BUJzQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Feb 2013 04:55:16 -0500
In-Reply-To: <1449748.lzaK5NRLYV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Lars-Peter Clausen <lars@metafoo.de>

Commit 26bab0c ("blackfin idle: delete pm_idle") introduced the followi=
ng
compile error:
	arch/blackfin/kernel/process.c: In function =E2=80=98cpu_idle=E2=80=99=
:
	arch/blackfin/kernel/process.c:83: error: =E2=80=98idle=E2=80=99 undec=
lared (first use in this function)
	arch/blackfin/kernel/process.c:83: error: (Each undeclared identifier =
is reported only once
	arch/blackfin/kernel/process.c:83: error: for each function it appears=
 in.)
	arch/blackfin/kernel/process.c:88: error: implicit declaration of func=
tion =E2=80=98idle=E2=80=99

This patch fixes it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/blackfin/kernel/process.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/proc=
ess.c
index 8061426..9782c03 100644
--- a/arch/blackfin/kernel/process.c
+++ b/arch/blackfin/kernel/process.c
@@ -80,12 +80,10 @@ void cpu_idle(void)
 		if (cpu_is_offline(smp_processor_id()))
 			cpu_die();
 #endif
-		if (!idle)
-			idle =3D default_idle;
 		tick_nohz_idle_enter();
 		rcu_idle_enter();
 		while (!need_resched())
-			idle();
+			default_idle();
 		rcu_idle_exit();
 		tick_nohz_idle_exit();
 		preempt_enable_no_resched();
--=20
1.8.0

