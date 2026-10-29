Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258753;
	b=xcvbBG79Gd5h32VVmqgE7A+fkn9WLmixZ4LiiM8128+BSFdd5iD6Op3/koHGC7i4tXJJ
	 BFbsXEDKver8vPxi1wulNmdx8OUILyxrNyW+0B+Tf5ki2n9b++K2u9/bCS1mAw7/RmOXl
	 qH/LKsWcKdKtyotO1ABNTFbTnPeeKnwe6KQax/S69oHHJuEoNd0ZJjSQMP6zx8vNEWXlT
	 PJfdYnYR7opF7pQx8x22aF3Ehomi8T4d9/xgC4inbqDF7WzFvYae1vce+aJnHL47uTwrQ
	 SD/R4hiNOioquiT50hisyXkc3Htz5nRi6RbxVrMKS8DOzzMg5pM31XzJRnMNXctv+cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258753;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DPr/ruBMl/5HBXMrl9bzUyjfwBosBgVuKL0NnKrAD/w=;
	b=ZhUUtmg5+47ptLt1/iS6KByneYyujU6DJ0E/5RKOPRb6UoPTf7HBuFbxD/a2t0u+Dxvk
	 DdQ+USAdwOpvitzB+07OWPykaURqX+xtaUg/xz/+JDb+E1d+cKf9QTYvR4JcCAfTvScxW
	 SE992d7fCmWyyqQFCRPX86R/H9icvSs37XbGyIpS8sWhqIXlzf+Nc5iXkYUyQ0wH9mFM7
	 bdx2ObV00mydS4HhidcfEL9ees3JkGvMcUewnqkz1rxb7Fa0XI0QyyqNFXLpH5sIqayBw
	 7BCpreo4KxREkPt0kVPDHTw1rErb6j32jTwVRn7EywItxKhZKaxRDCZ2+tqf8lD/l0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WMbDXrgb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GqdrpWKf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8D606A322
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B8D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WMbDXrgb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GqdrpWKf
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5GuLF3829010
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DPr/ruBMl/5HBXMrl9bzUyjfwBosBgVuKL0NnKrAD/w=; b=WMbDXrgb+uS8dEwt
	DjFQF79dR1ep6mfPqr4H1gwzFJ35mCShmfFtfCshkwKxnGD56fDCx74h8e2wh97W
	rUa4FlmajEarcIuR6Q+OO3UwbWTaBG9M7G6tyL1Hyk0eqXgQTmA2AN3GWQuKVLx2
	uuPrEMpRfmX4m6Tr6WGDjLPQ1x7AQUvqmUY4SG0SYM/XI/0BffHG5nfx7ysB/YC8
	bO4pu3ADHcqcAyqK71NzhqAo9uuMSs0oPGhhQQ+pSC9SbPPYP44ClEvwwflZF42E
	2sLRkxybcB5FYvZukMxQsiqAG6/QtMMz+nOS7WMD8yljtdKfQFO44Qp1vuXCS/jl
	NHaCnw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmp9fet-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:25:51 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c0f73807eso24194686d6.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 00:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793258751; x=1793863551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPr/ruBMl/5HBXMrl9bzUyjfwBosBgVuKL0NnKrAD/w=;
        b=GqdrpWKfCUk4imCVsSVEKcRZPv2JRmj+5XT7hpK7YUmufnLpeSYMLjTE9TKQumZoPL
         aNBk5O6rEJ2uYCIuuZZZpCxXHR0Dq1ZU+SSxEAwr7B2D7rgnDF4fnFYITPVAaDsAGYoO
         yjIr7lpInBOcW57eyrFeTY1zicJJoMsEJmiruQWkoAlD/WcRbpYMe/CpLQrbE4ty3K9i
         3S7h5/fQR9jAH9KIXZytdPNv1DUFsl7FLQh08OiTR4+wzqy/IWT2W6fV6NDpWhNixA96
         RKby40+baKyz7Gl90COd3j2w5ofaZM0skIlLKBXi4N7FeJ/9illy97w13Wis06pQCKar
         NpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793258751; x=1793863551;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPr/ruBMl/5HBXMrl9bzUyjfwBosBgVuKL0NnKrAD/w=;
        b=JFk30kTup72/VQc1DHWOI0QBBkXsabX7o+k3mQVjeD47TtAvk5zS26EXV9bwey79V9
         mi+ple1Fkz1kX7Jn+OEQ2McM6vtFpbkkEwuMx2YWSgrqAa6B9B6/aUsCB2D6rTucVrS0
         PcOoUWOwU62ybK1HtSZ1PsqPbJve/Y/H5CMNQ+4p9PCwor5cBC7cqvM80aPm0uHe9YCj
         KQOEbP+dOufLPmw1ygCKaufLITOl45M5PGYTkbmZJoYNstLeVSPqEoZRawkrgn5KkIEs
         fURB3al7xH6InBJPn60+34z0idDsy53emhG3V23gi5KeDRErqbvaSPfxoNlzS1m2/f7J
         oGyA==
X-Forwarded-Encrypted: i=1; AKwUvBw134880FUrvpwRP9CelZw7zC3SpmBrmUNQ0WEouRhALVqvg7pEYciGtclLsZxa4f5bnLRTiTBd3w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIccOrU0HFAJKH98PW6VEN55i2Zftd5AFU3YCS3jJ2KA0tOcZTC
	6qH0OPoPB8kxxXPzWB8S9Lp4aiKmQYL99W0C3tql5eWloLMe57AxjfknMfW1xm6AmrQKSM2tLgO
	jhmArnKcI9iBSCLHQTGjnApF67pJLgv7CDVgxxHkCpuhMI03hnuWyikYv6eAh3A==
X-Gm-Gg: AYBFou2kJcVG7h10YInMgZPByuCUmKj0h50H0xuAvNPnxPRQUDb8Its6pkmzwLPLGCm
	jC7k7rUxY++M1+vfpoYVT5oHfPSZ2Y413bb92K9eZZj3HwjKoc1u/9svZU/EigCGeW7oP0lNjRo
	6LnENs2DT8wQpOdYAz+VYdansjFmWGeZiUeaASygCwgOqR+4yVgsbyzHDYqQyBQnA3T7Wfi30s6
	vbsSomU6NHpqfzOe1rCPWms0x88/2TpL6zxWHgOcCT+cPMUzaSyHlJumlj3R8jZLlNkzfC5IBRS
	cFWSg6P+lWgzghO04lRmqhD3HFvRFc2iXXKB0NhOTIglL0S3q2uAtvPCO2OwDJAhiugSoXwhKga
	s2ecI25Dsd3nVZbmE3DJBs/gOyaUp+xtG/I2Vc3WHHXv5toYcbxYOEywxeo1fbfeoj7UfEARn2J
	u65HG5CmvTcFVM6Q==
X-Received: by 2002:a05:620a:284a:b0:944:6c7:c88 with SMTP id af79cd13be357-94408ce4acdmr614856685a.54.1793258750415;
        Thu, 29 Oct 2026 00:25:50 -0700 (PDT)
X-Received: by 2002:a05:620a:284a:b0:944:6c7:c88 with SMTP id af79cd13be357-94408ce4acdmr614853885a.54.1793258749900;
        Thu, 29 Oct 2026 00:25:49 -0700 (PDT)
Received: from [192.168.25.64] ([94.155.124.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e542ed998sm18038106f8f.13.2026.10.29.00.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 00:25:49 -0700 (PDT)
Message-ID: <d59a7591-b4ca-48fe-9f23-335e3bc21d81@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:25:46 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: qcom,camcc-sm8250: add
 interconnect provider
To: Bryan O'Donoghue <bod@kernel.org>,
        Atanas Filipov <atanas.filipov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-2-atanas.filipov@oss.qualcomm.com>
 <20261020-bloodhound-of-remarkable-debate-11afe3@quoll>
 <7ca815b3-4712-42e4-996d-4a1e53cad492@oss.qualcomm.com>
 <Sm-FvdxaOiXpzzGo30wECHdQF_-LtUaJCO3mGpBUxXfnVCYjOLE5DhNWdNmOMhYdkR1RMXhPzWuHhsZJkJ_Vzw==@protonmail.internalid>
 <20261028181040.3515955-1-atanas.filipov@oss.qualcomm.com>
 <f0618a27-cee2-4f39-a578-fcbf3c51607a@kernel.org>
Content-Language: en-US
From: "Gjorgji Rosikopulos (Consultant)"
 <gjorgji.rosikopulos@oss.qualcomm.com>
In-Reply-To: <f0618a27-cee2-4f39-a578-fcbf3c51607a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX41CmfedaOS6r
 BkiwObJgSBEWm1NKpYLHD/dfC4Lnq2/oO7U86FJCezvpXUQYwwRj1KGkxeChlAAtkUaw4bu8vp7
 00kM3kxQGGvDDy1mkikVbG8EyLmYuac6AECRJhFFP7u0bLyFlmr3NzmlfuECh0DPLNIJGc3PB7d
 csM3sqNoggvmQHBOVWQH3hVR/AWBWJ4CYS7I6uX6+jVFmJC/KJf57ZovPv3hg0HTPcdkqRHgbzZ
 z+asolARyz3AjFEGYr1dozFCDQQ81gpzy4EAag6LwCkj2kb3evP3VkoQB74gm0uqLnsReqTvmPd
 +51h1ZlVAU5BgWCM3l/rsiStDDUKrmdrmnszemUjFo0umDpJFvH1gAbQU+fDbfS+kHrucyNIzXt
 8N2m98XKgnURLzTslX9bBgcwFH0ZsumH0G6oR2SJb3r3QatV9kZSshfWmpTapv5cv5jSYaFGQ7K
 ImG7bolAGZu5OUzN0qQ==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae2f4ff cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=eGCDHFSXubCXFTSSGhjuOA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bB782UoiXxmDKwpK7Y8A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX76gwBqSPOCv5
 nBwV4pcBzKtp3qmx1PNaoQMR4M9vmvN/eAw6gqHAAeYgvKc7YeD7KbsRLCMRIr5Xf96y3DcVR0e
 ToERTKDFhI+t50Sboc4fz+ffARX2eqM=
X-Proofpoint-GUID: LG3BQ8qwnP4mGXgK50xPeGhRNMsxbvdq
X-Proofpoint-ORIG-GUID: LG3BQ8qwnP4mGXgK50xPeGhRNMsxbvdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290028



On 10/29/2026 12:00 AM, Bryan O'Donoghue wrote:
> On 28/10/2026 19:10, Atanas Filipov wrote:
>> What clock votes cannot express is why I think the camera NoC is an
>> interconnect:
>>
>>   - The camera NoC is a bus with several independent masters: the VFE
>>     write ports, JPEG and OPE. They share it on the way to the MMSS NoC,
>>     and the camnoc AXI clock sets its throughput.
> 
> I've always conceptually viewed the CamNoc as just another NoC that 
> happens to live inside of the TITAN_TOP_GDSC power-island.
> 
> I think the trouble here is the CAMNOC_AXI_CLK is just one clock, it's 
> not interconnecting any two things at all.
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
> 
> Which is not the case for CamNoc - here really we have some shared 
> clocks which we need to calculate across components within the Camera 
> power-island.
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
> After all what we are doing here _is_ specific to how camera works. We 
> don't really have many - any ? other examples in Qcom SoCs where we lump 
> a number of different semi-independent components into one area - ICP, 
> CDM, VFE, JPEG and ask them to share aggregated clocks - in a way that 
> is specific to - guessing but - specific to how these components get 
> modeled in silicon test benches.
> 
> My vote is to replicate CPAs in upstream with a CPA's icc provider driver.
> 
> The bandwidth calculations are already proven out in downstream and if 
> we get it right - potentially its something downstream could switch to.
> 
> We could even use the interconnect API inside of the CPA's driver but, I 
> think just doing votes via interconnect and icc_set_bw() into icc-clk in 
> the drivers directly won't produce the same bandwidth calculations we 
> have in downstream - which you may loathe downstream code but the clock 
> calculations we'd assume are ~ a pretty good starting point.
> 
> So; make the CPAs driver an icc provider.
> 
> cpas_icc_set() could/should absorb the downstream cam_cpas_hw.c 
> heuristic for calculating the aggregate clocks.
> 
> Its not represented in generic icc-clk right now and as we add in more 
> clocks/SoCs this disparity will grow.

Just to add, there is a CAMNOC interconnect within the camera subsystem
that handles arbitration between the online and offline engines and routes
the data to MMNOC.

It also provides QoS settings, which are currently configured by the VFE driver
as part of set_qos(). Therefore, I agree with Bryan that, if implemented properly,
the downstream driver could switch to this approach in the future.

This raises the question: should we update CAMSS to use the CAMNOC provider and stop
voting directly on MMNOC? CAMNOC could then vote on MNOC based on the aggregated bandwidth
requests from the individual engines.

Regards,
~Gjorgji

> 
> ---
> bod

