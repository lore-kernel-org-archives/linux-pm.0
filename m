Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992C1EFFA1
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786417688; cv=none; b=qPJsVdS8b/A7xJLBDSLWIKATFJysf8TlI1EMFZBjBLMt/iaJpns40tYFzM5FP1KZMcLKsY011JWi7N+qb1w9/BKNyyPItDNm46bZN/EFm0/KzbqbGNib8qjr11kAvZdM1urdGOVerXuJBJmY7C4tf5FCOk1McOP2JbvQqIgqo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786417688; c=relaxed/simple;
	bh=DlW8q4oLq48rVY5GwKZjkDvXGvkyA6zitlwCeSxMGIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmoiZS9/f3vWmLBrku2lxH7jFB9QF6NpiHtuFnCAJjrxHyVQ562WF3K5+jMLkuiPBYSsczxTc7ZxBtMSIs9ihwTtE/Mbf936TR6pS7r4LGhI3uEIaLFSIbiKIz5d83fnA6+9VVyfysgbQtgWOBW+43otVWK1cD4IMwn/7X/aBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkGG3wgx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lh65utaV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkGG3wgx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lh65utaV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMptwO2252415
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EtmCIS8KvZUiQkn67WxkI87wxCudwiP/IcdM2o9zbTc=; b=RkGG3wgxXsXTWtu7
	BD4DPEjTV1S+NISBzO6sy2j2XzZsOnY3zpN8TjB/lWel0y/hwRSq3sfCcpFYXFcw
	DDiporaxXVImLnysslm8+Rem/AHCuCmumyMbVy2aSN7Xa3dtpbouFBFSIf4pH8Qh
	rMxzB5WpMqOFB0z8O4px1KSa4Z0k7uUnjGwmL6bLlwTFOkGVRTqqo/tdoq7e/g1v
	t36H9J+Cd/gu6wMgCIWP2Kctb1dLa2QAf8Qf7sas7eP5krgM6vu9vxLlkc38R7BQ
	Vf2+lNZqXVhpJuD0Omy656iZQ71DNUTlGHs39wBae1DCVK+UlFbDTzwbryyGVBDe
	36TFXw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk7a502-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:08:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so55525555ad.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 20:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786417685; x=1787022485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtmCIS8KvZUiQkn67WxkI87wxCudwiP/IcdM2o9zbTc=;
        b=Lh65utaV31Cooq4lUslxXbbja7kxP4xwjtHUz1MdPcpQ8Co8hw1MH7H7HF8kyDXE05
         EpMwb0ToCut8Uzr/Gs15BxmXZ1ZFMZZ9iXPsdgYqBM+FmSPK60Z6LWkXVIZ4JmLfXSEV
         trhU5yjzofxt987O6bVw4YDqH+6dvLYlxLt/H8j9eeW1JV0ZlNBSpwYXezc0NRCSBtko
         cD5CqjDvTab/zkKjqeperHP8jkPeV33G0VJKeMLpbrNTpAtnuPO+3vSe4zwNolii4bxG
         sBpPOk3WUWtWBJXlZXtcf43Ko2oSBRKV+qMbEkjrUR2pPlpasWdH46d1EzIIfuUTZZ++
         tSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786417685; x=1787022485;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtmCIS8KvZUiQkn67WxkI87wxCudwiP/IcdM2o9zbTc=;
        b=UphMlwzZSc2jPGpro2Nwhoy5mfwQjkqNRjlohddiJwxFiDkjcZqi0lkiTtvHkN/5NM
         WkZlFDtL6CNB7lKwIs6APNxc8bF1+UuVQshJpRT3V6NoqafX7yqTOmnqxw0np++MUG9W
         dex5nzHM1Am9XSGmM/YMnrnwkVcJXTQi8v3Ur64EWGZ6ZQKMYVLqyQxFNrMn4UUyXDk5
         ircCWp5VYwwFm0vtLodEIdHDDpXF2xUQ6e0ogm73ozpprLiKMM31zayNk2gBnc0RQSw3
         mXmIFFrAVcofH/80vw5iYD3bjvltK8d211VItXq1wOBUc3LOujTkjVotHIA+0kA29R57
         f+vQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+JRz1Q9h6wrobOAB4TbdCfotZiVRu+bGtGFlgBwaO9z7qp57FGu0WH79I6eRGU9sOkns6mV0fPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxCNOwwWKXLwMRdYeXXTP4xxP8zPdnU4Q3YUH9UOzfWJbdALF
	7Knh5Zfj1vO7XW6fncCvXeNrpHjcTBFvReWPKQFhej+6Ku1VF0n5iBQtg6j98A+coIgd2LVm5Wd
	R8PWXY/eAm0M0jWiiwwWF8EePQfL44Hx1os9y8EDt4rRpsoUlO+FHC16ElYnfiQ==
X-Gm-Gg: AR+sD11v78XRQIcunNbclB7wAjI2DyG8ng2XgzdKfYLOjHPd621Xu6yxRCvPbm408q3
	k1BfZOhc614aPQJ1TYSyIa4Dt/V75NsiBNkTVVU4fANGJhyq7P/PrJ/lJGwdmdtTEp5i5wy5iHG
	sX47Fu1CaQj8WQuwVY9lx/DwSg2s0kwCgNFE1CS4oICv65XNvDMOoNXKkeBY668qqGfgIqFG3Cg
	YkgHA+UR+UGVEqwbMmJ3zQDw+OqAq3vXPkLrwjpeh0DLlkPpGpeQk5YVsVWLHlDv+gvDwNTJGEI
	eRchGSdldQziD/eE+KJJUn1SZRJ2N+R09IMs2nJAPRHwE/oLk1Ewjzfu5DtODZvVi5MfYznFX/v
	onor2rRkPyAAyCh+mu3cV2J6jWj2R/YJHtSuzTAfZXWuSgfxu8FkMbMRYm1G2Xapgc6wdIbGMcd
	fdgl++NpYUAsnX+jfsaNA=
X-Received: by 2002:a17:902:ea0f:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2d31788ea5emr3693695ad.14.1786417685146;
        Mon, 10 Aug 2026 20:08:05 -0700 (PDT)
X-Received: by 2002:a17:902:ea0f:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2d31788ea5emr3693185ad.14.1786417684728;
        Mon, 10 Aug 2026 20:08:04 -0700 (PDT)
Received: from [10.79.117.20] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a754dsm45103397eec.11.2026.08.10.20.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 20:08:04 -0700 (PDT)
Message-ID: <c47b3af2-d265-4e9b-b843-05b5e63fe5f9@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:37:54 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] soc: qcom: geni-se: allow selection on 32-bit ARM
 Qualcomm SoCs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-1-5e0ede4a0c72@oss.qualcomm.com>
 <7f4qs6su5fd5ilecy4r72suk6mqvj7oouz7ahgatxthqavrfia@wxilczij4unf>
 <vxpntlaebf4an2wgebgbwk2rdkingzjecdgylqv36wmxtyqju3@hkip3wqgendw>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <vxpntlaebf4an2wgebgbwk2rdkingzjecdgylqv36wmxtyqju3@hkip3wqgendw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yus/gYYX c=1 sm=1 tr=0 ts=6a7a9215 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=FqS0QMqP9mElqJ8EA1EA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: _Jr85F2ZKHsaSuZhuq2nWgdNCVTIp1I_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAyMyBTYWx0ZWRfXwuneVwx8tZ8A
 7yLLMKVd8A9iB23Xtfc2jbKKcW5/mA0A9XODXHhmvobbvUh1QUGlkqteXpfGydE9Xo+SN4vKGB5
 Wha1HczAMHPeTZmMhpF7ZhemGACfk41yVs0vTI0i3vDFr7f8BUAme26DwEWVD8JD52XfeKILlib
 sEyDh9+QYJn6KT5fr+IrNkD9w3ONg0X5tcXOiFrONAy+0lp2JzFt+FKj5LrjQbD/c+kFmYk0yTV
 8P3Kp8OmJw9wp3HwEVZMgyQjVzlW253q/Bjr9/vfUXlbDu5E2LrwmhHzYmE2z4/7ygu3zfjNTP1
 hpiEeLKcCp0yvywhwXOxj+UmIYicu6ugK56je714IYWIHUP77uQmvTn+9+WHS8mWZdXIuD2Wi44
 uoxgQ2S9T2ZBIgdzAkt5nseHAmoGn3arZ+HkYSh9zkYbLNt8wRJiep/JGnJnYzltQTVUDlNhnX9
 yNGtXWjWTx/7UQZgrmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAyMyBTYWx0ZWRfX+zf4+vqz7odW
 PswC+OOFoW+TwpHMmB8SnszCWOf/US1RkDmFNKtHUWR08e1YdEN88D9o6lYu8LRudegONr9kBC4
 gypH4xPW8omIUmCJBUW5EfPbawvWgJ0=
X-Proofpoint-GUID: _Jr85F2ZKHsaSuZhuq2nWgdNCVTIp1I_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110023


On 8/11/2026 6:45 AM, Dmitry Baryshkov wrote:
> On Tue, Aug 11, 2026 at 03:48:00AM +0300, Dmitry Baryshkov wrote:
>> On Sun, Aug 09, 2026 at 12:57:00PM +0530, Hardeep Sharma wrote:
>>> Commit e10b198a94c6 ("soc: qcom: Restrict drivers per ARM/ARM64")
>>> tightened QCOM_GENI_SE's dependency to ARM64 || COMPILE_TEST on the
>>> assumption that no ARMv7 Qualcomm SoC uses the GENI Serial Engine
>>> hardware.
>>>
>>> Kuno, a 32-bit ARM Cortex-A7 Qualcomm SoC, uses the GENI-based QUP
>>> wrapper for its debug UART, so this assumption no longer holds.
>>>
>>> Fixes: e10b198a94c6 ("soc: qcom: Restrict drivers per ARM/ARM64")
>>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>>> ---
>>>   drivers/soc/qcom/Kconfig | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index fd4d4ecd2df0..5b3c9d31fd7f 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -39,7 +39,6 @@ config QCOM_COMMAND_DB
>>>   
>>>   config QCOM_GENI_SE
>>>   	tristate "Qualcomm GENI Serial Engine Driver"
>>> -	depends on ARM64 || COMPILE_TEST
>> depends on ARM || ARM64 || COMPILE_TEST
> Or depends on ARCH_QCOM || COMPILE_TEST
>
>>>   	default ARCH_QCOM
>>>   	help
>>>   	  This driver is used to manage Generic Interface (GENI) firmware based
>>>
>>> -- 
>>> 2.43.0
>>>
>> -- 
>> With best wishes
>> Dmitry
> Hi Dmitry

Thanks for the review .

QCOM_GENI_SE is a child of "if QCOM_SOC" which is the menuconfig entry 
that guard (almost) the whole Kconfig, and that is already "depends on 
ARCH_QCOM || COMPILE_TEST".

Regards

