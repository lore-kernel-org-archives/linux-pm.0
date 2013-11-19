From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH 0/2] power_supply: Fix Oops from NULL pointer dereference from wakeup_source_activate
Date: Tue, 19 Nov 2013 08:59:34 -0700
Message-ID: <cover.1384875691.git.shuah.kh@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:56201 "EHLO
	qmta09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753143Ab3KSP7l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2013 10:59:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: len.brown@intel.com, pavel@ucw.cz, rjw@rjwysocki.net, gregkh@linuxfoundation.org, anton@enomsg.org, dwmw2@infradead.org
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

power_supply_register() calls device_init_wakeup() to register a wakeup
source before initializing dev_name. As a result, device_wakeup_enable()
end up registering wakeup source with a null name when wakeup_source_register()
gets called with dev_name(dev) which is null at the time.

device_wakeup_enable() uses dev_name(dev) as the wakeup source name.
When it gets called with a device with its name not yet set, ws structure
with ws->name = NULL gets created.

When kernel is booted with wakeup_source_activate enabled, it will panic
when the trace point code tries to dereferences ws->name.

This patch series fixes power_supply_register() to initialize the device name
prior to calling device_init_wakeup() and adds WARN_ON on null device name to
device_wakeup_enable() to detect driver bugs that result in calling
device_wakeup_enable() before device is fully initialized with its name in
device_wakeup_enable().

It is important that these two fixes to be pulled in together as a series. The
change to add WARN_ON on null device name without the power_supply_register()
fix will result in early boot panics when AC Adapter and Battery device drivers
try to register wakeup source.

Shuah Khan (2):
  power_supply: Fix Oops from NULL pointer dereference from
    wakeup_source_activate
  power: Change device_wakeup_enable() to WARN_ON on null dev_name(dev)

 drivers/base/power/wakeup.c       |  3 +++
 drivers/power/power_supply_core.c | 12 ++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
1.8.3.2

