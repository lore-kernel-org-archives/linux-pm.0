From: Guenter Roeck <linux@roeck-us.net>
Subject: Calling device_init_wakeup() on driver removal
Date: Sat, 14 Jan 2017 20:46:05 -0800
Message-ID: <b4f92201-77f6-4a15-81cf-8f2f384d0c1f@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44606 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdAOEqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Jan 2017 23:46:09 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi folks,

while looking through driver initialization and removal functions, I noticed that many drivers
call device_init_wakeup(dev, false) in the removal function. Given that the driver is about
to be removed, that doesn't make much sense to me, especially since device_wakeup_disable()
is called from device_pm_remove() anyway.

Is it safe to assume that all those calls can be removed, or is there a possible reason for
keeping them around ?

Thanks,
Guenter
