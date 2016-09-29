From: gmane@chmurka.net (Adam Wysocki)
Subject: Battery voltage unknown during charging
Date: Thu, 29 Sep 2016 13:30:49 +0000 (UTC)
Message-ID: <0Tctlp67I5v8Nv8%gof@news.chmurka.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:47348 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbcI2NfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2016 09:35:23 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gll-linux-pm2@m.gmane.org>)
        id 1bpbUR-0004GI-1r
        for linux-pm@vger.kernel.org; Thu, 29 Sep 2016 15:35:07 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I hope it's the right list to ask.

I'm writing a driver to report battery state on HP Jornada 720 handheld 
PC. Hardware provides the raw value read from ADC (corresponding to the 
voltage) and two binary values: whether AC power is connected or not, and 
whether battery is charging or charged. It doesn't have any fuel gauge IC.

The problem is that during charging the ADC value doesn't reflect the 
actual battery voltage. It is reliable only during discharging.

Is there a way to reflect this in the driver? What should I return in 
POWER_SUPPLY_VOLTAGE_NOW property when the battery is being charged and 
ADC returns garbage? Maybe I return some error (which one?) in my 
get_property function then?

Also, if the hardware doesn't provide the capacity (percentage), should it 
be calculated in the driver or not? The same about capacity_level (full, 
high, medium, low, critical)... it's not reported by hardware, but can be 
easily calculated. My understanding after reading power_supply_class.txt 
is that the first one shouldn't be calculated, but I'm not sure about the 
second one.

Thank you!

-- 
http://www.chmurka.net/

