Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA32367D9
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127071; cv=none; b=ulgkJgRHbSaO77shOvnLG303VC1Y6MJvQ918sdQxeyjB90NsHfEDz7qnNN1Tqc/3iwz69SfBt5ij+9pWOf7pKWNRJ2xpTYpadlKV5VnTVfubaQMv1khIUq3M8Nagd+QDKkTqjT9wx1e9biaQA5Px48A72DEFfb8Fd2wzXsX/zTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127071; c=relaxed/simple;
	bh=8Vp1BuTxGJcJD8AC4d+5NoDM0ihlVg+nG4ExSSlMHY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjgiMc8kHDRmJuKNITC1DjngvwHxSZNCtDqAT49u+6UwWw5VqgBGuvlgvXr+SSOtKTT+oiE6wEdMxw/CPET8/fUf7w7DeGVia0p9oa04iJ+iOXVJriDF8Gpny5PAV2gUMiRrfRNn6/gj186sB+Biv3cJZ2+kHGs0RN9/LYQDbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gto/qZ9v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TxU8LZID; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gto/qZ9v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxU8LZID"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IG72mG2091010
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yc4/d8qtJswMAftQKu9HSCdPYUpDaigiy7xk3vlQtpg=; b=Gto/qZ9v871KoKiS
	3kFXIT4ynbjQg/B30wEFJn+1nHNYBnPZcbo32cSDNRo1ljmQGs3VsiTE2dJiRxL+
	7K6er9M3QzqxWyIYspq0MuK76TUh1gqeiPtVCfk1szGI4bgGqTJ3tSE9dop+T9/I
	vUHCuuWSiaIUJIT7Tz9X6dQmCyMTMfSbyoNTMOYIlpML7Jgvv4tTg/IJ+eBvYy3t
	z2jyVCe7jLPQaASt7PkD3nS0S8wFa+sKr0rwHlHHUPXaCYcormQh7wcsh+tl+d8E
	RTiSSf5GuD9mGfL3i0dGGShSrEvg286fCaQAM71p8i5ccDS4fLJiiIgYQVDyPXfx
	QDtx3A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e80rphusg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 17:57:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51494d74d4bso61636891cf.1
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779127069; x=1779731869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yc4/d8qtJswMAftQKu9HSCdPYUpDaigiy7xk3vlQtpg=;
        b=TxU8LZIDVi7a8twLt1a97YK4TgC6AiKYgSpEHOa7Ks75gfSyYuWbJqX0fnWSZHZE8T
         iAxLIR1Us6bFslLFtMrb1tVCVuntVIAeBVk4voQGB+/EH5pTI2lVRoktRsLGNlx/ZqJz
         eT+Ic0xKI2oFmwio2JPJPA2AF9P9K+vExzunsRoxemsW8AGEDaXZvepCkQFnYATkvWyt
         TPsMObwFXqUT8jshzfFMp905/8/n9muat3qktU/pVZaTQriloM6sgYrkIJD1tHK8ECif
         rCDz+iuIHwnu5OtDndwCIU11Ka3Q6bZkh2jbDXdm2qfQcTLEydmoh6MYrM33e1f7djLB
         Pxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127069; x=1779731869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc4/d8qtJswMAftQKu9HSCdPYUpDaigiy7xk3vlQtpg=;
        b=IGmqytc9xUK7zv+U/UDJDwUt7Jq+UisjgWpApDtdez0gk2RiDP0x7qW7mXpa6xfev0
         /PQcyI5HvRZMlmHI8sZWjQDB3Tbal46+sQSU511e+r57+4txQtPmRYsVIU3EdeXjNhie
         2qQe5nscBybVCMLflrV3zgdWD9CtNZkKLAB2qbRTwR5aL7FoQzCB9IRl6CkjKV7QbSsk
         J7kqQLJctG3eikSNzijgRf4WDX0Z6wPsAY4PcIzSgtRFZ0+4tLglLKo4SdAzdrzQKdw2
         XNRpStSv9uszRhiz3ReJBmHwdQxiehKcGDCMI3sPthIeE0/yt4DUlIBGidrEp3wSqcY6
         i8ew==
X-Gm-Message-State: AOJu0YycOJix8U+JmyEsnJgyqNk2n8+A3hrQn2/6Izi0I1OJ2ABDdE2A
	CENTO4NJhVxpN4Wo4zIDF5E05jfWxve2Rx5vb8+WTRnBcfFfzE7FQwh9ECuGF+GVxLgfjAk7A1B
	Id547cKyZqTDpxaApiPlo4JFN9ZWS54JidVuBUgn+bLpsJsLV1zfuEADARKzzGg==
X-Gm-Gg: Acq92OFcNaQbU+HnVcqrqqpeLq1gcv3cM9HJOzvZljQWrosCmALf3saIEO0nru6VJB2
	eIWPdiYpuWV5vcAVo6qLSle7qv8L5dNp2UCGoo0miaA+o5epy4DFJ/d1UDHv0NS0J+NbOpS66xM
	GNap4HkgOwLS0IrN3RaxVjn2KrJWkgNjoGRlC2CSlhX7n+IM7SZKdldGF+NP8uzMXQoah+jo9AJ
	b/zGjc8tJofkpfi3rc9IPw4xoxrhhkFJGcsAZj9qb4PUhPIS48tIb3xVN6I/B90ax3RX8ynubD5
	j204IkNDXX4A9XzJN9SuU2Ac4r/ZgRMo+J8Sxw9fi/WeiciaGWGlNf05MccdDgRfKWU5xxFWtGu
	s5Z3P29R2N2L7Vpzo18aJvxcEc7qInjfetbngs35rBNQXXm8ozZx4T/XQGUCN0i6+Ebea8sSyQw
	PTWIEGqu9t
X-Received: by 2002:a05:622a:1386:b0:50f:b7b3:2ebb with SMTP id d75a77b69052e-51641928873mr254152581cf.33.1779127068684;
        Mon, 18 May 2026 10:57:48 -0700 (PDT)
X-Received: by 2002:a05:622a:1386:b0:50f:b7b3:2ebb with SMTP id d75a77b69052e-51641928873mr254152061cf.33.1779127068071;
        Mon, 18 May 2026 10:57:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9? ([2a05:6e02:1041:c10:e390:12f5:ed3c:ffd9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm276575975e9.0.2026.05.18.10.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 10:57:47 -0700 (PDT)
Message-ID: <9ae2a769-4b2a-4990-90d4-0a1c0f05ba82@oss.qualcomm.com>
Date: Mon, 18 May 2026 19:57:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: armada: replace msleep with usleep_range for
 short durations
To: Mayur Kumar <kmayur809@gmail.com>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260511153750.183640-1-kmayur809@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260511153750.183640-1-kmayur809@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _Y0dBGussA_lApPnNr9wzbI3aol2jEp0
X-Proofpoint-ORIG-GUID: _Y0dBGussA_lApPnNr9wzbI3aol2jEp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE3NyBTYWx0ZWRfX98kW22gvY/RN
 X8UWzUP5phuo5VsDXpW5eRLeFqvsBksgvIKqs7LGBgPKFOXDqI12pixF4ZTh10t8PxTgLG0ZNnp
 GrSsRV93TPZgbwhTmz1BMkiyfjDkR2j78woM64aeH2Caa1h7EYLDAfxnYkAZ1puNecBfhi9DvIS
 bOwCDd5wOgJ/XaZntt1mX6PL6TGYUZCc5i1ApshHRKVaDY0asbDT1pVTCaSiOFVZ5bbnlJKG+OR
 no59SaFhMTYda/15cDecvBmLj2PaWVWg3FSu/OX7xajrg7TXwMFx0IfEG9pzL+zhvTFksVfnxzt
 swnddCQJz4Ir79f4KsvIYoy4Www6R7NCPw1AbC3gpeyh3z2s915ZatCM7xNRhPDf6DgRRPfuhkK
 R9245AKPRpHLXQNtFQ1E5YVu5INiELgl61d8wtawNR9eYR4SJgpwRs42VsHxnIo+PnCfQyY1Xhc
 /gPoidwxoqq/GSz+mDg==
X-Authority-Analysis: v=2.4 cv=ecMNubEH c=1 sm=1 tr=0 ts=6a0b531d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=CvSXXL9ViinJZdB_jLEA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180177

On 5/11/26 17:37, Mayur Kumar wrote:
> The checkpatch tool warns that msleep(10) can sleep for up to 20ms.
> According to Documentation/timers/timers-howto.rst, usleep_range()
> should be used for delays between 1ms and 20ms to provide better
> timing accuracy.
> 
> Replace the 10ms msleep with a 10ms-11ms usleep_range.
> 
> Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
> ---

Miquel,

if you are not against this change, I'll pick it up

Thanks


>   drivers/thermal/armada_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index c2fbdb534f6..96965f393b4 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -178,7 +178,7 @@ static void armada370_init(struct platform_device *pdev,
>   
>   	regmap_write(priv->syscon, data->syscon_control1_off, reg);
>   
> -	msleep(10);
> +	usleep_range(10000, 11000);
>   }
>   
>   static void armada375_init(struct platform_device *pdev,

