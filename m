From: Michael Karcher <Michael.Karcher@fu-berlin.de>
Subject: power management regression in linux 3.10?
Date: Mon, 03 Jun 2013 19:56:15 +0200
Message-ID: <1370282175.18020.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54316 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753590Ab3FCSDI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2013 14:03:08 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.80.1)
          for linux-pm@vger.kernel.org with esmtp
          (envelope-from <Michael.Karcher@fu-berlin.de>)
          id <1UjYyY-002WUX-VC>; Mon, 03 Jun 2013 19:55:22 +0200
Received: from port-92-204-81-8.dynamic.qsc.de ([92.204.81.8] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.80.1)
          for linux-pm@vger.kernel.org with esmtpsa
          (envelope-from <Michael.Karcher@fu-berlin.de>)
          id <1UjYyY-000p07-Q8>; Mon, 03 Jun 2013 19:55:22 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I am using an IBM ThinkPad T60 (i915, Core 2 Duo T7200) and recently
upgraded from a custom 3.7 kernel to a custom 3.10-rc4 kernel
(v3.10-rc4-1-gc026d8e).
After upgrading, I get around 17-20W power usage instead of 12-15W power
usage as I had with 3.7. powertop show that CPU0 is in state POLL all of
the idle time, while CPU1 correctly enters C3.

As this may be caused by my kernel configuration, I pastebinned
my .config to http://pastebin.ca/2388457. Note that I am using
CONFIG_NO_HZ_FULL, which might be nonstandard and actually not sensible
for a standard single-user laptop system with GUI.

Do you want me to try something to debug the problem?

Regards,
  Michael Karcher


