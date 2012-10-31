From: kbuild test robot <fengguang.wu@intel.com>
Subject: drivers/acpi/acpica/nsxfname.c:500 acpi_get_object_info() info:
 redundant null check on sub calling kfree()
Date: Thu, 01 Nov 2012 07:11:46 +0800
Message-ID: <5091b032.8k8xSdvoYwGs0lBq%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21611 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755548Ab2JaXMT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 31 Oct 2012 19:12:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>
Cc: linux-pm@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   741933bb4230bfc0ef9eba19384fe58e528b39a9
commit: 00741297a43870e21dcae6429b5240a3cc7a5312 ACPICA: AcpiGetObjectInfo: Add support for ACPI 5 _SUB method
date:   74 minutes ago


smatch warnings:

  drivers/acpi/acpica/nsxfname.c:494 acpi_get_object_info() info: redundant null check on hid calling kfree()
  drivers/acpi/acpica/nsxfname.c:497 acpi_get_object_info() info: redundant null check on uid calling kfree()
+ drivers/acpi/acpica/nsxfname.c:500 acpi_get_object_info() info: redundant null check on sub calling kfree()
  drivers/acpi/acpica/nsxfname.c:503 acpi_get_object_info() info: redundant null check on cid_list calling kfree()

vim +500 drivers/acpi/acpica/nsxfname.c

15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  484  	info->type = type;
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  485  	info->name = name;
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  486  	info->param_count = param_count;
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  487  	info->valid = valid;
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  488  
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  489  	*return_buffer = info;
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  490  	status = AE_OK;
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  491  
4be44fcd drivers/acpi/namespace/nsxfname.c Len Brown      2005-08-05  492        cleanup:
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  493  	if (hid) {
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  494  		ACPI_FREE(hid);
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  495  	}
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  496  	if (uid) {
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  497  		ACPI_FREE(uid);
15b8dd53 drivers/acpi/acpica/nsxfname.c    Bob Moore      2009-06-29  498  	}
00741297 drivers/acpi/acpica/nsxfname.c    Bob Moore      2012-10-31  499  	if (sub) {
00741297 drivers/acpi/acpica/nsxfname.c    Bob Moore      2012-10-31 @500  		ACPI_FREE(sub);
00741297 drivers/acpi/acpica/nsxfname.c    Bob Moore      2012-10-31  501  	}
^1da177e drivers/acpi/namespace/nsxfname.c Linus Torvalds 2005-04-16  502  	if (cid_list) {
8313524a drivers/acpi/namespace/nsxfname.c Bob Moore      2006-10-03  503  		ACPI_FREE(cid_list);
^1da177e drivers/acpi/namespace/nsxfname.c Linus Torvalds 2005-04-16  504  	}
^1da177e drivers/acpi/namespace/nsxfname.c Linus Torvalds 2005-04-16  505  	return (status);
^1da177e drivers/acpi/namespace/nsxfname.c Linus Torvalds 2005-04-16  506  }
^1da177e drivers/acpi/namespace/nsxfname.c Linus Torvalds 2005-04-16  507  
8313524a drivers/acpi/namespace/nsxfname.c Bob Moore      2006-10-03  508  ACPI_EXPORT_SYMBOL(acpi_get_object_info)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
