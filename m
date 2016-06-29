From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpuidle: Fix last_residency division
Date: Wed, 29 Jun 2016 12:30:35 +0530
Message-ID: <57737213.4070204@linux.vnet.ibm.com>
References: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com> <14940457.SEYBmqcunj@wuerfel> <576D595F.9090001@linux.vnet.ibm.com> <3748080.8f21OXxXix@wuerfel> <063D6719AE5E284EB5DD2968C1650D6D5F4E4E87@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47841 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251AbcF2HAp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2016 03:00:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5T6sWue134224
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 03:00:44 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23usua184r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 03:00:44 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Wed, 29 Jun 2016 17:00:41 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 356DF357805A
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 17:00:40 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5T70e7f1507608
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 17:00:40 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5T70co3023221
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 17:00:39 +1000
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4E4E87@AcuExch.aculab.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>, 'Arnd Bergmann' <arnd@arndb.de>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "anton@samba.org" <anton@samba.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 06/27/2016 02:29 PM, David Laight wrote:
> From: Arnd Bergmann
>> Sent: 24 June 2016 20:43
>> On Friday, June 24, 2016 9:31:35 PM CEST Shreyas B Prabhu wrote:
>>>> If those functions are called less often than cpuidle_enter_state(),
>>>> we could just move the division there. Since the divisor is constant,
>>>> do_div() can convert it into a multiply and shift, or we could use
>>>> your the code you suggest above, or use a 32-bit division most of
>>>> the time:
>>>>
>>>>       if (diff <= UINT_MAX)
>>>>               diff_32 = (u32)diff / NSECS_PER_USEC;
>>>>       else
>>>>               diff_32 = div_u64(diff, NSECS_PER_USEC;
>>>>
>>>> which gcc itself will turn into a multiplication or series of
>>>> shifts on CPUs on which that is faster.
>>>>
>>> I'm not sure which division method of the three suggested here to use.
>>> Does anyone have a strong preference?
>>>
>>
>> It depends on how accurate we want it and how long we expect
>> the times to be. The optimization for the 4.2 second cutoff
>> for doing a 32-bit division only makes sense if the majority
>> of the sleep times are below that.
> 
> It also depends if the code actually cares about the length of 'long' sleeps.
> I'd guess that for cpu idle 4.2 seconds is 'a long time', so the div_u64()
> result could be treated as 4.2 seconds without causing grief.
> 
> Actually the cost of a 64bit divide after a 4 second sleep will be noise.
> OTOH a 64bit divide after a sleep that lasted a few ns will be significant.
> 
Agreed. I'll use the code you suggested, with a small change-
Using diff_32 += diff_32 >> 5 instead of diff_32 += diff_32 >> 6
since I want to err on the side of last_residency being more than actual.

And for long sleep cases, I'll use div_u64().

Thanks,
Shreyas

