Return-Path: <SRS0=8Vg7=SO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEB0C10F0E
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293652084D
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfDLL2l (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:28:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbfDLL2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2019 07:28:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CBQDJT129061
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 07:28:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtsrhr5t7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 07:28:40 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth015@linux.vnet.ibm.com>;
        Fri, 12 Apr 2019 12:28:38 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 12:28:35 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3CBSY3e52822068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 11:28:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CED7011C052;
        Fri, 12 Apr 2019 11:28:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 606EA11C050;
        Fri, 12 Apr 2019 11:28:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.96])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 11:28:34 +0000 (GMT)
Subject: Re: [RFC 5/6] Improvise cgroup interface for classifying jitter from
 WOF tasks
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-6-parth015@linux.vnet.ibm.com>
 <52dc3a49-60c0-476f-4a01-c805861458cc@arm.com>
From:   Parth Shah <parth015@linux.vnet.ibm.com>
Date:   Fri, 12 Apr 2019 16:58:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <52dc3a49-60c0-476f-4a01-c805861458cc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041211-0028-0000-0000-0000036018D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041211-0029-0000-0000-0000241F43A9
Message-Id: <a4d214e8-b255-0d98-6269-b887a64b1fd8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120075
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/11/19 9:31 PM, Dietmar Eggemann wrote:
> On 3/22/19 7:06 AM, Parth Shah wrote:
>> Signed-off-by: Parth Shah <parth015@linux.vnet.ibm.com>
>> ---
>>   kernel/sched/fair.c  | 40 +++++++++++++++++++++++++++++++++++++---
>>   kernel/sched/sched.h |  2 ++
>>   2 files changed, 39 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7ecf5ed0b391..c7be5803a37c 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -27,9 +27,15 @@
>>   /*
>>    * Maintain cpumask to track the core occupying throughput intensive tasks,
>>    * which are usually high utilization tasks.
>> + *
>> + * WOF(Workload Optimized Frequency) tasks are manually classified(task_type=2)

Good catch. This has to be task_type=1.

