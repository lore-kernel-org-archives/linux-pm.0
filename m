From: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Subject: RE: S3, SMP non boot cpus and
 /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Wed, 15 May 2013 09:20:22 +0000
Message-ID: <65F5F98566038744B1B43C8FD3B7549F1911B599@IRSMSX104.ger.corp.intel.com>
References: <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com>
 <Pine.LNX.4.44L0.1305141001400.1130-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42722 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab3EOJUZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2013 05:20:25 -0400
In-Reply-To: <Pine.LNX.4.44L0.1305141001400.1130-100000@iolanthe.rowland.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

-----Original Message-----
From: Alan Stern [mailto:stern@rowland.harvard.edu] 

> The right way to solve this problem is to add a new state.  As I understand it, right now CPUs can be either present (active) or not present (inactive).  What you want is a third state in which the CPU is present but inactive.  Then all the device-core stuff (including sysfs
> attributes) can remain unchanged, and eventually the CPU is either reactivated or removed.

Ah, my understanding is much more fuzzy unfortunately.
The way I understand CPU states is that each cpu has the following flags (stolen from include/linux/cpumask.h) :
 - cpu_present
   If I understand that one, it's when the CPU is physically inserted into the system bus (as when a blade with CPUs is inserted)
 - cpu_online
  This one represents if the CPU "has power connected" (or another sentence would be if it can service interrupts and schedule tasks)
 - cpu_active
  I think this one is related to the scheduler, which marks a cpu is "active" upon CPU_STARTING notification

>From these 3 masks tuple (present, online, active) I think we can find out if the CPU is really removed or reactivated.
Of course, if you were speaking about the notifications (ie. include/linu/cpu.h, CPU_*), then I didn't see the distinction between "cpu removal" and "cpu activation". Yet I feel that I'm missing something in your "third state" proposition ... 

Cheers.

--
Robert

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

