Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B73C10F0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572F120651
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 08:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u+FAy+ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfDOIeJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:34:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33780 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOIeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2019 04:34:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F8OPhJ040665;
        Mon, 15 Apr 2019 08:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=ffeRfzaxm+NiO0MV2zMCyzjD/UfGt4UMK088qMIReu4=;
 b=u+FAy+ciw+ofPje2+3tK5xp2S75afwQW8809uTJflX25rnxjzhkdJ8k/5WHHvw8hRoig
 quDmxJNLr4wXp0zheo0nyzOEhjmCdbkuQJB9KIC/pXb9ZY5f0rK3mIKX2LKwfUprcozm
 52NXjaN6MR6fEQtCOiFWLskJ1hmwsR5JcbOV+Roe4BEuFAmyxhFOrhWGY3haXjWUOVR8
 Y8C6DM3diUylYkUm2me6wfVAK/UlYjeh1R8mdU5Oa0sGT4A1BBc1wlNmLR7Dj1uleGNl
 6bB3KCIwMvl0kztCg3xz+hQHTQ6ud7eCGDa3q/3bVW/sSagPCTOE7+DPbEhWaHuCGnA9 Mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2ru59cwbms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 08:33:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F8X2Rw157599;
        Mon, 15 Apr 2019 08:33:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2rv2tu23ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 08:33:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3F8X1As029898;
        Mon, 15 Apr 2019 08:33:01 GMT
Received: from [10.0.5.57] (/213.57.127.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 01:33:01 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 1/2] x86: intel_pstate: Fix wrong definition of Disable
 Energy Efficiency Optimization bit
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <d1825fdb9b1c9d759bcfefa7ef80a380cd9ece78.camel@linux.intel.com>
Date:   Mon, 15 Apr 2019 11:32:57 +0300
Cc:     linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDD74CD9-4DF0-4403-8140-12008DB86E7A@oracle.com>
References: <20190414204831.93705-1-liran.alon@oracle.com>
 <d1825fdb9b1c9d759bcfefa7ef80a380cd9ece78.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=872
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150060
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=893 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150059
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On 15 Apr 2019, at 5:00, Srinivas Pandruvada =
<srinivas.pandruvada@linux.intel.com> wrote:
>=20
> On Sun, 2019-04-14 at 23:48 +0300, Liran Alon wrote:
>> Bit definition can be found in Intel SDM Section 2.16 MSRS IN THE 6TH
>> GENERATION, 7TH GENERATION AND 8TH GENERATION
>> INTEL=C2=AE CORE=E2=84=A2 PROCESSORS, INTEL=C2=AE XEON=C2=AE =
PROCESSOR SCALABLE
>> FAMILY, AND FUTURE INTEL=C2=AE CORE=E2=84=A2 PROCESSORS.
>>=20
>> Definition of all Skylake MSR_POWER_CTL bits can also be found at
>> EDK2
>> source at UefiCpuPkg/Include/Register/Msr/SkylakeMsr.h union
>> MSR_SKYLAKE_POWER_CTL_REGISTER.
>>=20
>> Fixes: 6e978b22efa1 ("cpufreq: intel_pstate: Disable energy
>> efficiency optimization")
> What are you trying to address? This bit 19 has a special meaning when
> system is in HWP mode. So this is correct.
>=20
> Bit 20 has a different meaning depending on legacy or in HWP mode.
>=20
> Thanks,
> Srinivas
>=20

Maybe I=E2=80=99m misinterpreting Intel SDM, but it seems to me that bit =
19 in MSR_POWER_CTL is always "Disable Race to Halt Optimization =
(R/W)=E2=80=9D
while bit 20 is the "Disable Energy Efficiency Optimization (R/W)=E2=80=9D=
.

I didn=E2=80=99t find a place in Intel SDM where it is discussed that =
bit 19 have a special meaning when system is in HWP mode.
Can you point me to relevant place in Intel SDM?

Thanks,
-Liran

