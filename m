From: Zoran Markovic <zoran.markovic@linaro.org>
Subject: [RFC PATCHv2 0/2] power: device suspend/resume watchdog
Date: Fri, 10 May 2013 14:28:47 -0700
Message-ID: <1368221329-1841-1-git-send-email-zoran.markovic@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52876 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab3EJV3a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2013 17:29:30 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp2so354214pbb.36
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2013 14:29:29 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Zoran Markovic <zoran.markovic@linaro.org>, Android Kernel Team <kernel-team@android.com>, Colin Cross <ccross@android.com>, Todd Poynor <toddpoynor@google.com>, San Mehat <san@google.com>, Benoit Goby <benoit@android.com>, John Stultz <john.stultz@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi all,
Attached are two patches addressing comments on the implementation
of device suspend (and resume) watchdogs from the android kernel. I have
squashed changes for the suspend and resume watchdogs as they address
pretty much the same functionality, and also added compile-time
configurability of the watchdogs.

Please be kind to review and comment if it is ready for upstreaming.

Best regards,
Zoran

Cc: Android Kernel Team <kernel-team@android.com>
Cc: Colin Cross <ccross@android.com>
Cc: Todd Poynor <toddpoynor@google.com>
Cc: San Mehat <san@google.com>
Cc: Benoit Goby <benoit@android.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Benoit Goby (1):
  drivers: power: Add watchdog timer to catch drivers which lockup
    during suspend/resume.

Zoran Markovic (1):
  PM: compile-time configuration of device suspend/resume watchdogs.

 drivers/base/power/main.c |   87 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/Kconfig      |   48 +++++++++++++++++++++++++
 2 files changed, 135 insertions(+)

-- 
1.7.9.5

