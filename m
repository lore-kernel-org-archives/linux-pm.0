From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 173361] Under heavy load, the CPU speed suddenly and
 irreversibly drops from 3500 to 400 MHz
Date: Thu, 29 Sep 2016 16:40:29 +0000
Message-ID: <bug-173361-137361-df12pSOD59@https.bugzilla.kernel.org/>
References: <bug-173361-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753890AbcI2Qkc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Sep 2016 12:40:32 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 33BB62038E
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 16:40:31 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 1CE0B20260
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 16:40:30 +0000 (UTC)
In-Reply-To: <bug-173361-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=173361

Doug Smythies <dsmythies@telus.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dsmythies@telus.net

--- Comment #1 from Doug Smythies <dsmythies@telus.net> ---
For what it is worth, some data from my computer:

. I get the exact same steady state temperature and package power under full
load with both kernel 4.7 and 4.8-rc8.

. I messed with the cooling so that it could exceed the high limit, and when it
did nothing tripped (as expected):

doug@s15:~/temp2$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +81.0°C  (high = +80.0°C, crit = +98.0°C)
Core 0:         +77.0°C  (high = +80.0°C, crit = +98.0°C)
Core 1:         +81.0°C  (high = +80.0°C, crit = +98.0°C)
Core 2:         +77.0°C  (high = +80.0°C, crit = +98.0°C)
Core 3:         +78.0°C  (high = +80.0°C, crit = +98.0°C)

For this comment from the e-mail thread: "Hmm, I would not expect the CPU to
drop from 80 to 40 degrees in a few seconds if the fan is not spinning.  I
wouldn't even expect it if the fan was spinning.  I would think at least 30 to
60 seconds if not more."

I from a steady state, full load, temperature of 78 degrees C to 0 load I see:
15 degrees drop in 1 second; 18 degrees drop in 2 seconds; 22 degrees drop in
10 seconds; 25 degrees droop in 20 seconds.

For the original post comment: "In that case, the bug would be that the
frequency is never restored."
It isn't supposed to restore. I do not know why in this case it is kicking in
at 50%, usually it is less. Regardless, the current control algorithm in the
intel_pstate driver is fundamentally incompatible with clock modulation, and
will always drive the CPU down to the minimum * the modulation %, regardless of
load. Other drivers typically drive the CPU frequency to what would normally be
desired * modulation % (and for the most part users don't even notice).

-- 
You are receiving this mail because:
You are the assignee for the bug.