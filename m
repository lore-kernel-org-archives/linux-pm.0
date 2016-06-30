From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] cpuidle: Fix last_residency division
Date: Thu, 30 Jun 2016 19:50:03 +0530
Message-ID: <57752A93.6000502@linux.vnet.ibm.com>
References: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com> <57737AA1.7050201@linaro.org> <alpine.LFD.2.20.1606290944400.24439@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37009 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752521AbcF3OU4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2016 10:20:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5UEKJpA055452
	for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2016 10:20:33 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23utcaer4e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2016 10:20:31 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Fri, 1 Jul 2016 00:20:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id C396B2BB0059
	for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2016 00:20:07 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5UEK7PT10551562
	for <linux-pm@vger.kernel.org>; Fri, 1 Jul 2016 00:20:07 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5UEK6DQ013987
	for <linux-pm@vger.kernel.org>; Fri, 1 Jul 2016 00:20:07 +1000
In-Reply-To: <alpine.LFD.2.20.1606290944400.24439@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, David.Laight@ACULAB.COM, anton@samba.org, linuxppc-dev@lists.ozlabs.org



On 06/29/2016 08:31 PM, Nicolas Pitre wrote:
> On Wed, 29 Jun 2016, Daniel Lezcano wrote:
> 
>> On 06/29/2016 09:06 AM, Shreyas B. Prabhu wrote:
>>> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
>>> index f87f399..c8ea5ad 100644
>>> --- a/drivers/cpuidle/cpuidle.h
>>> +++ b/drivers/cpuidle/cpuidle.h
>>> @@ -68,4 +68,27 @@ static inline void
>>> cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
>>>   }
>>>   #endif
>>>
>>> +/*
>>> + * Used for calculating last_residency in usec. Optimized for case
>>> + * where last_residency in nsecs is < INT_MAX/2 by using faster
>>> + * approximation. Approximated value has less than 1% error.
>>> + */
>>> +static inline int convert_nsec_to_usec(u64 nsec)
>>> +{
>>> +	if (likely(nsec < INT_MAX / 2)) {
>>
>> UINT_MAX ?
> 
> Actually this can be better than that.
> 
>>> +		int usec = (int)nsec;
> 
> First, you'll want an unsigned type. Given the provided argument is u64, 
> we can assume there won't be any negative values here.
> 
> Then it would be wise to use a type with an explicit width, like U32.

Cool. I wanted to avoid multiple casts. i.e u64 -> u32 -> int. But I
guess there is no real need to avoid it.

Sending v4 with your suggestions.

Thanks,
Shreyas

