Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345A1C10F0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 08:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A1620651
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 08:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cUoHSGS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfDOIhx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:37:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48552 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOIhx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2019 04:37:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F8YOji043930;
        Mon, 15 Apr 2019 08:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=r0CJvIXpY5oClmRXY+gLfbV6E3heo5I647llz0oRf+k=;
 b=cUoHSGS3WMgeXvcCdDt6NjStbP7ZHCuCQ3j5nasd3j2q7OQVES+If9oanvEr3QRT3Blp
 jBOCZ0dZdGm5RXIHM2BCgblJg+M3A/juVxLXL0JY4IKA9z5yWWuGqQZ+E+dTalEuvzbl
 bCN9F9AFy4QYAo2CYNtcekWwB2xKVE1lm9DuMFmrrU3ii4ateUcpc/0sSMWYNJWiyMMQ
 1Y9CFVjYdL8l5Jj+NRvj9wzFUEcerEOFnMju//vIJK4qDfv3oVIRa4CgE2AY3luxy9ot
 h6U9iA8eKAehTX7UZMEeW0IZC0zA4rgH+zQEVlpsbDxq0qt3MggMiRiDTfCsFVIpixyO nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ru76t57g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 08:37:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F8Y3T1159742;
        Mon, 15 Apr 2019 08:35:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2rv2tu24v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 08:35:45 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3F8ZhBf019378;
        Mon, 15 Apr 2019 08:35:43 GMT
Received: from [10.0.5.57] (/213.57.127.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 01:35:43 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 2/2] x86: intel: Define MSR_POWER_CTL bits with symbolic
 constants
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1831fa285e2b73cd8dd7583efe2f073c7277ed2a.camel@linux.intel.com>
Date:   Mon, 15 Apr 2019 11:35:40 +0300
Cc:     linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <116A1F36-A298-4F43-A1C2-1FC4AB75C731@oracle.com>
References: <20190414204831.93705-1-liran.alon@oracle.com>
 <20190414204831.93705-2-liran.alon@oracle.com>
 <1831fa285e2b73cd8dd7583efe2f073c7277ed2a.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150060
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150060
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On 15 Apr 2019, at 5:10, Srinivas Pandruvada =
<srinivas.pandruvada@linux.intel.com> wrote:
>=20
> On Sun, 2019-04-14 at 23:48 +0300, Liran Alon wrote:
>> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>> arch/x86/include/asm/msr-index.h      | 7 +++++++
>> drivers/cpufreq/intel_pstate.c        | 6 ++----
>> drivers/idle/intel_idle.c             | 2 +-
>> tools/power/x86/turbostat/turbostat.c | 2 +-
>> 4 files changed, 11 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/msr-index.h
>> b/arch/x86/include/asm/msr-index.h
>> index 8e40c2446fd1..436f3c5aa358 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -209,6 +209,13 @@
>>=20
>> #define MSR_IA32_POWER_CTL		0x000001fc
>>=20
>> +/* POWERCTLMSR bits: */
>> +#define POWERCTLMSR_BI_DIR_PROCHOT	BIT(0)	/* Bi-directional
>> PROCHOT */
>> +#define POWERCTLMSR_C1E_ENABLE		BIT(1)  /* C1E Enable
>> */
>> +#define POWERCTLMSR_EN_ENERGY_PERF_BIAS	BIT(18) /* Enable
>> MSR_IA32_ENERGY_PERF_BIAS */
>> +#define POWERCTLMSR_DISABLE_RACE_TO_HLT	BIT(19)	/* Disable
>> Race to Halt Optimization */
>> +#define POWERCTLMSR_DISABLE_EE		BIT(20) /* Disable
>> Energy Efficiency Optimization */
>> +
>> #define MSR_IA32_MC0_CTL		0x00000400
>> #define MSR_IA32_MC0_STATUS		0x00000401
>> #define MSR_IA32_MC0_ADDR		0x00000402
>> diff --git a/drivers/cpufreq/intel_pstate.c
>> b/drivers/cpufreq/intel_pstate.c
>> index 3ce39c332c7b..b42ba4456f66 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -1200,8 +1200,6 @@ static void intel_pstate_hwp_enable(struct
>> cpudata *cpudata)
>> 		cpudata->epp_default =3D intel_pstate_get_epp(cpudata,
>> 0);
>> }
>>=20
>> -#define MSR_IA32_POWER_CTL_BIT_EE	20
>> -
>> /* Disable energy efficiency optimization */
>> static void intel_pstate_disable_ee(int cpu)
>> {
>> @@ -1212,9 +1210,9 @@ static void intel_pstate_disable_ee(int cpu)
>> 	if (ret)
>> 		return;
>>=20
>> -	if (!(power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE))) {
>> +	if (!(power_ctl & POWERCTLMSR_DISABLE_EE)) {
>> 		pr_info("Disabling energy efficiency optimization\n");
>> -		power_ctl |=3D BIT(MSR_IA32_POWER_CTL_BIT_EE);
>> +		power_ctl |=3D POWERCTLMSR_DISABLE_EE;
> To match SDM defintion
> power_ctl |=3D POWERCTLMSR_DISABLE_RACE_TO_HLT;
> To set BIT 20, we need some data why this is necessary. If you really
> need performance set eneregy_perf_preference to performance.
>=20
> Thanks,
> Srinivas

This patch is solely a refactoring patch. It doesn=E2=80=99t intend to =
change semantics.
Based on our discussion on previous patch, it seems we are just =
misaligned on the meaning of the various MSR_POWER_CTL bits.

-Liran

>=20
>> 		wrmsrl_on_cpu(cpu, MSR_IA32_POWER_CTL, power_ctl);
>> 	}
>> }
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index 8b5d85c91e9d..3654575e6697 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -977,7 +977,7 @@ static void c1e_promotion_disable(void)
>> 	unsigned long long msr_bits;
>>=20
>> 	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
>> -	msr_bits &=3D ~0x2;
>> +	msr_bits &=3D ~POWERCTLMSR_C1E_ENABLE;
>> 	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
>> }
>>=20
>> diff --git a/tools/power/x86/turbostat/turbostat.c
>> b/tools/power/x86/turbostat/turbostat.c
>> index 9327c0ddc3a5..0455aa7e9c6f 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -2019,7 +2019,7 @@ dump_nhm_platform_info(void)
>>=20
>> 	get_msr(base_cpu, MSR_IA32_POWER_CTL, &msr);
>> 	fprintf(outf, "cpu%d: MSR_IA32_POWER_CTL: 0x%08llx (C1E auto-
>> promotion: %sabled)\n",
>> -		base_cpu, msr, msr & 0x2 ? "EN" : "DIS");
>> +		base_cpu, msr, msr & POWERCTLMSR_C1E_ENABLE ? "EN" :
>> "DIS");
>>=20
>> 	return;
>> }
>=20

