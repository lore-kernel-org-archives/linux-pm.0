From: Jim Quinlan <jim2101024@gmail.com>
Subject: Linux common clock framework: device with many clocks
Date: Tue, 29 Apr 2014 09:40:26 -0400
Message-ID: <CANCKTBvB4mPmEgwZ-dxxB1aDTQmawXYZyhDMdSh9E7K1Nh6eeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62868 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbaD2Nk1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 09:40:27 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so230827obc.17
        for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2014 06:40:27 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

In most examples of .dtsi files I have perused, a device is associated with
typically one clock, maybe two.  In the SoC I'm working on, some devices
need to turn off multiple clocks for PM, as many as 13.   The driver gets
the clocks from the device tree, and when the driver wants to turn off
clocks to the device, it loops through all 13 clocks.

I'm wondering if is possible to abstract a group of many clocks into one
"software clock". Invoking clk_disable() on said software clock would
effect the iteration of clk_disable() on all 13 of the clocks it governs.
 Enabling would effect clk_enable() on all 13.  This would make the driver
writer's life a little simpler.

I've looked at the Linux Common Clock Framework, and it doesn't really
accommodate multiple active parents as it's somewhat contrary to its
design.  Also, playing with the innards of clk.c is ill-advised.  Should I
just stick to putting iteration over the clocks in all my drivers, or is
there a better way?

--Jim Quinlan
