Return-Path: <SRS0=8Vg7=SO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C2C10F0E
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273392171F
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDLLXs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:23:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726244AbfDLLXs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2019 07:23:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CBL3hH162908
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 07:23:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rtq2xy2sg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 07:23:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth015@linux.vnet.ibm.com>;
        Fri, 12 Apr 2019 12:23:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 12:23:34 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3CBNYm951314932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 11:23:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E459811C052;
        Fri, 12 Apr 2019 11:23:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7592711C04A;
        Fri, 12 Apr 2019 11:23:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.96])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 11:23:33 +0000 (GMT)
Subject: Re: [RFC 4/6] Add cpumask to track throughput intensive tasks
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-5-parth015@linux.vnet.ibm.com>
 <08788b47-d15c-9529-aae6-3977f6aa32c2@arm.com>
From:   Parth Shah <parth015@linux.vnet.ibm.com>
Date:   Fri, 12 Apr 2019 16:53:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <08788b47-d15c-9529-aae6-3977f6aa32c2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041211-0008-0000-0000-000002D917F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041211-0009-0000-0000-00002245442A
Message-Id: <35a1e643-7543-1388-e73b-c3a3a423a853@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120074
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/12/19 4:43 PM, Dietmar Eggemann wrote:
> On 3/22/19 7:06 AM, Parth Shah wrote:
> 
> [...]
> 
>> @@ -7038,6 +7046,11 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>>       struct task_struct *p;
>>       int new_tasks;
>>   +    if (!core_underutilized(cpu_util(rq->cpu),capacity_of(rq->cpu)))
>> +        cpumask_test_and_set_cpu(rq->cpu, highutil_task_cpu_mask);
>> +    else
>> +        cpumask_test_and_clear_cpu(rq->cpu, highutil_task_cpu_mask);
>> +
> 
> Shouldn't this update of the highutil_task_cpu_mask also be under the hood of turbo_sched_enabled()?
> 
> [...]
> 

So if this is kept inside turbo_sched_enabled, then the highutil_task_cpu_mask will contain irrelevant
information when the turbo_sched is enabled. This will result in selecting wrong CPU unless
pick_next_task_fair gets invoked in most CPUs.

Maybe, that is okay since it impacts only during the time of enabling the feature. Also, since I will
remove CONFIG options, almost every piece of TurboSched code will have to pass through turbo_sched_enabled() condition.

Thanks

