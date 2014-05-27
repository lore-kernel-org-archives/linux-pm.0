From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: governor: Be friendly towards latency-sensitive
 bursty workloads
Date: Tue, 27 May 2014 08:45:52 +0530
Message-ID: <53840368.4030004@linux.vnet.ibm.com>
References: <20140526205337.1100.55275.stgit@srivatsabhat.in.ibm.com> <2902116.OdbNv5KQzQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:39724 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaE0DRK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 23:17:10 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 27 May 2014 13:17:08 +1000
In-Reply-To: <2902116.OdbNv5KQzQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/27/2014 04:57 AM, Rafael J. Wysocki wrote:
> Hi Srivatsa,
> 
> On Tuesday, May 27, 2014 02:23:38 AM Srivatsa S. Bhat wrote:
>> Cpufreq governors like the ondemand governor calculate the load on the CPU
>> periodically by employing deferrable timers. A deferrable timer won't fire
>> if the CPU is completely idle (and there are no other timers to be run), in
>> order to avoid unnecessary wakeups and thus save CPU power.
>>
>> However, the load calculation logic is agnostic to all this, and this can
>> lead to the problem described below.
> 
> This is subtle enough that I need some more time to chew on it, but since the
> merge window is coming, I'm not sure when that's going to happen honestly.
>

Sure, I completely understand. Please take your time, no hurry!

Thank you very much!

Regards,
Srivatsa S. Bhat

