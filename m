From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] mmc: core: Favor autosuspend at runtime idle
Date: Thu, 10 Oct 2013 12:01:45 +0200
Message-ID: <1381399307-21534-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:54887 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab3JJKB5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2013 06:01:57 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so885619bkb.29
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2013 03:01:56 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, " Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Runtime idle is typically triggered after resume and probe. In these
cases we would like to make use of autosuspend if we have enabled it
earlier, otherwise the device will more or less immediately be
requested to go into in-active state.

As a part of this patchset a new helper function has been added to the
runtime PM API. My suggestion is to collect acks and let Chris merge
the completet patchset through the mmc tree, if that seems acceptable
to everyone.

Ulf Hansson (2):
  PM / Runtime: Add helper function to get value of use_autosuspend
  mmc: core: Use autosuspend at runtime idle

 drivers/mmc/core/bus.c     |    6 ++++++
 include/linux/pm_runtime.h |    6 ++++++
 2 files changed, 12 insertions(+)

-- 
1.7.9.5

