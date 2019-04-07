Return-Path: <SRS0=LXM6=SJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCCCC10F0E
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 05:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B0D213F2
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 05:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfDGF53 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Apr 2019 01:57:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725929AbfDGF53 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Apr 2019 01:57:29 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x375mm0M014518
        for <linux-pm@vger.kernel.org>; Sun, 7 Apr 2019 01:57:27 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rq9hku9qr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Sun, 07 Apr 2019 01:57:27 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth015@linux.vnet.ibm.com>;
        Sun, 7 Apr 2019 06:57:25 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 7 Apr 2019 06:57:22 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x375vLOm28180598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Apr 2019 05:57:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C603E11C050;
        Sun,  7 Apr 2019 05:57:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D487311C04A;
        Sun,  7 Apr 2019 05:57:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.53.130])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  7 Apr 2019 05:57:20 +0000 (GMT)
Subject: Re: [RFC 1/6] Optimize wake-up task for Task Packing heuristic
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-2-parth015@linux.vnet.ibm.com>
 <0b198386-ef0b-75e0-e53a-1160c77326b7@arm.com>
From:   Parth Shah <parth015@linux.vnet.ibm.com>
Date:   Sun, 7 Apr 2019 11:27:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0b198386-ef0b-75e0-e53a-1160c77326b7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040705-0020-0000-0000-0000032D173A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040705-0021-0000-0000-0000217F346E
Message-Id: <60e34244-1e40-e318-080e-e76607bb3d92@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904070054
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/27/19 3:01 PM, Dietmar Eggemann wrote:
> Hi Parth,
> 
> On 3/22/19 7:06 AM, Parth Shah wrote:
>> TurboSched feature requires the minimal number of cores to be active
>> inorder to sustain higher Turbo-frequency in SMP sytems. The jitter
>> tasks if packed on the idle CPUs of already active cores will result in
>> better performance for throughput intensive workloads.
>>
>> Signed-off-by: Parth Shah <parth015@linux.vnet.ibm.com>
>> ---
>>   kernel/sched/fair.c | 91 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 89 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 51003e1c794d..dcf48f37e0fa 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6202,6 +6202,82 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>       return cpu;
>>   }
>>   +/*
>> + * Core is defined as under-utilized in case if the aggregated utilization of a
>> + * all the CPUs in a core is less than 12.5%
>> + */
>> +static inline bool core_underutilized(long unsigned core_util,
>> +           long unsigned core_capacity)
>> +{
>> +    return core_util < core_capacity>>3;
>> +}
>> +
>> +/*
>> + * Core Capacity Mulitplication Factor
>> + * The capacity of a core is defined to be 1.6x the capacity of any
>> + * CPU(or SM thread), since the architecture is symmetric
>> + */
>> +static const int core_cap_mf = 16;
>> +
>> +/*
>> + * Try to find non idle core in the system, but with spare capacity available
>> + * for task packing, thereby keeping minimal cores active.
>> + */
>> +static int select_non_idle_core(struct task_struct *p, int prev_cpu)
>> +{
>> +    struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>> +    int core, smt;
>> +
>> +    cpumask_and(cpus, cpu_online_mask, &p->cpus_allowed);
>> +
>> +    for_each_cpu_wrap(core, cpus, prev_cpu)
>> +    {
>> +        long unsigned int core_util = 0;
>> +        long unsigned int core_cap = core_cap_mf*capacity_of(core)/10;
>> +        long unsigned int cache_cpu_util = (unsigned)-1;
>> +        long unsigned est_util = 0, est_util_enqueued = 0;
>> +        int cache_cpu = core;
>> +        struct cfs_rq *cfs_rq;
>> +
>> +        for_each_cpu(smt, cpu_smt_mask(core)) {
> 
> This one doesn't build for me on arm64 (make defconfig) since it uses cpu_smt_mask() outside the CONFIG_SCHED_SMT guard.
> 
> kernel/sched/fair.c: In function ‘select_non_idle_core’:
> kernel/sched/fair.c:6243:21: error: implicit declaration of function ‘cpu_smt_mask’; did you mean ‘cpu_cpu_mask’? [-Werror=implicit-function-declaration]
>    for_each_cpu(smt, cpu_smt_mask(core)) {
>                      ^
> ./include/linux/cpumask.h:242:32: note: in definition of macro ‘for_each_cpu’
> 
> [...]
> 

Thanks for pointing out. It will not build for individual patches for the current version of RFC.

Please try to build it with full patch set. I assure, the following iterations of RFC will resolve this issue.

