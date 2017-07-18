From: Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 0/4] PM / Suspend: Print wall time
Date: Tue, 18 Jul 2017 10:24:22 -0700
Message-ID: <20170718172443.114401-1-salyzyn@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35487 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdGRRZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 13:25:12 -0400
Received: by mail-pf0-f176.google.com with SMTP id e199so14471958pfh.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 10:25:12 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>

Helpful for post-mortem analysis to synchronize CLOCK_MONOTONIC
kernel logs with CLOCK_REALTIME user space logs.  Post-mortem
analysis for Battery and Power diagnosis.  Improved reporting
of suspension times against the rtc wallclock, which is
persistent even at the lowest power management states.

analyze_suspend.py requires a configured kernel to debug, these
prints can remain in a field product with CONFIG_RTC_TIME_SHOW.

Sincerely -- Mark Salyzyn
