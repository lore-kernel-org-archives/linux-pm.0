From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: (no subject)
Date: Thu, 11 Jun 2009 22:44:20 +0000 (UTC)
Message-ID: <S4AoGnG.A.5F.dcYMKB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

>From 26008d13d7fb5054634898dab794f8808a93a775 Mon Sep 17 00:00:00 2001
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Subject: [PATCH 06/19] x86: unify power/cpu_(32|64) copyright notes

From: Sergio Luis <sergio@larces.uece.br>

In this step, we do unify the copyright notes for both files
cpu_32.c and cpu_64.c, making such files exactly the same.
It's the last step before the actual unification, that will
rename one of them to cpu.c and remove the other one.

Signed-off-by: Sergio Luis <sergio@larces.uece.br>
Signed-off-by: Lauro Salmito <laurosalmito@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/power/cpu_32.c |    3 ++-
 arch/x86/power/cpu_64.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/cpu_32.c b/arch/x86/power/cpu_32.c
index 29b9c0a..ca0ecae 100644
--- a/arch/x86/power/cpu_32.c
+++ b/arch/x86/power/cpu_32.c
@@ -1,8 +1,9 @@
 /*
- * Suspend support specific for i386.
+ * Suspend and hibernation support for i386/x86-64.
  *
  * Distribute under GPLv2
  *
+ * Copyright (c) 2007 Rafael J. Wysocki <rjw@sisk.pl>
  * Copyright (c) 2002 Pavel Machek <pavel@suse.cz>
  * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
  */
diff --git a/arch/x86/power/cpu_64.c b/arch/x86/power/cpu_64.c
index 5c8bdc0..d277ef1 100644
--- a/arch/x86/power/cpu_64.c
+++ b/arch/x86/power/cpu_64.c
@@ -1,5 +1,5 @@
 /*
- * Suspend and hibernation support for x86-64
+ * Suspend support specific for i386/x86-64.
  *
  * Distribute under GPLv2
  *
-- 
1.5.2.4
