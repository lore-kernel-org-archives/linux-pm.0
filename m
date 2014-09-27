From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/10] power/reset: Register drivers with restart handler
Date: Fri, 26 Sep 2014 17:57:08 -0700
Message-ID: <1411779438-23127-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:59544 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbaI0A5b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 20:57:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Convert drivers to use the kernel restart handler instead of setting
arm_pm_restart directly.

This patch set depends on the kernel restart handler patchset submitted
earlier.

Patch 01/10 was tested with qemu. All other patches were compile tested only.

Some of the restart handlers loop forever after the reset instruction was
executed. It might makes sense to use mdelay() instead and return if resetting
the system failed. I did not implement that since I do not know what reasonable
delays would be.

The series does not include drivers to be introduced in the next commit window
(at91, versatile). Those can be converted later. I also did not convert the
sun6i driver, in the assumption that it will be removed since the sunxi
watchdog driver will register a restart handler for the architecture.
