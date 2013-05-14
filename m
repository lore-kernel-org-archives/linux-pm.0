From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 15:57:39 +0530
Message-ID: <5192119B.4020009@linux.vnet.ibm.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <51914FC3.7080003@linux.vnet.ibm.com>	<2474384.pn7hhNIAGR@vostro.rjw.lan> <65F5F98566038744B1B43C8FD3B7549F191199BC@IRSMSX104.ger.corp.intel.com> <51920D6B.7030904@linux.vnet.ibm.com> <CAKohponfQ11Ak9Q-HmSK83g1XB5_KF0UDHaSQh_jiEZBNtSUMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:48802 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3ENKaj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2013 06:30:39 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 14 May 2013 20:24:17 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id C75F02BB0053
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 20:30:34 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r4EAGRmc21889258
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 20:16:27 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r4EAUXam028752
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 20:30:34 +1000
In-Reply-To: <CAKohponfQ11Ak9Q-HmSK83g1XB5_KF0UDHaSQh_jiEZBNtSUMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Jarzmik, Robert" <robert.jarzmik@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 05/14/2013 03:52 PM, Viresh Kumar wrote:
> On 14 May 2013 15:39, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> And losing permissions isn't specific to suspend-to-ram right?
>> You said that yourself, that on regular cpu online/offline you lose
>> the changed permissions. So just write a resume hook to restore whatever
>> permissions you want after suspend-resume. See /usr/lib64/pm-utils/sleep.d
>> for some sample resume scripts.
> 
> This is what i feel about losing chages on cpu hotplug/unplug:
> - On normal online/offline, we aren't required to preserve earlier settings.

>From Robert's descriptions, we _are_ required to preserve the settings. But
this is somewhat acceptable because the user _knows_ he is doing hotplug.

> - But on suspend/resume, user shouldn't know that cpus have been
>   removed/added and so permissions should stay as is.
>

Hmm, you are right. It is wrong for us to expect the user to use custom scripts
to preserve permissions across S3, since he is supposed to remain ignorant of
CPU hotplug in this path.

> What do you say?
> 

I agree, we should try to fix it for the S3/S4 case. Robert, I'm sorry, you were
right - if S3 is supposed to hide CPU hotplug, it should hide it completely or
not at all. And since we go with the former option, a fix for the permissions
is in order, IMHO.

Regards,
Srivatsa S. Bhat

