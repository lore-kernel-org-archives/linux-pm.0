From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/05] ARM: mach-shmobile: sh7372 D4 support
Date: Thu, 07 Jul 2011 22:32:20 +0900
Message-ID: <20110707133220.22347.53762.sendpatchset__26341.4308814847$1310045226$gmane$org@t400s>
References: <20110707133212.22347.68775.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110707133212.22347.68775.sendpatchset@t400s>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-sh@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for the sh7372 D4 power domain. This power domain
contains the Coresight-ETM hardware block.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 +
 arch/arm/mach-shmobile/pm-sh7372.c           |    4 ++++
 arch/arm/mach-shmobile/setup-sh7372.c        |    1 +
 3 files changed, 6 insertions(+)

--- 0002/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-07-07 19:20:09.000000000 +0900
@@ -486,6 +486,7 @@ static inline struct sh7372_pm_domain *t
 #ifdef CONFIG_PM
 extern struct sh7372_pm_domain sh7372_a4lc;
 extern struct sh7372_pm_domain sh7372_a4mp;
+extern struct sh7372_pm_domain sh7372_d4;
 extern struct sh7372_pm_domain sh7372_a3rv;
 extern struct sh7372_pm_domain sh7372_a3ri;
 extern struct sh7372_pm_domain sh7372_a3sg;
--- 0002/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-07-07 19:24:26.000000000 +0900
@@ -129,6 +129,10 @@ struct sh7372_pm_domain sh7372_a4mp = {
 	.bit_shift = 2,
 };
 
+struct sh7372_pm_domain sh7372_d4 = {
+	.bit_shift = 3,
+};
+
 struct sh7372_pm_domain sh7372_a3rv = {
 	.bit_shift = 6,
 };
--- 0002/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-07-07 19:20:33.000000000 +0900
@@ -843,6 +843,7 @@ void __init sh7372_add_standard_devices(
 {
 	sh7372_init_pm_domain(&sh7372_a4lc);
 	sh7372_init_pm_domain(&sh7372_a4mp);
+	sh7372_init_pm_domain(&sh7372_d4);
 	sh7372_init_pm_domain(&sh7372_a3rv);
 	sh7372_init_pm_domain(&sh7372_a3ri);
 	sh7372_init_pm_domain(&sh7372_a3sg);
