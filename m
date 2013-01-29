From: kbuild test robot <fengguang.wu@intel.com>
Subject: pl320-ipc.c:undefined reference to `amba_driver_register'
Date: Tue, 29 Jan 2013 23:21:34 +0800
Message-ID: <5107e8fe.D1ryP/mCHLvnm4xO%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29217 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961Ab3A2P0T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Jan 2013 10:26:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>
Cc: linux-pm@vger.kernel.org, Mark Langsdorf <mark.langsdorf@calxeda.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   37170124ff3c6d53a8ef4fbdd16e3e91245dba05
commit: 970066f5b2698589d1c06bdbfcaf36dcc997eef6 ARM / highbank: add support for pl320 IPC
date:   18 hours ago
config: make ARCH=i386 allyesconfig

All error/warnings:

>> WARNING: drivers/mailbox/built-in.o(.data+0xf4): Section mismatch in reference from the variable pl320_driver to the function .init.text:pl320_probe()
   The variable pl320_driver references
   the function __init pl320_probe()
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
   drivers/built-in.o: In function `ipc_init':
>> pl320-ipc.c:(.init.text+0x7df09): undefined reference to `amba_driver_register'

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
