From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/5] cpufreq: Remove temporary fix for race between CPU
 hotplug and sysfs-writes
Date: Tue, 10 Sep 2013 14:27:47 +0530
Message-ID: <522EDF0B.60308@linux.vnet.ibm.com>
References: <20130906195206.26919.20884.stgit@srivatsabhat.in.ibm.com> <20130906195353.26919.76123.stgit@srivatsabhat.in.ibm.com> <CAKohpon96ecA3L9ux0tnFngPbWDmrVfW3xUWf_3aZ5qYZGXLVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:55092 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab3IJJBr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2013 05:01:47 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 10 Sep 2013 14:23:27 +0530
In-Reply-To: <CAKohpon96ecA3L9ux0tnFngPbWDmrVfW3xUWf_3aZ5qYZGXLVw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Boyd <sboyd@codeaurora.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 09/10/2013 12:39 PM, Viresh Kumar wrote:
> On 7 September 2013 01:23, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> Commit "cpufreq: serialize calls to __cpufreq_governor()" had been a temporary
>> and partial solution to the race condition between writing to a cpufreq sysfs
>> file and taking a CPU offline. Now that we have a proper and complete solution
>> to that problem, remove the temporary fix.
>>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> ---
> 
> I would still vote for keeping this code or reverting this patch of yours..
> As there might be other scenarios, than hotplug races, where this serialization
> would be useful..
> 

I would say it would be better to first explain those scenarios in detail, and
then justify why this solution is the best one. Without that, it starts appearing
more like premature optimization... and we all know the mess that it can lead to ;-)

Regards,
Srivatsa S. Bhat

