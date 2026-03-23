Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94D35F17D
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256571; cv=none; b=sZjm/y9GVNPMr0BJuNOcE215u4Dye4iYAdldojZR8qjvrTPFslYSgFJ19vX5h9kFlnzrcWlZiNcwwiWKMYkAJ7XE4PAradiUJ4i+pzHtp6/nNzafuq9oTOHvOuMl11o7qBIaTy1zt06JVYR/qjGp252+6PgxNRRlsa6oZe6XCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256571; c=relaxed/simple;
	bh=1YEYqDf1LB1KMCb1UKjOEBsNJ1K2jABt3RfVRVuTbdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmDUoDSUY8uP9G2qR1t4SmdBzmuKP+UQ4jDMpJlHNe/ZB5DuCpRjawFMo7ArXmqYmIhroWGQmGM8+8IIkd3unmkOX9K3zoTer4cbpW0QDtBP0hYhsLT0ayY9RjtB6cZTTrvjuvI8S+niuF3r2TFEFvETrtPfMrEWcByPpNuGixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cWeiwXAC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BAwVVeFC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cWeiwXAC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BAwVVeFC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N61OLK934023
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 09:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eAeKaUPxN4hdmfgJf2X5L1nebaVTTWL1hb6JyibW76k=; b=cWeiwXACJWm3/cJa
	cH3GVXDtA00MLQLRFu8yw6y1IJb9z+opemAaWOclNihMmm9rU1GVP7gHwrtJYeTj
	u0mbpyPVRU7KO8u/6imZexx4TT8/QE1FrLi/NdfkgKC1XKKeKNqiRtpKwPQZI3qy
	jZKZv/qSosKQ+sfeLquviFj50bQI6M6KBA8yAX+/srhjk3WR7KgiSm5VcSosPilj
	Kif4j8BMoBr7zJyoOMIRrid1w51SDYKzxXjRfuYrryb39kVwJtQ1avLyqjsDlWzu
	Xlti97oZpAs53/Od5fv3e4yS3ZpuZSM4qQKTfY1T7JkqJSwlfCPNdSFkEvPbCThK
	9PmneQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kducjsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 09:02:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adef9d486bso11167465ad.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774256568; x=1774861368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAeKaUPxN4hdmfgJf2X5L1nebaVTTWL1hb6JyibW76k=;
        b=BAwVVeFCD/VFoupxkljkq5OduRN4wGRl/jGAZiucdaKeywo8EpcbCSOKCNW0hWyWor
         87sT7mw60OXQfCxyGVa17u+0NJsxtg1tQBKdbfAQJ66Pz2pAaSCZ4oVsPwLU/BTfLy0c
         O+rneckiDzOaPzYC+y+tJqQCZTkLbbapOmnOpPHoAKg0ykNKh8gCXusX7H+VYbLl5y3O
         9M3Ye+EW1mR70PCcLF5O2GbL7LBwwVkV1IQjlg6tLc3WqatgDxhMTeibhgRWk+Rp7t3d
         6dH2mEMRG0oCQpl+bZM1rASy5lBRlK6WLsUNBuyGL/ILdNrON6Q7AoYMNcF1URkY2yuH
         BwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774256568; x=1774861368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAeKaUPxN4hdmfgJf2X5L1nebaVTTWL1hb6JyibW76k=;
        b=ZSt/zoIA8KlsoKvRxWWzMblj6BMyOoLCug4KcEgvUJdxFWFcLaOD6p9yiZLCAKIUnu
         1txZKqawMz16oOAWEouPYOm5bzS/oVVjmMTbp0dKKtzPF6G6OBrAYUlZfUrK6nIttFM5
         +/75gS3/eAsOMbVun6stxyuWSJsysj1jxukHaijB+kjIpiQ4OnR4QhpYkZuxP4xhQrgY
         OZGbt2vclIxfDT3PEnFv8jX2lY4jlm8UsiLLz/kkcSFOz5EI6Mr21t4TIKgPppxKLx91
         sAy7mA+oSxKbq9S+DJ69AB77/2UbWQYVX0kM4clOOHTJRtatJYH/PuM48f+zyXgw6LVK
         LwWA==
X-Gm-Message-State: AOJu0YxQakg0apcAiPYEe8rIKiIf9eZ+5xsTcFqcaS9tPnzERRwjgqdb
	QiLW/HyyYoMPpNZEHHLLAPeYjNoZ971O37DWkTSrkMnKCYJRniGiAshNx/wRWpmNy+AWaKg7sGf
	nM33ugitXEThtgo2lrj2UUs50yubi9iFw4y9dzCN+HJcH1SqBkpGZ4gcT0V4Phg==
X-Gm-Gg: ATEYQzxzirQVA9xAEWTvTTD8/I7h8dGsd1G5z6fMBY3eoWwoXCFELsJ4tGv7dF9vcpT
	H4S3zGX5eBJlg5JSMyMcUVCIjSRaA5ObHw5bsO5X5lTIPX9noONk5V3FLKUAmGNNQ0URxCzI15d
	O+3yQRf6nkCcKRCbRQH18butYFOoD+OvugQ+4hBgQ4WrrP/689dzXeB2Qfbtbg28maEttrj5UR0
	Z4wPVc9LAJTf9tz4W1LGicR+jNkfIRMBMaqxJWfCEv2G2hDQyG88/x2mQ3xVhZDZzBI82nJJHJ0
	EYAHpfCTWjnaMA+uu/2i6WU1HqmUM6BuiRLwcaYx+ztp+BtbpNTieNyBcRkrSxr4PWysw0PZdCB
	V8Rg3tIxSaz4AQh9YoeV2hAkQeWh4XtrkcRJdGhkVkYMi7WYZWGc=
X-Received: by 2002:a17:902:d4d2:b0:2b0:6a3d:36e9 with SMTP id d9443c01a7336-2b0827a93ffmr105389385ad.33.1774256568372;
        Mon, 23 Mar 2026 02:02:48 -0700 (PDT)
X-Received: by 2002:a17:902:d4d2:b0:2b0:6a3d:36e9 with SMTP id d9443c01a7336-2b0827a93ffmr105388825ad.33.1774256567730;
        Mon, 23 Mar 2026 02:02:47 -0700 (PDT)
Received: from [10.218.12.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835298acsm106071805ad.22.2026.03.23.02.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 02:02:47 -0700 (PDT)
Message-ID: <b7b19386-510e-4892-84db-09a20bca635f@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 14:32:39 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750: Enable TSENS and thermal
 zones
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aastha.pandey@oss.qualcomm.com, dipa.mantre@oss.qualcomm.com,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <20260313-sm8750_tsens-v1-0-250fcc3794a2@oss.qualcomm.com>
 <20260313-sm8750_tsens-v1-2-250fcc3794a2@oss.qualcomm.com>
 <c4376a88-a490-4b58-bff3-b0f4d2f731b7@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <c4376a88-a490-4b58-bff3-b0f4d2f731b7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA2OSBTYWx0ZWRfX+FZNFQNq5VDc
 bUl63x1On+fcTGQM8378YZhiqjQqG7w7hlxslVm4SdoD6Qxo9BQVSzYx6Y37T34smxjXzuFbUNr
 jGRvpdVMTXi/dMNosjz9DOObw1sWSRgM/Z/pwilVUqtSXl5bmf3Nog1oBD5wDb0V6mDI4yUf1fx
 FA+q9aJh8Jeu8YuGB4Oy1wO5+FVsOPqI89Or5zxkTAeIn3epIPDbESvRDB2GwJf2EnyxxS3uxz1
 8q2FrnwS3Lvst+qDVhvxlp59gQHHAahGjb+fyBRBJ2G3KsTKXxJ9cuCspXkljI3p4PdC/hx2qP1
 mXW3C+3FEDvkR1LnR74Fl3c2J36d/xlE1HJcg1FH3bN4dmsEegA3Jm+R3bSSbQQYkeo/vGD+6bR
 U6PrIX2KG+Z5/cdQag0GESiOO1QYNrFm38s/mtXSBO50+rYHYLijXEWMRwNopNAtszK3mTk/N65
 h/Lxg/TfdxTBqS8od1A==
X-Proofpoint-ORIG-GUID: x46KhDXqTn5vXLF_K8Gv8kCbhSRaNmHK
X-Authority-Analysis: v=2.4 cv=Q4DfIo2a c=1 sm=1 tr=0 ts=69c101b9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=RYkhNht3YKPCQp1dbvQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: x46KhDXqTn5vXLF_K8Gv8kCbhSRaNmHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230069



On 3/18/2026 3:14 PM, Konrad Dybcio wrote:
> On 3/13/26 11:34 AM, Gaurav Kohli wrote:
>> From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>>
>> The sm8750 includes four TSENS instances, with a total of 47 thermal
>> sensors distributed across various locations on the SoC.
>>
>> The TSENS max/reset threshold is configured to 130°C in the hardware.
>> Enable all TSENS instances, and define the thermal zones with a hot trip
>> at 120°C and critical trip at 125°C.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +		cpu-0-0-0-thermal {
>> +			thermal-sensors = <&tsens0 1>;
>> +
>> +			trips {
>> +				trip-point0 {
>> +					temperature = <120000>;
>> +					hysteresis = <5000>;
>> +					type = "hot";
>> +				};
> 
> Are we going to use these trip points for the CPUs? If not, let's only
> keep the critical ones (again, for CPUs specifically since they get
> externally throttled)

thanks Konrad, for review.
We are not using this trip points for CPUs, For Kaanapali, Dmitry 
suggested to add more warning for CPUs also, if in case some user want 
to use it. So we have added for this soc also.

https://lore.kernel.org/all/vjx3bd75zdgdh6hzhrmlv5tlarnf6ea3yklwhg7jx6momknase@kstxwngyicd3/

> 
> Konrad

