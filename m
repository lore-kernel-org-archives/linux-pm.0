Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53427AC4D
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511854; cv=none; b=Zb5GVWRqW4mhT8CeMISVf14SOdU2bQVYE7gxy05u5N/XTVAfAbcEmzATcpyr7sNubB2fx8TieEAhxXBvbfFabDTLEV02YVHAihgqXfn71sDzaVQth/usTIAq4OH3wRTc5iFox4RFXmXVPgFuk3+5ig2PUiuXRkz+skaNd/spGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511854; c=relaxed/simple;
	bh=fz4msogSnakmeQKSqrQ7d4iwY+ZxUx3s4/WKfGlla1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4H2imOi2+pVsI2HlqRgDmZd0M7WSpQh1JCJJYu8JUpZ79G948ixo16YZNOXwx/I0OjFHQ1ulAKByRv4PZJMmT0XFfL8Ru39yAbUU01JVsVUnwtI6hllTIy/jEEkRabb/OMo4sRUvbyNRkD98xBncr2zOt6DjU51x+mXPYPBDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTcCk3nW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Li7OhnMx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTcCk3nW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Li7OhnMx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOVLK403798
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 15:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xNunTRXsqpTsk4gUldkupbFQmBRLlsHQmR+eXlL+D8U=; b=jTcCk3nWFwj3zqCZ
	HXK2aGTGQfkjUJiQhdjXPIe4d8GKmzHhhMX9mzSyJHH/gwHNQ9/pnZx8s/5SMTt5
	v/fwpQArD7ZzOpRSEV+3KbksS87eaAWLemhnGSiarKI2b2lkr5+QDNkIIJsEaGt+
	jexTIEMx29ZbZFc6mVKnfkTBRncsD/OhOWtJuTs5Y55rkMn/o2yyTtNYzCWzJiuz
	NcnUtqDOrISRhOIAMssv8VQ0x62QtNkRO6YbL+vnNVNUsZLBXJ6w1fImEzO8VrSS
	ies22v2lCBSzxA+YTfZ7zvaGx1u+Xi9H80HfgpcmtaoljJ08RzGO1cm+H1xOfHwd
	m6mQAQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frufkgvbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 15:30:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so883887a12.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785511845; x=1786116645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNunTRXsqpTsk4gUldkupbFQmBRLlsHQmR+eXlL+D8U=;
        b=Li7OhnMxg/+t0TD4C5BpWzcoCBJaRVhX9hhcRhmfe9lYEKHynraFxXyJnRXXskG8Uw
         mQxC4XyzpZkEZamfSlgK7So1s7Z+LXcyx6IDcriuKnJ/ND1UbXM3naPRk7T163FAOdHc
         SK8B4sADaigDZt2AVG3BqceklBG0nH/X+1r0ISYF+L47eyY2tKMGv5YT1uS+vUHNabmb
         +IiXYBqIse6fz1lmK3/9rxmMVgxHz7X83pnVq3cSKKKhhUB6zHdqzgMfwaDORTFMwOXJ
         AWxVVqlY4uSI70m20b4ltU8ruZnEXSpFIBQAZcw/4i+qqOdqKOuGkIsX1V/nbtiVap9H
         vLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511845; x=1786116645;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNunTRXsqpTsk4gUldkupbFQmBRLlsHQmR+eXlL+D8U=;
        b=saAt/lve5pj8qPMTQgZm5mB55daE1Goo8KYdmVYX6IJVcKzmj2DTkhbUYgu/Ka7A7s
         t6rYEWWDlwkhB0pvSsYk2PhVCLnjqd7V6cZTB6c5Dnhy5ED0JcT23Bl5GjxK4XcM+mOQ
         /NK5CzX8oPL14yRQ5YDSwhlPxG57v27ARg5iJM7wSDU9LfPqZrs3tVkj/XpBQSOuiAzW
         h6rRI0mCAg/A8c4S5pG6GSxPnTsDJkAtg5u5xrnC4UqVN8PENNqgDJPfA8eognMP1K5O
         MgJzhC6c6zVBuO+1NZvOKj2V4w8T6jwv4rRkH2JX+H92tDvanMZJVX0ovwGbCVtUe5/8
         461A==
X-Forwarded-Encrypted: i=1; AHgh+RrGCAHPwhMadZujj5iwAX44amG2x2/qd6d6kWIg3t75zT/w04ODoqLbu6WfeVlmM+QTAdD+zpVwIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vJ1i+9M0W2TTy3LyCR2qIRHaswj//khHwzhj+pHYHJezrYoo
	EK470mt/As0q8cbiDI+jdysxXpYBJHC6k8AT06LOCU34msOLMF1coDt8rJK031cCLXIoDLP5b4s
	9wKU0qiApkIYF36i8SbubwwkmKlCO1hni65FJHSZmecK7AYImdbdjzUe3GyJmGg==
X-Gm-Gg: AR+sD11BQgurJbxjPKkBIvZViKLnqi2FI9ip2LnqiMScjFnW5sVCEc7Le6DdKH596jy
	QkXiQtzbGdDZVzteimNbAi83EKgu0mb3nYFf2KgsJl8Tokvpd/nwAs3i7gXv3QL4qyZmdO3TKYW
	dKykzFPmZ9i5hn6xdTJIcJ5CwB3KojDGXpIcy7ZlvDyRMcOlAKVYxm7jTycFXeDYbNQrbNjWVxd
	6Uw6V9ojuyPquZcaKSJ4ANVZ/KPKG752W0FjxhyJ2g9tB4PIKf177qc7QcwrtP2CBhKIlimrUEj
	zMpzd/d2VzDTOovWqeyn/CwQ/+XdzyWYCVb4ff9le1+NtStmZOR+mSWlo3j2u71X1Hh6R6/6oCN
	uqNef4dlnipkaYvTFrJUSEearoWtn6EYg
X-Received: by 2002:a05:6a20:9f09:b0:3bf:8de9:c647 with SMTP id adf61e73a8af0-3c92a2a9efemr292248637.0.1785511844957;
        Fri, 31 Jul 2026 08:30:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f09:b0:3bf:8de9:c647 with SMTP id adf61e73a8af0-3c92a2a9efemr292197637.0.1785511844540;
        Fri, 31 Jul 2026 08:30:44 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963daa7sm716655a12.5.2026.07.31.08.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:30:44 -0700 (PDT)
Message-ID: <acb2dfcd-f024-4a70-88dc-8d2482c1e20f@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 21:00:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: qcs6490-rb3gen2: label BT PMU
 and M.2 PCI node
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNyBTYWx0ZWRfXy46vYIO69cy+
 H03x4JfgpHH4uxPH64n+NLQPw03i9USwloxj5HDMgZHfg9rBWAEOJdhhSEXC0EYiGC9MJYare5M
 kWqo0NT/Fi0+5RXOHe4MPEtErBSITPo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNyBTYWx0ZWRfXz6bFQVQHb7n1
 kea2iXSjW5n5d6eIxxgcO+od3dZSG8CtWukjmbsReO7lRGQiJbbwmd+J9PYvKfh+1fekHwe4R7Z
 OWKTcL8SZ8jQAfP7NyQnUF8OIiU6yVS2K800IxFoW86pt/sgIQN3nm24KDpAcmHCqa90PtL880U
 BZNy0EPkbEwu+GyxThxzewUTr5Znr8Yk6PKMhsDf5rxZZ5FlRTgFE9/a8jydyjH90AQQwMbav8g
 AralHfZabEvNJySGh1SN7ypUjzOBAlHt6b4Zd+Azs/92FzZe1cF0du52sx+RWXs9u5Wwo7xQU8k
 oHhCd+PVvXgD1GnchTtd8JZLv84b6CDqVNCtX6cXbr8Q6cq6lfBEVIHUeufVbF/Od2TZWgpgeNt
 5PljFTShqJlBdHZAYc1zgCPu3NZwg9bPp3m40DuhxMDtZF30QPB/6tfT4iFYr5QvMjiS0BrhSr9
 YEDTkcrfR4qzOZKAOqg==
X-Proofpoint-GUID: vXWwWMoGpQ_n_-W3avFH_kq01Ae8qE8d
X-Authority-Analysis: v=2.4 cv=BpOtB4X5 c=1 sm=1 tr=0 ts=6a6cbfa5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=B7p1tibXOPgUgj-QF2sA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: vXWwWMoGpQ_n_-W3avFH_kq01Ae8qE8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310117



On 27-07-2026 21:15, Rahul Samana wrote:
> The reworked RB3 Gen 2 Industrial BT UART overlay needs to disable the
> on-board WCN6750 PMU and add a graph endpoint to the M.2 PCI node.
> 
> Label the exact WCN6750 PMU node and PCI child node connected to the M.2
> E-key slot so the overlay can patch them directly instead of using a full
> path or reconstructing the nested PCI hierarchy.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 37a3b51323ce..b2b6fd29880f 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -325,7 +325,7 @@ vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
>  		regulator-enable-ramp-delay = <10000>;
>  	};
>  
> -	wcn6750-pmu {
> +	wcn6750_pmu: wcn6750-pmu {
>  		compatible = "qcom,wcn6750-pmu";
>  		pinctrl-0 = <&bt_en>;
>  		pinctrl-names = "default";
> @@ -901,7 +901,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
>  			bus-range = <0x3 0xff>;
>  		};
>  
> -		pcie@2,0 {
> +		pcie0_m2_e: pcie@2,0 {
>  			reg = <0x21000 0x0 0x0 0x0 0x0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> 

One correction for this patch:

After re-checking the composed devicetree and the device enumeration, the
QCC2072-facing PCIe path is behind the Industrial mezzanine PCIe0 switch:

    /soc@0/pcie@1c00000/pcie@0/pcie@0,0/pcie@2,0

The pcie@2,0 node labelled in qcs6490-rb3gen2.dts by this patch is under
the base RB3 PCIe1 topology, so it is not the right endpoint for the BT UART
variant.

I will fix this in v3 once the endpoint modelling approach is clarified.

Regards,
Rahul
