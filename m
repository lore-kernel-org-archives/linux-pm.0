Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484809;
	b=2Sj+61p+eBAWBcpZGENxcH4E+i1NkBFLbehfRZ3sNXEdNjzbcxhJ0N1x+kP33H3S6elW
	 IMDuBDE3QmPLdjFIEMsJrK8u6vX2fLCQ21KSyUPMZUPKnoN8LxQ/4KfaUS+zyH2tNEXne
	 Th2zClqHlKiUdcYzxrFAXQmDDbSwsl8X+034d7jVMmvhdVdpBUTox2iHyLkmSmxI+r32T
	 EYrJNPfPT/7H+Ed653ZZNUA+6E1mNZBgJCkT/PbEd3m3KiUX7p3joanctBexYkank2CYS
	 fJjiGwRV4fsZJEUL9Y/8Vk4hbFcU+jQ9Lkj8PYIyNPsh4+KAeuEePWyHdFnSmoYw5DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484809;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CFtFxHbDFiRPlcasZEvlvzwpY6ZQE81kNWfCGg2zSH8=;
	b=peQI9ifRZH8OfZk4aPifluSGnsyZyPH+ReqXYxEEwDTy6o7ymaYm51ZFweFCzU2WNHDf
	 y4umAjBHHDho73RVaJ9U2nSp8N2Ops8eaqvzqFIG5OhZf5Ni23IxMhsMJ0VvG28px21ff
	 Ew/Sf7a0s1I0ADG0NRthS9F18DTEnWfDKluCpOmTTV5Qn6oFyih4rZWaQNib6SqnnhGza
	 8DpP4NXXrOVGrLy2V5Tb/q3bAanG/Bc6qDZP2Q8y4tMe2xxsCdeGs4MU/I+1k9Cmc6LDe
	 Od4NRJ9Fz6EZMUn0wuawZjo37LVKDKfxLb6v1nBsUXj1Jimi1hsKcbgDTy4ag7zc6xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hg1K+ht4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ylx+hLwn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F647606A337
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 08:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F647606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hg1K+ht4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ylx+hLwn
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8Gk053806878
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 08:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CFtFxHbDFiRPlcasZEvlvzwpY6ZQE81kNWfCGg2zSH8=; b=Hg1K+ht4nvw/TKTR
	9pcR4obxqTpo2pNkEVYwC2lCCsWlKZMnbinoxHKeE0L+Ocnw0HbuSECOW9RUMO1W
	Lo2EnUmLxiu1Sb5adHWt3+h4dMcWjBUx4TVetLZxdxHHDysJ51cqn2jXZuI2tKWV
	wvbjrRkiv0XAyHKaf/CWOmyqJGymABRY7UEbcjGi7AFwliLYwa+0GTtkhjJw+tNT
	MPVAv5fwRJKdMl1ucb9NsnGk4PTuJybr+8iYHsFzECBl214JdED5Nb0pJuBiM0S6
	MmE5iunWmRQ/JlKSgC7WOQv3Cpt3EdMIkkyT91olpkWsd3ritEiKBNUH4fOgaraT
	NqlhWg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p9mk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 08:26:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb6391e89so671345185a.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792484807; x=1793089607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CFtFxHbDFiRPlcasZEvlvzwpY6ZQE81kNWfCGg2zSH8=;
        b=Ylx+hLwnCgHlPUu+q+hmV4ugx0Q1UkGFoA+aPNCvwSHk7C8zwk+yJ6+4jCYKDheVc5
         pCghVfweQxZHYGFdZK2dBu0BIYHzyq5yBnJiRbq3MikSeEmnd9T5yFkF2f5wWt0ylKjR
         BPAd939X/76paGsuilMfqwdgeVYzDOhFs8Mx/KVbpSx3hhcwpFn8a74AGNao1C5SQd0J
         Y0fLn+lxH0EGMVf5Y41x0+ybLpCXJ/nXqxAe7nFBHZESkKbvJSw15nyoxZJuxHik5elr
         VKUUGxeNMKSxDuwe+mxewA/Y2/pgHg7OHeQDcrjh1MJfQvmfPP/xMHx6Ct9KQv/OFQGH
         mPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484807; x=1793089607;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CFtFxHbDFiRPlcasZEvlvzwpY6ZQE81kNWfCGg2zSH8=;
        b=YdsV7dSgTNkeKo3jvlk1apggJjp1ve0t3kJZ1SvLSLtpM4FQFDqUPzvUTFNAD+wIWV
         KnwswCdpIzkNAH2JRELoUMTZEWSoBlE3qk58XX9OurLoNVHouWs33oF6R/Uw6rSgRNU8
         L77FqYK2Cm8Ixf0S9ax/dDnl5Pwo224416tlfuhmdyFHBQHMtIk5tLbz1OaKHPzg0djo
         x2VmETTnLv6yeL301xz2zsM1Id8VtufPUFBMAXAYrKJ4BtOUDJBE+q/BaEPckMAO/pB6
         EbECszs8EmW6CNusHfcHZh5J3Lo3RtH7Ka01PRXc+aboIEpoHBwuZlozQsM8UOmeoqu8
         yuJA==
X-Forwarded-Encrypted: i=1; AKwUvBx9PODWN8Jd7CzFqB2jRtFTxbCDUm3zSJt5dvZ4W3WZ74hC2ZtdpRWg65fUtW92hsBd3XCYnDcj6w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIkx8U/yRJiTs/qzxPHs7QpfCp7AjdX+euWrQ76iLkuXYWg1XGP
	veDwWvfeIVtWe76TUpIcU41Jhl7/ESiXlm30AStVNSeXlOAVv1LYtSooyeoSqa+4pXIRWDqZ0gv
	G0eKcBWj47fkrkm2I2Huo9Vlkplp9QQmCy/XtQhjvBkNHT2sf34q2R2e1wzrDog==
X-Gm-Gg: AYBFou3nIEXb18t5ThTQunV3GEMKb0bx2PDAviGWCj3U9bDpCvym1mdCNJg7NnoUTb8
	n853CezaIGF7b9OJ7bZM11DjRnZWVOLVAi+aw0U2e8TnPaLcQMK5H1UOq//0SmneDJ3sv537lT+
	me/75eJ9OzWJUIx5u6hRIPE9kRGS9G0GuYeXhfaFTvnkuGYU4iY6Rifo91XkcQRldTtztqhQb21
	kFLbDPQcr2390rRjLsWuWcfzVn5xVRmNOgF3wWARz09/UjAMEHoVijRHIcSWglPAJytbkDOi2I2
	dZmRsydl/Fv7D7/wZ9tjq8GohL4C3z3/MdNfUYpErbicUHHwrW7X7iOPQuSzycmLZYcCToaGwnz
	l7y5TZWSpVvMtBUUnsZvgWw6HC9VcwS4=
X-Received: by 2002:a05:620a:6310:10b0:93f:2ab9:729e with SMTP id af79cd13be357-93f2ab978b8mr1099291085a.21.1792484806552;
        Tue, 20 Oct 2026 01:26:46 -0700 (PDT)
X-Received: by 2002:a05:620a:6310:10b0:93f:2ab9:729e with SMTP id af79cd13be357-93f2ab978b8mr1099289685a.21.1792484806024;
        Tue, 20 Oct 2026 01:26:46 -0700 (PDT)
Received: from [192.168.1.73] ([92.247.57.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cd348asm57085425e9.11.2026.10.20.01.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 01:26:44 -0700 (PDT)
Message-ID: <3e5b7781-20ef-4e84-bb62-29a081c26d8f@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 11:26:42 +0300
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
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8250: add camcc interconnect
 cells
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-4-atanas.filipov@oss.qualcomm.com>
 <usade5zkrncpry4ufbdtaahoa2zyd5hx7tjgfvzfte2aqbkgs7@t3mej4maj6za>
Content-Language: en-US
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
In-Reply-To: <usade5zkrncpry4ufbdtaahoa2zyd5hx7tjgfvzfte2aqbkgs7@t3mej4maj6za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Fx19WKwGtC2pRiNBHapFt_OISVjn0EJy
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad725c7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ybD9qRDIDfZaXNPQ7Ca20A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=r4jdIUCLbnRwEHhwRoYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfX9IyCVAXwqf2R
 9Ggm51O5PUJygGDNU5k9BxlRmtiSj0SAqt/hvYvyEeFxnqu+EChwKqhFOYiDt/ur7vpseBGG/II
 ILiC2DrhQK11XTEMtnutaNIUuWp+WZPrtPYJ7vOZp8lxFaOwqn08O582KnXE3RsJ/5EZ9S/ZqjR
 KmHkk5JYeFFDzZKvTc9VL9JH8zWixCBUJDUOWKA96OOJ0f0iiDoKxt8ZJQLNiHYwHHlEICArXYh
 b2sgx++nfr3fxj7pBuYP9NYiEHy36ijx1M/bHXhdF6n+BF1NshmPOAFa1CNMNgqhRv0I+91KD/x
 87tk/U098Cq8iWlRWmGEsmdMVxv1ZOJlt+Qg26nfHoRQj8ftrgVaQ0JAANGPtYlitxsCL/ZJqXs
 mSutgBUM+QFq2O6Axt0UVA8pnnibKrUJx0w9oOsDYj2ZuFdcRX8IEkzeRUchLtRtzsa5KkzDRv/
 ZqGAS7FB0tMPptn/cvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfXwoNsXWmUoHy2
 iSiu/IV45BLcm7H/9pqpt1UwUtg9+gtba1eqcdOtlhjTQMTV+TtVBrokaAnPVkdcVbFeIU8qBC3
 BD4ZydovXNRPJEKTsLh51ulU7Kdcknc=
X-Proofpoint-ORIG-GUID: Fx19WKwGtC2pRiNBHapFt_OISVjn0EJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200033

On 10/19/2026 5:50 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 16, 2026 at 08:07:01PM +0300, Atanas Filipov wrote:
>> Add #interconnect-cells to the camera clock controller so camera
>> consumers can request camera NoC AXI bandwidth through the
>> interconnect framework.
> 
> I guess currently we have only one consumer, camss. Could you please
> include patches converting it to the bus voting? Be sure to retain
> compatibility with older DTs, which don't have ICC provided by the camcc
> node.
>

Before converting CAMSS I would like to agree on the approach, since it
cannot simply follow JPEG. In either case the camcc path would be
optional, so older DTs keep working as before.

OPP is per device, and CAMSS is a single device containing several VFEs, 
each with its own core clock and its own load. If CAMSS used 
dev_pm_opp_set_opp() on its device like JPEG does, every VFE would 
overwrite the clock and bandwidth votes of the others, which is the same 
last-writer-wins problem in a different place.

I see two ways to keep the VFEs independent:

1. One OPP table in the CAMSS node, used only as a lookup. Each VFE
    finds the OPP for its own required rate, sets its own clock and
    votes the bandwidth from that OPP on its own ICC path. The driver
    requests a separate path per VFE from the same "interconnects"
    entry, so DT describes the hardware connection once and the
    interconnect core aggregates the VFE requests with the other
    consumers. The rail level is not applied by the OPP core in this
    case, so CAMSS keeps handling it as today.

2. An OPP table per VFE, attached to the per-VFE power domain device
    that CAMSS already creates, so each VFE calls dev_pm_opp_set_opp()
    on its own device. This applies the rail level as well, but the
    virtual device shares the CAMSS of_node, so it would pick up all
    CAMSS interconnect paths and need indexed OPP tables in DT, which I
    have not seen used for such devices.

Which one would you prefer, or do you see a better way?

Best regards,
Atanas

>>
>> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> index f975c2183269a..e923c74dc1435 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> @@ -4675,6 +4675,7 @@ camcc: clock-controller@ad00000 {
>>   			#clock-cells = <1>;
>>   			#reset-cells = <1>;
>>   			#power-domain-cells = <1>;
>> +			#interconnect-cells = <1>;
>>   		};
>>   
>>   		mdss: display-subsystem@ae00000 {
>> -- 
>> 2.34.1
>>
> 

