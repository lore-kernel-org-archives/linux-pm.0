Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B564E386C0F
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362353; cv=none; b=bgZ2vk5+T9WAT6mLrobAFunvtO9Zo8207zeAvsV4QNOBs3W/KgfDmw6HNAT/exKzGJocyyPS8pFDaUVfCxbOI+94K2oqz9LaHXE0cqG2AJjo/7QeFV4sUWa4djXzrsJvCs71zemyhCs6arSk6cxjHnXvvPDwG9sr2VCi/DojiKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362353; c=relaxed/simple;
	bh=Va1tsaXau3ZOp4Fs1C6XDkNnNoOcNPKFH6zod0IfVuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLZLhcm2a6AiHdtjdaLbhCo3lTwoJeyHaPVvoffeXQ/gf3vK6+NM2Whd5iknuuCJOSMSBha0smneZecOidfOU4wpzMDP7J1cHQNBow5oXtQvU+lhSaAubvPokajbBoNc2RwqBps9D/ljrhhivThKmPglLsyBtXyuu0DgH3Ae89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4GNa20f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T4HOYb+v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4GNa20f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T4HOYb+v"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99vP33772941
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7zTCbgzBEgy2rmz8Lm0pdUFHaG13OEbYSNtkZTbeHg=; b=H4GNa20fpZA3wcMy
	LobHT60IIU6ZNxgcEiPCX73buSLKX1O0Tx+ZduVLSb93fUh7qnO1NMQ3rbETM5aC
	ydoJA+9cLksq/me5mLfcJmLVV1IPx8pFdZsqDqML0D9pVsVQjk0lCVN+U4yO9R4u
	+aILbPfAfy5HrabDCnbPh3qR2j3U8/48x/F0SqqP2sXhzZZatgEqRyN3w1E9KdmY
	kaMzgai5M9NRRiMTSvKyvfn1HHwEexTKPZBo+4TpiY1Nib4aZv5tv8uplBW7nfml
	u59E/KyMAy2uErqx8IbHkkrRPTeCUV3L30kuB+5roxzrlg800GXh/RrTbeXVdtkZ
	4cT/SQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma42x4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:19:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50faec938fcso15277031cf.3
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779362350; x=1779967150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7zTCbgzBEgy2rmz8Lm0pdUFHaG13OEbYSNtkZTbeHg=;
        b=T4HOYb+v9yAfXR87qfMfX7Ra5/Epgmk25br5GGbtrNqRobeW19ScKksOw1flh/uRD/
         AZDs4xKIBhyiyg4SBI+9wkrEY/vX8l3KXeGa91UIeNaSKGaK6l6oPRsuecIgUdP/hOhP
         /xkEBqUU90xJFc7zAu8dW4IV1Y0ALtQEw7NwX/Pw7PzGVDlLcjyevo5CrRdU57msI9WP
         wRbXiJKFkoPtW8JwaoAJdx4VebEY4VWKJeG+WHzXzDrZqksDXIZ8npauT3rg3epEMGMZ
         dYAUMunfS7W/3rqL+caOPPJt7YjkpdNADFLqmEUlM9RVIs51+gG9y4LFcSRSCwfOmlsS
         rjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779362350; x=1779967150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7zTCbgzBEgy2rmz8Lm0pdUFHaG13OEbYSNtkZTbeHg=;
        b=aV/cSC+yeWPaqEyu/MeE0M4yTHj/d/TCJqUIHvFB0h+hy3iETh27GfElIcr/tmXNXl
         chlQ2H4M/Y2yAGrOuo8GHVsn6OdHwAZSkO+knYzZ7v4WtaCsTvkbVFhUrf5G+4LrRopg
         C31J6iKmYcgwbXDLgi7XjXAUWJK3wQJoEM7i9q6EneE2+neg92tz+rOpYd9P+ovFUJcI
         Re8dNJhf79kcOpPvsopO83nXMm5k0GriHo5G2iP+T/Rtms9suHM2mLEyARYCTZBJqCpE
         h6K//6W7mGWsZ987fRR0ysOdup9e/Q63ey9dM8gkCr+2azDxS2bC4X6Pa9Y/u3Wnh4DU
         gryg==
X-Forwarded-Encrypted: i=1; AFNElJ9oa5mA/ywzAF9qujummPPpqe0W/A2wrlqErG0HY75svh1Fm4/a05v0msFWl3OmQZ9VMNblheI9kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzogdisdNGV1ZLo9NXKGvltXhkHxkfzitu1lj4N+AmcAop/khb/
	Gz2usJECTMAUZGvYdFGe2kxR1sNDtlzJoSvP+4XfGbWXioLFrtp3dD7IrmfLOqd8z3t0qXJhIVf
	bP3kuUrd4bY3dNt3zo2BaTDzLJRlbtYtJ1eWW63w+28vM5Iguc7tur494WMM+Zw==
X-Gm-Gg: Acq92OHmjHNX6kLRPWDMV8z2VmJYz9knlinTpVfqSEo4JSXXRg45ic6MJQLm1k21hUc
	nvXk0WtJhOCWNoqQR+4mNSPD+ju8SX/nlDPhpDeaBPO44eGfmTUkmGKHGUn+LjFKqYKnhpfr8NS
	7DYJMpnH53wo8W3B8xRTYC4HGtgGwLn/zYhMHHjXjlT49SfbzALd0nE+FVrXyOD6470zsyO2kwl
	OzxVQwHr+Gl77S4XXEhExhy5rZdUl9frPkFwrRHPvHpUM0w0E3KKB10P2nzPlVJ2lInPp2iK4An
	zxnzSxVxuNQu/QmxFpikHtT21xqjwYgtmFfJ9lMNfQNXGlE83s+qQletErjOceNPjEcsFNmwz7U
	9+DGlozm7mwOd90i/49k83McncTDPu+vBDseyBoszX99mRMdchygfJWA888fqv2ha6Kz2BKvkBv
	UdAs0=
X-Received: by 2002:a05:622a:4113:b0:509:e68:22cb with SMTP id d75a77b69052e-516c5646459mr21000051cf.5.1779362350232;
        Thu, 21 May 2026 04:19:10 -0700 (PDT)
X-Received: by 2002:a05:622a:4113:b0:509:e68:22cb with SMTP id d75a77b69052e-516c5646459mr20999661cf.5.1779362349730;
        Thu, 21 May 2026 04:19:09 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a410c87sm32062966b.30.2026.05.21.04.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 04:19:08 -0700 (PDT)
Message-ID: <69ad1327-8ef2-41c3-b07f-61d00e862904@oss.qualcomm.com>
Date: Thu, 21 May 2026 13:19:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powercap: qcom: Add SPEL powercap driver
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
 <20260519-qcom_spel_driver_upstream-v1-2-75356d1b7f94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260519-qcom_spel_driver_upstream-v1-2-75356d1b7f94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0eea2f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=fLRa9Tv8D7x8Vr91H4gA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: kNZtVApw6hn-glu2K_UWZUWFC2wtZKDB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDExMiBTYWx0ZWRfX3c0EEnzoiBLe
 aEgpB2UpSGES3+tXnxK+PhQXBxSnvNyb73O48n40Y9EOaEBbXcNHIxxeY8MMKa2Fiy1C7wc8iK6
 UgLn7WKiRklm5o+W40TWiRs0B6XCCphCvB54xxFv1w1ud6SsiI0zRFLPXE91edTLRX/4y/vOu1x
 vtjveFg8QjKBL1ajj86nErpP6188zohtgVsQafxR7lHHY5w1gQwamSpZ3z0jfpYATJ8dLMgjMK5
 qH1CMmHQYhjP6P3EHsyahAEMjzyjI9LOwZpRqnU8pAXqpeyhrUIFLwRnzakZchZbFDyLYlwwdJv
 OBazvTMnbgloYQ+wVEwtUan+FVSSbWgRKcbp1UQhABa5BhlmdYOUbbQgjELJjfDkYwLSKiER7+y
 WRdIOoYJTeKRN9N4SBYaPUcDSLymecoZr6EKLfDx+Kg1HXskVLUSfh9UvbmNAuHary5K54hbTs3
 VkRQ0K6bPB3BJW2+b3g==
X-Proofpoint-ORIG-GUID: kNZtVApw6hn-glu2K_UWZUWFC2wtZKDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210112

On 5/19/26 12:49 PM, Manaf Meethalavalappu Pallikunhi wrote:
> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
> based power monitoring and limiting capabilities for various power
> domains including System, SoC, CPU clusters, GPU, and various other
> subsystems.
> 
> The driver integrates with the Linux powercap framework, exposing SPEL
> capabilities through powercap sysfs interfaces.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> ---

[...]

> +static const char *const spel_domain_names[] = {
> +	"sys", "soc", "cl0", "cl1", "cl2", "igpu", "dgpu", "nsp",
> +	"mmcx", "infra", "dram", "mdm", "wlan", "usb1", "usb2", "usb3",
> +};

If the domain data is not going to change for future platforms (but
e.g. only the offsets will), which I doubt, please use designated
initializers

Otherwise, please coalesce the names and offsets in a struct

Konrad
