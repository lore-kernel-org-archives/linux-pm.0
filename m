From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] ACPI / boot: Few amendments
Date: Mon, 17 Jul 2017 13:23:59 +0300
Message-ID: <20170717102404.27191-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbdGQKYI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jul 2017 06:24:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This series does few amendments to architectural ACPI code related to
boot, in particularly to arch/x86/kernel/acpi/boot.c.

First two patches are amendments to satisfy compiler and static analyzer
(the order is changed from first version which had been applied; in case
of partial update first patch is already in tree).

Third patch might be useful on platforms when debugging *PIC related
code path to see how many legacy IRQs are registered.

Fourth and fifth patches are preparation for some interesting
implementation of ACPI HW reduced platforms (note, this does not mean
it's against specification, patch 5 actually about following
specification).

Fifth patch might be subject to additional discussions.

In v2:
- fix function declarations in ia64 and arm64 as well (Hanjun)
- add three more patches

Andy Shevchenko (5):
  ACPI / boot: Don't define unused variables
  ACPI / boot: Correct address space of __acpi_map_table()
  ACPI / boot: Add number of legacy IRQs to debug output
  ACPI / boot: Not all platform require acpi_reduced_hw_init()
  ACPI / boot: Don't handle SCI on HW reduced platforms

 arch/arm64/kernel/acpi.c    |  4 ++--
 arch/ia64/kernel/acpi.c     |  4 ++--
 arch/x86/kernel/acpi/boot.c | 15 +++++++++------
 include/linux/acpi.h        |  7 +++++--
 4 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.11.0
