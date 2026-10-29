Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238087;
	b=gWt2UFukZnh0tAKYg9tZc4F1vI/LKwN4V1F4gYcoziE4qIRuNR9/W9CF0gVKxxXsu2m7
	 ryBvW4GP4LbQy0MygDTXSaFalALliCQ9N4yLbA2OrYqpVFAUjJ0hXVLE3Zqg3YdI0aNXG
	 b1a+jFFvvOvQfOefE66fzvfLnxYc7I8kIzTTirs0UfPp0kmKNur1YjblSuRWMSYCEsQLj
	 B7V+oC7XjuPDUF2DxFwoJ9xPqMZqvUzQj7KyovFK6ZAcUX2em6ZaKNfkQO0wzu0QgHBeu
	 Yic40xSzkZhRhUQJqNimEO/lQh+sQrrrcg0yfHwc8A7WiGyE3YJLZggHweRn9Uzyqow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238087;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=a2kuXhqVMsHVz13E2+Xy/aRM3eaxUgD5cFHLsM4u7/8=;
	b=pOScdZmWLRc152fskF4YMUak5b0V3WVVg8uBD9AVic6yJdzBc0CvoVQC7VN/V0/VRMc4
	 whl1R+J8NCYfEkDL7Bk1ECrmcJKV2bivGAi9OUfUUWCIXGiNP9ny89vYZCdO+GwtOpn59
	 gqRLxvQMRqRyhMWcuov8XgmAKTkvGJ2hx3hjHEwLzuDRHhMVXJN4CdHGC+XXr7djeL0H/
	 +bXg0Zczozuy5gpvZYbtTr0p1Ku7FyeqPJedc878Ore00peqDydfz71yCY0Wvzw67v2lW
	 UzOSZp7oEnJhe93iP1VeHkdbaQ0L36bhXHRmIzxAyY3ZHVUM22l5iSeuuHRlr1ZVHFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="FO5r/cyj";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="LsKvT/JE";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B799606A31D
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 01:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B799606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FO5r/cyj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LsKvT/JE
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SNK2iN3067927
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 01:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=a2kuXhqVMsHVz13E2+Xy/aRM
	3eaxUgD5cFHLsM4u7/8=; b=FO5r/cyjOLkBNAJFnWxgB1NUvwodRJijYg496R31
	+KlJUmu5ZzIxTukS2wkBt+jNNXzrVBAVOniHH0vUQR7NkDw5Q14ah7KioCAvNO3L
	Z82Kq6bnDDoU/ptI4fSoWwJSuuxS8h0RegwcKGsuou/2UeKx43kwCU+51Gi1d582
	lT7uYlLk/tNK2hwrO4ixPCvdRH4lFzA/Rtk90AwjpOyTmCKshQs1SY5f4B43jItu
	ZNORkbmem2nRvttm3Nc/k3F8YKHCZXb650NqhYd9hXwqjUPAM3ecRirD4riQBrFg
	xUO9fV9KL6sY/hfbtaDgYLrVz6o5BldLV4H/W5FB6byxEQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmp8css-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 01:41:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb93c874bso55209585a.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 18:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793238084; x=1793842884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a2kuXhqVMsHVz13E2+Xy/aRM3eaxUgD5cFHLsM4u7/8=;
        b=LsKvT/JEXNLi43lAm3c8END4CjTzsCR1l9d6gAIPE82nsWVFSmvVT4EU+hVbDLGjxC
         pHb/Ky4wDnILcYsGX51QKbXDnaS+lNOIGcBIM+pHqZ/T40Meei80kDwLePawR2FpYO3K
         UNi1yo7Qbtcvx/9z/Wyw2LBmffxMylvGxMKoY6me9uznx6wt74PbvMUOyXmPDKQbDyCn
         /FhlC47Fq4qIzK93TMT7+zpPFwDMc1dEx6vJbhxzYcoewQ+36wbV2NtO0Y6I6wlumDLe
         DeWtmn9VyGw7ZeAGgHlTZXiYOgmQ/HKsoleLPtchwpNq+kpaozziB6p02wrudYJj9CMd
         aRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793238084; x=1793842884;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2kuXhqVMsHVz13E2+Xy/aRM3eaxUgD5cFHLsM4u7/8=;
        b=EZVSWtSEWWB5mF5bWU99DC9UV2m0AzF2m/fZ13o7fRv1W1e8mTJ7BGTpusCRRTXndI
         P41yAyfUnWkn2zK5udGe76/q39jwwez9YQZyp3vIDO9gaAZmmUujxbJRwiB0EzLyVHmM
         /pKzcOBkk7ytywxuMlkyr4kc6LCEkX+F4+W6K2gD34U3dI1JIthgIUlS220bsLB7OJsn
         pdLrAnOD33oUVp0yvfI05na80LYoPv/fD5YZ78qHDL6HDh8UwaP7fCcpgx0KYsA92SmA
         f7XB9vFITDqG44hrc8m0X+0Wvg+a8Oi3E3ShpA+2HEmrQp5hbVMUYUH1Ek8Rb8watrmL
         faQw==
X-Forwarded-Encrypted: i=1; AKwUvBwwHsdj9zvUPVKCVg1bvb2okWZtVu/Fn7PJezZwPlKlasCkTtX4XOu12TYWmOOLR3zNVkCTCQh6lg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK5u1Sx2lRsTk3J11Q2f2WzB830VwPa8PbUQUXjzyyUQIqSYCZB
	l9zqfZOuQFoWijg8ncH/EGDBB3cejxqrd7SBsN+YToEBAlAGG+J0GYZ1kV/Ft/6GSZTLSV7jUiT
	ZlxAH0l0waCbJk2TYuJFOO4pXUBX5++RbO0KXw/sCEiMupYQNIbFlPxkR9ORV4m2tqh4Kag==
X-Gm-Gg: AYBFou1yYAbl4CGPcSeJC85GLXVvxMYgqJWiWB3EUuZ6rsHS8oqe5S8avINjFucwK8U
	bPBMex+/UQHfmTKPSiQhr1MXLTvJSX4abmkCncfnwjLrVBEY3xUWllOTgvClY9UJPSb7xFcCzBy
	2+sXS/6UwounNfwspJXzIJwVdw5Tuy5kxXBD7Z8q/UZkq/6MN0SevJYM8OiWV7hpHOL4RKbUpRx
	yF5/lXCou2eBllJ6xpnqZ+5XJCtapK8h5vg+x9Ynw7UQnYCqGPv1KgnFVn/KidIvAaanocxK8Ob
	PLY14SSdZmNyH/6awltJv3bpuunTYzZ0YzycI3DoOJu/qtXduuViXLyRjVQJ6e0J9U4uBM0vLsx
	WO6Um9Xgb2rwjlU5wLlgp8NxVuQwWWs+g6/+eBuXQCVizuf+ta4X7sLuR4t2siP2oX6QlMAZ+Fs
	UbnSTmKHUivedSCd3/SGmG2s9BBxVFNyD76PV5Zz+U0bcqs5jc0bbywwMZLAgDMA==
X-Received: by 2002:a05:620a:4104:b0:944:4e6:85d8 with SMTP id af79cd13be357-944132689a6mr211048985a.5.1793238084451;
        Wed, 28 Oct 2026 18:41:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4104:b0:944:4e6:85d8 with SMTP id af79cd13be357-944132689a6mr211046785a.5.1793238084012;
        Wed, 28 Oct 2026 18:41:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfd27eecedsm69199e87.2.2026.10.28.18.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:41:21 -0700 (PDT)
Date: Thu, 29 Oct 2026 03:41:18 +0200
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
Message-ID: <6ivurpkaxe7rs5lxpbyahpst2bqzpkcb67whcymoopdgo6sjvq@xd2otcdpe6gg>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-4-atanas.filipov@oss.qualcomm.com>
 <usade5zkrncpry4ufbdtaahoa2zyd5hx7tjgfvzfte2aqbkgs7@t3mej4maj6za>
 <3e5b7781-20ef-4e84-bb62-29a081c26d8f@oss.qualcomm.com>
 <x5x4av76vm3swozvwe46uq5vz2ys7bvo4bducpp7flnmhykg65@pvr3znxyktje>
 <a01d8d86-740e-4a25-96a4-d4dfd664af5e@oss.qualcomm.com>
 <20261028174523.3514860-1-atanas.filipov@oss.qualcomm.com>
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
In-Reply-To: <20261028174523.3514860-1-atanas.filipov@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwNiBTYWx0ZWRfX9SVf653KYNFH
 61vKrieeCTMWfK1dqGZADW1ZT7zXqT03GT9nh/6qKuJ4Tn/+cXBeDmlsBEBKV6pj5Tf4WzVqawx
 EoZwZBdKZTjfmXULNgyKMQfXAfRR/gGmZO/urtaKmT9mlso2PbDCiaypKFt8u0oLskeqBYqUDm0
 l0fOAM68g/NhJE+hWVN3DWVN3CYFwodR1p9VniPwohncB9YCt/opqoi6AoN87dyAfPEIdTYFFmZ
 MHEnlRor5twNpTQsw8UDmrx8aWuEa5pNuXhrh0ZBE+PC2HUCd/Uu506vZ1DMVDVTCKGYmoTjMYT
 3BZZ6T0lnP+FkuuLDjPnqpU2KYMG8M/jNEBIXHWLjP1qUfwZJyCxIc54tolFzeN56LIETnGBwPI
 KhGCGvuDf39rxZcWI+v2fa8QQZHw0TAzy1rLCo2oT0OLo7CZbbmFw+48BCDAM/D6Erf8jqrxxZv
 KSLYQWx/dc0XCeCbT8Q==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae2a445 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=rTgqbrGwJKAB67wPnucA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwNiBTYWx0ZWRfX6zpOXSgg8q+S
 yLj0HRsEpTqJCEP5ttX0g24CqXFPLDDGWRfkzsHZfXmKyrS29+2KvImDFHhi/OMHyMJGKrdAcdV
 WqdoeCOyJPCa0FJkwzfCchzYMvPLTDg=
X-Proofpoint-GUID: DnFpu9wmcOIw2dy1VjjsfRTqQxcfYRsf
X-Proofpoint-ORIG-GUID: DnFpu9wmcOIw2dy1VjjsfRTqQxcfYRsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290006

On Wed, Oct 28, 2026 at 07:45:23PM +0200, Atanas Filipov wrote:
> On 10/20/2026 3:49 PM, Atanas Filipov wrote:
> > On 10/20/2026 12:45 PM, Dmitry Baryshkov wrote:
> >> 3. Add minimal VFE nodes and let camss use those. Converge towards the
> >> split VFE (IFE) device tree.
> >
> > Agreed, I will take that up separately. To get it right the first
> > time, could you clarify what "minimal" covers:
> 
> After going through the options discussed so far, I think the VFE
> child nodes you suggested are the right approach for the per-VFE
> votes. Below is a concrete proposal. It is separate from this series,
> which stays limited to the icc-clk conversion as you asked.
> 
> Why a VFE node is needed, not only convenient:
> 
>  - The VFEs need independent votes for three things: their own clock
>    rate, the MMCX level that rate requires, and their own bandwidth.
>    OPP is per device, so this needs one device per VFE.
>  - VFE and VFE Lite have different rate tables (on SM8250 vfe0/vfe1
>    350-720 MHz, vfe_lite0/vfe_lite1 400/480 MHz). A single
>    frequency-keyed OPP table in the CAMSS node cannot describe both.
>  - Today nothing scales MMCX with the VFE rates: camcc only applies
>    its fixed required-opps, and CAMSS sets no performance state.
> 
> Proposed minimal node, one per VFE, as a child of the camss node:
> 
> 	camss: camss@ac6a000 {
> 		...
> 		vfe0: vfe-0 {
> 			compatible = "qcom,sm8250-vfe";
> 			clocks = <&camcc CAM_CC_IFE_0_CLK>;
> 			clock-names = "core";
> 			power-domains = <&camcc IFE_0_GDSC>,
> 					<&rpmhpd RPMHPD_MMCX>;
> 			power-domain-names = "ife", "mmcx";

If IFE_0_GDSC is an (indirect) child of MMCX, this is an overkill. You
should not need to cast votes on MMCX, IFE -> TITAN_TOP -> MMCX will
work for you.

> 			interconnects = <&mmss_noc MASTER_CAMNOC_HF 0
> 					 &mc_virt SLAVE_EBI_CH0 0>,
> 					<&camcc MASTER_CAMCC_CAMNOC_AXI
> 					 &camcc SLAVE_CAMCC_CAMNOC_AXI>;
> 			interconnect-names = "hf", "camnoc_axi";
> 			operating-points-v2 = <&vfe_opp_table>;
> 		};
> 		...
> 	};
> 
>  - Only what is needed for the votes moves: the core clock, the
>    power domains, the OPP table with required-opps, and the
>    interconnect paths. reg, interrupts and the remaining clocks stay
>    in the camss node for now.
>  - VFE and VFE Lite get separate compatibles and separate OPP tables;
>    VFE nodes of the same kind share one table.
>  - CAMSS populates the children and uses each child device for
>    dev_pm_opp_set_rate() and its ICC path. The OPP core then sets the
>    clock and the MMCX level, genpd takes the highest level across the
>    VFEs and the other MMCX consumers, and the interconnect core
>    aggregates the bandwidth with the other camera consumers.
>  - Without the child nodes CAMSS keeps its current behaviour, so older
>    DTs keep working.
> 
> Child nodes keep the camss node as the single entry point and keep
> the change small for existing DTs. reg and interrupts are not needed
> for the votes, so I would leave them in the camss node; moving them
> would only make the child nodes look complete without changing what
> the driver can do.
> 
> Does this match what you had in mind?

Yes

> 
> --
> Best regards,
> Atanas

-- 
With best wishes
Dmitry
