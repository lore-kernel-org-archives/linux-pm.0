From: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Subject: RE: S3, SMP non boot cpus and
 /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 09:06:34 +0000
Message-ID: <65F5F98566038744B1B43C8FD3B7549F191199BC@IRSMSX104.ger.corp.intel.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com>
 <51914FC3.7080003@linux.vnet.ibm.com> <2474384.pn7hhNIAGR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59849 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756288Ab3ENJGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2013 05:06:38 -0400
In-Reply-To: <2474384.pn7hhNIAGR@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

-----Original Message-----
From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
Sent: Tuesday, May 14, 2013 1:33 AM
To: Srivatsa S. Bhat; Jarzmik, Robert
Cc: linux-pm@vger.kernel.org
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq

> > So my question is : is it intended behavior that no udev offline/online event happens on S3 for non-boot CPUs, or is it something I should try to fix ?
> 
> IMHO, using CPU hotplug (offline/online of CPUs) in the S3 path is 
> supposed to be totally internal to the suspend/resume code.
> It is not intended for userspace to know that we are internally 
> offlining/onlining CPUs. So I'm not surprised that udev events are not 
> triggered for hotplug in S3 path. And that's not a bug, if you ask me. 
> (And yes, even code-wise, we use a slightly different path in the S3 
> code, to initiate hotplug. That's why the uevents are by-passed.)
> 
> The user initiated an S3 operation, not CPU hotplug. So there is no 
> reason to surprise the user with unexpected events.
Hi Srivatsa,

But the user actually *is* very surprised to have "lost" his
permissions to write to scaling_max_freq. Or, told differently,
if a userspace process handles this scaling_max_freq based on
thermal values for example, a suspend/resume will impede his
capacity to throttle the CPU, and the CPU will overheat.

A good example is an Android phone : imagine the thermal will not
be able anymore to throttle the CPU, the phone will become hot
and possibly burn the user (yeah, that's not very probable but
still ...).

So you say "there is no reason to surprise the user with
unexpected events", and I say "this is a bug that permissions of
a /sys file change because a suspend/resume happened". Now if I'm
right, what could be done to keep these permissions, other than
adding a udev event ?

> Put another way, in the future, if we change the kernel code to do S3 
> without using hotplug, then there should be no visible change in 
> userspace, because how S3 is handled in the kernel is intended to be 
> an "internal" operation.
Yep.


Cheers.

--
Robert

PS: My first experience with Outlook instead of my usual Gnus doesn't
promise a great future cooperation. I'm sorry for mail formatting ...

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

