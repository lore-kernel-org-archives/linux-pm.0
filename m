Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162642F6FD
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614719; cv=pass; b=YPx6n5Eg32HbW6Hq+8V+7Ou3wQxrLfm7EuQTh/EQvLXPYPSLUkvlxx1J21v4BqnTznCaDsn/PKHaTc6UELoB7pyJM3dAHZQGR6NiBb2kJUAxGuxXXUGX2Zowo2FVBzf2sKAzkab7S+eFRGNIeVZ34jXReSstq2WchyWbtTm1+6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614719; c=relaxed/simple;
	bh=fL0Oyp88GwG7kNOMBo/yujFF8wNjRPW6Iy2PxK6WeBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpuAqQYmz1vDJtmBf2uZtWdp6ET2afHgMVQeeeb0pF+gDiDnxKFm/VFWKCPWtJ+jcXpq5SEiSqDGsTDc83g9SZiRBCzMF2ksVfxbgYs8zzjMYndB04/YzbWrw+nqbss7M18F1wSoTrXlUt6BNJGDXTtU3YSAiR/HBS0WqDUdaeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UFUCq942; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AUAwQvSR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UFUCq942";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AUAwQvSR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D934kG2326106
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 09:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fL0Oyp88GwG7kNOMBo/yujFF8wNjRPW6Iy2PxK6WeBs=; b=UFUCq942nrPbctuG
	znqVroq90ZHi1z6V+1XxkjtfazzjyNXp2Y5VDZ2/qipRLuIKKF2bhPW20H7MJyJn
	ldj7zeVIUXvmcnOP6NqpwPSHfc/gOTnu0k3wh6zQ37txwhhZhyDi1+4xp5s9E5EP
	J89+jJvxeqB+yci1ay4nwuxkLbFEn0PiNs3HFW9pX2biFiMB5Tc9UFn+eojAwBZh
	20AIDG9+031yQBtGkVM5WV9lJP/wToh0JbZCeSDF7VH2Wj0oQ2CIkar/zmxa6vBE
	QSeQfgHKFd9Rjx5CtCeAgvmgh7RFgWC+xDJRgdnEHwcCl+UXNb1Cw0kdOi+lMxIU
	WVBh8g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0wt8ud3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 09:51:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf6acd760cso8342575ad.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 02:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786614716; cv=none;
        d=google.com; s=arc-20260327;
        b=g9BYB7Ibc/+GhvDwHrkxU1gq7+UPFtNuXdMpKg5ioPGImGS6oBlHfiy9I3JIratRAc
         82g+10Ct/aXpva1V9WJ9D41zpWhSa2w1DYeJpNSDNULs06A10v4ym2G1+RfOj0Z17HLD
         NtscIrCqkDmd3+pYLvtSubynGySB2FzpuZQOwrxoEhN2NkJr+AnRpIuGDwn61A4ymI9p
         0zBqnRA0sCqGhS6zFC184kdSdKiPDvxfUjnY1FdwCp0gnsEH9zWmhyPZjK/pq0MhRxus
         rdQi/h8A9jwH7x5WWxkuHn0QvVo6KxF3ngLU9SixWF5/keWRVvCm7bp5iBUZM0qOeh5v
         Zttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fL0Oyp88GwG7kNOMBo/yujFF8wNjRPW6Iy2PxK6WeBs=;
        fh=tnyQQ6HDfjtVpyPWn65HsxYRmkc/BtWiKHptf7kIO+g=;
        b=TwDFJyjveJSveLiwWAJD+KMYgFS6gJhuqWijc7GfvLpBp6NePqpDKhBXJIxKxlZxjP
         WrmYhjij4qEeu39n3CQCDGDVaX+0gttLwkFCE619iziiRVPNoqzbXdtvEZYRm+tT+bs4
         gWOWQRER8IgNlixoBO/EqOD+YuAHyAnGxL8vP6GEjRz3n10FOJ+ZYMLjbT5pJnkquVMO
         JuHibXgT1CDls67TklovBj0c+1RmtcDEV2l2JeNC6VpAdsSMqNYcwYcqqR94X/3uLOap
         81/SF4iJYrF4CQ2HgPBVEDY13XbhQJDXv1R0cpMwp0IC8YTau7JqqN/mWEc4S6YJfYDa
         qP9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786614716; x=1787219516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fL0Oyp88GwG7kNOMBo/yujFF8wNjRPW6Iy2PxK6WeBs=;
        b=AUAwQvSRTfXDusTwV7EaUVE8EuqK8HaK2UHm+OpHhi4uNUkQ5TpWFd5eGAMunjXFCn
         u3AYmuY2uCEczp/CLOqcEKKX66+OjutnC12fACR2Sloyz4KLxJwLfW3vQbSaRjtRRIVE
         w/tbg93ojxJNYKbtWMvwbMdeRb5gEsqNa2GW95h4FhG6GRMvg53asaNKPPnSyXIYtZwU
         bHal9WbK0xbM7X3QlnzROsHujwRfjIO1qKL9bTI3GX0AMGfxoVIiTn4ZPh+bY0Z5Vrsy
         JesnwRNpHZipUp2vlgAWcMA/VHs6xMm71ggzK6qTamaClyKomm0z4hLjVxvy2+OKH+ED
         9QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786614716; x=1787219516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fL0Oyp88GwG7kNOMBo/yujFF8wNjRPW6Iy2PxK6WeBs=;
        b=hTtuoW4+pLLOenICpaI+BJfsvCsOJpAnPxBcZHQycsBJ2hjixaVrFbEAdsOD1cryac
         JroZkFnHoeVTFZcS/+ijcxkvS2Hk+KMwCZMk5lafHH0vuzj0wLvoDgp4Nn+d2PATQvGj
         625s5EgafPypVRu2RWK/GK17gFsErTWoCB/XUpFNK9wq/qpOk0wJsJe9nl8KO7Lk38Zm
         g+fzc6Fip1BOJh5N887lWmmJRC1G7ZTFp8mf2NnPLIQM8ExrCtyutOBUERVa/s5Amtm/
         kamOQFpHGq3i6b3E6Uxso7hrKE3fO0PjFPwLna5jQgm64t5hl6y+lB+R/aIQIrgh1hD6
         SP5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqej6th03iyiBL/YOB+5sLnMM8+5n6hTutX00p5xDXDauV20sNf1n/qggjs2XKEWbYGlBmQB55p4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRqLYJJjAGa9BHpi4iIlUGU/o3I/ncI/juCuXgiVMPbJ1LjOX
	erhj1kyHrmFTNcgsBWMf0SN35U5pO1Je2jd8+sPFKjPKotlJKvHI+esoMg/v9+Gvz9kt/brQRVa
	dgs5Xn865rHlRYfJL9aQv1a97/FdTOxEJ3JJpakltw8ON7DH1TGEP0Uy5bAS26frSYZYiPHQp8J
	TMr9IdfRjCmwCoXH4gzAYfPYDIgoQLG06iEnwx
X-Gm-Gg: AR+sD12beqb7EwcP+vpXFdjolob9ZwLJIhiCoIwQk2YdTPAY/ONbsl00YlpS3edkwFp
	JCJihbcUe63mEy8AMAAOwvxeDFkK05CGn0fJBS2lKbKV/B71tU7G4zsTr5grq9PMJGTR3M/IqdI
	nqf6UukIVs4wvdFdJ5rIWrUBPchK0/MVh6HvznqBdGdN59VKxxbPWSJV77/Q==
X-Received: by 2002:a17:902:d4c7:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2d37e833aa5mr44485605ad.13.1786614716133;
        Thu, 13 Aug 2026 02:51:56 -0700 (PDT)
X-Received: by 2002:a17:902:d4c7:b0:2c9:a5e9:c26e with SMTP id
 d9443c01a7336-2d37e833aa5mr44485025ad.13.1786614715579; Thu, 13 Aug 2026
 02:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-cpu_cluster_component_pm-v2-0-2335a6ae62a0@oss.qualcomm.com>
 <20251218-careful-ruby-wildebeest-a8babd@sudeepholla> <d0ce8306-84e0-4940-98aa-dbc356d87593@oss.qualcomm.com>
 <20251219-hysterical-sparkling-meerkat-59c5eb@sudeepholla>
 <11a01108-63da-4317-a547-5977a469a7dc@oss.qualcomm.com> <20260723-light-aardwolf-of-swiftness-1c46ea@sudeepholla>
In-Reply-To: <20260723-light-aardwolf-of-swiftness-1c46ea@sudeepholla>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 11:51:42 +0200
X-Gm-Features: AUfX_mzzSEQffGx9CifuPbFV5RxAKHUylsQq-VNyHO84epcOG5G-e9RJOaAN9Os
Message-ID: <CAPx+jO-sCierYj8jnoKQHckJG16dOBxnNrsZVYO=38R2cLV8nw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] coresight: Add CPU cluster funnel/replicator/tmc support
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
Cc: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>, ulfh@kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, kernel@oss.qualcomm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=YLqvDxGx c=1 sm=1 tr=0 ts=6a7d93bc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
 a=c5Fe1Fe05ZhRYI1i2R0A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2OCBTYWx0ZWRfX2weJ5ot32Voi
 XV99xDhfJc8fyvEug+voVdZUPvifmFbyB5spDzyxs17naqBK4x7UfBAUy3Q6K6S+EUSXOdvX2l/
 dpXh1z51HsJgKCfh7pbZzGe+3uRSC0wEgb7uConw3Z7k6fyjao9Yyv8uCxu10gQmR57/wu9tT6m
 hF2f9ByJ77FDVmKzO6pMAX79Pz7JwTIfItquVtHUeITxyIdU5SzyvDXIfmcNQAJSo2MHJl9ly6q
 x0rDZBq9CBUNfCJ+ATx2yPTEUsG5MrnfOMQv0/OhN9njmou6EKTY56S0UekB/Kv6eLV94Tb6+Wr
 UNeTXu7zrv/mCM9sgfAr+T0bMtothMUxvjl9d7BY/qF5djt7YvQypSqpnlis0v/t1kBol5KbYKY
 dJlJ7d4X1VM1EbgE1O8SZBGMGckNvExjAMABjPcetWhFU+PF28idgbk6qLsurBS4Hi39AZcX23c
 P7vB9SUOW3bt5Js0uGA==
X-Proofpoint-ORIG-GUID: capV-xN40ijkZSozMB9Ql-C5swKuohdX
X-Proofpoint-GUID: capV-xN40ijkZSozMB9Ql-C5swKuohdX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2OCBTYWx0ZWRfX0OFRd6CxxVW0
 YjpFXDprst/0NPlOs+jf/++h16kKtcG0V+W6i8BbKSsr2yPup1w3IMtncsfelGwohHPneTZxKJX
 lJXVdZVGzbf2spQXFfoeQR5YeE8g/W8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130068

+ linux-pm

On Thu, Jul 23, 2026 at 3:45=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Mon, May 25, 2026 at 06:47:27PM +0530, Maulik Shah (mkshah) wrote:
> >
> >
> > On 12/19/2025 3:51 PM, Sudeep Holla wrote:
> > > On Fri, Dec 19, 2025 at 10:13:14AM +0800, yuanfang zhang wrote:
> > >>
> > >>
> > >> On 12/18/2025 7:33 PM, Sudeep Holla wrote:
> > >>> On Thu, Dec 18, 2025 at 12:09:40AM -0800, Yuanfang Zhang wrote:
> > >>>> This patch series adds support for CoreSight components local to C=
PU clusters,
> > >>>> including funnel, replicator, and TMC, which reside within CPU clu=
ster power
> > >>>> domains. These components require special handling due to power do=
main
> > >>>> constraints.
> > >>>>
> > >>>
> > >>> Could you clarify why PSCI-based power domains associated with clus=
ters in
> > >>> domain-idle-states cannot address these requirements, given that PS=
CI CPU-idle
> > >>> OSI mode was originally intended to support them? My understanding =
of this
> > >>> patch series is that OSI mode is unable to do so, which, if accurat=
e, appears
> > >>> to be a flaw that should be corrected.
> > >>
> > >> It is due to the particular characteristics of the CPU cluster power
> > >> domain.Runtime PM for CPU devices works little different, it is most=
ly used
> > >> to manage hierarchicalCPU topology (PSCI OSI mode) to talk with genp=
d
> > >> framework to manage the last CPU handling in cluster.
> > >
> > > That is indeed the intended design. Could you clarify which specific
> > > characteristics differentiate it here?
> >
> > Sorry for coming very late on this.
> >
> > This series is intended to handle coresight components which resides wi=
thin CPU cluster.
> > For the cases where cluster is in deepest idle low power mode or all CP=
Us belonging to cluster
> > are hotplugged off, access to coresight components can not be done.
> >
>
> Sure, but the question is why is the cluster entering deepest idle state =
if
> coresight is in use ?
>
> > The implementation tried to address in two parts,
> > 1. Using cluster power-domain to know which coresight component belongs=
 to which cluster/CPUs
>
> OK
>
> > 2. Schedule the task on intended cluster's CPU to make sure the CPU (an=
d cluster) power is
> > ON while coresight component of the cluster is being accessed (using sm=
p_call_function_single()).
> >
>
> Why, just block any cluster entering deeper idle state when corresponding
> coresight component is in use. This should be taken care automatically.
>
> > The use of power-domains in (1) will limit this to PSCI OS-Initiated mo=
de,
>
> Yes
>
> > to have this support on PSCI Platform-Coordinated mode too, probably in=
stead of power-domains,
> > cpu-maps (which also defines the clusters) from device tree is a better=
 choice which will give
> > the information on which CPU belongs to which cluster.
> >
>
> No, let the platform deal with it. And the whole OSI mode was pushed givi=
ng
> such use-case as example and now you are telling you want to solve the pr=
oblem
> for PC mode. I am confused. Just use OSI.
>
> > (2) ensured that scheduling happened on intended CPU and while the acce=
ss is in progress, CPU (and
> > cluster) will not enter power down in between.
> >
>
> No, just block entering that state in OS(for OSI) and in the platform(for=
 PC)
>
> > >
> > >> It doesn=E2=80=99t really send IPI to wakeup CPU device (It don=E2=
=80=99t have
> > >> .power_on/.power_off) callback implemented which gets invoked from
> > >> .runtime_resume callback. This behavior is aligned with the upstream=
 Kernel.
> > >>
> > >
> > > I am quite lost here. Why is it necessary to wake up the CPU? If I un=
derstand
> > > correctly, all of this complexity is meant to ensure that the cluster=
 power
> > > domain is enabled before any of the funnel registers are accessed. Is=
 that
> > > correct?
> >
> > Yes, This is to ensure that CPU (and cluster) power is ON while coresig=
ht components
> > for same cluster are being accessed.
> >
>
> Or just don't turn off cluster if coresight is enabled and in use.
>
> > >
> > > If so, and if the cluster domains are already defined as the power do=
mains for
> > > these funnel devices, then they should be requested to power on autom=
atically
> > > before any register access occurs. Is that not the case?
> >
> > Cluster power-domains will be only available for PSCI OS-initiated mode=
 but also
> > will not help for cases where all CPUs in cluster are hotplugged off as=
 hotplugs are
> > platform coordinated.
> >
>
> See above, let platform deal with it. It is called PC for that reason.

I agree. If PC mode is used, then the FW should manage this through
another channel, like SCMI for example.

>
> > After discussion with our HW team to automatically request power on for=
 coresight
> > component GPR [1] can be used but they seems not working as intended on=
 the existing
> > SoCs and will be available on next generation SoC.
> >
> > [1] https://developer.arm.com/documentation/ddi0480/d/Functional-Overvi=
ew/Granular-Power-Requestor
> >
>
> You are looking at it from wrong side as you allowed cluster to power dow=
n
> when the coresight in the cluster power domain was still in use, right ?

This coresight part that is about to be configured for profiling
belongs to one CPU cluster. The current CPU we are running on when
starting the configuration, belongs to another cluster.

Hence, the cluster that contains the CPU for profiling may be turned
off. See more below.

>
> > >
> > > What am I missing in this reasoning?
> > >
> > > The only explanation I can see is that the firmware does not properly=
 honor
> > > power-domain requests coming directly from the OS. I believe that may=
 be the
> > > case, but I would be glad to be proven wrong.
> > >
> >
> > please see below comment for more details, This seems not a firmware is=
sue.
> >
> > >>>
> > >>>> Unlike system-level CoreSight devices, these components share the =
CPU cluster's
> > >>>> power domain. When the cluster enters low-power mode (LPM), their =
registers
> > >>>> become inaccessible. Notably, `pm_runtime_get` alone cannot bring =
the cluster
> > >>>> out of LPM, making standard register access unreliable.
> > >>>>
> > >>>
> > >>> Are these devices the only ones on the system that are uniquely bou=
nd to
> > >>> cluster-level power domains? If not, what additional devices share =
this
> > >>> dependency so that we can understand how they are managed in compar=
ison?
> > >>>
> > >>
> > >> Yes, devices like ETM and TRBE also share this power domain and acce=
ss constraint.
> > >> Their drivers naturally handle enablement/disablement on the specifi=
c CPU they
> > >> belong to (e.g., via hotplug callbacks or existing smp_call_function=
 paths).
> > >
> > > I understand many things are possible to implement, but the key quest=
ion
> > > remains: why doesn=E2=80=99t the existing OSI mechanism - added speci=
fically to cover
> > > cases like this solve the problem today?
> > >
> > > Especially on platforms with OSI enabled, what concrete limitation fo=
rces us
> > > into this additional =E2=80=9Cwake-up=E2=80=9D path instead of relyin=
g on OSI to manage the
> > > dependency/power sequencing?
> >
> > + Ulf in loop.
> >
> > Current platforms with OSI enabled, Linux PSCI do not implement the pow=
er_on/power_off
> > requests, as far as i know, runtime PM was never meant to implement thi=
s part and
> > pm_runtime_get_sync() (from drivers/cpuidle/cpuidle-psci.c) call is onl=
y used to convey
> > to cluster power domains about a child CPU/ sub domain being on after i=
t has already
> > been landed in Linux.
> >
>
> When a shared power domain has one of the consumer active, why is the pow=
er
> domain being turned off. OSI is supposed to handle that, I still don't
> understand what am I missing ?
>
> > The standalone invoke of pm_runtime_get_sync() from another CPU do not =
really turn on/get
> > the CPU (and cluster), as the CPUs either use CPUidle / CPU hotplug pat=
hs to enter/exit
> > low power mode.

This is the main problem!

Calling pm_runtime_get_sync() on a device, doesn't necessarily power
on the CPU PM domain (cluster) it belongs to.

At the moment pm_runtime_get_sync(), for CPU PM domains, only
guarantees that an already powered-on CPU PM domain stays powered on
if it's already on.

I am working on a patch to fix this in a generic way, I will keep you poste=
d.

[...]

Kind regards
Uffe
