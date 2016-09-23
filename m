From: "doa379@gmail.com" <doa379@gmail.com>
Subject: Linux PM: Suspend to Disk Stalls at 35% RAM consumption
Date: Fri, 23 Sep 2016 10:56:36 +0000
Message-ID: <CANc1tDDWWibn2_btDt4BcHa5p5vy4e+7zMJtRLP65WZfpsMPSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37586 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753578AbcIWK4j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2016 06:56:39 -0400
Received: by mail-wm0-f52.google.com with SMTP id b130so23031079wmc.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2016 03:56:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Re. Kernel 4.4, 4.7.

There is a curious issue with hibernating RAM contents to disk when
RAM consumption reaches around 35%. The system stalls and becomes
non-responsive.

This is running the vanilla kernel without any PM-utils software.

Has anyone seen this issue and any tips on how to further debug?
Recompiling the kernel with additional PM verbose doesn't show
anything peculiar in syslog.
