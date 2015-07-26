From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 0/3] power: clean up bin attribute read/write functions
Date: Mon, 27 Jul 2015 00:26:46 +0300
Message-ID: <1437946009-6743-1-git-send-email-vz@mleia.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:55745 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbbGZVgB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 26 Jul 2015 17:36:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This change removes a number of redundant checks on bin attribute
client's side, the same checks are done by sysfs_kf_bin_read() or
sysfs_kf_bin_write() caller from fs/sysfs/file.c.

No functional change, hopefully.

Vladimir Zapolskiy (3):
  power: ds2780_battery: clean up eeprom read/write functions
  power: ds2781_battery: clean up eeprom read/write functions
  power: olpc_battery: clean up eeprom read function

 drivers/power/ds2780_battery.c | 20 ++------------------
 drivers/power/ds2781_battery.c |  8 --------
 drivers/power/olpc_battery.c   |  7 +------
 3 files changed, 3 insertions(+), 32 deletions(-)

-- 
2.1.4
