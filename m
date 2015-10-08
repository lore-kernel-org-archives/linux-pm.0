From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/2] PM / sleep: prohibit devices probing during suspend/hibernation
Date: Thu, 8 Oct 2015 11:57:05 -0500
Message-ID: <1444323427-6822-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57640 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964928AbbJHQ5T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 12:57:19 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Thierry Reding <thierry.reding@gmail.com>

The main goal of this patchset is to ensure that devices probing will not
happen during system transition to low power states like suspend or
hibernation, because it is unsafe [1] and system behavior will be
unpredictable in this case (for example: after successful probe the device
potentially has a different set of PM callbacks than before [2]).

Tested on dra7-evm using a simple kernel module which only does 
msleep(5000) in its probe.
Test cmd: insmod test_probe.ko & echo mem > sys/power/state
 - suspend will wait for test_probe to finish

[1] https://lkml.org/lkml/2015/9/11/554
[2] https://lkml.org/lkml/2015/9/15/1039
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Grygorii Strashko (2):
  PM / sleep: ensure deferred probe workqueue is finished in wait_for_device_probe
  PM / sleep: prohibit devices probing during suspend/hibernation

 drivers/base/base.h       |  1 +
 drivers/base/dd.c         | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/base/power/main.c | 13 +++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.5.1

