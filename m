From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 10:05:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305141001400.1130-100000@iolanthe.rowland.org>
References: <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56412 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757475Ab3ENOFD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2013 10:05:03 -0400
In-Reply-To: <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, 14 May 2013, Jarzmik, Robert wrote:

> > Okay, agreed after looking at this discussion ;) I am fine with the approach of kernel preserving permissions too.
> 
> Ok, that's great, yet I don't see a clean solution here.  This is
> the path I see and that bothers me in the S3 suspend path:
> cpufreq_sysfs_release
>   kobject_cleanup
>     kobject_release
>       kobject_put
>         __cpufreq_remove_dev
>           cpufreq_cpu_callback
>             notifier_call_chain
>               __raw_notifier_call_chain
>                 __cpu_notify
>                   _cpu_down
> 
> Here the sysfs attributes are destroyed. Cpu onlining will
> recreate them with root permissions. I don't see a good clean way
> to preserve permissions in sysfs across suspend/resume for
> deleted nodes. Do you ?
> 
> And here we come to my actual worry : what is the technical clean
> way to solve this problem ?
> 
> So far I have no idea (the cpufreq example is only a subset of
> the cases where it could happen). So if someone comes up with a
> good idea I'll volunteer to implement it :)

The right way to solve this problem is to add a new state.  As I
understand it, right now CPUs can be either present (active) or not
present (inactive).  What you want is a third state in which the CPU is
present but inactive.  Then all the device-core stuff (including sysfs
attributes) can remain unchanged, and eventually the CPU is either
reactivated or removed.

Alan Stern

