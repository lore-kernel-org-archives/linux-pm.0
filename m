Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AFCC10F12
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 18:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062C9205ED
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 18:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DUIMLHEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfDOSOk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:14:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52138 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDOSOk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2019 14:14:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FI8rDn161190;
        Mon, 15 Apr 2019 18:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=jBEsahECH6EekVLF35nLQacv3Pw7xB2Z8BWylaFWHOw=;
 b=DUIMLHEflx1EVghK1jzanZVaVqw5WKsStxEf4fx2x5NOxdowFIW8lphiVcM0CIGShZaX
 BPJINRT8MPeDoh3UiVIO1RG/Z/8ggGj3Pq82t35Hsj5oTPl9U9Y7CSuex1jovuaCl75d
 OyQkcRibnStdsLUBc4UXoxpTbMYHpB6LsdnrjFtyYyaRAb5ScgOkG4F/QoGfqAB6ADxk
 I1z/Y/1WH1OHGYvmpbeml1AzRRL/klop5B1c5vMOigo+FfIayPltRQwF4nBPMxXv5Flu
 v/mDOA4fvBHqfZ88d6y2k8ri3mpyIrVi9j73Vw7Y+1Xgzna9lZYob69eQDKGYdOOOIHm Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2ru59d0dkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 18:13:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FICuB4048360;
        Mon, 15 Apr 2019 18:13:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ru4vsrue3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 18:13:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3FIDV7w029716;
        Mon, 15 Apr 2019 18:13:31 GMT
Received: from [10.74.125.67] (/10.74.125.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 11:13:31 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 1/2] x86: intel_pstate: Fix wrong definition of Disable
 Energy Efficiency Optimization bit
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1411b93ccc156d6712b9e9bb7ba3e03049489c02.camel@linux.intel.com>
Date:   Mon, 15 Apr 2019 21:13:27 +0300
Cc:     linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <40769113-101E-43D0-BC7B-BFF7C72DD1E4@oracle.com>
References: <20190414204831.93705-1-liran.alon@oracle.com>
 <d1825fdb9b1c9d759bcfefa7ef80a380cd9ece78.camel@linux.intel.com>
 <CDD74CD9-4DF0-4403-8140-12008DB86E7A@oracle.com>
 <1411b93ccc156d6712b9e9bb7ba3e03049489c02.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150126
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150126
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On 15 Apr 2019, at 21:03, Srinivas Pandruvada =
<srinivas.pandruvada@linux.intel.com> wrote:
>=20
> On Mon, 2019-04-15 at 11:32 +0300, Liran Alon wrote:
>>> On 15 Apr 2019, at 5:00, Srinivas Pandruvada <
>>> srinivas.pandruvada@linux.intel.com> wrote:
>>>=20
>>> On Sun, 2019-04-14 at 23:48 +0300, Liran Alon wrote:
>>>> Bit definition can be found in Intel SDM Section 2.16 MSRS IN THE
>>>> 6TH
>>>> GENERATION, 7TH GENERATION AND 8TH GENERATION
>>>> INTEL=C2=AE CORE=E2=84=A2 PROCESSORS, INTEL=C2=AE XEON=C2=AE =
PROCESSOR SCALABLE
>>>> FAMILY, AND FUTURE INTEL=C2=AE CORE=E2=84=A2 PROCESSORS.
>>>>=20
>>>> Definition of all Skylake MSR_POWER_CTL bits can also be found at
>>>> EDK2
>>>> source at UefiCpuPkg/Include/Register/Msr/SkylakeMsr.h union
>>>> MSR_SKYLAKE_POWER_CTL_REGISTER.
>>>>=20
>>>> Fixes: 6e978b22efa1 ("cpufreq: intel_pstate: Disable energy
>>>> efficiency optimization")
>>>=20
>>> What are you trying to address? This bit 19 has a special meaning
>>> when
>>> system is in HWP mode. So this is correct.
>>>=20
>>> Bit 20 has a different meaning depending on legacy or in HWP mode.
>>>=20
>>> Thanks,
>>> Srinivas
>>>=20
>>=20
>> Maybe I=E2=80=99m misinterpreting Intel SDM, but it seems to me that =
bit 19
>> in MSR_POWER_CTL is always "Disable Race to Halt Optimization =
(R/W)=E2=80=9D
>> while bit 20 is the "Disable Energy Efficiency Optimization (R/W)=E2=80=
=9D.
>>=20
>> I didn=E2=80=99t find a place in Intel SDM where it is discussed that =
bit 19
>> have a special meaning when system is in HWP mode.
>> Can you point me to relevant place in Intel SDM?
>>=20
>=20
> SDM doesn't describe the algorithms. This is a feature of Intel Speed
> Shift Technology aka HWP. Both bits target disabling some energy
> efficiency features of the processor. I wish there are some better
> names of these bits. Ideas is to pick the best for a platform based on
> the performance needs. Here based on the experiments, setting bit 19
> gave the required performance on Kaby Lake desktops.
>=20
> So unless you found some performance/power issue with setting of bit =
19
> vs bit 20, on Kaby Lake based platforms, we shouldn't change (may be
> rename as per SDM definition).
>=20
> Thanks,
> Srinivas

I haven=E2=80=99t found any performance/power issue.

The name of the bit, the function names, prints and comments just seems =
to refer to bit 20 and not bit 19.
If the code intention is to manipulate "Disable Race to Halt =
Optimization=E2=80=9D bit instead of "Disable Energy Efficiency =
Optimization=E2=80=9D bit,
code should be renamed appropriately.
Is this code intention?

I have also haven=E2=80=99t found any documentation that describes bit =
19 have different meaning when system is in HWP mode.

-Liran

>=20
>> Thanks,
>> -Liran
>>=20
>=20

