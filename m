Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ECEC10F13
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 14:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93062077C
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 14:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfDKOoP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:44:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbfDKOoP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2019 10:44:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BEf6LK096214
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2019 10:44:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rt6ugjx97-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2019 10:44:13 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth015@linux.vnet.ibm.com>;
        Thu, 11 Apr 2019 15:44:07 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 15:44:05 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3BEi4Ku35258466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 14:44:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42BEE4204B;
        Thu, 11 Apr 2019 14:44:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AD3242045;
        Thu, 11 Apr 2019 14:44:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.68.79])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 14:44:03 +0000 (GMT)
Subject: Re: [RFC 1/6] Optimize wake-up task for Task Packing heuristic
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-2-parth015@linux.vnet.ibm.com>
 <0b198386-ef0b-75e0-e53a-1160c77326b7@arm.com>
 <60e34244-1e40-e318-080e-e76607bb3d92@linux.vnet.ibm.com>
 <c877a201-2601-5bf4-7c80-0f6b190c1711@arm.com>
From:   Parth Shah <parth015@linux.vnet.ibm.com>
Date:   Thu, 11 Apr 2019 20:14:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c877a201-2601-5bf4-7c80-0f6b190c1711@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041114-0008-0000-0000-000002D8C8B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041114-0009-0000-0000-00002244F11A
Message-Id: <3df9024a-b5a9-434e-8608-216fa93eaad8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110100
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/10/19 10:03 PM, Dietmar Eggemann wrote:
> On 4/7/19 7:57 AM, Parth Shah wrote:
>>
>>
>> On 3/27/19 3:01 PM, Dietmar Eggemann wrote:
>>> Hi Parth,
>>>
>>> On 3/22/19 7:06 AM, Parth Shah wrote:
> 
> [...]
> 
>>>> +    for_each_cpu_wrap(core, cpus, prev_cpu)
>>>> +    {
>>>> +        long unsigned int core_util = 0;
>>>> +        long unsigned int core_cap = core_cap_mf*capacity_of(core)/10;
>>>> +        long unsigned int cache_cpu_util = (unsigned)-1;
>>>> +        long unsigned est_util = 0, est_util_enqueued = 0;
>>>> +        int cache_cpu = core;
>>>> +        struct cfs_rq *cfs_rq;
>>>> +
>>>> +        for_each_cpu(smt, cpu_smt_mask(core)) {
>>>
>>> This one doesn't build for me on arm64 (make defconfig) since it uses cpu_smt_mask() outside the CONFIG_SCHED_SMT guard.
>>>
>>> kernel/sched/fair.c: In function ‘select_non_idle_core’:
>>> kernel/sched/fair.c:6243:21: error: implicit declaration of function ‘cpu_smt_mask’; did you mean ‘cpu_cpu_mask’? [-Werror=implicit-function-declaration]
>>>     for_each_cpu(smt, cpu_smt_mask(core)) {
>>>                       ^
>>> ./include/linux/cpumask.h:242:32: note: in definition of macro ‘for_each_cpu’
>>>
>>> [...]
>>>
>>
>> Thanks for pointing out. It will not build for individual patches for the current version of RFC.
>>
>> Please try to build it with full patch set. I assure, the following iterations of RFC will resolve this issue.
> 
> Ah, I see, you have this CONFIG_TURBO_SCHED patch at the end of the series. I think that you will have a hard time to get new CONFIG switches into the task scheduler code. Can you not bting in your feature w/o CONFIG_TURBO_SCHED?
> 
> [...]
> 

Yes, that seems doable. I will remove the additional CONFIG option and modify the code so that it builds for arm64 as well.
Thanks.

