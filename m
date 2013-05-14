From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 15:39:47 +0530
Message-ID: <51920D6B.7030904@linux.vnet.ibm.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <51914FC3.7080003@linux.vnet.ibm.com> <2474384.pn7hhNIAGR@vostro.rjw.lan> <65F5F98566038744B1B43C8FD3B7549F191199BC@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:32955 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab3ENKN6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2013 06:13:58 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 14 May 2013 20:02:47 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 814862CE8055
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 20:12:49 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r4E9we3L19726512
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 19:58:41 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r4EACl7W029705
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 20:12:48 +1000
In-Reply-To: <65F5F98566038744B1B43C8FD3B7549F191199BC@IRSMSX104.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On 05/14/2013 02:36 PM, Jarzmik, Robert wrote:
> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
> Sent: Tuesday, May 14, 2013 1:33 AM
> To: Srivatsa S. Bhat; Jarzmik, Robert
> Cc: linux-pm@vger.kernel.org
> Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
> 
>>> So my question is : is it intended behavior that no udev offline/online event happens on S3 for non-boot CPUs, or is it something I should try to fix ?
>>
>> IMHO, using CPU hotplug (offline/online of CPUs) in the S3 path is 
>> supposed to be totally internal to the suspend/resume code.
>> It is not intended for userspace to know that we are internally 
>> offlining/onlining CPUs. So I'm not surprised that udev events are not 
>> triggered for hotplug in S3 path. And that's not a bug, if you ask me. 
>> (And yes, even code-wise, we use a slightly different path in the S3 
>> code, to initiate hotplug. That's why the uevents are by-passed.)
>>
>> The user initiated an S3 operation, not CPU hotplug. So there is no 
>> reason to surprise the user with unexpected events.
> Hi Srivatsa,
> 
> But the user actually *is* very surprised to have "lost" his
> permissions to write to scaling_max_freq.

And losing permissions isn't specific to suspend-to-ram right?
You said that yourself, that on regular cpu online/offline you lose
the changed permissions. So just write a resume hook to restore whatever
permissions you want after suspend-resume. See /usr/lib64/pm-utils/sleep.d
for some sample resume scripts.

> Or, told differently,
> if a userspace process handles this scaling_max_freq based on
> thermal values for example, a suspend/resume will impede his
> capacity to throttle the CPU, and the CPU will overheat.
> 
> A good example is an Android phone : imagine the thermal will not
> be able anymore to throttle the CPU, the phone will become hot
> and possibly burn the user (yeah, that's not very probable but
> still ...).
> 
> So you say "there is no reason to surprise the user with
> unexpected events", and I say "this is a bug that permissions of
> a /sys file change because a suspend/resume happened". Now if I'm
> right, what could be done to keep these permissions, other than
> adding a udev event ?
> 

The point I was trying to make is that expecting udev events for
CPU online/offline during S3 is wrong. Nobody is supposed to know that
we are offlining/onlining CPUs under-the-hood.
If you want to do something special on resume, use a resume script
that is automatically invoked for you upon system resume.

Regards,
Srivatsa S. Bhat

