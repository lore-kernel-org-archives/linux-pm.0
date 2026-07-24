Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D213B27C7
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881462; cv=none; b=T5r+BLau3H26XAR7KzttjOh2uZaLdIi/g+1UI5PsYJPphS5jS1xHc5tc6SF+TYMAws9vNq1tvi07JCmYWSVAOq/lyxnRt7pBoTLt4r9g7tTZxAjnXUR2X2OZtwGcQPN3u8IWN1yXYbPkAhlLPdXBWwkms5VR7R9ftHkJUJyfyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881462; c=relaxed/simple;
	bh=Y0EyfXp7yrNeq21sEKo7MWHCuPuxTv8jOAGHJnXAXeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuScUkTtvdgRSDNSzVl+dH1W1iOz9K2zxGe00jLdOei2wL/Ttt4/mv28Jn50yq6JS9YYGuTytcRYWSbZDR3/9yF7hlaPMujdot86pmg3qOcJsAwQnrA57fJNFr/5OvtsdqvGVQBPq5ou3mSgHqyETc3m8DbhO1KUjOIHzvXFhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n33EMt0c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FcK5okjD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n33EMt0c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FcK5okjD"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lUsd1510145
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	askDjVkAxFPwvHcTAV+zi0ANzlszBe058FKv0G1PdwM=; b=n33EMt0cWSBDjcgB
	O7MV2O8mJWPTix6kb6a7pDbAKyCysKiyMUaL+XcDQmRWiJW4q0gy+cePXJ4ZeUtR
	sBBugvXwzWY8n32CGrkD1lUF2LaKqAZW85gmn2fJPbRAWPIEammoKjBTeXvctFwp
	JRdZXdvLVl8GgVFS0nLkJCwehkRQNGgBRJM2pza05SDH09nV2XIIoD6O1UVerjUf
	KJtsa/A1HpNVuHQPEH7I9bEzMVUK6iEVscwStKH3ALPLQSm1SYsFR74Gmp3YtIZ+
	Icw5s6yGbhmGzU0EALLeCLsIJi0M2E/FknPpr3OGZAQS1N0RyiCVodsW2zE3vAWw
	iDq8bw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkusrsqwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:24:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c110a3b6aso2129281cf.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784881458; x=1785486258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=askDjVkAxFPwvHcTAV+zi0ANzlszBe058FKv0G1PdwM=;
        b=FcK5okjDvQtyVb3oP0HtV7Hbh+bCKtFZ6x66wQrCN7QtRL3KcEO3iLhh5DjXuFvhbF
         eKzqGU+JSOA9BlTDnvTGYeFZxLAWma/M6GpQDnUdjJoyZfTYdVf+Y9q0jYquS/bcJh/J
         rPO+LCQBLn2qqYTKFPMhY3lp3qWGLCfFvbQlvfYHDtYoHda+lPsoyNe4ANAAnBC3/OjU
         t+tRB+UG4SGGHLZzD/jD2ZdXHV4suc8y+PhX4e7/d28uCEnTluM0TWdveak4+QRADYWy
         J3XYxqivtEkMv0CXwAFSQtb2AhdSMpbPmh5EoCpEAVWx7E8fjpXnRM6fgc8mwRiZh0I1
         IArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784881458; x=1785486258;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=askDjVkAxFPwvHcTAV+zi0ANzlszBe058FKv0G1PdwM=;
        b=os6HvBy8+ysOUOkoh1BAWjej2iot/vBhRD8K17eq7ImmUUpbkMFYKgXJl8Rs4jbS0P
         FEhHQ1EVapo5a7kL98D2BaEHzY2QBtt9xqLo8t1g9kbLgE+qb0TuAp3t5UVh19w0/gvq
         5TrT1DKq5fi5Z6uVgfSO3Gz7krEn8b28iRCL72HkCP3pGJWnYqef1144PQq8TFsHD2Fh
         B0N4GzKgK9+q2SNH64Jic/QdThe67ZQKDcONH0353de/YVBpvJzZNNG6qzKItJvAOHSt
         zOeDqMTzF5qMkzlKB0qK0br125jURye/b5FsDqC3yEvG0wbDf2w00nTkhDF/QFHaJ1RP
         Wcfg==
X-Forwarded-Encrypted: i=1; AHgh+RpR0Eu1MY7wSmo53SKcjqMI0IHCQ3htIMenAQCMlL5yZar6k5XiofJR5ryY1bZEuBGaU1rv3gDhAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSwGyXjI1ouhIUa0YONZjq6ndLmDiz7bjOxzhb34fvFtyw42X
	zrHJ7UU6jF+8BgxAnpSC8gm5pSq/B8JQGZCgb/TtliIIIoB25flwwaWFbLyTa5draN5dARf3frh
	C9BZa9ccBOnI5/xNtpbgbs7YhEGP2+RIGhGMUsLlADp+B73V3SUZI76MMdHZvbw==
X-Gm-Gg: AR+sD12UrdBN93S49ll87eQrnxBZWB5tbBL11y0wAZoh4kuAwswxbRCcYi6RT6G+1/z
	5p3wUiCm9ChjyjnwU+DIoSGjvs4ghx3PEU+fv2SsEWCBTCL9LSx9r5ma//MD9nDwb2q0pg7QXxz
	uWqQMlB1nh9ICQDQFQb4XXfokan4D/RePbzlLu1n5GA9jSvOPDp3Omyt7O4mV+AFDdm0X/QOL54
	oeuRSM1LcqvAX8Htadcfz2SIixsSuWiPI1u4R5xL8RZYeEG5X9T9a5QRKC7uDmOjEjaOAtM7pRi
	auVU3FGVb/6SjWs5g3t/K4f0EBKNj1cQ65iCanjLPmrccHIT04uolaAmRqRffx5+7RINzsNG3A+
	n617dqLc8rCi9bBrYTEgEiJPg4N00Eg==
X-Received: by 2002:a05:622a:391:b0:51c:7b12:1211 with SMTP id d75a77b69052e-5283e017e6dmr56331931cf.79.1784881458128;
        Fri, 24 Jul 2026 01:24:18 -0700 (PDT)
X-Received: by 2002:a05:622a:391:b0:51c:7b12:1211 with SMTP id d75a77b69052e-5283e017e6dmr56331771cf.79.1784881457683;
        Fri, 24 Jul 2026 01:24:17 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm35162045e9.0.2026.07.24.01.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 01:24:16 -0700 (PDT)
Message-ID: <f9fe60ca-b801-4915-b7a6-8d4b1a2acf9a@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 10:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: sequencing: pwrseq-pcie-m2: Drop undocumented
 QCC2072 compatible
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723193525.319826-2-krzysztof.kozlowski@oss.qualcomm.com>
 <CAMRc=Mc=4BkXsv2efKipwTq_qXx8m0tH2RPTF6vtZjpE_maaCg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAMRc=Mc=4BkXsv2efKipwTq_qXx8m0tH2RPTF6vtZjpE_maaCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3NSBTYWx0ZWRfXzd3NuEDOavmi
 08LB4Yw4FbJBs2y2jS2VWT4Tf5pUhRnB6H7W6j1YLjEFi0cpZLv3ZdDE0jhpm33U0ZnsjKELygw
 AOxuEX7Yv47tp018sfZgm5E6Mfcpqhk=
X-Proofpoint-ORIG-GUID: KW490scwE76gTLmOj6XZGQufTrCbV5zP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3NSBTYWx0ZWRfX//zKSvQAZvds
 8XpdVBXb/MALZCJOkmnJpBpt+WNhdobfFqqDnfmM9xNH8xdDdtwoh8BjFz/VNU8gsZXH+Skr70n
 WOcsEJhmBEY7/nvFblbGKvH5g2PPOgHejE6AwnmNwq2p31OB7tJxe6ENpHm5alaO3jJVjxokTyA
 w6uOekqS7US6wqnsKKdDCYCc8WFbETFBRXLrDuoG7O0ErNupA0zme1U+BRhWOjLzi52ZYVsTglF
 0/v4wc0icxJRY/lhoOolVl6hsVK9plNxogjy/wvk5uzCh1miwDbf35CJ0nGDBbJY2hoEU2YybB4
 rJwRDe0plMkGlbYGrL3EKlJ97jZ9Or7pTOzVBmodWN/C83QVxMzTQooV83Gr/tUhKk0Ife3MyLU
 em+aLlE244ddTHyFYgJNsWymorILbpyl+SJxEJZ+SIXDakG2+kbrUnAjRiK7EVdYk+CxYHlh6J5
 0wDqTb2QtU/sZ11Ogxw==
X-Authority-Analysis: v=2.4 cv=PtejqQM3 c=1 sm=1 tr=0 ts=6a632133 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=xwBlPVaBI0DFnX2r-McA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: KW490scwE76gTLmOj6XZGQufTrCbV5zP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240075

On 24/07/2026 09:39, Bartosz Golaszewski wrote:
> On Thu, 23 Jul 2026 21:35:26 +0200, Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com> said:
>> There is no such compatible documented (thus allowed) as
>> qcom,qcc2072-bt, thus it should not be added even in driver match data,
>> which later is used for compatible matching.
>>
>> Revert commit 162ea02941a9 ("power: sequencing: pwrseq-pcie-m2: Add
>> QCC2072 BT PCI device ID").
>>
>> Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
>> index 83fe6a1396bc..168e915f2c89 100644
>> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
>> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
>> @@ -195,8 +195,6 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
>>  	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>>  	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
>> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
>> -	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },
>>  	{ } /* Sentinel */
>>  };
>>
>> --
>> 2.53.0
>>
>>
> 
> This is the top commit in my queue so I just dropped it entirely, otherwise it
> would be an addition followed by a revert which could raise Linus' eyebrow.

Thanks, this works for me. I expect the commit to be resent/reapplied at
some point when the compatible is documented.

Best regards,
Krzysztof
