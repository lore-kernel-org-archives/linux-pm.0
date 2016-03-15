From: nishtala <rajiv.nishtala@bsc.es>
Subject: Questions about sleep states on ARM Juno R0
Date: Tue, 15 Mar 2016 13:50:33 +0100
Message-ID: <56E80519.1040400@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:49159 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932564AbcCOMu0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Mar 2016 08:50:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


In response to the discussion here 
(https://community.arm.com/thread/9382). I'm continuing my follow-up 
question.

Sudeep here says to read the sysfs files to get usage/time to understand 
the sleep-state residency of the cores/cluster.

To look at the sysfs files, I wrote a version of a watchdog which 
essentially prints out the difference in "usage", if
it changes in the last 0.01s (it is a LARGE interval relative to update 
period of sysfs files).

The questions I have are the following:
- When the system is idle, that is, no user initiated tasks are running; 
I expected the counter for "usage" in CLUSTER_SLEEP_0 to remain 
constant, because you don't exit
until any kernel interrupts occur, and is guaranteed to stay atleast for 
3500us while the "time" in the same category to increase.

However, what I notice is that "usage" ALSO increases, which is 
something I do not understand.

- When I run an application only on small OR big cores, the counter 
"usage" for CPU_SLEEP_0 on the other type of core (big/small) still 
isn't updated.
Am I missing something here?

- Similarly, when I have an application that does only computations on 
both big AND small cores simultaneously, how come the counter, "usage", 
for CLUSTER_SLEEP_0 increases?
Shouldn't it remain constant?

- How come value of "CLUSTER_SLEEP_0" (on a57 cluster) increases when 
there is actually something running on it. How is it computed?

Any help would be highly appreciated.

Best Regards,
Rajiv Nishtala

WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
