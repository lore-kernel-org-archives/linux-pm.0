From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Wed, 15 May 2013 10:15:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305151012110.1711-100000@iolanthe.rowland.org>
References: <65F5F98566038744B1B43C8FD3B7549F1911B599@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39375 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756609Ab3EOOPm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2013 10:15:42 -0400
In-Reply-To: <65F5F98566038744B1B43C8FD3B7549F1911B599@IRSMSX104.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, 15 May 2013, Jarzmik, Robert wrote:

> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> 
> > The right way to solve this problem is to add a new state.  As I understand it, right now CPUs can be either present (active) or not present (inactive).  What you want is a third state in which the CPU is present but inactive.  Then all the device-core stuff (including sysfs
> > attributes) can remain unchanged, and eventually the CPU is either reactivated or removed.
> 
> Ah, my understanding is much more fuzzy unfortunately.

You probably understand the situation better than I do, though.

> The way I understand CPU states is that each cpu has the following flags (stolen from include/linux/cpumask.h) :
>  - cpu_present
>    If I understand that one, it's when the CPU is physically inserted into the system bus (as when a blade with CPUs is inserted)
>  - cpu_online
>   This one represents if the CPU "has power connected" (or another sentence would be if it can service interrupts and schedule tasks)
>  - cpu_active
>   I think this one is related to the scheduler, which marks a cpu is "active" upon CPU_STARTING notification
> 
> From these 3 masks tuple (present, online, active) I think we can find out if the CPU is really removed or reactivated.
> Of course, if you were speaking about the notifications (ie. include/linu/cpu.h, CPU_*), then I didn't see the distinction between "cpu removal" and "cpu activation". Yet I feel that I'm missing something in your "third state" proposition ... 

Then a suspended CPU should have the cpu_present flag set and the other
two flags clear, right?  And as long as the cpu_present flag is set,
there's no need to remove device- or sysfs-related structures.

Alan Stern

