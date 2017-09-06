From: Johannes Stezenbach <js@sig21.net>
Subject: S0ix failure due to "clk: x86: Do not gate clocks enabled by the
 firmware"
Date: Wed, 6 Sep 2017 22:42:37 +0200
Message-ID: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:53871 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752353AbdIFUmq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Sep 2017 16:42:46 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>

Hi,

I'm poking around on Asus E200HA, based on Atom x5-Z8300 (Cherrytrail),
trying to get S0ix working, atm with gross hacks that are recorded in
https://bugzilla.kernel.org/show_bug.cgi?id=193891


I found commit d31fd43c0f9a4 "clk: x86: Do not gate clocks enabled by the firmware"
prevents S0i3 entry.  Unfortunately the commit message doesn't explain
the problem it fixes, nor does it mention the platform.

How can we fix d31fd43c0f9a4 to not break S0i3?


Johannes
