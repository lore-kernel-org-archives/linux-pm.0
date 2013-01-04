From: kbuild test robot <fengguang.wu@intel.com>
Subject: drivers/acpi/processor_driver.c:351:2: error: 'else' without a
 previous 'if'
Date: Sat, 05 Jan 2013 07:02:44 +0800
Message-ID: <50e75f94.QueKkJ7Ms/cbp/Qu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15880 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755229Ab3ADXGp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 18:06:45 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>
Cc: linux-pm@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   279355c3da8cc9b3ce41865fddfa1cedc9625bf9
commit: 2e6bce9096cf01e4b57e1d1ae7574a2bd986dd8e ACPICA: DEBUG_PRINT macros: Update to improve performance.
date:   42 minutes ago
config: make ARCH=x86_64 allmodconfig

All error/warnings:

drivers/acpi/processor_driver.c: In function 'acpi_processor_get_info':
drivers/acpi/processor_driver.c:351:2: error: 'else' without a previous 'if'
drivers/acpi/processor_driver.c: In function 'is_processor_present':
drivers/acpi/processor_driver.c:674:2: error: 'else' without a previous 'if'

vim +351 drivers/acpi/processor_driver.c

4be44fcd drivers/acpi/processor_core.c   Len Brown           2005-08-05  335  	}
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  336  	/*
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  337  	 * On some boxes several processors use the same processor bus id.
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  338  	 * But they are located in different scope. For example:
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  339  	 * \_SB.SCK0.CPU0
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  340  	 * \_SB.SCK1.CPU0
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  341  	 * Rename the processor device bus id. And the new bus id will be
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  342  	 * generated as the following format:
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  343  	 * CPU+CPU ID.
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  344  	 */
7a04b849 drivers/acpi/processor_core.c   Zhao Yakui          2009-06-24  345  	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
^1da177e drivers/acpi/processor_core.c   Linus Torvalds      2005-04-16  346  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id,
4be44fcd drivers/acpi/processor_core.c   Len Brown           2005-08-05  347  			  pr->acpi_id));
^1da177e drivers/acpi/processor_core.c   Linus Torvalds      2005-04-16  348  
^1da177e drivers/acpi/processor_core.c   Linus Torvalds      2005-04-16  349  	if (!object.processor.pblk_address)
^1da177e drivers/acpi/processor_core.c   Linus Torvalds      2005-04-16  350  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
^1da177e drivers/acpi/processor_core.c   Linus Torvalds      2005-04-16 @351  	else if (object.processor.pblk_length != 6)
47db4547 drivers/acpi/processor_driver.c Toshi Kani          2012-11-20  352  		dev_err(&device->dev, "Invalid PBLK length [%d]\n",
6468463a drivers/acpi/processor_core.c   Len Brown           2006-06-26  353  			    object.processor.pblk_length);
^1da177e drivers/acpi/processor_core.c   Linus Torvalds      2005-04-16  354  	else {
^1da177e drivers/acpi/processor_core.c   Linus Torvalds      2005-04-16  355  		pr->throttling.address = object.processor.pblk_address;
cee324b1 drivers/acpi/processor_core.c   Alexey Starikovskiy 2007-02-02  356  		pr->throttling.duty_offset = acpi_gbl_FADT.duty_offset;
cee324b1 drivers/acpi/processor_core.c   Alexey Starikovskiy 2007-02-02  357  		pr->throttling.duty_width = acpi_gbl_FADT.duty_width;
^1da177e drivers/acpi/processor_core.c   Linus Torvalds      2005-04-16  358  
^1da177e drivers/acpi/processor_core.c   Linus Torvalds      2005-04-16  359  		pr->pblk = object.processor.pblk_address;

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
