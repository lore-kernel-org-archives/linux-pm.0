From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 268/293] x86/power: Fix swsusp_arch_resume
 prototype
Date: Mon, 9 Apr 2018 00:26:24 +0000
Message-ID: <20180409002239.163177-268-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Nicolas Pitre <nico@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Bart Van Assche <bart.vanassche@wdc.com>, Sasha Levin <Alexander.Levin@microsoft.com>
List-Id: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 328008a72d38b5bde6491e463405c34a81a65d3e ]

The declaration for swsusp_arch_resume marks it as 'asmlinkage', but the
definition in x86-32 does not, and it fails to include the header with the
declaration. This leads to a warning when building with
link-time-optimizations:

kernel/power/power.h:108:23: error: type of 'swsusp_arch_resume' does not m=
atch original declaration [-Werror=3Dlto-type-mismatch]
 extern asmlinkage int swsusp_arch_resume(void);
                       ^
arch/x86/power/hibernate_32.c:148:0: note: 'swsusp_arch_resume' was previou=
sly declared here
 int swsusp_arch_resume(void)

This moves the declaration into a globally visible header file and fixes up
both x86 definitions to match it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <len.brown@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Link: https://lkml.kernel.org/r/20180202145634.200291-2-arnd@arndb.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/power/hibernate_32.c | 2 +-
 arch/x86/power/hibernate_64.c | 2 +-
 include/linux/suspend.h       | 2 ++
 kernel/power/power.h          | 3 ---
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index 9f14bd34581d..74b516cb39df 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -142,7 +142,7 @@ static inline void resume_init_first_level_page_table(p=
gd_t *pg_dir)
 #endif
 }
=20
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
=20
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 9634557a5444..0cb1dd461529 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -149,7 +149,7 @@ static int relocate_restore_code(void)
 	return 0;
 }
=20
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
=20
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index d9718378a8be..249dafce2788 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -378,6 +378,8 @@ extern int swsusp_page_is_forbidden(struct page *);
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
+extern asmlinkage int swsusp_arch_suspend(void);
+extern asmlinkage int swsusp_arch_resume(void);
=20
 extern void hibernation_set_ops(const struct platform_hibernation_ops *ops=
);
 extern int hibernate(void);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 56d1d0dedf76..ccba4d820078 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -103,9 +103,6 @@ extern int in_suspend;
 extern dev_t swsusp_resume_device;
 extern sector_t swsusp_resume_block;
=20
-extern asmlinkage int swsusp_arch_suspend(void);
-extern asmlinkage int swsusp_arch_resume(void);
-
 extern int create_basic_memory_bitmaps(void);
 extern void free_basic_memory_bitmaps(void);
 extern int hibernate_preallocate_memory(void);
--=20
2.15.1
