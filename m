From: Pavel Machek <pavel@ucw.cz>
Subject: Only compile kernel/power when neccessary
Date: Fri, 17 Jun 2005 15:02:01 +0200
Message-ID: <20050617130200.GA14587@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============22029629796066597=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============22029629796066597==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Does it look okay for people?

Only compile kernel/power when neccessary. This introduces new
CONFIG_SLEEP, and automatically selects it when some support for
sleeping was selected by user.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit b243c2b0aefb6a045ef03e41cfb6f9811914b629
tree 316b34859536bef3272c0724cbf004d42761d11e
parent 38336d7fba655c81a914b98b0a109f7cad9079f3
author <pavel@amd.(none)> Fri, 17 Jun 2005 15:01:41 +0200
committer <pavel@amd.(none)> Fri, 17 Jun 2005 15:01:41 +0200

 drivers/acpi/Kconfig |    1 +
 kernel/Makefile      |    2 +-
 kernel/power/Kconfig |    5 +++++
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -57,6 +57,7 @@ config ACPI_SLEEP
 	bool "Sleep States (EXPERIMENTAL)"
 	depends on X86
 	depends on EXPERIMENTAL && PM
+	select SLEEP
 	default y
 	---help---
 	  This option adds support for ACPI suspend states. 
diff --git a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
-obj-$(CONFIG_PM) += power/
+obj-$(CONFIG_SLEEP) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -18,6 +18,10 @@ config PM
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
+config SLEEP
+	bool
+	depends on PM
+
 config PM_DEBUG
 	bool "Power Management Debug Support"
 	depends on PM
@@ -29,6 +33,7 @@ config PM_DEBUG
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
 	depends on PM && SWAP && ((X86 && SMP) || ((FVR || PPC32 || X86) && !SMP))
+	select SLEEP
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.

-- 
teflon -- maybe it is a trademark, but it should not be.

--===============22029629796066597==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============22029629796066597==--
