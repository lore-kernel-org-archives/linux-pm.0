From: kbuild test robot <fengguang.wu@intel.com>
Subject: arch/ia64/hp/common/aml_nfw.c:209:3: warning: initialization from incompatible pointer type
Date: Wed, 23 Jan 2013 09:42:04 +0800
Message-ID: <50ff3fec.dzZurAbFSdIanVcO%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:61809 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719Ab3AWBmI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Jan 2013 20:42:08 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   8368b19d264e6bf4f68e9ff2d2b5b94bd40d4e45
commit: 3a784c20418b5df6ef28ca0ed9a41d1169da137d ACPI: Remove useless type argument of driver .remove() operation
date:   4 hours ago
config: make ARCH=ia64 allmodconfig

All warnings:

>> arch/ia64/hp/common/aml_nfw.c:209:3: warning: initialization from incompatible pointer type [enabled by default]
>> arch/ia64/hp/common/aml_nfw.c:209:3: warning: (near initialization for 'acpi_aml_nfw_driver.ops.remove') [enabled by default]

vim +209 arch/ia64/hp/common/aml_nfw.c

   193	
   194	static int aml_nfw_remove(struct acpi_device *device, int type)
   195	{
   196		return aml_nfw_remove_global_handler();
   197	}
   198	
   199	static const struct acpi_device_id aml_nfw_ids[] = {
   200		{"HPQ5001", 0},
   201		{"", 0}
   202	};
   203	
   204	static struct acpi_driver acpi_aml_nfw_driver = {
   205		.name = "native firmware",
   206		.ids = aml_nfw_ids,
   207		.ops = {
   208			.add = aml_nfw_add,
 > 209			.remove = aml_nfw_remove,
   210			},
   211	};
   212	
   213	static int __init aml_nfw_init(void)
   214	{
   215		int result;
   216	
   217		if (force_register)

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
