From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
Date: Thu, 23 Jun 2016 19:05:11 +0530
Message-ID: <576BE58F.9030303@linux.vnet.ibm.com>
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com> <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com> <576BABC5.7020600@gmail.com> <576BB395.5050502@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49737 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751644AbcFWNfX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 09:35:23 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5NDTigE019811
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 09:35:22 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23q9ncueb8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 09:35:22 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Thu, 23 Jun 2016 23:35:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 439483578058
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 23:35:15 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5NDZFnU11469262
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 23:35:15 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5NDZEpO003203
	for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 23:35:14 +1000
In-Reply-To: <576BB395.5050502@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Balbir Singh <bsingharora@gmail.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org



On 06/23/2016 03:31 PM, Daniel Lezcano wrote:
> On 06/23/2016 11:28 AM, Balbir Singh wrote:
> 
> [ ... ]
> 
>>> cpuidle_enter_state()
>>> {
>>>     [...]
>>>     time_start = local_clock();
>>>     [enter idle state]
>>>     time_end = local_clock();
>>>     /*
>>>           * local_clock() returns the time in nanosecond, let's shift
>>>           * by 10 (divide by 1024) to have microsecond based time.
>>>           */
>>>          diff = (time_end - time_start) >> 10;
>>>     [...]
>>>     dev->last_residency = (int) diff;
>>> }
>>>
>>> Because of >>10 as opposed to /1000, last_residency is lesser by 2.3%
> 
> I am surprised the last_residency is 2.3% exactly less. The difference
> between >>10 and /1000 is 2.34%.
> 
> What is the next target residency value ?
> 
Target residency of the next idle state is 100 microseconds.
When snooze times out after 100 microseconds, last_residency value
calculated is typically 97 or 98 microseconds.

> Does it solve the issue if you replace >>10 by /1000 ?
> 

Yes it does.

--Shreyas

