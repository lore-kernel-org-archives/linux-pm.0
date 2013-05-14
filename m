From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 19:46:24 +0530
Message-ID: <51924738.2000301@linux.vnet.ibm.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <4D68720C2E767A4AA6A8796D42C8EB59C8E7D8@BGSMSX101.gar.corp.intel.com> <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com> <2258179.54N0npf6HW@vostro.rjw.lan> <65F5F98566038744B1B43C8FD3B7549F1911A4A2@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:40060 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab3ENOTe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2013 10:19:34 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 15 May 2013 11:17:06 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id ABD962BB004F
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2013 00:19:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r4EE5Rsu21168212
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2013 00:05:27 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r4EEJPvQ004254
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2013 00:19:26 +1000
In-Reply-To: <65F5F98566038744B1B43C8FD3B7549F1911A4A2@IRSMSX104.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "R, Durgadoss" <durgadoss.r@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 05/14/2013 07:31 PM, Jarzmik, Robert wrote:
> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
> Sent: Tuesday, May 14, 2013 2:59 PM
> To: Jarzmik, Robert
> Cc: R, Durgadoss; Srivatsa S. Bhat; Viresh Kumar; linux-pm@vger.kernel.org; Greg Kroah-Hartman
> Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
> 
[...]
>> One can argue that we're doing too much during system suspend, because what we really need is the _cpu_down() down the road.  That said we need to let cpufreq (and other subsystems too) know that this CPU is gone temporarily and it is good to have a clean state in case it doesn't come up later.
> Agreed.
> 
>> So I think that the cleanest way to address this issue would be to rearrange the code so that the sysfs is not modified by suspend/resume at all, unless the resume fails, but I don't think it's going to be easy to make that happen.
> I think I miss the point in there, as a failing resume path
> should be catchable in the cpufreq framework. Well,
> I should have a closer look in here.
> 

Please take a look at the v2 of the patch that I sent out
just now. IMHO it addresses Rafael's concern adequately.

Regards,
Srivatsa S. Bhat

