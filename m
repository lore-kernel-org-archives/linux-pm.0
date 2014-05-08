From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: linux-pm build failure
Date: Thu, 08 May 2014 20:12:24 +0300
Message-ID: <536BBAF8.6040601@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:56034 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751856AbaEHRM1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 13:12:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi all,

There is a build failure in latest linux-pm bleeding-edge:

In file included from include/linux/linkage.h:6:0,
                 from include/linux/kernel.h:6,
                 from include/acpi/platform/aclinux.h:64,
                 from include/acpi/platform/acenv.h:150,
                 from include/acpi/acpi.h:56,
                 from drivers/acpi/acpica/rscreate.c:44:
include/linux/export.h:59:20: error: redefinition of =91__kstrtab_acpi_=
buffer_to_resource=92
  static const char __kstrtab_##sym[]   \
                    ^
include/linux/export.h:69:2: note: in expansion of macro =91__EXPORT_SY=
MBOL=92
  __EXPORT_SYMBOL(sym, "")
  ^
include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =91=
EXPORT_SYMBOL=92
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
                                     ^
drivers/acpi/acpica/rscreate.c:119:1: note: in expansion of macro =91AC=
PI_EXPORT_SYMBOL=92
 ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource)
 ^
include/linux/export.h:59:20: note: previous definition of =91__kstrtab=
_acpi_buffer_to_resource=92 was here
  static const char __kstrtab_##sym[]   \
                    ^
include/linux/export.h:69:2: note: in expansion of macro =91__EXPORT_SY=
MBOL=92
  __EXPORT_SYMBOL(sym, "")
  ^
include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =91=
EXPORT_SYMBOL=92
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
                                     ^
drivers/acpi/acpica/rscreate.c:117:1: note: in expansion of macro =91AC=
PI_EXPORT_SYMBOL=92
 ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
 ^
include/linux/export.h:63:39: error: redefinition of =91__ksymtab_acpi_=
buffer_to_resource=92
  __visible const struct kernel_symbol __ksymtab_##sym \
                                       ^
include/linux/export.h:69:2: note: in expansion of macro =91__EXPORT_SY=
MBOL=92
  __EXPORT_SYMBOL(sym, "")
  ^
include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =91=
EXPORT_SYMBOL=92
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
                                     ^
drivers/acpi/acpica/rscreate.c:119:1: note: in expansion of macro =91AC=
PI_EXPORT_SYMBOL=92
 ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource)
 ^
include/linux/export.h:63:39: note: previous definition of =91__ksymtab=
_acpi_buffer_to_resource=92 was here
  __visible const struct kernel_symbol __ksymtab_##sym \
                                       ^
include/linux/export.h:69:2: note: in expansion of macro =91__EXPORT_SY=
MBOL=92
  __EXPORT_SYMBOL(sym, "")
  ^
include/acpi/platform/aclinux.h:110:37: note: in expansion of macro =91=
EXPORT_SYMBOL=92
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
                                     ^
drivers/acpi/acpica/rscreate.c:117:1: note: in expansion of macro =91AC=
PI_EXPORT_SYMBOL=92
 ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
 ^
make[3]: *** [drivers/acpi/acpica/rscreate.o] Error 1
make[2]: *** [drivers/acpi/acpica] Error 2
make[1]: *** [drivers/acpi] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2


Reverting commit 51e35823eb57 ("ACPICA: Update acpi_buffer_to_resource =
interface"), build completes fine.


Thanks,
Stratos Karafotis
