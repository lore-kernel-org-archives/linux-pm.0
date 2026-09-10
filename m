Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A892F3C19
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025901; cv=none; b=WfhTLkjpVKrV+ceibYvWtCKhZHesUQB8ToPvPqNhQfl+18TTCedLotTIZXD1eeh97nfcptk3QRcWycnsVyGjMzOClxJH3GLBku9XNe1mSBvlK2v0LN4aop0fF0xkugZ2YOQJ0dPzLpH/k+eFlYjDko21iYBSZ3oiGZFoDdfijRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025901; c=relaxed/simple;
	bh=yFx8LJ2aOskQ5Z197d1d87Hlzz62gvVdXK9GUbtNQiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWuuWTkLUUiv0pBBHc061zAPschhXN8+VZHP9TLTl89awHJmy4h+xnAU+WRZ9IeIpfx/Bd4goeiHAGLonujVdumYaev67HLbcbd782JG4jqZsMiuGGJ2SGtpn5oCmGtU6zdn8oERDjiLO/NMvJfY8CIqgDkUZl+c9LAbaOItwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ict7Smoo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OmnjiWD/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ict7Smoo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OmnjiWD/"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GcEM1108133
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UpoNQYrLBIJhuLHAlfG2fUBcoGRiViUf1SVLvCEmnmk=; b=ict7SmooToVev/87
	kEaF/I5qPcL62JfNAc+bOgPli/WIhWXg/Hwyb8pJsf11TCh6Fp1L7dQYPL/p06WM
	QNrh65a3cKtmU0OQLTf9cC0KrxXBVRXYOcMI+4pNc/ERijfYet8eQT27PRp/Y4F+
	HtqZXJKl9V6pVgyWN2Ufl1Or1lE+yEeVcNFIDGbvgHaNQcC06rmMZA1unbF4pe2w
	aZ8wlAuNv+CXa28W9QcJBT2WIn//HYZYNtx+CmeeGEKkUZ0Z/ZqD/+DK7WeouHlZ
	yKMtUhvR605U3MJ6vzyw+TSFmtt0DW508S1PpDBFFp2CpJUpRpgf29oaJPLvW3x5
	A9QV5w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyhamy2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:38:08 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e8d3a2d3fso13136396d6.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 00:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789025888; x=1789630688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UpoNQYrLBIJhuLHAlfG2fUBcoGRiViUf1SVLvCEmnmk=;
        b=OmnjiWD/ChbzsYPBEeosNl7QUiphBOnfBxY+fBOwO71xXtrE3veOxRcDjhqdEY43KE
         uCfIqPvUVXOG0x4m7xw88t5tcnn0BWrPx+t2HaRHIP2mD/glBZ246vavVxFli9cacC3V
         i4XVJ5qiS0ccFsvCbB9BK1Gr4vqWX7lZo9Zr88CTiFqG1/bSh9vJ92FaBZGM0GtDU26B
         XlkiQpSVarDTQiPifHVjisOkxW+eFguT7yVka4KrfVJxs1oikOs+Hyl5ZTiqxZaJUu46
         G0E7KFfsagjAMHUSHluDudj5U1KggBYPRb+d0tABpk9bVfJBfbs4zAh4KR3dVop9uR/K
         nyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025888; x=1789630688;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UpoNQYrLBIJhuLHAlfG2fUBcoGRiViUf1SVLvCEmnmk=;
        b=qNboVEae7miJlj4H66U2tyk/5HgJMakOTd23jdGAnghXQDZk7jREWC1s5KSzUJNaCO
         gialLHArhb6J5neXDDrOaxbf9RFeNTxhrUumDSDMeISROgaP+iVBtifJQlt2POlPd1xg
         NEfCnGx347OfaGD2DaCjVlpgswrYOC3N8hB4wvMUUrK6WpYNZooRPXhN9poM7fmXEiHc
         0l7VbzeCou+4ko1ozDYgm3kxePyjqwvOiTUDOPe5kSmubkpl8ig73pziuikgHfnCRPs2
         Fn7icoMUcLxnHJsqLgwEJ05Vmd1wiztkIoQAq03pwAB/RmGItxnA0E1WnZ32SeMu0Xmr
         07zw==
X-Forwarded-Encrypted: i=1; AKwUvByFkweLn/B7yvF4R919Rw8ihAUADluB579GsLd6ElvRAAgIV2ngDqZJvs+ftD9XQOwUyreJuG2Udg==@vger.kernel.org
X-Gm-Message-State: AFuF++kIrNLLQyiixKGkSjN7czFfdULir1+lG4GjvVooWeZyOVDNDpn8
	dCBbFHJO7RsZ833of86bdrVfjKFrt28a3+qkPZRQ+n26txJJo4Hy91kFRqMrtx1PvXwBxE7OObT
	HwUsr2bse/8Ya2OBoDtkgOeHlR+KNSFPVbP3JCE/msCdjkhj9jmiHBEHxtP0U8+NcM4vrUg==
X-Gm-Gg: AYBFou20GpmKKwOA/M6Zc4k8objJacXv9yccfbyWc/w5Ic57wqqP4XXbgZw8yAXgCX2
	GKG9v0CGpXRnoKy+cpXxeRuTv/1c7M/b2w91rlFVu7rQO2YL2aN8vjbRQ7wb2OoSsz/6IJghRvh
	TC9FVtqKE/PK/TFu0xRoJ5bxnBdclNfJf1Is/5QKM5y89hTwG922R8wGZkAhV69L0q5ogQ5rnAe
	sJyBdPOg1xW7AR6xLv8/4HCfZLT48cqdMM0wnMuNCIbI+tjiyyHEIM96v2gX8bRe4tgXsMGHR2G
	x2hXT+PjR7IGvWjZDzW0NDlTn245Asw16BSxRbgBEVgxH+R1RHIbhV6f4aTVlf5kQMtHv9vQlGU
	GOPb1BVMRVh8Fksj3zIFQiQ==
X-Received: by 2002:a05:6214:5c47:b0:90e:9aba:f095 with SMTP id 6a1803df08f44-9104796275amr329705766d6.5.1789025887658;
        Thu, 10 Sep 2026 00:38:07 -0700 (PDT)
X-Received: by 2002:a05:6214:5c47:b0:90e:9aba:f095 with SMTP id 6a1803df08f44-9104796275amr329705556d6.5.1789025887275;
        Thu, 10 Sep 2026 00:38:07 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c262ccca88fsm708891166b.17.2026.09.10.00.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 00:38:06 -0700 (PDT)
Message-ID: <9dc6664c-616e-4a8d-8cd3-9a790c09fff9@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 09:38:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] interconnect: qcom: icc-rpm: Don't skip small votes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-2-6dc5b5e97626@oss.qualcomm.com>
 <eguvscm5rutrezg3n6oncxfbma3qolho6acj3uibiknp732nah@n7fhrx5jyfdd>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <eguvscm5rutrezg3n6oncxfbma3qolho6acj3uibiknp732nah@n7fhrx5jyfdd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MyBTYWx0ZWRfXzFY2/Y8pc9OH
 WGWmDh66SlrmKJAVFp5vQU32g0voidKzX4RfSJGSE2+8tx17NdOg4bqwOoOMo5oczpjc0Reyct4
 YrD8eWBVkFUlFw3oxVH/pXB7psAZeyQQbk0EDpJujsEn7yjGqMoZy/XatLiuBoGKC3BXyewSORo
 Oc1XacBMo6n8eqUleVt5fRugL/Kfyshch01iS0KYI4WQLEwOw9XyPwFf+evQrnygTWATnyXxWa9
 SMirDOWmtzHZqUSJTkJUfhDPPVoCkJasC3n0grwvz8+yHkZY80EKanXk3LDqDq1gWC/ZGfIRQ0S
 2212N9aAh5/nzRlo/0jjuTdHWZu42R/++lM09jGj9OdE9y/7bPrkutf4K8K+NYoKPdrV4SJs4d+
 OaT5JH3DDPkG3OMGI/1stEnfjreG3wOpH5vRhZ4IsArZO63C9c0d2nYFsgQx+LOSRR1dY9NhKOR
 ZyDykcrWIh9HGXXozsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MyBTYWx0ZWRfXzAHyaqJCh91H
 AkRkiwqppTOd4HE+77jnHIzeHGT1AftCfgX3I4JNlMvtcUrmfrLncUjI14qzyQ8waBKy+8Z9vs4
 8vysS1g46K0V15i6oUKVImjmwc4llOA=
X-Authority-Analysis: v=2.4 cv=YKgKWhGx c=1 sm=1 tr=0 ts=6aa25e60 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Bsi9rA6XVeWCVWKWEHwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: shIHt6YFBTTgdox2FGVp5Vwqj-o43TgD
X-Proofpoint-GUID: shIHt6YFBTTgdox2FGVp5Vwqj-o43TgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100083

On 9/9/26 8:38 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 09, 2026 at 06:41:55PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Small votes (such as 1 or 100) can end up being rounded down to 0
>> midway through the calculations. Use qcom_bw_div() when dividing to
>> prevent that.
>>
>> Assisted-by: LLM
>> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  drivers/interconnect/qcom/icc-rpm.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> What is the reason for the drivers to cast such small votes? Isn't it a
> mistake on the driver side?

Yes and no.. the interconnect infrastructure on RPM/RPMH is a bit
"meh" given it accept kBps values that it then converts to bus clock
frequencies in MHz that are then clamped to one of the predefined DVFS
levels. Many drivers want "level X specifically" or "anything that's non
zero" or "anything just above the first nonzero level", but due to the
differences in topology, that may translate to different values on
different platforms.

So 1 was at one point deemed okay for "i don't care, just need the
bus on". I'm not sure if the uses of it are valid, given that doesn't
*actually* reserve the bandwidth on the [most often] config path
while the driver may hammer register i/o pretty hard, but at least I'd
like for that to give the expected result.

These "safe-divisions" are more meaningful in the RPMH world, because
each BCM defines the units in which it accepts bandwidth (may be N
Bps, kBps etc.), so there's much more potential for truncation there

Konrad
