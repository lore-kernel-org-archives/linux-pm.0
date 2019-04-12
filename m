Return-Path: <SRS0=8Vg7=SO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AD2C10F14
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE10B2084D
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfDLLbN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:31:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727070AbfDLLbM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2019 07:31:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CBQCAd129015
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 07:31:11 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtsrhr9kg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 07:31:11 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth015@linux.vnet.ibm.com>;
        Fri, 12 Apr 2019 12:31:09 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 12:31:07 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3CBV6Wx49807360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 11:31:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FFE811C058;
        Fri, 12 Apr 2019 11:31:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9890A11C04A;
        Fri, 12 Apr 2019 11:31:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.96])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 11:31:05 +0000 (GMT)
Subject: Re: [RFC 4/6] Add cpumask to track throughput intensive tasks
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-5-parth015@linux.vnet.ibm.com>
 <4cfafd66-d5aa-36b4-af77-eaa757d77eb4@arm.com>
From:   Parth Shah <parth015@linux.vnet.ibm.com>
Date:   Fri, 12 Apr 2019 17:01:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <4cfafd66-d5aa-36b4-af77-eaa757d77eb4@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041211-0028-0000-0000-000003601909
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041211-0029-0000-0000-0000241F43E0
Message-Id: <99a5f3c1-624a-e91e-2ffb-d0f08962838f@linux.vnet.ibm.com>
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



On 4/12/19 4:28 PM, Dietmar Eggemann wrote:
> On 3/22/19 7:06 AM, Parth Shah wrote:
> 
> [...]
> 
>> @@ -6225,10 +6232,11 @@ static const int core_cap_mf = 16;
>>    */
>>   static int select_non_idle_core(struct task_struct *p, int prev_cpu)
>>   {
>> -    struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>> +    struct cpumask highutil_task_mask_copy;
>> +    struct cpumask *cpus = &highutil_task_mask_copy;
>>       int core, smt;
I think I should retain the following line
>>   -    cpumask_and(cpus, cpu_online_mask, &p->cpus_allowed);
>> +    cpumask_copy(cpus, highutil_task_cpu_mask);
> 
> IMHO, you still would have to and cpus with cpu_online_mask and &p->cpus_allowed.
> 
> [...]
> I agree.

