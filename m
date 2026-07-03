Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BEB413D99
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091353; cv=none; b=qVGhteLS4dIxbB0zCLsNO2WUqS6nUtBdEg9F3YxJB9TU9FfftU6tuUy6pPyINHxUrf3GLfgP8Z02yYTJuWdsspwM7CzkjLttxPxl+nHdqR/N6hyWFvrDDL4Absx/8q5SEHnsSvilUqJI1+pGJiyJw5cZB7cUZERjEyYM3eDERFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091353; c=relaxed/simple;
	bh=9AJ9t2zKbz3CM4OW0384dvG2q2y6xZLXbgr5QaSSAbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0L7oQLFyoUuomV+b00lZZ++c6XI2FKSkD8izAFELGmK3Y2k+mBI4pD1bAsF7mp+YooQEMI90dLBJH//ggdptpp3rC+jmIZBA1/lBrDoA7xp1CVeY4pd6w3QwcYPjcDHBgmi1yjCojFr2ZVyRozhTMU06pggWVE0MqVzmXJ1sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kgIK3/LP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DY05/ipb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kgIK3/LP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DY05/ipb"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BqpJo4091208
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 15:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fwim1m/o8/vtW6F5/R3W9M3DsGtJx+nlb8SSGEWQJDo=; b=kgIK3/LPHHkmedOb
	wG7Y3GHqjJqq9Z6+xr0WIwEi21MowgiDLDNwxYAbrsqurA3LWf05TumdIREhJ+s6
	l452JLmnBmIMpMqPPH3OFWeXSwSHYEooHfK2Pd8RSEzKRDqrdHBFK/7aSnTPUeIv
	lUu23uet3GvU3O0zD1FXbUf7hdCFOt4n2yndhHJO50eAJjd1FL6BWQRjIF3A44Ff
	2PgMn83RrRO2Vovlo36ca+zTNaOvfHIl9fPxl10j7ZVnLxEcTREUDhXmubCvBOAk
	EC49FWRBIxAVDnwAD36yhPsVtPLI4/PuqK/ZTxRodiwvWLU6ted66BPCdkT8AZoQ
	PgTmOg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0n9c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 15:09:08 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7386e55c63cso24314137.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091348; x=1783696148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwim1m/o8/vtW6F5/R3W9M3DsGtJx+nlb8SSGEWQJDo=;
        b=DY05/ipbVaAV1BWj/5rONCobo8NxUBBMFjt/k+WUrSu6IitTHet6smFmOrQMESqInG
         46qcE1GFFFmIOxj5X3AiMuaydaCQqlYaAWdLGDJI8nHL67sKYj+MoJd2Eaec00kPRPnC
         P297Nvop+oVV4iP9ozZV7xOSlKvKxoKbSpDAPvp+ha+fhnfpjHdveSzcDN8FPGoD4m44
         yd4SEpjaCntHs+lNJ17KFjJS3rPEw0jus9teme6v/VueARCbI3WQAUXvZdgwb7d7ERfA
         k+OU+ik1VYYRWaP7+Ifepkc3JJ4oBhfLniZsjACrKF4/wed1shg7Ih3HcpOOdvEEEloG
         dxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091348; x=1783696148;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwim1m/o8/vtW6F5/R3W9M3DsGtJx+nlb8SSGEWQJDo=;
        b=QSIzbllDT/fLdiUP8oEEc5szj/MhaerZ5kyZD3ca4mv0GqazBFvIUTElRaYUK0j7I9
         qoJR4Bmz5U38hlQhO22HLo38L42BKBQ5WXJN846+mdQlPRa6KFipertM/Lz8UZrMG6CD
         9qXat1f8fBpX55DBvTKXlOEPrP7c9qPsbENx1aIRwSG6827/UkeyedL4na0923oboV0x
         dv1zInYUK3M+cvvhAaNsUrjyE4MYKpnvyLG6/l6y7/na5tvZA0nENTJTWruEEIQolZK7
         ZUYm9DmuFWNmvJ60GFAKZ355VGn9M6BJAcPHTlTaiaR0PF8MLs5E2ETHtjcqvRBNBfrn
         A2hA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3OEjxVQjsBG/T0HnDOzeYGjzwXbbDw/8mX2fG6mSTNrdFhBbZE1B5P0oPvZNMz0b6TSGNZAbaaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/6CZtFxNOumlOTATEQ896x78gukpj62J1BdmpRY3EsmT4Ufj
	xp89EjDU2GmZlRxCykNHLwMw57vO9B5dEKZD4MRUoFNj2uRk5msZd5GTbql5BpTRF6xYC1rHTCO
	kGLAguc3k3/eV0IDReBHmtBWK3Xfpmi5k3vZ8FTV5hCUpLQN00bedo/atuuzTK7hkD0csng==
X-Gm-Gg: AfdE7cn8ruEpe+uagbWbRBc3Dd+Hj396R+v8iUCIqdCaYupPPqfyAmx9FcA0JnxXoZ+
	Isk2nDkKV9sT4i4kR8m7pMUJ3/lgCR+8Qb0om+69b0q5a9HJhyNIapo3f+dgbkjFgV5tKWovLHv
	RspKo+yC6gFTy/rleYbTlwe9Pi4ZtVpRgK9RELjv5Zz3/bB3IPrI85CUnLGw0RXFsqhMRO4Xt05
	zMBzThC/gPST1EqXY8MtRpfNg/ex0lcFttqFUq4TPpqKxYN9ZNtbNXgI5GK9LH2L1wbfMq199fa
	LQedUbUSF/UTps88KNXsF0p3zpG8Ng3QGwQH2+ppoYhDC5gv8yzFWqN8J9MKRMQYS5jXICgiox+
	GaLh5NG74TFsMCoy6YVGgQmoM99lnf7FTs/M=
X-Received: by 2002:a05:6102:6a8a:b0:738:4343:fba9 with SMTP id ada2fe7eead31-741f8ffb110mr55433137.6.1783091347614;
        Fri, 03 Jul 2026 08:09:07 -0700 (PDT)
X-Received: by 2002:a05:6102:6a8a:b0:738:4343:fba9 with SMTP id ada2fe7eead31-741f8ffb110mr55406137.6.1783091346108;
        Fri, 03 Jul 2026 08:09:06 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd8904sm2578a12.2.2026.07.03.08.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 08:09:05 -0700 (PDT)
Message-ID: <7ce4844c-8025-48e5-a1fc-4d1cf9f7917d@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 17:09:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
 <20260703-eliza_evk-v1-2-7624440bd76d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260703-eliza_evk-v1-2-7624440bd76d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX4agbxEaASqgA
 CmSW+YG8gVEtSOUGBRd5CaS+COsRLCK7+CIzQwsp5Oj1JXYmg32aigGoE9H/o18ZIWU7AdjNkNk
 XZkhmA7Vkxt7mEM7c/r7DSxCd6nbk8U=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47d094 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CLDG33loBYVu3UNdBq4A:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: -BTfvnamU1O2_o2fduDOWfplLF1RdluS
X-Proofpoint-GUID: -BTfvnamU1O2_o2fduDOWfplLF1RdluS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfXw3pVmbMfhJv2
 VbfO9wuglTLWkP6RY3v9QsYeJhAIOFUanrHpFgJlyLVwKIdtnOC0zZ7txkKad2rn/4yawiCNb5A
 sBeD4tx3qOuWQ8Py5Rr5VoguBMIAxe3QT/PKXyKtjeF6zosQTJgeQH+9U2q7quFNVJav0OLbFWi
 JC5xbNwAS57NhrOyPbS511Sl6vVUxF3gR1IcEoJHKBlweDkmboYrfhdZw2D4Np0uuvyyBAvqOsP
 hMXdNQ7OU9NDmJYZinhuGAvlwGNSXtv332zD5LooOpxht+Qxtx5dN7+51G8n3bperjRZDdjN4Il
 RohBAA9W97IB914l0NVNxyQgAayeiJnPPENGRLoXG/JN89Esj1MngTTKZ0fcQ9+XuIFeOqMdG5E
 4SiDlWO7hglr+BVnL64xQW4G62A7ySjKG7r44JDpOKYHRQ9yyavEW8KJ3ZhIV8K+KEua4aIXjQP
 ajg1EU00jeApjTz2ZRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030150

On 7/3/26 2:38 PM, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> 
> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> Override the base iommu-map with the expanded set covering all the
> switch's downstream ports (0x1400-0x1408 SID range).
> 
> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> from the PCIe controller.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +&pcie1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_default_state>;

flipped order

[...]

> +&pcie1port0 {

This port should also get the compatible

Konrad
