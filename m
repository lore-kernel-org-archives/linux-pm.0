Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871E4A49BB
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361346; cv=none; b=kvBrlxKigv5yfQwTFJtdcE8vmOKgOQ0LqINABuAviF/zpKLWcCbqUk3/yDyjcl0uLM3S/gSI14mcWp+ihx2+x93cDtYg7xlgvL5esXQ89G22FDhlwpiOJTn3uBQVrnCOc0EOYEDzm6ke4r9d7PaTKB4y5tkeblnuRBDODg/KpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361346; c=relaxed/simple;
	bh=8ZSjNYTL8Ml6u8jCUwBjbxNKyQONvg0xPIbXWyCmk6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgHOq4NXT8QyYDMS0C0gE+RXJo6jzMayil1DJ7MzdvPa25qJvUCLu5iP/PNBetKjJJilX7W5alEcbN/IdVJ6T5AdnckbMrnUgr0jU4h0iIqs4RHkSNqFAjQ7YHaPBMw+yQL/DVENG5hUZMLsNKdxqr+BDpo3lV/P67IuUI/xeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QqANDGqG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i5ytJ/bn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QqANDGqG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i5ytJ/bn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CRJ0t1491365
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 15:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kt8GHJ5keyTKWhMxN2RQEwwtSHHHEF1wieLuKB/lRZw=; b=QqANDGqGpXjF+DYp
	IBRL6lfYikbQmTeC7c6WcGbbSL2wYiX9bvWlvwu084h1ED9ywp1Df3FbtmUTNCO/
	yaZnc7Gzy07aBxyeIzJY59Wg2P75plwEbwzEbodjkNxBWzS1z3Wxf4z+1k11ABV0
	u0lXx9kx+v/JmGSyJrduX4BrhuKweRfcZKnILKTBbyHVCtjD1kLV+tw37Ie6DXNH
	PImaCSZ1FaNxN3sdB4ubnLMxCRc+ib1capPrp1HI9iNsTzMVFmNCLEh+RcI//mqp
	dMglTA5ygllMR0MPjoDhtjgeVep0hlw2LmmQClTOxMK6OkxQx+7opzPBH0ZR7W8Q
	hO4AqQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geb562qnf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 15:02:14 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7f439b09124so167842a34.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788361334; x=1788966134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kt8GHJ5keyTKWhMxN2RQEwwtSHHHEF1wieLuKB/lRZw=;
        b=i5ytJ/bnTUtQLBAn4ejjiY3aTnFDcynTvOvtRE1a545+Rqrb09IaYeqH6uSWpTVZ/M
         LtjlcJN/9oaXZsunZVURLK/SGkdTQ8VzfKc73aowYByvj3fUf2GsOAqzKNwOAYVeeoe4
         sB1riHN8QkdSfSxaK+BTF4jhjMZr7zTJt+Cygaw5XkIYCLykSFl8WRkEKv+pnUlkk7u/
         4ilssEQCiIQDPpsQlsOyGPcWQT1xRm/H83O71dQvqFvUYJRF/7FjnSQVcORsmnTYCueH
         ojCY7l/EYC1MjR9TfEnV/qoOvxfNwYDCIFqKNwA7AtF0ZPVV4EiPebwr5AKG+wR0FAya
         Z8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361334; x=1788966134;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kt8GHJ5keyTKWhMxN2RQEwwtSHHHEF1wieLuKB/lRZw=;
        b=MDfZrmLf4kABt0MiDD87F3L3qmU3G7midBmBKXgaQkcfSCtjq55u4Dx4Rhm8SlZPRG
         UkXxua78Q6NJs8bVNeQRYcvy+cpYZyvUpu1nW5O1Y/9uiWBhimAYzBvy+yXGAIPnvTJx
         aeCx8oTNlyq1pTNFl7zF57crE1dSndx9NsuZRcWHnLl/PTtZtSyJVvCxB8r0P8pNvPGw
         6BIHCOfwwc+Lvidqtxdni+9IPKlPqicGZWxAjJujwgAzEsBfE9lKZQsqpceYfK2FoMaT
         FlL4fZrQ/qOOxcv7H9emJunouyrIwU+jkhu/Y8AzDm41gj/pujLzWywPwlTLqchbTogs
         2bnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rohzi/reKOTg7jCmpgNZZKGbETSn8wLr8lJd/hRP845sCc2ewIoLtkmn9kR72NHaKjy0OCXHqDi8Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kb3NFWPMNyXnQwrFB3M+cVDjGczq6jfjyRBS7OwA2pEIDkZnOp
	yTOICJNmijKqjGSGLdN5SK/QZRfu/08dhvTHk05EYNJkCxFRg81Z94LDpE+K0WoZYLymZCAlJzO
	nMW8QUEDMciFHawu7rW701tguXaK7fJWQCNjJjkiWHiF3aOUcjet6xSid4LnHzBy/tuONzQ==
X-Gm-Gg: AR+sD123gS+V5hCZwFXeafqh/OyShl2ffhcChUeQYkPE1HQD62F+XsM2N39y8wCVkTj
	aIa7Gf5ESbre98m67EtsCegBi0/JdX3xFsXKhaS1+iTWunUviS4Ptlus0U1bUPRK5tSdcZcpsuU
	rwCtNIOdwAW4BW2+4oo0Ph+tNXHXpJoBkCekafsNvI4yrgtec7SqBMM7M4uNar3cSRvRF+G6c/k
	hcAI6W71xWXu9CUGvkgPsfnWcy4eW9TdsJgXzrd6m646pgeUS6HUVsgGWNwc/hzGYAuomIr9tBg
	fXZNlUGn0UyXmgkn0FPWqSdFClmipHIAmByW32Br0XREY/SXSaR/A2iaQ9u4IcvNtOugnlHp16/
	BGT9hQM8Uds+77OTriVlArQ==
X-Received: by 2002:a05:6830:6d16:b0:7e6:6ced:992f with SMTP id 46e09a7af769-7f781694bfamr2826307a34.2.1788361333563;
        Wed, 02 Sep 2026 08:02:13 -0700 (PDT)
X-Received: by 2002:a05:6830:6d16:b0:7e6:6ced:992f with SMTP id 46e09a7af769-7f781694bfamr2826234a34.2.1788361332925;
        Wed, 02 Sep 2026 08:02:12 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f835955sm1260039a12.0.2026.09.02.08.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:02:12 -0700 (PDT)
Message-ID: <a2f3de2b-90f6-427d-9994-a8b1ec8cbed6@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 17:02:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: expose CHARGE_NOW on
 SM8350-class firmware
To: Jan-Michael Brummer <jan.brummer@tabos.org>, sre@kernel.org
Cc: andersson@kernel.org, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260829054546.86210-1-jan.brummer@tabos.org>
 <20260829054546.86210-3-jan.brummer@tabos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260829054546.86210-3-jan.brummer@tabos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfX3kwnF9jjWsCI
 APgtmJA4woAmbXCgndkufsBJNP5KGowamVoifEvjWPrsPUKZUUn5yHkEYpCkOItnrv8RqBKwzVK
 FWaaV+gIAhMYPm17R8CKAPuQGVG8Qzt+tXhoZOUF0fmkU5Er7dLGuEh2uONRoMwEnmq+cDBTviq
 QXVRZX9DupS6RTv28tlR4ED1SWaLotoxtB2gc93I7gx0H10CBue8DKn5b1eaLPyo6O4v0DphEmJ
 23tsFFbMt6ZZFh3f7hq0nrvRRJ/3gsaNHH8OKAWRaL3+zua793RvnQq7wf+alvCo+E1wpEB6Rcc
 VzrZkc3/TcpNaBH6wXz7zNWBVKWyQn5+hwZpCYWxYukjYASQOcbRBpfP6v3Eru7gsjnkrYmx/u9
 gToct5fAym6kXKaPtBhdr2IaFdj5c8YV6EJQALJ1l6Qf28P5sdbElBcbFGn24Swyjomavml2s3Q
 7GOjPVldsMTOnpu5GTg==
X-Proofpoint-GUID: 2NLDLi6GpvZOIMf74KB83pwBjNizPolK
X-Authority-Analysis: v=2.4 cv=D8N37PRj c=1 sm=1 tr=0 ts=6a983a76 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=DYa_1O34AAAA:8 a=qAZn5fJD0YA4aXmIaTwA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=piCpHeHFVjWJlYWd443B:22
X-Proofpoint-ORIG-GUID: 2NLDLi6GpvZOIMf74KB83pwBjNizPolK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfXzycBfRjBjMkn
 bGGQWOzC82sNQbRWjcrY0Yqv7hyFA8jHxGIjkdWtSsO8seVnrBZdJbFiNfXV/S0qVIzQ5Jeg90d
 f/+iapYWRjmlKUJ9ndCTvWyksv5OZzU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020133

On 8/29/26 7:45 AM, Jan-Michael Brummer wrote:
> The SM8350-class firmware does not implement a dedicated 'charge now'
> property. It does however report BATT_CHG_COUNTER, and on this class of
> firmware that value is the remaining charge in uAh rather than a
> monotonic counter. Measured on a Fairphone 5 with charge_full at
> 4116000 uAh:
> 
>   BATT_CHG_COUNTER   reported capacity   counter / charge_full
>   2434614            59%                 59.1%
>   3525354            85%                 85.6%
> 
> Map POWER_SUPPLY_PROP_CHARGE_NOW onto the same firmware property and
> store the value in status.capacity, which the CHARGE_NOW/ENERGY_NOW case
> of qcom_battmgr_bat_get_property() already reads.
> 
> Together with the preceding patch this gives userspace both the full
> charge and the current charge. UPower now derives an energy level and
> runtime estimates in both directions:
> 
>     state:               discharging      state:               charging
>     energy:              14.4347 Wh       energy:              15.6003 Wh
>     energy-full:         16.8807 Wh       energy-full:         18.1505 Wh
>     energy-rate:         3.39313 W        energy-rate:         7.3492 W
>     time to empty:       4.3 hours        time to full:        20.8 minutes
> 
> Signed-off-by: Jan-Michael Brummer <jan.brummer@tabos.org>
> ---

Ok this makes more sense now. We should still gate the other property though.

[...]

> @@ -1442,7 +1445,10 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>  			battmgr->info.technology = le32_to_cpu(resp->intval.value);
>  			break;
>  		case BATT_CHG_COUNTER:
> -			battmgr->info.charge_count = le32_to_cpu(resp->intval.value);
> +			val = le32_to_cpu(resp->intval.value);
> +			battmgr->info.charge_count = val;
> +			/* the firmware reports the remaining charge here */
> +			battmgr->status.capacity = val;

Let me try and find whether we can rely on this - on newer targets
many properties are more or less just front-ends for vendor
plumbing (because there's a ton of different chargers etc.)

Konrad
