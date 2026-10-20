Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489523;
	b=V//C03rH1FaTkHRzQoFAPWvMIG7KUErdsumFiwiXdtDsScN3ELEgUmVzmfzBrDZ2w/5G
	 0ZxQFHHJHMv9JQP6ZXA24sVX4lJumQFqFkIv2O7gjz2PujqFBobOo6V1aN/N0TrCp/DrE
	 1/iYVDRvmYz5O/6U4e+NslFf6VGY29kmOIWgfLJPUxRtZVkr3fL/YHrm4pSml0DQifrvR
	 VaIhy9hfVO1ZVanQkmXLD2NCwDI7vuG/VODlrIubIvTgiRYMykrMbAY1Q8o0R8MEsQjoC
	 fH308zry+JhVJn3qGOuKmM4a/RmsR1QmbnnjSWDlZE2DRwa7gwO84INp4p38kp4bY4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489523;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NC1hiC1DqKSX7UHtU2uk6sPHM2rRGUITByEu42a5Geo=;
	b=IJPNqlFHC8H8Mf8oXs1zZ2x4nrJ0SBeeNtbHVhpfQDYFeDyJMcD8cbUotzrOcVrKOSth
	 tAHDfB1QrfT4Z/DciySz9NMd8VshmXeQVPmbUtG/aw6j8ARcMgwOCc45mf9RlD6qsoeu1
	 x91zITr0HcD2yBtYjKau9DCVv4K4aw6HOmBCO7Kdw+u5rNzhM3S8MewV88e+SIuD4DAT2
	 DUDu9VrqCEUP7Dt0fDWxILHkzJibbpvgTJxnm6vgAX/N+SS5y2phtykHMpVYBaEsbJON5
	 BNery2NgwOGc0ayNy9Tx7KjT6Sm92w6UcooikpC+cE9wI5PAmlGjnZj2ItXueFkNOsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUk1ohYl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cuqFe0U0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67202606A31D
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 09:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67202606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dUk1ohYl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cuqFe0U0
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8hiT31718248
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 09:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NC1hiC1DqKSX7UHtU2uk6sPH
	M2rRGUITByEu42a5Geo=; b=dUk1ohYlAnMiWz4Far3u5Icgm8K0xvjB5E7uZylM
	bUCZ6zptepiTPlcVzLAls8BmzTwNRfwQywBUtjUCcZXKtzK9/PNLzxtJ2tFSzsqK
	680r718XjnXTfs+1zjqkJWBVN6+j1LTIrxnCHg0b//ImLu9AVZtgIbMhEZKymyKf
	ZQ4cz47cOofM8Aw8n951bwK1tCZnjVwGkuf6ZxpxAJb85ug9pVQlpReEA851Qz7q
	7I8ify8DIpnZ36DAUF8X+4Gny2JgXcrkZ1Z9i9YEOiXC+CRia/QGAsLSCBL+OXim
	qFP2z9/SsBvEsBJ0SnIt/oiXD9vbufnKsFWTl0WH00Nowg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5phxmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 09:45:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f20addba1so562499585a.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 02:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792489522; x=1793094322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NC1hiC1DqKSX7UHtU2uk6sPHM2rRGUITByEu42a5Geo=;
        b=cuqFe0U0dOu1cqHImrQFZDcbNCQm2Ye8S1RfixE3xipTosPmD3mFRuT05tRXMrc5ly
         7Z9a1afuu6NDeDT7DHP9fje3bDXF1O5O6ma2d9gvz32E0XVmAOo+7APvGhNaVsI6FpIr
         iFbAnh7TkOahVLHsgwSy1xIrroPI7z3JFy4k869MD0FOlxYe3RIV13xbY2BgF5wk/bos
         kiku371DjiOVvYd1OcZi+UkxR3rbWmb/nuwMQ/NYv7hlts6/o+dxQBS2lUQywp/nA3ol
         lC5oS/qNUUNDzdjsXt6Eiz4a4/d7e/WFvXqhVMWf2EIj9i1QbwirK/tYG/M/o3OJvSlH
         PBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489522; x=1793094322;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NC1hiC1DqKSX7UHtU2uk6sPHM2rRGUITByEu42a5Geo=;
        b=lKesnFQwrIIz+0R7DyoUETo/KOTznL6ZUrnq8LNpM0EQokO6K/07bQX7q/dIcgx2zI
         TsyiadDJHn2HRhlj919uuiKFnBbLr1Cp8cSxqbBELFveCSR5tv7iGFfQxDgnxCNq7mui
         yMA6B23rlHz7U2Yg1y72L294J+90SUQdZkEL5gOTBOjEVEIeTG/kmtB435lHftVs5IP0
         MWIFuq0Azrjt1roLy2GWKC0KKOkppp/OPLU/g3Y2rgUawR9cEE5Jwue/9YaQ34q6pjbm
         Mmejs6ZAzzs/jPK2W5j5ZTCIqDzWAdlw2C89eddrdBZlFeQx+cy0Dr7nFY64Ig6BD/CM
         Zx6A==
X-Forwarded-Encrypted: i=1; AKwUvBzbR+0eKtY6+8iS8xqUETLCORAxqKk8b0zH8YO96b+QLv7eJIMUqrjur/lLKUhnJKF9PGcM+UjwHw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLbwpgC7AxnWhZ7I5H6Ri4QRs8fuMx1X451Mo8Kf+lPesWtzUd2
	52Gxoe1DHaHI743nkD9mMdp854w74FsnysXEUnOLmzoAwx+jQMPDWeWy9Zdwqo/8Li/XAWR8kdl
	W2zzv2X20Z/KBbSosodzu997V14ic8rl3bgTGjFPNhJpE8bLb00VGrvTle1YXhA==
X-Gm-Gg: AYBFou0p1FcBsqYvWFPPBfkCq9NIc94zz/KCqAD98/VXmKRr9Xp+MqePcp+rx3h/dyc
	PnvOILlA8LAGmI/2Yri7fzXnW/3eQxQXH4rw8QYB6wehWR4cin8/KBGvB1XumOg8BzpazBJnJRJ
	7j6d2evbH078mV4IHNlBpYiHo46UB61VVHyn1+dQUWRy7JXgoKzahVjPp07QlgHqHqRjfpXAFG8
	ThGGY3XWSnR63XPZKMfnLUgmhHg3ifWKM4MsNfgNseD5Xce/QGp/Rc4aYVu1yZrfFkFxqCbIw2T
	B+QlKlHhZ/mQ36LKLdkrsFZwlk6iCquoBocqt3LYHto3CqKJoro4a5y4wpcFg35x8zPF0r5QEvJ
	fxoZlyjR0WqP29Zd3fYQ1XsVeG1ZvQcUCV7GanO01/oZmeSjmE+tvMjSGdkY62KlDyzOS3c7FMk
	nD4ELYzW/LJ5Dn
X-Received: by 2002:a05:620a:7085:b0:93f:21de:f3da with SMTP id af79cd13be357-93f29cc9ad3mr1601787485a.15.1792489521582;
        Tue, 20 Oct 2026 02:45:21 -0700 (PDT)
X-Received: by 2002:a05:620a:7085:b0:93f:21de:f3da with SMTP id af79cd13be357-93f29cc9ad3mr1601784185a.15.1792489521107;
        Tue, 20 Oct 2026 02:45:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a3fcf07sm2478354e87.3.2026.10.20.02.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:45:19 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:45:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8250: add camcc interconnect
 cells
Message-ID: <x5x4av76vm3swozvwe46uq5vz2ys7bvo4bducpp7flnmhykg65@pvr3znxyktje>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-4-atanas.filipov@oss.qualcomm.com>
 <usade5zkrncpry4ufbdtaahoa2zyd5hx7tjgfvzfte2aqbkgs7@t3mej4maj6za>
 <3e5b7781-20ef-4e84-bb62-29a081c26d8f@oss.qualcomm.com>
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
In-Reply-To: <3e5b7781-20ef-4e84-bb62-29a081c26d8f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=a7WlZkSF c=1 sm=1 tr=0 ts=6ad73832 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=1SZ4gMyvtsQaTvh4xNwA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: tKuhln5FUm9YK0eZ8r9Gw67Ev0vIyVwe
X-Proofpoint-GUID: tKuhln5FUm9YK0eZ8r9Gw67Ev0vIyVwe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzOCBTYWx0ZWRfX89hAN6M66MDA
 6hgio6P58hgkhBH5xYzcjaq/q+kMnioh0oBOijNJXWyns7N1D2XxfUquK4RHe/dV3+/TXBBh00m
 dBm934NpzuZAiOzOOYFeQ2vBXj9qCxV9bWstwtBiuBTJynMO2n5Qv73oXVh/6/y2A9qazQQMy5r
 mq5gqRXZDaHjPvx+KJ9xd2K0BVowXCzZ9VsHHNssewpwe/VP7CTiAkxzecbs7pkSFpLapMtwfY5
 tFtXwVlFw4+GdMtOAlNAdI7v9Y1w+vccUQNUqO2ReCxeTw35k87si8OaZPFrVCOrJKu7WSexiC9
 xHracEJZYGaO5Z5qbP2iDJ5328hoK9ktmz2fN6Jj/bl2i1fSlEuOt5uAvdkE4IAP6LPNtxysAlo
 vtjN8zT30m/h/0WtzCJikR9N6CGQZVLxWcSlGWIK59CtwxOMocyNv5QdL3Drn62k9ChnJewT4mm
 hl0RNQNXLjuJ8bMi8nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzOCBTYWx0ZWRfXyHFSDvM3Il49
 ZS44OTJyYMeL2Y1sC0lcahSGkABqZOQMabkEVu2cwhZSUzeygv8xeFmGVxAQ1cH+bQTJJXZOs7D
 Pevh/hvmiJcR2pBHKsvJ4G5XrydnJWg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200038

On Tue, Oct 20, 2026 at 11:26:42AM +0300, Atanas Filipov wrote:
> On 10/19/2026 5:50 PM, Dmitry Baryshkov wrote:
> > On Fri, Oct 16, 2026 at 08:07:01PM +0300, Atanas Filipov wrote:
> > > Add #interconnect-cells to the camera clock controller so camera
> > > consumers can request camera NoC AXI bandwidth through the
> > > interconnect framework.
> > 
> > I guess currently we have only one consumer, camss. Could you please
> > include patches converting it to the bus voting? Be sure to retain
> > compatibility with older DTs, which don't have ICC provided by the camcc
> > node.
> > 
> 
> Before converting CAMSS I would like to agree on the approach, since it
> cannot simply follow JPEG. In either case the camcc path would be
> optional, so older DTs keep working as before.

How does the current camss vote on the clock?  JPEG is not (yet) merged,
so we can't reference it here. The order in which the patches can land
would be: icc-clk, camss using the (optional) interconnect, JPEG on top.

Please note Krzysztof's comments.

> OPP is per device, and CAMSS is a single device containing several VFEs,
> each with its own core clock and its own load. If CAMSS used
> dev_pm_opp_set_opp() on its device like JPEG does, every VFE would overwrite
> the clock and bandwidth votes of the others, which is the same
> last-writer-wins problem in a different place.

For this series just convert the existing approach as is. We have two
distinct questions here:
 - Letting camss and JPEG (and others) to vote independently on the
   clock
 - Letting camss correctly handle per-VFE votes

This series must address the first question only.

> I see two ways to keep the VFEs independent:
> 
> 1. One OPP table in the CAMSS node, used only as a lookup. Each VFE
>    finds the OPP for its own required rate, sets its own clock and
>    votes the bandwidth from that OPP on its own ICC path. The driver
>    requests a separate path per VFE from the same "interconnects"
>    entry, so DT describes the hardware connection once and the
>    interconnect core aggregates the VFE requests with the other
>    consumers. The rail level is not applied by the OPP core in this
>    case, so CAMSS keeps handling it as today.
> 
> 2. An OPP table per VFE, attached to the per-VFE power domain device
>    that CAMSS already creates, so each VFE calls dev_pm_opp_set_opp()
>    on its own device. This applies the rail level as well, but the
>    virtual device shares the CAMSS of_node, so it would pick up all
>    CAMSS interconnect paths and need indexed OPP tables in DT, which I
>    have not seen used for such devices.
> 
> Which one would you prefer, or do you see a better way?

3. Add minimal VFE nodes and let camss use those. Converge towards the
split VFE (IFE) device tree.

-- 
With best wishes
Dmitry
