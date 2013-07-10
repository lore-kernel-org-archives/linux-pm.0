From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [REGRESSION] Commit a66b2e50 "Preserve sysfs files across suspend/resume"
 causes a regression in intel_pstate
Date: Thu, 11 Jul 2013 03:55:04 +0530
Message-ID: <51DDDF40.1000809@linux.vnet.ibm.com>
References: <51DD8890.8040008@gmail.com> <20529831.Jz4xYMjFtS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:53589 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426Ab3GJW2d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2013 18:28:33 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 11 Jul 2013 03:50:56 +0530
In-Reply-To: <20529831.Jz4xYMjFtS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, cpufreq <cpufreq@vger.kernel.org>, durgadoss.r@intel.com, "Jarzmik, Robert" <robert.jarzmik@intel.com>, tianyu.lan@intel.com, Linux PM list <linux-pm@vger.kernel.org>

On 07/11/2013 03:34 AM, Rafael J. Wysocki wrote:
> On Wednesday, July 10, 2013 09:15:12 AM Dirk Brandewie wrote:
>> Hi All,
> 
> Hi,
> 
>> Tianyu debugged into https://bugzilla.kernel.org/show_bug.cgi?id=59781 and found
>> that commit a66b2e50 is causing the regression.
>>
>> Tianyu has proposed a fix (patch attached to bugzilla) but having scaling
>> drivers receive hotplug notifications through two paths seems weird.
>>
>> Looking at the core code and some of the other scaling drivers
>> I don't see an obvious fix.  Maybe adding optional suspend/resume callbacks
>> to the scaling driver interface?
>>
>> All the scaling drivers that need to do stateful  work in the init/exit
>> callbacks are being affected by this change so I think there are other
>> subtle side-effects out there that haven't been noticed yet.
>>
>> I am not sure how we should proceed here?
> 
> Well, first off, I'll queue up a revert of commit a66b2e50, as this was really
> about being nice to user space than anything else.  And it has caused subtle
> problems to happen already elsewhere.
> 
> Then we can figure out how to address the original issue.
> 

Sure, that sounds like a good plan. Sorry about the mess it caused :(
I do have a (large-ish) fix in the works (which I posted in my previous mail),
but reverting the original commit first will be better, especially from the
stable-tree perspective.

I can provide you the revert tomorrow after testing (the revert needs to take
care of commit f51e1eb6 which went in later), but if you do it yourself by then,
you can add my ACK to it.

Thanks a lot!
Regards,
Srivatsa S. Bhat

