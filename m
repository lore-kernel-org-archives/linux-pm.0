From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] Driver core: Fix driver re-bind/probe-defer for runtime PM cases
Date: Tue, 17 Nov 2015 15:35:27 +0100
Message-ID: <1447770929-16652-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34421 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbbKQOft (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 09:35:49 -0500
Received: by lbbcs9 with SMTP id cs9so6655221lbb.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 06:35:47 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eduardo Valentin <edubezval@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

Because of how some subsystems/drivers deploys runtime PM, it may set certain
requirements on the behaviour of the driver core, but which currently aren't
being full-filled. One may argue that these subsystem/drivers should be fixed,
but from a quick analyze it turned out to be quite a significant amount of code
to change.

Moreover, while considering how the driver core behaves around assigning the
initial states for runtime PM during device registration/unregistration, it
seems reasonable to apply a similar policy when dealing with driver unbind and
probe failures.

These change were initially discussed [1] when Kuninori Morimoto, tried to fix a
regression for re-bind of RCAR's thermal driver.

At that point we looked past two other related issues, during probe defer and
for pm_runtime_irq_safe() devices. This patchset tries to address all the
related problems.

As these issues are generic and have been existing long way back, perhaps we not
only need to consider them for the 4.4 rcs, but also for other stable releases.
At this first version I have decided to not include any fix or stable tag, as I
what like to request your input for this.

[1]
https://lkml.org/lkml/2015/11/9/849

Ulf Hansson (2):
  PM / Runtime: Extend the scope for pm_runtime_remove()
  Driver core: Set initial runtime PM states at probe err and driver
    unbind

 drivers/base/dd.c            |  2 ++
 drivers/base/power/main.c    |  2 +-
 drivers/base/power/power.h   |  6 +++---
 drivers/base/power/runtime.c | 21 +++++++++++++--------
 4 files changed, 19 insertions(+), 12 deletions(-)

-- 
1.9.1

