From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 02:10:35 +0530
Message-ID: <51914FC3.7080003@linux.vnet.ibm.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:42353 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab3EMUnd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2013 16:43:33 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 14 May 2013 02:09:47 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id C7997E0054
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 02:15:52 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r4DKhNub25297144
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 02:13:23 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r4DKhRCJ025081
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 06:43:28 +1000
In-Reply-To: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Cc: "Rafael J. Wysocki" <rjkw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 05/13/2013 06:31 PM, Jarzmik, Robert wrote:
> Hi Rafael,
> 
> I came across that little odd behavior in "Suspend to RAM" :
>  1) I do a "chmod audio:audio /sys/devices/system/cpu1/cpufreq/scaling_max_freq (I know, stupid, but it's for the example)
>  2) I do a "echo mem > /sys/power/state"
>  3) I resume the kernel
>      => here the permissions of /sys/devices/system/cpu1/cpufreq/scaling_max_freq have turned back to root:root
> 
> OK, fair well, I add a UDEV rule which does a "chown audio:audio /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq" upon udev event "online, /sys/...".
> And here it becomes interesting :
>  - the udev event "offline" or "online" never comes with the "Suspend to RAM" testcase
>  - but the same udev event comes when I manually do a "echo 0 > /sys/devices/system/cpu/cpu1/online"
> 
> So my question is : is it intended behavior that no udev offline/online event happens on S3 for non-boot CPUs, or is it something I should try to fix ?
>

IMHO, using CPU hotplug (offline/online of CPUs) in the S3 path is
supposed to be totally internal to the suspend/resume code.
It is not intended for userspace to know that we are internally
offlining/onlining CPUs. So I'm not surprised that udev events
are not triggered for hotplug in S3 path. And that's not a bug,
if you ask me. (And yes, even code-wise, we use a slightly different
path in the S3 code, to initiate hotplug. That's why the uevents
are by-passed.)

The user initiated an S3 operation, not CPU hotplug. So there is
no reason to surprise the user with unexpected events.
Put another way, in the future, if we change the kernel code
to do S3 without using hotplug, then there should be no visible
change in userspace, because how S3 is handled in the kernel is
intended to be an "internal" operation. 

Regards,
Srivatsa S. Bhat

