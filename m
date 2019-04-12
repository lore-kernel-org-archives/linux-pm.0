Return-Path: <SRS0=8Vg7=SO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D15C282CE
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECED20693
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 15:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDLPt5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:49:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbfDLPt5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2019 11:49:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CFna0j039724
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 11:49:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtuydvxsr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 11:49:44 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth015@linux.vnet.ibm.com>;
        Fri, 12 Apr 2019 16:48:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 16:48:48 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3CFmlR852625552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 15:48:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5484311C050;
        Fri, 12 Apr 2019 15:48:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE35011C058;
        Fri, 12 Apr 2019 15:48:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.68.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 15:48:43 +0000 (GMT)
Subject: Re: [RFC 5/6] Improvise cgroup interface for classifying jitter from
 WOF tasks
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-6-parth015@linux.vnet.ibm.com>
 <8de36526-806a-810f-9f5e-393dddb523be@arm.com>
From:   Parth Shah <parth015@linux.vnet.ibm.com>
Date:   Fri, 12 Apr 2019 21:18:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <8de36526-806a-810f-9f5e-393dddb523be@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041215-4275-0000-0000-000003273264
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041215-4276-0000-0000-000038365738
Message-Id: <9aeb5767-82b3-77c1-5334-193236e8a786@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120105
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/12/19 6:38 PM, Dietmar Eggemann wrote:
> On 3/22/19 7:06 AM, Parth Shah wrote:
> 
> [...]
> 
>> @@ -6236,7 +6259,15 @@ static int select_non_idle_core(struct task_struct *p, int prev_cpu)
>>       struct cpumask *cpus = &highutil_task_mask_copy;
>>       int core, smt;
>>   -    cpumask_copy(cpus, highutil_task_cpu_mask);
>> +    /*
>> +     * Prefer jitters to be pulled on core occupying WOF tasks
>> +     * If such tasks are not running then use long code path to find
>> +     * non-idle core with spare capacity
>> +     */
> 
> I'm struggling to grasp what you mean by ' ... long code path to find non-idle core with spare capacity' here?
> 
> We're here in:
> select_task_rq_fair()->__select_idle_sibling()->select_non_idle_core()
> 
> What is the 'long code path'? In case select_non_idle_core() can't find a CPU, select_idle_sibling() is called but IMHO that's the original fastpath operating on the LLC domain.
> 
> It can't be the slow path find_idlest_cpu() because that's only called in case __select_idle_sibling() isn't called.
> 
> [...]
> 

Maybe the comment is not self-explainable. Please follow a below one,

Here we have two cpumask to iterate through
1. wof_tasks_cpu_mask which contains CPU occupied by user classified task and is hence easier to track
2. highutil_task_cpu_mask which contains CPU which are non-idle (not core_underutilized)

So, the selection of "cpus" can be either from the above two masks. 
Selecting "wof_tasks_cpu_mask" leads to quicker and better selection of non idle CPU,
whereas "highutil_task_cpu_mask" will contain more CPUs (inclusive of wof_tasks_cpu_mask) and hence finding perfect CPU may require more iterations.

Hence, selecting "highutil_task_cpu_mask" is relatively exhaustive (which I termed "longer code path") in general cases.

Hope this helps.

Thanks

