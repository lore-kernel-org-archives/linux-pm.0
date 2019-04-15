Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46481C10F0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 07:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD4320825
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 07:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfDOHX6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:23:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfDOHX6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2019 03:23:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3F7EbWb091067
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2019 03:23:57 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvkh2nka9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2019 03:23:56 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth015@linux.vnet.ibm.com>;
        Mon, 15 Apr 2019 08:23:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 08:23:52 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3F7NpXd38535298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 07:23:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D62EF11C064;
        Mon, 15 Apr 2019 07:23:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45D1311C04C;
        Mon, 15 Apr 2019 07:23:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.44.57])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 07:23:51 +0000 (GMT)
Subject: Re: [RFC 2/6] Provide cgroup interface for manual jitter
 classification
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-3-parth015@linux.vnet.ibm.com>
 <462cf628-1b0b-4f8c-251d-c0cff6af18fd@arm.com>
From:   Parth Shah <parth015@linux.vnet.ibm.com>
Date:   Mon, 15 Apr 2019 12:53:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <462cf628-1b0b-4f8c-251d-c0cff6af18fd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041507-0016-0000-0000-0000026ED7EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041507-0017-0000-0000-000032CB1AE4
Message-Id: <f14f03e4-33e9-06a0-ca81-fbfb07ae22d5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150049
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/11/19 7:16 PM, Dietmar Eggemann wrote:
> On 3/22/19 7:06 AM, Parth Shah wrote:
>> Signed-off-by: Parth Shah <parth015@linux.vnet.ibm.com>
>> ---
>>   include/linux/sched.h |  8 ++++++++
>>   kernel/sched/core.c   | 46 +++++++++++++++++++++++++++++++++++++++++++
>>   kernel/sched/fair.c   | 15 +++++++++-----
>>   kernel/sched/sched.h  |  2 ++
>>   4 files changed, 66 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 903ef29b62c3..be8e8617e0cb 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -604,6 +604,14 @@ struct task_struct {
>>       unsigned int            flags;
>>       unsigned int            ptrace;
>>   +    /*
>> +     * task_characteristics:
>> +     * 0 = unknown. Follows regular CFS policy for task placement.
>> +     * 1 = Throughput intensive high utilization task
>> +     * 2 = Jitter tasks. Should be packed to reduce active core count.
> 
> This is very similar to the ideas in [PATCH v8 00/16] Add utilization clamping support https://lore.kernel.org/lkml/20190402104153.25404-1-patrick.bellasi@arm.com . Task classification from userspace ...
> 
> [...]
> 

Patches seems interesting and converges to the process of jitter classification.
I will try to re-base my patches on top of that.

Thanks

