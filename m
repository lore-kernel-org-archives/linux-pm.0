Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BC25B095
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284695; cv=none; b=UNtcuswtinVunEVicPtI1OPRSSv9LP9bEMQyRVOqcKYQWPNDe5SJLWZ8iPgZv9f5jlASgPC0dcMmiafSaN8rEe51AodAPKGchiBTdFzXZ8jSvjCTPKhAl5XKE8DxMEgz+P3duGKdtKOfkkPSP5OX35UMspdAy3enuybKJXTxkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284695; c=relaxed/simple;
	bh=J6rFtg0+bXCN1aC4RFHbN3goPX170czVFyH9zgtlswE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LA40V7G/mUIhk6Q29nSnKCvRs4mD5/3HTfjlQqmfvWfGIV9PrjFWjufazOj5BGRZM+zLp0wV9D9YVGiJBOu173joXcP2EemGb4VUoR31DF96mAE2dHOEjYu2Db2Jmat3iZHr/QOiwuwxqPilA0jsgKkO3GNrt8Kzsy4dAGC/60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GBxg6XlT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iZUYs2VE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBxg6XlT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iZUYs2VE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VMtZZL2294712
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 03:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dY/4w1en2mj6+bG8nkDP5PXPv1+H8W7nlBS2tcRhn3E=; b=GBxg6XlT4FhquoNe
	GHpbpQQ/P83ld2Yta0ndEBWyJm9WWK3zVqVXfBDjKWrBWoilKfpu8BNev1ntXGIk
	X3v9/wjEbq/yvB3zjLARlpN/PHieyeLFoy94aobgG4qiVlm6IaP8lsnEfHKU+Dbg
	STd4CyE+PYRI53ynfstuJZtnVn1L1MSHBjnEpu3A7DNb1DXcMJKYbKSuJfE+gg7O
	tQ+L9wCLXYGEjXX1PLutH/XSpL+k96nydwMcKdFO07OH+cvvQL5Piv5hQnYyATdA
	w8bKX7QxULsAwM03nueC2arUPl3akLfnEro/1yQpWwi89zh+xcLU1rjebuHKtIa9
	oLhD4Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqfxwg9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 03:31:33 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8424aac207eso539870b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 20:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780284692; x=1780889492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dY/4w1en2mj6+bG8nkDP5PXPv1+H8W7nlBS2tcRhn3E=;
        b=iZUYs2VEn3aLNWuzRTxfeoszpLLmMhozs+I1hPt0zeuI+5evLiSMdxwwZBelSR8qg0
         SnE2QK2XpnDPV/axfYIfkfk/TJ22dY7bjad7fA+1YM08InJ2uYtVvhF6yK2rp6244j4a
         1A2zJpLXCImSrn3CBxED+Alx7J2Yl9QdsKQLMGDDowUfsPRjJP4+OpsCDo9GhAZEnndY
         pMj8H4dKfQB6XeOpnZgfQL10/5XOToxXLARw0Rt/W0ZUzoR+el3sARSK1yEQ0P1dmo2I
         EE/oGabRwA6Dxj3dtsTkqJ+MdxgODFnztASA9ZE0y4SOV3KA7i4G6Ee4F4M4a54aeo5P
         NqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780284692; x=1780889492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dY/4w1en2mj6+bG8nkDP5PXPv1+H8W7nlBS2tcRhn3E=;
        b=GnfFoxmxdyDRBaZWkw0mlYBTY5peDmTQNBoD3oYAoFfaoGrTL/GfJmiPX/WHOEl0sR
         9qp007gbwbhFR+BXgUPkquAWE0KTA7mhDw+qAGqtu/9YGCmRYmdYsLzkkqmbwRTLCFJV
         hC/ZxxVkDSMDNdYzpu6Dc4E+2i7Lpla6HhFrOrZHDD8ax9cHJS0UdU++hwkD0KakEwDT
         p5xzTBg5j/0dQet+T+5Dahr4KBCpjCB8tJEGvXrDIFHdQKrcmo3MVcll2cr7hCPYhe+i
         sDyfIWFsr10YDr4CeVO/GhXqRfsBjP7tq9xz6pmA3r4qnm/+ZiWCW2XlMxNpmq3OTxkI
         IWxg==
X-Forwarded-Encrypted: i=1; AFNElJ9YWIuHbVAFJLm1MkZfAAG29aXrYikYs9Abq9uzoI4XOcuzwLbaYGoDzz+oI0rgst9r8rquFJDS/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKH/u/Vs6UNm6yoj1D+YFcDteZD4iOlDMuBLx2p5Of5GS5Pe/
	fDEwQl1Tuj5ADlaYP6n66VuHC33H9NKcSKgDB5/jxZZr5PzqUHARVy91hOZXLfAEht/37wLHadx
	6pNebeXi1W1BL2VGKg+8TdxppB7ZUxyzMs7Ujn2GD1Wj5xokSTdiftK1ZHhBy0w==
X-Gm-Gg: Acq92OEdq94usITEd1Zro5XlVwx9Z5FHfd/An4yhu6PNjAsE0m0u05gnbiEaS4Yc6Pp
	+zmRBp0WqNHj/3nreYkvlIg09wydVJjyQCO4AsRE3w2rG0VVU2IwqDAb0JRdOM6WRwQ2U7IPmyy
	3qpbTvjxPuLaYCAZZCW6dxCyIPuys9bHEdB1m2CeAl8Vi9NEubQ+Aaz5Bt9HMzHeRYjb4pBn9bJ
	fYuXSZb8UDR31cvbW/ml9iGfLjyrcyWDtwdiqmtueoUwjsPYcK93XSJjTP/IkFZuXNKcWLe6RWV
	QQGp57kjLABRBQ2nVfmM8+/rjAKB5YvUQTVEsuBmJGoQjKQwUrOPJaoRys1ONylFfpcU8W8T0Vx
	znJdf+/PivkTYy51J3PvAbrrVTyblwKIFbgjEprgKjOKj39NQ2gPbVpstLuqD2bUDxJJhlvLA3P
	ZluG30vsedy0qXeOeVzoifDsV2xQI=
X-Received: by 2002:a05:6a00:3903:b0:842:2382:a0ea with SMTP id d2e1a72fcca58-8422535fc9bmr7926000b3a.14.1780284692282;
        Sun, 31 May 2026 20:31:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:3903:b0:842:2382:a0ea with SMTP id d2e1a72fcca58-8422535fc9bmr7925961b3a.14.1780284691797;
        Sun, 31 May 2026 20:31:31 -0700 (PDT)
Received: from [10.133.33.90] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842596e63f4sm685783b3a.29.2026.05.31.20.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 20:31:31 -0700 (PDT)
Message-ID: <c669673c-ff3e-4d16-98b6-2efddf69458a@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 11:31:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
To: Akashdeep Kaur <a-kaur@ti.com>, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vishalm@ti.com, sebin.francis@ti.com, k-willis@ti.com,
        zhongqiu.han@oss.qualcomm.com
References: <20260527062534.1808422-1-a-kaur@ti.com>
 <20260527062534.1808422-2-a-kaur@ti.com>
 <c1214419-1f29-490e-a553-8662b08de2c1@oss.qualcomm.com>
 <9e5b46b8-cf04-4b9b-9e33-2cf27802690d@ti.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <9e5b46b8-cf04-4b9b-9e33-2cf27802690d@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ppSPGmY8pmxT5TbPVGZs4eNIIgsSxW_W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzMiBTYWx0ZWRfX4iyD+dB7fodu
 8BsrcvK/oG8kZKvV8QAoudXgyVTj44a5eVVaKkbcuJuh1lp5phmwYI7YuRS3cVSSpEQRbvJ+3Nb
 q254VcaGJDR7thzTC7ikwLA4QCkmUsoWCi/jJgWtIYe4dPha0n5o67pon6NhXOLotctR7txRFXh
 9FOA+UgXtn5JKm3GMLUQKxAZ+J0w3ehfzTUEvdl6rK+Jqp9XW0slSHV8lkQrDbevc8FTxNmfxE3
 n2WCjNexJlbSrjyeRsP/YKbCCH74WsxHoCsI4Sg3uHJGm3Tsv2Nx0DF7Oq5dhq56S4HYuKr6qCc
 bS5qQDl1ov5y4nfVCps6cayx1dIRg9iGC6EZd5YGqnEVmCzPNUg6R9oZbD6zG73DQjz35Mfvx7J
 bZx0m5q2MWw6BOT7MRueTBQYCBQA2AnDpEOj45Cievd8lpcpQ5dlUNlihzziAIWyMlR3KCONue8
 DhWzFVskHKqldUfcHpg==
X-Proofpoint-GUID: ppSPGmY8pmxT5TbPVGZs4eNIIgsSxW_W
X-Authority-Analysis: v=2.4 cv=Zq/d7d7G c=1 sm=1 tr=0 ts=6a1cfd15 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=SNJnxaED15Gh7SIramcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010032

On 5/28/2026 9:26 PM, Akashdeep Kaur wrote:
> Hi Han,
> 
> On 27/05/26 13:29, Zhongqiu Han wrote:
>> On 5/27/2026 2:25 PM, Akashdeep Kaur wrote:
>>> On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
>>> device before soc_device_match() can return valid revision
>>> information. If ti-cpufreq probes before k3-socinfo,
>>> soc_device_match() returns NULL, leading to incorrect CPU frequency
> ...
>>>       u32 revision;
>>>       int ret;
>>> @@ -441,6 +442,15 @@ static int ti_cpufreq_get_rev(struct 
>>> ti_cpufreq_data *opp_data,
>>>            */
>>>           *revision_value = 0x1;
>>>           goto done;
>>> +    } else {
>>> +        /* Check if we're on a K3 SoC that needs k3-socinfo */
>>> +        match = dev_get_platdata(dev);
>>
>>
>> Hi Akashdeep,
>>
>> Just to double-check: here 'dev' is 'opp_data->cpu_dev'
>> (get_cpu_device(0)), not 'pdev->dev', right?
>>
>> In that case, would the 'struct of_device_id' match data actually be
>> associated with the ti-cpufreq platform device rather than the CPU
>> device?
>>
>> Do you think it would be reasonable to add a boolean
>> `needs_k3_socinfo` flag to `struct ti_cpufreq_soc_data` (similar to the
>> existing multi_regulator pattern), and check
>> `opp_data->soc_data->needs_k3_socinfo` instead?
> 
> Good catch!! I think the approach to use needs_k3_socinfo is good, i 
> have respinned the series with this approach, please take a look.


Thanks, Akashdeep.

I've shared my comments on v4.



>>
>>
>>
>>> +        if (match && !strncmp(match->compatible, "ti,am62", 7)) {
>>> +            /* SoC info not ready yet, defer */
>>> +            dev_dbg(opp_data->cpu_dev,
>>> +                "Failed to get SoC info, deferring probe\n");
>>> +            return -EPROBE_DEFER;
>>> +        }
>>>       }
>>>       ret = regmap_read(opp_data->syscon, opp_data->soc_data- 
>>> >rev_offset,
>>
>>
> 
> Thanks and Regards,
> Akashdeep Kaur


-- 
Thx and BRs,
Zhongqiu Han
