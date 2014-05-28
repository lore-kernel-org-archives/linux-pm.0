From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/4] fix spurious wake from suspend to freeze caused by ACPI battery driver
Date: Wed, 28 May 2014 15:23:34 +0800
Message-ID: <1401261818-2978-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40127 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859AbaE1HXm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 May 2014 03:23:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, anton@enomsg.org, Zhang Rui <rui.zhang@intel.com>

Hi, all,

There is a bug report complaining about spurious wake from suspend to freeze.
And I can reproduce the problem on a Toshiba PORTEGE Z830 ultrabook.
https://bugzilla.kernel.org/show_bug.cgi?id=76221

The root cause is that,
1. ACPI battery device receives an ACPI notification about battery remaining
capacity change every 10 seconds.
2. commit 948dcf96622814d2a850a12851d27824530a9747 registers a wakeup source
for every power supply device, to prevent the system from sleeping when there
is a power supply event.

And this results in that the ACPI notification wakes the system up from
suspend-to-freeze shortly.

As ACPI battery driver has the knowledge of whether an important battery change
happens, e.g. battery remaining capacity critical low, etc, it is reasonable
to have its own wakeup source and wakeup the system only when necessary.
And this patch set is made to fix the problem in this way.

Any comments are welcome.

thanks,
rui
