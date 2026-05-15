Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5683E9C2E
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836801; cv=none; b=hoBbsj25C+jakKF7nmjDk+OSq9XJlIXWZk4qb6M4+kvE9PV7JH5k/kVTpTZV1DsukgrrUlkj2WshSOp7O8XmgpI2IZJ6rRoyX7QTOd0w6FVARUOJBcE5oBQr8j/DyXufccpzvrQxkM+Chf0hi4REz/v0/TOPKK1A0m8ju2TiXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836801; c=relaxed/simple;
	bh=RCnxFa+yI5Y9Xy4053kfK+km7U3a/gFtswsMRuExpyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf8O+puCjZbWibPgj8GG/IJySxt+0plTRzKRXzKoIzcK53MtLNOO1vWgmQV57UcVT8Z4OomzQZeJmTtO9hQb+lB9GwCKeQjXaRDvohbz+JsblqhHmjXC/2E6Q3u0ebrD9chrUvCQpWjNjim5jLsRkHVnDfm3ZbMy6I1X5QcPofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZAND3AW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RbaMssZj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZAND3AW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RbaMssZj"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5CEXL1848101
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GuWR6ejKO60MeLWfVVXF1au0lbdF5Zpf1WZXUVNB2FA=; b=NZAND3AWTQ096osm
	qGmaAQmSJq/9kjCw3HDKjc5laOZsbeOdIbvrAo+YMxpO85bqSJ2/bzXHw0DpxtRa
	ukXqut+TATrwgwKxMzjVE8Fx8MFI4NhBZVksV/iHPBYeGsl4FGn2MctWNWXGUv6/
	5YrOKYy6B7jdXKw4C05Hw+zWQ+xwtRi+9sNQuFjF98pM/RCyGLfq03HGT2Q+kXPp
	ro4HSFfWkHVW9o8sb471XMHrOpkOp8shez+QNInD1j4Jh2EnLxCoJB0MibODp3Rj
	3Y0YqCjMXrXUSf8fcFt7+KoHV5qPV4EW1HU4hV8+A+RetMwsBbdD8BDRgaUMW6Wt
	/3Ytyg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1t2j2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:19:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-514b5cc5cd2so13671291cf.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778836799; x=1779441599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuWR6ejKO60MeLWfVVXF1au0lbdF5Zpf1WZXUVNB2FA=;
        b=RbaMssZjURwH1w45i4k5u0LrTVWXbpC7ZknW1vQXh+g+kfmW8l5Bb12DOHD/ANSf7b
         m0DScaJmQg/1DwVIKUJT+9kS0IgblwyE7zAHoIQICOEnNuoxuXCNAwfqiz+dqTAKk2Am
         tiQ9urboFU9Y7Y/0ULzDQPWgHLQVhmyQ3iZqxdZ8SI0SAFMAaxUmvKc7cBF5dbm3yq/k
         6Yf8mE//FrfCNifSoX+Yz3PXb5o36PHnpShYD+2R+x2lBW30KIskEX3ucc0iGbaV+DhR
         +gSFfPlljfRc3rcv4o1gEpTNR6htzQ01FnyWME47GetgK3afa4+xu2wQtwZfLA0ySjz+
         Nv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778836799; x=1779441599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuWR6ejKO60MeLWfVVXF1au0lbdF5Zpf1WZXUVNB2FA=;
        b=dF9wy8PID+iEzjqjf4V+YPtndIyGpN/XxXOktSlKvC3SK6bpCemKVEO4tFk8fYH8mC
         fHQOg1fr03TqhXjuF96L8viWYQR9W7Ez6zYxzJmt4j10uQNFsJ2N2MvK0jBd/vFRxheI
         w6Yh3wsuv4hgbOYmKaFVqMNuqIif2jjUiaW+6k0f/OB7CahCXAJkba1mE4J8WgmAQz+J
         C8Y9AQgSenQK7zBtMQJCZVZRso5tuRJxpRbW0umtiG3nBFE2bWgr1fEPUvfAS8L7y/O3
         Y1t4+mljPZU7hF/kqidqO0ULJEIXazN7vRnXt0O/93HXsqL/5bsE5dH6gm4kZi9B43V2
         V1/g==
X-Forwarded-Encrypted: i=1; AFNElJ+ajHXGPrE4hsencBwaqCqV7nQquJCJPnLRhSiOIUtnIulymIVD6ROf7WbYM97plHnfFLxTbmA28g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFS7LsE4unDdsAt+gvsJxmom4uZcBkssCVNRZjudpEYluHyCUz
	GOwjbhrC+UD09MOJihrgY6dxD1bCyDOficx/G1cO02tyEgSTArmLrUdfLlSZYnfn5xI//wJ6muz
	udy3b7HnwiPrHtrnU6fVK3EX3Ax4cB7P1JEY9iAHgAuv7Sh4I9cOZYvQOjzdhOA==
X-Gm-Gg: Acq92OE8Jck4vnaoLgSJ/Df1thhjednxNcfb9dteeQzSwN4zJNxiZQeb/XP92yqXGJl
	psFJnKP+hRnQIBdvi5TnRGJzM9go5bv3e0uNE18UI/esBSm3IS54uiFDfn75DDEoNQaLiyWnHUO
	+SlQfFOOZJnTV3Vuj8W3FbwbBEy12MIIrTPZ58fMYzOwrisu8b44+SWryu49YeYZwzi4Dw8Cs5F
	lMhhl9/JUe0zE7Mnu1yLJBlpsKfvKojSDUx/6NxMfgCK/SfA50YeJF45EGRxXQiPpliuizybLpk
	a7TUsdfGruj0MInXLVSWv5oZjyF7LuqyNmrLa9U7FGBPteAAAbN7/NEixQ4eFPavCjz2eQD09a0
	k++X4GoRLigmSiNeLbw2njXX2rUF7twBXGo63WeoJ91OT1vhVPL1Ye1ab7NpV0YmxggFXsXWxY/
	C8K8c=
X-Received: by 2002:a05:622a:594:b0:50e:6311:7380 with SMTP id d75a77b69052e-5165a229508mr30234401cf.6.1778836798659;
        Fri, 15 May 2026 02:19:58 -0700 (PDT)
X-Received: by 2002:a05:622a:594:b0:50e:6311:7380 with SMTP id d75a77b69052e-5165a229508mr30234191cf.6.1778836798206;
        Fri, 15 May 2026 02:19:58 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b3e800sm1842166a12.6.2026.05.15.02.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:19:56 -0700 (PDT)
Message-ID: <c898b619-676e-4385-a69f-cd1e6dc2f9bf@oss.qualcomm.com>
Date: Fri, 15 May 2026 11:19:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: qcom: Add cpufreq scaling support for
 Qualcomm Shikra SoC
To: Imran Shaik <imran.shaik@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com>
 <20260501-shikra-cpufreq-scaling-v1-2-c78b95f53b91@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260501-shikra-cpufreq-scaling-v1-2-c78b95f53b91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D7Z37PRj c=1 sm=1 tr=0 ts=6a06e53f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=4ielwApaMtWjWprE9YYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA5MyBTYWx0ZWRfX1xaRppoTcOy1
 uLsz8zakvijZ3TQgFrLOGiLNqM5ISDp9rRBdGfpdytfdSuNCFeulV20Vf2SUdVBQw4kW/gw7vaw
 yKpBF3I9h6kv5rrKhbl/Zkz3Ef2qAaxXvA7nMK0lO+/Pyi2jHReheuCk8FKP8fREIAdnGQrogwP
 UzvlGT95gS58SYh77cP1GcQXLYQhXmEAkcRvMW2dUhlvsDtag0oMuf0aXp9zxxlhLI7Ck2NMUgN
 RWIlrbcEUFlD0xgQjzXlk9kxiKhL/t2yiG58s1qWPoPir+yqighUOYRnuBG0SS6Pg2wNasRaFCG
 F5B3TXp/oOD2XabSOG94dH8o/bRc70DlEBlCrBIxH5W2Mc38Y+BRgoM8TOisjuP56JS2QI/0K+X
 5+rLaoRPNrguxRAA2jCWsLX9M5+OV1dfvvzSSa33SfKC+ynqynL3qNLUwRVpgyw1v+vl6wgcpRk
 NM2ZwKf+uGzXpRp235w==
X-Proofpoint-ORIG-GUID: Df9agk1FWDk_r7tdTVVMjyG1fVvMl9dY
X-Proofpoint-GUID: Df9agk1FWDk_r7tdTVVMjyG1fVvMl9dY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150093

On 5/1/26 9:15 AM, Imran Shaik wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
> but supports only up to 12 frequency lookup table (LUT) entries. Hence,
> add epss_lite_soc_data that reuses EPSS configuration with the appropriate
> LUT entries limit.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
