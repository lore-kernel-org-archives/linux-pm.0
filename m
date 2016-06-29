From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] cpuidle: Fix last_residency division
Date: Wed, 29 Jun 2016 14:29:36 +0530
Message-ID: <57738DF8.3000909@linux.vnet.ibm.com>
References: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com> <57737AA1.7050201@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36335 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141AbcF2JAZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2016 05:00:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5T90KtO141350
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 05:00:25 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23usua5236-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 05:00:23 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Wed, 29 Jun 2016 18:59:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 32EB82CE8046
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 18:59:41 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5T8xfSq12190142
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 18:59:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5T8xdId024241
	for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 18:59:40 +1000
In-Reply-To: <57737AA1.7050201@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org, mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM, arnd@arndb.de, Nicolas Pitre <nicolas.pitre@linaro.org>


>>
>> +/*
>> + * Used for calculating last_residency in usec. Optimized for case
>> + * where last_residency in nsecs is < INT_MAX/2 by using faster
>> + * approximation. Approximated value has less than 1% error.
>> + */
>> +static inline int convert_nsec_to_usec(u64 nsec)
>> +{
>> +    if (likely(nsec < INT_MAX / 2)) {
> 
> UINT_MAX ?

I don't think I can use UINT_MAX here since usec += usec >> 5 can
overflow. Also using INT_MAX / 2 instead of INT_MAX since potentially
usec += usec >> 5 can be negative and usec >> 10 will retain the sign bit.

> 
>> +        int usec = (int)nsec;
>> +
>> +        usec += usec >> 5;
>> +        usec = usec >> 10;
>> +        return usec;
>> +    } else {
>> +        u64 usec = div_u64(nsec, 1000);
>> +
>> +        if (usec > INT_MAX)
>> +            usec = INT_MAX;
>> +        return (int)usec;
>> +    }
>> +}
> 

Thanks,
Shreyas

