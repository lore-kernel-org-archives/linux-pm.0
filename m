Return-Path: <SRS0=LXM6=SJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D0C282DE
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 06:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28712218A3
	for <linux-pm@archiver.kernel.org>; Sun,  7 Apr 2019 06:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbfDGGnx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Apr 2019 02:43:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbfDGGnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Apr 2019 02:43:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x376hTrs016871
        for <linux-pm@vger.kernel.org>; Sun, 7 Apr 2019 02:43:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rq8xsdk1b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Sun, 07 Apr 2019 02:43:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth015@linux.vnet.ibm.com>;
        Sun, 7 Apr 2019 07:43:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 7 Apr 2019 07:43:46 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x376hjqq50331852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Apr 2019 06:43:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C8D3A4054;
        Sun,  7 Apr 2019 06:43:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB673A405B;
        Sun,  7 Apr 2019 06:43:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.53.130])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  7 Apr 2019 06:43:43 +0000 (GMT)
Subject: Re: [RFC 3/6] Introduce static key to enable or disable TurboSched
To:     Akshay Adiga <overenthusiasticakshay@gmail.com>,
        Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-4-parth015@linux.vnet.ibm.com>
 <001101d4e35c$13951220$3abf3660$@net> <20190404095854.GB25302@aks.ibm>
From:   Parth Shah <parth015@linux.vnet.ibm.com>
Date:   Sun, 7 Apr 2019 12:13:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190404095854.GB25302@aks.ibm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040706-0016-0000-0000-0000026C196E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040706-0017-0000-0000-000032C8385F
Message-Id: <e7c8bfbd-a4b4-d671-7a18-c645697452e0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904070063
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/4/19 3:28 PM, Akshay Adiga wrote:
> On Mon, Mar 25, 2019 at 03:42:48PM -0700, Doug Smythies wrote:
>> On 2019.03.21 23:06 Parth Shah wrote:
>>
>>> Signed-off-by: Parth Shah <parth015@linux.vnet.ibm.com>
>>> ---
>>>  kernel/sched/core.c  | 36 ++++++++++++++++++++++++++++++++++++
>>> kernel/sched/fair.c  |  2 +-
>>> kernel/sched/sched.h |  7 +++++++
>>> 3 files changed, 44 insertions(+), 1 deletion(-)
>>
>> ...[snip]...
>>
>> I wanted to try this patch set with a particular work flow.
>> I actually don't think it will help, but wanted to try it.
>>
>> Forgive me if this is something that should be obvious but...
>>
>> I have not been able to figure out how to enable or disable
>> Turboshed.
>>
>> This patch suggests that I should be able to, but how?
>>
>> I have a kernel 5.1-rc1 with this entire patch set added.
>>  
>> ... Doug
>>
>>
> I think he added attribute called cpu.turbo_sched for each cpu controller.
> 
> In order to enable this feature you need first create a cpu cgroup, and set
> the attribute value cpu.turbo_sched to :
>   - cpu.turbo_sched = 1 (tasks benefiting from high freq) or
>   - cpu.turbo_sched = 2 (tasks which are jitters)
> 
> Looks like  the feature is disabled by default or cpu.turbo_sched = 0.
> 

Correct Akshay.

In fact, one can follow the below procedure to create 2 different categories
of workload,

cd  /sys/fs/cgroup/cpu/
mkdir type1
execute type1_workload
echo `pidof type1_workload` > type1/cgroup.procs && echo 1 > type1/cpu.turbo_sched
mkdir type2
execute type2_workload
echo `pidof type2_workload` > type2/cgroup.procs && echo 2 > type2/cpu.turbo_sched

where    Type1 = tasks benefiting from high freq
and    Type2 = tasks which are jitters


One can use the test benchmark (wofbench.c) to have a quick demo of TurboSched as follows

Execute program with 8 jitters and 8 High util tasks: wofbench -t 30 -h 8 -n 16
Create cgroup: cd  /sys/fs/cgroup/cpu/ && mkdir type2
Put task: echo `pidof wofbench`> type2/cgroup.procs && echo 2 > type2/cpu.turbo_sched
Result: Jitters will be packed on the same core as other 8 High util tasks.

Thus during multi-thread workload execution, if the system throttles frequency
due to power budget constraint of the system, using these patches may result in
sustaining of higher frequencies by keeping maximum cores idle.

Hope this helps. Thanks

