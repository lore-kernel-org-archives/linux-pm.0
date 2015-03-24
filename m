From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/3] Thermal: thermal enhancements for boot and system sleep
Date: Tue, 24 Mar 2015 13:21:27 +0800
Message-ID: <1427174490-7974-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64496 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbbCXFXj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 24 Mar 2015 01:23:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>

Currently, there are a couple of problems in thermal core framework after boot
and resume from system sleep state, because the thermal zone devices are not
put into a proper state in these cases.

Details of the problems are described in the patch change logs.

In general, altogether they fix three bugs
https://bugzilla.kernel.org/show_bug.cgi?id=78201
https://bugzilla.kernel.org/show_bug.cgi?id=91411
https://bugzilla.kernel.org/show_bug.cgi?id=92431

Bug 78201 needs patch 1/3 and 2/3.
Bug 91411 and 92431 are regressions caused by
commit 19593a1fb1f6718406afca5b867dab184289d406
Author: Aaron Lu <aaron.lu@intel.com>
Date:   Tue Nov 19 16:59:20 2013 +0800

    ACPI / fan: convert to platform driver

    Convert ACPI fan driver to a platform driver for the purpose of phasing
    out ACPI bus.

    Signed-off-by: Aaron Lu <aaron.lu@intel.com>
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>

which is shipped in 3.18.

Bug 91411 needs patch 1/3, 2/3 to fix, while 92431 needs all three patches.

If possible, I'd like to push these patches into 4.0-rc and 3.18/3.19 stable
kernel as it actually fixes a regression in 3.18.

Any comments are welcome.

thanks,
rui
