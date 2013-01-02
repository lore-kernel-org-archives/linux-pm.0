From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH RESEND 0/4] thermal sys: couple of fixes and cleanups
Date: Wed, 2 Jan 2013 17:29:38 +0200
Message-ID: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39900 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab3ABPaG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jan 2013 10:30:06 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: durgadoss.r@intel.com, linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Hello Rui,

Here is a couple of fixes and cleanups on the thermal_sys.c.

I am resending this series because it has been idling in the mainling list
for some months already. So, before we forget them, I decided to resend.

Again, one important change is the netlink channel, which I am proposing
to have the zone id in each message.

So far, looks like we can deprecate this API, but in this series, I keep
it but now every message has the zone id.

All best,

Eduardo Valentin (4):
  thermal: Use thermal zone device id in netlink messages
  thermal: remove unnecessary include
  thermal: cleanup: use dev_* helper functions
  thermal: check for invalid trip setup when registering thermal device

 Documentation/thermal/sysfs-api.txt |    5 +++--
 drivers/thermal/thermal_sys.c       |   22 +++++++++++++++-------
 include/linux/thermal.h             |    6 ++++--
 3 files changed, 22 insertions(+), 11 deletions(-)

-- 
1.7.7.1.488.ge8e1c

