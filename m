From: Michael Heinemann <posted@heine.so>
Subject: sbs-battery: Reading CHARGE in uAh
Date: Thu, 06 Jul 2017 17:23:02 +0200
Message-ID: <d760d0a1b38fbda966caaefc63677a56@heine.so>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:56658 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbdGFPcM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jul 2017 11:32:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 2F1664380064
        for <linux-pm@vger.kernel.org>; Thu,  6 Jul 2017 17:23:05 +0200 (CEST)
Received: from _ (frachter.stresser.de [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id 38FCD4380063
        for <linux-pm@vger.kernel.org>; Thu,  6 Jul 2017 17:23:03 +0200 (CEST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org



Hi,

I got an INSPIRED ENERGY NH2057 Battery which is compliant to SBS 
Specification Version 1.1.

The Battery is generally working but I noticed that the values I get 
from sysfs for the CHARGE values
are identical to the values I get as ENERGY and they are in uWh. 
According to the power_supply_class
documentation CHARGE should be in uAh and ENERGY in uWh.

So I took a look into the drivers/power/supply/sbs-battery.c and noticed 
a possible bug in the code
when switching from BATTERY_MODE_WATTS to BATTERY_MODE_AMPS:

The configuration bit, according to the SBS Spec, is bit 15 of the 
BatteryMode Register.

These two modes are reflected in the code as:

enum sbs_battery_mode {
	BATTERY_MODE_AMPS,
	BATTERY_MODE_WATTS
};

When I look into the 'sbs_set_battery_mode' function I don't see any 
point where these mode bits are
shifted to bit 15. When I debug I only see the register being changed 
from 0x8000 to 0x8001 and back.

So I'm a bit confused, is this actually working for somebody? I see in 
the 'for-next' branch [1] that
there is currently work done to add a mutex to the mode switch. So at 
least it seems to be working for
some people. But I don't see why. Am I missing something?


Regards,
Michael

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/drivers/power/supply/sbs-battery.c?h=for-next
