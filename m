Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB025438486
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119078; cv=none; b=Xy7TYZmGYzdViQ8cjTFNwpv2cCfl2jXwJB0RdrtV+eA/7J+3HuhfoG35by4ydTpH7/h2rm+Z8KcgYJrjgC6YeC+w3evsn0/ETdK4iXPvWKm08akLRoud4yYIjUGqoChUhbP5X2CkDT/H7oZanWsbYObQYSRIczWR6pIN9BPpO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119078; c=relaxed/simple;
	bh=s6rOJUKjsosJ8zG8JnJ8lvfkzgjQFmzpU7EX5Y+jty8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejSYhvG4djgyzq+1OkYd1Ye15U2I5gfrE6ZAbnOSb5MudstEc74K8+1fQdGaevVHPiCP526OHkfuzcuk+ReK0xe1bBJU77W5J2vrC8dBXmEFALi9ErLF8nlaKiRDG5xzzQHKUyzDtS5KPFlQAYA+nTapYISHASusAASiHal/6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o9kEJEsl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R9droFRe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o9kEJEsl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R9droFRe"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBcoKK3708167
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ke4jI+V5mt+h93c+f0rABKkElWpg5+/EJP/XOU8y9D4=; b=o9kEJEslBAWWEAlR
	gHUFresG05kG6GX0ZjpmXXVRI9SU1QlHP71/O/izpp8hUSvIFgTV2WLoGbEdk6sX
	6aEpcb1o8fV98Sj/ru5DV+7I1aZbm++SNXTevi6wD+e0P5kux7dG9sGJBg2WpXM5
	82SMwLtJqoCt1Nn2D3iaW5defR6/Oit2ifzGcdV5l3lY4LxdeACBgPtD2JljOqvU
	ujMaAyGaRBwtS/4BivxkkHt5JFuIHebUne6DkP1kT9ZfDmDeKSWoRl6BnLpHuow9
	cJ4pjiXtv+NyekaG5Lz9H0ay1IUOode+dHhPkQrnIYPwr5SFob1hgiX6klN+hs8X
	akq7kg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7nmgpwd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:37:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so100901925ad.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784119075; x=1784723875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke4jI+V5mt+h93c+f0rABKkElWpg5+/EJP/XOU8y9D4=;
        b=R9droFReBtBU+edgz4OOOgiXPGO/pHTn+QdvleEGTf+2IluH94AskfmbrWaz67zNo2
         0dpyNG0FZ9pVyqG+ugpitNJxKOs43wuJZJ+RSv0e+cTmnKxbdqfzSzzoyQYIVZ9/xK7W
         2yMXVv7VPaxNeVX7lpmgWP0O1Tsis1lPmRTnZXNlOT/FUQL5uY0QOITVqRsOSSuSp8t6
         yEbu6V7iMzrWH5a2EDdhcHhvcRUECjIwLAcUgXODbKxE5hSGs557+mcEPG3IvzNghiBC
         3IUS7GPlHaTYJ1/pli76eJz6v58uZztStBngK+5Oij7j0JFPAMXg8YgPz9D0CYEedVgr
         0W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119075; x=1784723875;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ke4jI+V5mt+h93c+f0rABKkElWpg5+/EJP/XOU8y9D4=;
        b=TMe2/U46ciHT2TuCO3X2gmzdfkBysD/ex6imGGAdmpiq92HRdRfJnqnMf6TBe5/A55
         Vc9l1ZDyW60l46mJtrggkPdheU+U7AIOldvG8cAwPVNVbCjrVonTlbDEvse/Ogf9TkOI
         dVvNQe6QVNiBohQgxSilT7ZFe6ABI/hfLtUfhbAi7yNB3guXzzsXZ7QQ3PqhF9sDw6DX
         nPe76HyKsqMMEnDiUIsPZEe8S4fXeB1DxbcXOrGKJkZjxE25PyOo8Q4W13rs2n2tdcT6
         mxv/vMD1ShytOtzWJ72ocUA021BQaExKOO9e9QYGrIO/zZnN6rpOSFnXq0+SWOeMPbHO
         izJw==
X-Forwarded-Encrypted: i=1; AHgh+RoaTHkKpOnaJQj+SFisiArkylV85aT8FAnajR1huTSEm8Tq4kDxE//udyq96z/LaAN8a4q9NdIniw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNtyptlePdQkXWMc/fhaeU4NwA2zxV5CR3nPbm3OTdqZQOO0f
	kwUYx7LIjb+VIIX38BxOMjm/aDzQGEG1gVGOGoTAINW0risBEu/aObd/yDZy/mrsvwtwaHxPBBv
	AE/VuvzwEm5tydA/kNIWteMyMdYaIg1Kcwk9zwAMVbs2J34qyAfDN41hWOIe5nA==
X-Gm-Gg: AfdE7ckqut1Y7M8FZ/7svGxH/eyVWPPXA7ZIYRt52u8Kwu3Og5zQTB+ioG8xMJ7YFS7
	99BbiZf85ZHns983LcJcZtrXy9WGxxW7XK0VQbeQ4CaMmgU/+c2O7/SXbdoeVBin+J8GbbznzOa
	MlVywlX6HA8cul4s85lXzH0oKlEq0dpMomsHCPaI66u5fbFcap3UkH/+KDTqnHl+FJEGqq8kAOm
	WjhNtkP1kWnEsjfuLkSvAJW4V1ZtFTdOhZQczbB+bmEIKu9YJtULNaZO2+UHwnRa3LfL/i3XB50
	KG38rTqLsKCImncdZQLAQmdRm44cM+47PSQBNX30dcFcyFwH5hc1n0dl+atEvJlCgKVKdL33+WI
	StkGrYve6RiYeq4aEYAndBjIELhUr7YHm0xAQ7mKC
X-Received: by 2002:a17:90b:2cc8:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-38e29fca185mr2454410a91.10.1784119074626;
        Wed, 15 Jul 2026 05:37:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2cc8:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-38e29fca185mr2454388a91.10.1784119074070;
        Wed, 15 Jul 2026 05:37:54 -0700 (PDT)
Received: from [10.217.198.242] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6c10dcsm1404027eec.23.2026.07.15.05.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 05:37:53 -0700 (PDT)
Message-ID: <ff6f8e27-5489-4d63-afeb-a38881d717d0@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 18:07:47 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm2290: Hook up MPM
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
 <CGME20260709114143eucas1p18463122323bdeae8e63b1d13cd626b55@eucas1p1.samsung.com>
 <20231215-topic-mpm_dt-v1-3-c6636fc75ce3@linaro.org>
 <dadff7a9-bf04-49fb-8c55-5605e99be7fc@samsung.com>
 <CAPx+jO9d1qH12mxg-n1rkbp6Xd__sdrSMeoc7CPELE+jgxRYHA@mail.gmail.com>
 <e83dffd9-e54f-45a8-b997-e84b5beead71@oss.qualcomm.com>
 <b434e198-2778-4dd6-8896-f7f54bc9b8e2@samsung.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <b434e198-2778-4dd6-8896-f7f54bc9b8e2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyNSBTYWx0ZWRfXwwCH6q2xliQX
 XyX+m9eJfFjyxL7GjYMbQE602+EvSCz8YQmpG+KJQUoRCt88S1583jNfgnDEVTYjzrnHibXma8E
 +ouRbMq7f4WC+Gp/Gw9T6NL/WtOgFaI=
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a577f23 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hD80L64hAAAA:8 a=R9InvSr7yIoRGizY3ssA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: ueSmqGVDvcicWFrwZGcdG_yvzxUEV1I9
X-Proofpoint-GUID: ueSmqGVDvcicWFrwZGcdG_yvzxUEV1I9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyNSBTYWx0ZWRfX+gljGVnR9M7V
 CE0VLSva/vIWyozIC1NX0jnd97FiuzyLTLwO3CcMpf/TOXywyw5VgsCYXYF8P5kUZBtQVk2b7Xb
 TtAUNzTn95Mt8bG//vHB9Qetf+UQthib6jLaGWm1NEcSxGRYdejvRQv47WK3+Rn85oQHnlhNirL
 nLd4Cd2K1rIoU2BN8auClUccTruaKtm6eFf+wH4eMxDdwCCpZyIMiiMqXq1C+Hy4S7ZYTUPiu5h
 aeKV8Q4QWywcbe5KK7RCxgNgxs0OX8xe47/0J4LnBYqck8XJ4q36CmtRHYvVoL6KkopBBXIFN+P
 Qomm4GGoEE4OPPJKv0ngAuLCe9hpvavcBy86tLvaVUGQqOAX2qOkKvZbw8l86ZLlP31UHxSJa0g
 Ztw2vl39OR1YRQ/ExzqFy+i7URXT3iALLCDyNdY8pGWc+QjbGmO1lT/8e7RfA3slVPV6t1mrNuS
 UpbczXzBPcRZPmURe+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150125



On 7/15/2026 11:44 AM, Marek Szyprowski wrote:
> On 14.07.2026 15:29, Maulik Shah (mkshah) wrote:
>> On 7/14/2026 6:34 PM, Ulf Hansson wrote:
>>> On Thu, Jul 9, 2026 at 1:41 PM Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>> [...]
>>
>>> Without detailed HW expertise (still learning about the UnoQ), it
>>> looks to me that the HW may have been modelled upside down.
>>>
>>> The power-domain-cpu-cluster should probably *not* be the consumer of
>>> the mpm, but rather the opposite. This is how qcom,rpmh-rsc works, for
>>> example.
>> Agree, There is a series [1] sent out to fix modeling similar to how rpmh-rsc works.
>>
>> [1] https://lore.kernel.org/lkml/20260713-b4-shikra_lpm_addition-v1-0-3d858df2cbbf@oss.qualcomm.com/
> Indeed that series fixes the modelling issue, but it doesn't change much
> from the spinlock vs. raw_spinlock perspective. There is still the
> 'invalid wait context' issue there, because mbox API cannot be properly
> called from cpu_pm_notifier (which use raw_notifier internally):

Okay, i see why series [1] did not help for agatti due to fallback on CPU PM notification.

On PREEMPT_RT kernel, GENPD is marked as always RPM always on,
So MPM driver never get the .power_off callback it registered for and hence MPM irqchip won't invoke mbox_() APIs.

from drivers/cpuidle/cpuidle-psci-domain.c,

        /*
         * On a PREEMPT_RT based configuration the domain idle states are
         * supported, but only during system-wide suspend.
         */
            if (IS_ENABLED(CONFIG_PREEMPT_RT))
                        pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;

The series [1] fallbacks to CPU_PM based notification if "power-domains" property is not added.
having a power-domains property would have avoided the BUG for agatti on RT kernel.

Agatti device tree change in the series [2] only removed power-domain-cells# but did not add power-domains = <&cluster_pd>;
with the reason that qrb2210-rb1.dts had deleted "cluster_pd" however qrb2210-arduino-imola.dts still have it.

so below change on top of [1] series would avoid the BUG from mpm_cpu_pm_callback().

--- a/arch/arm64/boot/dts/qcom/agatti.dtsi
+++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
@@ -281,6 +281,7 @@ mpm: interrupt-controller {
                        interrupt-controller;
                        #interrupt-cells = <2>;
                        interrupt-parent = <&intc>;
+                       power-domains = <&cluster_pd>;
                        qcom,mpm-pin-count = <96>;
                        qcom,mpm-pin-map = <2 275>,  /* TSENS0 uplow */
                                           <5 296>,  /* Soundwire master_irq */
diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index bf6fb12ad990..7dc2cade0a7f 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -246,6 +246,10 @@ &cpu_pd3 {

 /delete-node/ &cluster_pd;

+&mpm {
+       /delete-property/ power-domains;
+};
+

[2] https://lore.kernel.org/linux-arm-msm/20260713-b4-shikra_lpm_addition-v1-0-3d858df2cbbf@oss.qualcomm.com/T/#m5bbdb535424c38209cc08e6afeae5e3aac9f6cc0

Thanks,
Maulik

> 
> =============================
> [ BUG: Invalid wait context ]
> 7.2.0-rc3-next-20260714+ #16842 Not tainted
> -----------------------------
> swapper/3/0 is trying to lock:
> ffff0000008ac408 (&chan->lock){....}-{3:3}, at: mbox_send_message+0x3c/0x15c
> other info that might help us debug this:
> context-{5:5}
> locks held by swapper/3/0: 1, last CPU#3:
>  #0: ffffd99263a61228 (cpu_pm_notifier.lock){....}-{2:2}, at: cpu_pm_enter+0x28/0x78
> stack backtrace:
> CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.2.0-rc3-next-20260714+ #16842 PREEMPT
> Hardware name: Arduino UnoQ (DT)
> Call trace:
>  show_stack+0x18/0x24 (C)
>  dump_stack_lvl+0x8c/0xcc
>  dump_stack+0x18/0x24
>  __lock_acquire+0x928/0x1f90
>  lock_acquire+0x2b8/0x3ec
>  _raw_spin_lock_irqsave+0x60/0x88
>  mbox_send_message+0x3c/0x15c
>  handle_rpm_notification+0x58/0x114
>  mpm_cpu_pm_callback+0x9c/0xdc
>  notifier_call_chain+0xa0/0x234
>  raw_notifier_call_chain_robust+0x48/0xa8
>  cpu_pm_enter+0x40/0x78
>  __psci_enter_domain_idle_state.isra.0+0x48/0x470
>  psci_enter_domain_idle_state+0x18/0x24
>  cpuidle_enter_state+0xbc/0x428
>  cpuidle_enter+0x38/0x50
>  do_idle+0x158/0x324
>  cpu_startup_entry+0x38/0x3c
>  secondary_start_kernel+0x138/0x158
>  __secondary_switched+0xc0/0xc4
> 
> Best regards

