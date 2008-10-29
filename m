From: Pavel Machek <pavel@suse.cz>
Subject: [PATCH] hibernation should work ok with memory hotplug
Date: Wed, 29 Oct 2008 11:59:56 +0100
Message-ID: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753943AbYJ2LAO@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org


hibernation + memory hotplug was disabled in kconfig because we could
not handle hibernation + sparse mem at some point. It seems to work
now, so I guess we can enable it.

Signed-off-by: Pavel Machek <pavel@suse.cz>


diff -ur linux/mm/Kconfig linux.tmp/mm/Kconfig
--- linux/mm/Kconfig	2008-10-27 10:10:59.000000000 +0100
+++ linux.tmp/mm/Kconfig	2008-10-29 10:02:41.000000000 +0100
@@ -128,12 +128,9 @@
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
-	depends on HOTPLUG && !HIBERNATION && ARCH_ENABLE_MEMORY_HOTPLUG
+	depends on HOTPLUG && ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on (IA64 || X86 || PPC64 || SUPERH || S390)
 
-comment "Memory hotplug is currently incompatible with Software Suspend"
-	depends on SPARSEMEM && HOTPLUG && HIBERNATION
-
 config MEMORY_HOTPLUG_SPARSE
 	def_bool y
 	depends on SPARSEMEM && MEMORY_HOTPLUG

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
