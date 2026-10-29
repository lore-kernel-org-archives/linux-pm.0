Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238665;
	b=cAQUBeNMUcUEFKLjTcAsceR4NrL54vm4yy6mAwSuplai9o+wpRj+XNAd8qJUpy7EmvJ9
	 nUUvvxl3IdoCoLAxCv+PIPBZn0bbYH2KumNrbQwfFQ0sHWxUYJJ0WF0l2btybkz8mI7OT
	 SaEEXHZJUbQJ15ytQEXzTtu4HiL3y3UcJHZ8Fc9PKI7oWBZfohPXawof0zpsQnptcbXMf
	 kbSoFRHN3UKU+3bjGgDfPKpQAN7V7XGh4oypqK46d/IpNyrHCcupQ0ceLu48N+z/nCjlb
	 7nEMPLFDwL2DRtPm4cLAucJnVtDrksGn3jhRv6E4df4+FQv5wQsC60VUhss7EEZZMFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238665;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2NgBNbLq+9RK99duvmMJui2cE6p6jlGXHry0ZBzeGwQ=;
	b=1ukZCRK61v/5Jajsq7r45dR02G/DtryXCe/AKzhap3eZ3bumoxUmr+VfHMdaSN1QiXVg
	 EvJjSpAMLtgxtwS4nYUQxg3rioThNiDfHM0BXxczLBDijuaEXlb80L3fnen41az/U7wpf
	 AqlzbyGboeXtu+hOSwhtXV5YdxHHYD7q/I1p5Xx7/D/miJcjhO5/VNo3YAuynXufg2FU/
	 HWVX+f4Fo6cswgG1NXmRpCqqqc6dEVI4euGujffqpe6ZucdwPY4PBRDdvCwJB1jcgiEcy
	 BKkPd+ws6b5G/P8Mm/NZGp6nOTC4Hru61tiZkV4CqTrY6wmUox/4d4o5VskMj9bcxcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PjE+YALq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f71RSJsk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E051606A31F
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 01:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E051606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PjE+YALq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f71RSJsk
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T1jRcE3375192
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 01:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2NgBNbLq+9RK99duvmMJui2c
	E6p6jlGXHry0ZBzeGwQ=; b=PjE+YALq5oSs0K/SsDeOpvvR0L5UI9h9ymC7pRL4
	Sh1CdtNvbAUhOeF+ITnRzndDlS43zOdQvMRl7oTlwDSxC1XtXQ0pYSP9QWcOM/Ex
	6lXeUF6dfiTvAdaP38CmtZ5/rBba9KVHhu3X1dfXrUyxkTG/jYH+QWCnTWmqY+iR
	uMyqAaqquH6+ior3SZemUKnpK8mwg/+epjGvrdVh96j11o2rocDcEQxzZGsLg2et
	Z1v9hBLCt3l7nq72oN5/TEdSlaH/Bt6/qRPvCdt2OM8IYQHV+iewGf5ppQM5gQrE
	kBVaIbnuhE4wrRxsyrtRrQCa6ONeslB1TOwuvj6hxKFYvQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmp8drb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 01:51:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f37c94ceeso51794285a.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 18:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793238663; x=1793843463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2NgBNbLq+9RK99duvmMJui2cE6p6jlGXHry0ZBzeGwQ=;
        b=f71RSJskHUY8w0Up1IqrAWrSwJ7qGp7VMJPalzdmC6nWtGtY0GtO0lQvAIKMaDR+st
         OhwIHpUSb7y+7bsUEJqUOqeEinweGKXfKLei5UqkvHVFmTNgRdb5s4rv6suzhE3AA+ix
         SSwKewQloywHNNyJkKSTXIUOF9Xj2ScQfP+wmkaM3WuHC7e7ZqaynF1rTK4iZOqA7V5w
         pieba7oY8GrhYd6CtejMLlgoiU6wx1CYH5FWSSCo57w20zrI3EcOMO3+oyt80kmE3H1K
         /hdD7KQXPPAMFzhfI49agL10slInQvPueJC6Sb77zCNity0kgwVLQWDIUilpSsj1fD4c
         myUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793238663; x=1793843463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NgBNbLq+9RK99duvmMJui2cE6p6jlGXHry0ZBzeGwQ=;
        b=xDzRk9BA1KTZGzSgUPk8Mad5Rl1ukI9l8X8tRgXK9hDI1JZSp/hO0s7Ydv1jSW2rd5
         kWu9leooAoJ29IPZkWhu4Q4kAgVL+Mmm1g+sbGdR0y/2iieQt7bEAJuS6AYoGbISvlqX
         QpmGRwSMBAHc5kTVCXZCU3/arQTkf6g1A/EJDTRjXeDeeWiWRrLrZMny3n8HNjRRDo49
         Kqs9t5jLCexN4tdXT+auLNudT0nrigTIS1iYMT/zsQyoaSijpuK+nTCZeuUnWwE9N9hZ
         bihQkAiheOf5UzQN7hIhC4iwDoGrM+OdnM4RkpgExIaOm5YSsppgypO6B6Mnl4K3IDTP
         mqSg==
X-Forwarded-Encrypted: i=1; AKwUvBybAhRE4FDwq0Ks99NOJWaL5AWe1CznMbiDi8vwMNyaM1N/45Z8euxtn0Rzh/zayB0VryzrcOrT7Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKbh39aNJDiekXC2O6HaAVXcRsZ9j0wghkRBuK8FzLBCxU8nT+r
	G8shJ3aXq/DcGesgr78EN72vz6lCR9cYuH9Y0aLg1YuoxM5l3R/xiUsbSvtlBS/FKzLyUFil38s
	nKldHWPHFGpdbyWonrLioSHsvu/5jJm7e4to3rC4V+Xep3zVg0nYaLGj5JnuFrQ==
X-Gm-Gg: AYBFou1g82uJXnuwFBpunKrZiI/E3HZVjUbFblbGwn1hvb3UHxq20siJxcUC/DZRYgL
	d2lLIf4jeU6oG+cIlCgCekFlZEP2goHf82k+lsWMEgXllPlhlVt1b6Nua0YymiTgZPUc0pn5vgn
	3UVw/TRnD2sz2xVXb95n6u+ieWVOTYyKRB6qsaMtlcjL4OX1/4jIhQ3dNqa7htFgubfaV4cCvoL
	CJ/YiwR0rwwXwa3cl5BKgegLQHAc6NYmkJ2h8Xfugfv10s87WCs3DGitlkDnozZSXQMgEKaqhFl
	c0uU7QoCLCWKrwMGsXjZXCwsGfQxXD02TJdNsGzYhYALO6mDIEEtRUALmdJi/mEXJhUSrkdpMCj
	6edGjZyXPaXFmLh9CdWex3ZFWFqvSUpS6G6k6c3iztgeTOjqIlWSpUDt8PrMJP4O26Fgzzkrs6r
	jXUVFuKQ1RMTK8ZU/0Srb+bpaU/1o3Y3aPQlLz7yL+EU5R/jZf4LC7rHsqUQY7Sw==
X-Received: by 2002:a05:620a:2815:b0:93c:6e1d:96b0 with SMTP id af79cd13be357-94413381feemr207245285a.17.1793238662562;
        Wed, 28 Oct 2026 18:51:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2815:b0:93c:6e1d:96b0 with SMTP id af79cd13be357-94413381feemr207242985a.17.1793238661951;
        Wed, 28 Oct 2026 18:51:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfca5c8f4asm982402e87.83.2026.10.28.18.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:50:59 -0700 (PDT)
Date: Thu, 29 Oct 2026 03:50:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Atanas Filipov <atanas.filipov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: qcom,camcc-sm8250: add
 interconnect provider
Message-ID: <uqtvrqp7rsmxcloz2fgzv2jbcofd3x7y6hm6plnan5mao4t5rr@6lxub7q3duti>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-2-atanas.filipov@oss.qualcomm.com>
 <20261020-bloodhound-of-remarkable-debate-11afe3@quoll>
 <7ca815b3-4712-42e4-996d-4a1e53cad492@oss.qualcomm.com>
 <Sm-FvdxaOiXpzzGo30wECHdQF_-LtUaJCO3mGpBUxXfnVCYjOLE5DhNWdNmOMhYdkR1RMXhPzWuHhsZJkJ_Vzw==@protonmail.internalid>
 <20261028181040.3515955-1-atanas.filipov@oss.qualcomm.com>
 <f0618a27-cee2-4f39-a578-fcbf3c51607a@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0618a27-cee2-4f39-a578-fcbf3c51607a@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwNyBTYWx0ZWRfX+fOY3ihAq4QT
 l8d7E9P8gfxjnpZildI/9OpWeZ93bVwZiiQaRnMILEvf3ofwF+VhKNamqAV0NSoZRnSDcQ4+QVy
 n6TJNaT38S6fxOh+A+1/Aj0C7pp/YJI4VPl3QYXiTB8oyjWEGJhtkR/FhMbqhjJUZOKkqPL0g7T
 uYVIKI7INv/CaVaKSAAcJDm2428mdyPlls37UG5lIDWe0Z0ZmeSD2NzSYoaeVdURVk01mDf4dpT
 lJS9rS3ciOyD5ch5/NjnIZt4cC8Tc36IBOGYdCSNFgwNEBqlr2SWpMSF3REPxODvdtsnGVajkhG
 q5rkRHiVsRyZwdngWO7luIeA7BuglRxlBdx4JRaQpIWbjErbruUH+i7UpkNqtlATPdrNOITU0Fm
 lO9R6IUxAximxKJG6k87XdHSGlPLry4V5lFc+2vYX6GJ8jlRmrAur65cHI66/bzObpm38LK+Pa5
 K9gnJMbPTny4+o9sdQw==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae2a687 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=z-wHjszcAMnUrtkC1bAA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwNyBTYWx0ZWRfX/yKWrKdFY0B9
 GTsD2iUT+bRhonHwQKb5wtxf9fnuBdzlSBH0F+aW2bhUwwjNAXNZw99gp7mQAmGsgvwIE71GsoJ
 qVBEevQkbcoMefSnRi7Lt9vB/PjzUtc=
X-Proofpoint-GUID: UNdpJhFkHy1DaV3WvIBSoN0sTjweePfG
X-Proofpoint-ORIG-GUID: UNdpJhFkHy1DaV3WvIBSoN0sTjweePfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290007

On Wed, Oct 28, 2026 at 11:00:29PM +0100, Bryan O'Donoghue wrote:
> On 28/10/2026 19:10, Atanas Filipov wrote:
> > What clock votes cannot express is why I think the camera NoC is an
> > interconnect:
> > 
> >   - The camera NoC is a bus with several independent masters: the VFE
> >     write ports, JPEG and OPE. They share it on the way to the MMSS NoC,
> >     and the camnoc AXI clock sets its throughput.
> 
> I've always conceptually viewed the CamNoc as just another NoC that happens
> to live inside of the TITAN_TOP_GDSC power-island.
> 
> I think the trouble here is the CAMNOC_AXI_CLK is just one clock, it's not
> interconnecting any two things at all.
> 
> Noc entries in DT usually look like
> 
> interconnects = <&gem_noc MASTER_AMPSS_M0 0
> 		 &config_noc SLAVE_VENUS_CFG 0>,
> 		<&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI_CH0 0>;
> 		interconnect-names = "cpu-cfg", "video-mem";
> 
> In the second case we're connecting an MMSS port to a DRAM port i.e. two
> completely separate producers/consumers and we have specific ports that
> RPM/RPMh is involved in managing.

RPM / RPMh are Qualcomm-specific abstractions. If you look underneath,
you'd see NoC clocks, being managed by the RPMh cores. We also have OSM
device, which describes how each of the cores / clusters is connected to
the L3 cache. On MSM8996 similarly there is a CBF device, which
describes connection between two core clusters.

From my PoV, CAMNOX_AXI, is just the same NoC clock, just not being
wired through RPM/RPMh. From this point of view the clock can be
described as as an interconnect, it gives correct abstraction: no matter
how the camera blocks are connected or how the connection between them
is managed in hardware / firmware / clock devices, there is a bus (aka
interconnect) between those camera blocks. If at some point the clock
becomes managed by RPMh, it won't (significantly) change the hardware
description

> 
> Which is not the case for CamNoc - here really we have some shared clocks
> which we need to calculate across components within the Camera power-island.
> 
> In downstream the CPAs code does that.
> 
> - icc-clk would I think over-provision clocks
> - CCF would as you've observed under-provision
> 
> - But a CPA's analog in upstream which components set/consume ?
> 
> That would work.
> 
> After all what we are doing here _is_ specific to how camera works. We don't
> really have many - any ? other examples in Qcom SoCs where we lump a number
> of different semi-independent components into one area - ICP, CDM, VFE, JPEG
> and ask them to share aggregated clocks - in a way that is specific to -
> guessing but - specific to how these components get modeled in silicon test
> benches.
> 
> My vote is to replicate CPAs in upstream with a CPA's icc provider driver.
> 
> The bandwidth calculations are already proven out in downstream and if we
> get it right - potentially its something downstream could switch to.
> 
> We could even use the interconnect API inside of the CPA's driver but, I
> think just doing votes via interconnect and icc_set_bw() into icc-clk in the
> drivers directly won't produce the same bandwidth calculations we have in
> downstream - which you may loathe downstream code but the clock calculations
> we'd assume are ~ a pretty good starting point.
> 
> So; make the CPAs driver an icc provider.
> 
> cpas_icc_set() could/should absorb the downstream cam_cpas_hw.c heuristic
> for calculating the aggregate clocks.
> 
> Its not represented in generic icc-clk right now and as we add in more
> clocks/SoCs this disparity will grow.
> 
> ---
> bod

-- 
With best wishes
Dmitry
