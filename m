Return-Path: <SRS0=8Vg7=SO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53392C10F0E
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E07B20643
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDLLQZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:16:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbfDLLQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2019 07:16:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CB4RWk070735
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 07:16:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rts0q9kmc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 07:16:24 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth015@linux.vnet.ibm.com>;
        Fri, 12 Apr 2019 12:16:21 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 12:16:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3CBGJan46792744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 11:16:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BA4A11C052;
        Fri, 12 Apr 2019 11:16:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDE9E11C05C;
        Fri, 12 Apr 2019 11:16:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.96])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 11:16:18 +0000 (GMT)
Subject: Re: [RFC 4/6] Add cpumask to track throughput intensive tasks
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-5-parth015@linux.vnet.ibm.com>
 <505b6e2f-86fa-cd51-e071-695d1f1da17c@arm.com>
 <00fef9cf-5e3c-5635-42a3-8a8c1cea149b@arm.com>
From:   Parth Shah <parth015@linux.vnet.ibm.com>
Date:   Fri, 12 Apr 2019 16:46:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <00fef9cf-5e3c-5635-42a3-8a8c1cea149b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041211-0020-0000-0000-0000032F16EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041211-0021-0000-0000-000021814C73
Message-Id: <519e8c72-c08b-f534-67b6-c12f9ad95094@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120073
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/12/19 4:17 PM, Dietmar Eggemann wrote:
> On 4/11/19 5:54 PM, Dietmar Eggemann wrote:
>> On 3/22/19 7:06 AM, Parth Shah wrote:
>>> WOF tasks indicates the workload optimized frequency tasks which has
>>
>> You should explain what WOF stands for before you it. I think its only done in the next patch.
>>
>> [...]
>>
>>> @@ -6225,10 +6232,11 @@ static const int core_cap_mf = 16;
>>>    */
>>>   static int select_non_idle_core(struct task_struct *p, int prev_cpu)
>>>   {
>>> -    struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>>> +    struct cpumask highutil_task_mask_copy;
>>
>> Don't put struct cpumask on the stack.
> 
> Why don't you provide a per-cpu mask for highutil_task_cpu_mask and wof_tasks_cpu_mask like we have for select_idle_mask?
> 
> DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
> 
> [...]
> 
Yes, referring per_cpu highutil_task_mask will solve the problem of initializing new cpumask on stack.
Thanks for pointing that out.

