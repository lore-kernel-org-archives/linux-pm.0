From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] PM: Fix freezer compilation if PM_SLEEP is
	unset
Date: Tue, 6 Jan 2009 21:14:04 +0100
Message-ID: <200901062114.04649.rjw__32224.5061667219$1231273214$gmane$org@sisk.pl>
References: <200901062112.29227.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901062112.29227.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Cheng Renquan <crquan@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Freezer fails to compile if with the following configuration
settings:

CONFIG_CGROUPS=y
CONFIG_CGROUP_FREEZER=y
CONFIG_MODULES=y
CONFIG_FREEZER=y
CONFIG_PM=y
CONFIG_PM_SLEEP=n

Fix this by making process.o compilation depend on CONFIG_FREEZER.

Reported-by: Cheng Renquan <crquan@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 kernel/power/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/power/Makefile
===================================================================
--- linux-2.6.orig/kernel/power/Makefile
+++ linux-2.6/kernel/power/Makefile
@@ -4,7 +4,8 @@ EXTRA_CFLAGS	+=	-DDEBUG
 endif
 
 obj-y				:= main.o
-obj-$(CONFIG_PM_SLEEP)		+= process.o console.o
+obj-$(CONFIG_PM_SLEEP)		+= console.o
+obj-$(CONFIG_FREEZER)		+= process.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o disk.o snapshot.o swap.o user.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
