From: Matthias Larisch <mail@matthias-larisch.de>
Subject: Processor Package C6 state does not work on real idle Intel Core I
 first generation (Westmere/Arrandale)
Date: Wed, 10 Apr 2013 13:48:03 +0200
Message-ID: <20130410134803.7788494f@purefruit.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.mlh-server.de ([5.9.104.232]:56411 "EHLO
	mail.mlh-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3DJMEw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 08:04:52 -0400
Received: from purefruit.fritz.box (dhcp-95-88.wlan1.uni-oldenburg.de [134.106.95.88])
	(Authenticated sender: mail@matthias-larisch.de)
	by mail.mlh-server.de (Postfix) with ESMTPSA id 013FE3070E7
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 13:47:48 +0200 (CEST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello all,

I recently discovered a problem that I verified with my Lenovo X201 and my
Lenovo T410 (both using Core-I5 520m Intel Westmere/Arrandale processor).


Problem is:
Real idle system (very low wakeup count, c6 residencies above 50-100ms as shown
by powertop) DO NOT stay in package C6 so use much more power!

I also posted this in german thinkpad forum but there have been no comments so
far:
http://thinkpad-forum.de/threads/157461-X201-i5-520m-Package-C6-nur-_mit_-CPU-Last

Steps to reproduce:
- Kill all running processes generating wakeups (stop X)
- verify number of wakeups with powertop, should stay below 3-5/second
- verify C6 residency per core with powertop. Should be above 100ms
- See Package-C6 percentage: Will be at 40-70%, PC3 also very low (sum << 80)
- Generate light load in second terminal: while [ 1 ]; do sleep 0.1; done

- See Package-C6 percentage rising and power usage (checked both via ACPI and
  wall meter) going down about 3-4W although C6 residency per core will go down
  to 10-20ms and wakeups go up


Can anyone point me to some tools I can use to dig further into this? There has
to be some kind of wakeup source from PC6 (outside Kernel maybe?) but no signal
to go into pc6 again. 


Kernel from T410:
Linux purefruit 3.8.3-2-ck #1 SMP PREEMPT Tue Mar 19 11:53:17 CET 2013 x86_64
GNU/Linux

Kernel on X201 is also the 3.8.3-2 without CK.

Checked both with archlinux LTS kernel (3.0.72-1), same problem there.

Any ideas?

Thanks a lot,
Matthias Larisch
