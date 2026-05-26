Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE840960B
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820526; cv=none; b=kZn22/LrlDs9GzK3sGk38025dICXuLTc5FpkbV8ZWkDjeFahPgQSk2+Dk3LT3EDA84neoOkaCqQut494i4pPZzRJsgHjLnshSZ9E2I403gLneI19hKkeC1DllFWThiVp/uhOFyN65Ca31tqb3nADA4W2kIx+YwGSSre0KNdTLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820526; c=relaxed/simple;
	bh=XShyEC70wvRr1BVvQmCcjGI75vl0OQ839ZipTO+bUMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQvZXCZvhv58E+llTEY3M1S9ZiYaqCUVrt+l31Pxb/0MfRVGp9eqSIPzyFDhZszOXzp12uGE7M9m7gEYddc92Msjjs+ibZ2g8NIfnWtTKtF9H5pIOQlebgJ9TvBBBpmVh8ZB2JGAPG32poyR6OB4p3I/93za1HBHuwEIhlBvvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YTxzee/C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fZ4jG3Ub; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YTxzee/C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fZ4jG3Ub"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH1CIA2995471
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 18:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EDQuCbgew80mDW3EHjwEB7on0f9SF/XtcUG6BT86WAA=; b=YTxzee/CpchOd363
	WPNMg0cXc+EFpnguDl8gm9OKElgiR46TSzPAlrct8a0C0qATTHmh/OU97uTCGhhw
	x5ZPoQzK1Z7Fogfu9CGEc8pwQCUTS8RT+i82PNC1rVlVXfZwFpHh5ogXXdHsYHJn
	lg8nXwPWpoP5I62tQgmzfDXMCAqyYRICiIRTd9cgAhVb9+c0qiFXDMRhmpx00T9u
	Kd1zO8VnHtG++NuLLWteMGUH5rZOk2miwFELMWnOt+Fj3C5/7ycPJL6mgeyjLuHO
	dH5Suhkrt08WQoQ8eY1PFrinMCVa3TjuRXg1kYoibrWaVI0nvRaU1gZsWXQh0X4V
	zyLW1Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edcnnsajx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 18:35:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5104b861649so9488421cf.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779820523; x=1780425323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDQuCbgew80mDW3EHjwEB7on0f9SF/XtcUG6BT86WAA=;
        b=fZ4jG3Ubq4tUJ/TOwa9PhHpiS+ls/Dpapg9cY+S3Zl0XMLLhZc8LQsmbkPdP58Djn5
         ZuwvhwadMXa0EXBFsRvzCNRg7gXA/m7P513MecrXNuD2hYhelh4qaSjAQ6yWG2xBGxXL
         6OZaAiUEklc0INfp7I2lE8i31DhntkLQClzQ5mtVDnK3a/TEyeg4sZnJrCcibcaPmmBd
         wlWVsPAgNnipFshAjPeZNhmy6h6IY0GmbojPfA3u9+gJSFxQmTt3O6zTx+sYwh98Ed57
         JL1w/k5aEBtx15vnZr/AaI9hZdMep2eVR3YbEzKMo8wGk8zQeJyp81VxvrWiXW22jPzb
         2IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820523; x=1780425323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDQuCbgew80mDW3EHjwEB7on0f9SF/XtcUG6BT86WAA=;
        b=XgI/k9q+Mx6R8BO2F5/G7R+QRvhkBsF0LngAy60SdkDN25PS3/Hrax2PtX89vHR9m0
         /vz345FUb0I2Lwh4QURveq9xjWm31zDxKPaVxcAyo3MJVMd7q3PF/hKs4BaqnChXlWwk
         nb021/a17Bb1/wVp0g1u/98xsmg3IlHmOG3iePOfAmOWDLarE8a4edPse6WCIsn3b29P
         ioeb9JcBCcc0ZY9FRMEJV6E4O/abBRVwzEUnw3RuwLNp1+YtYDUPrOWLzBy5+QB9ztTz
         C8YBXN1p4jEWFojblVG3ip7vi9BT5l+vnvEPb8zM2+t6UQCwXyf7Q0s2+kwmFwbDGdpo
         WkEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/ICPCvU6lHMOaBVxs8ac6hqcINR4X8CkgGqn+1qCOaPIXg/ysPOpJdDmvvLZfT0lzqer5F+pxjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV736/pFGkpxtvABC52pfM0J3RbS9mKRk1Ps2ToYCSqeO9YrMa
	p/58bRkMQEjlw22sjkk8wd3yjsN6MA6lYZP44OEcLDGkBAhPAMVqbZ8Ic2TCkrwknI2EITpmPkn
	mjs5vT7yVWXgmLasQo2ox1pO+6v/QfL0TMOSGx1HuW2ox2m8vVKjbyq+UGV/sTg==
X-Gm-Gg: Acq92OE/pPbU+/fmPN1gcCWlKMbo2SL3ld2cD2BjaV6StcH9e9pOER9xC6kSEDodjdo
	9JDx7hClZuvYif5gMcIHmhP+eTBeFK+ZBihxhfjZy8DzP+R8l7ChGuk542RoSBwL3qu1jhM94hr
	SC4IUtwZHz2Wm/oxj2bZmbLqA3Szond/Aoy0kKdt+huPRKxNHZje+r6QX26IIwvCNVRdumWyD/5
	0O5OQzGqpJhMPiURLwDKDYHPPzgEKj7kfsPr/SMmxRqqM07WU8Nrv6n9IGeWFaK8eBT+fwAKrc7
	AspXN8L+MVWLCUj7j8YDyXMUCWVW77SJuaQbNdIVXtReemcB55QtEyTx1BZWMPszruqRwN9vEZ1
	5DYI/DzHchuEnR3ojpGZ/b6KExw4LWTjVVTx8gaIC6seszbPTv//Js1853hkGgWfqBuSYUFSNAi
	1vNTuR8Uw0
X-Received: by 2002:a05:622a:43:b0:516:ea00:2eb2 with SMTP id d75a77b69052e-516ea00353amr171988631cf.21.1779820523056;
        Tue, 26 May 2026 11:35:23 -0700 (PDT)
X-Received: by 2002:a05:622a:43:b0:516:ea00:2eb2 with SMTP id d75a77b69052e-516ea00353amr171988091cf.21.1779820522594;
        Tue, 26 May 2026 11:35:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb548dfasm132928f8f.4.2026.05.26.11.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 11:35:21 -0700 (PDT)
Message-ID: <06029f19-86f3-4a41-aff1-d6fbc6a45193@oss.qualcomm.com>
Date: Tue, 26 May 2026 20:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: qcom: tsens: switch wake IRQ handling to PM
 callbacks
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260526-tsens_interrupt_wake_control-v1-0-6adcd75555b9@oss.qualcomm.com>
 <20260526-tsens_interrupt_wake_control-v1-1-6adcd75555b9@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260526-tsens_interrupt_wake_control-v1-1-6adcd75555b9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7eBZ7YCvnaU8WhNyJ7D7-36ocjH0qkz_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE2MiBTYWx0ZWRfXxrS0VCmUldcC
 +8n83h8htMuvHlcFEYco08a4XeiEVyutJMqWnRgM4mQRtj6Fxd5zXFEEZ3bzLi3eT4vdB03BG6d
 1Ypgt5iCL3kidpH7a1nnrSd5+vxNhvgF1fhoiUolCWvcyNu352ElFAw58RmPSt4GeeV74KERSuZ
 3uzzJpqUKFxygXr/S6tgEaFxzRuFxKipE6rgl08jDE/4Ly9+4pOzRMa+noFUJ6+icWUHnYT4OM8
 nMj80LgpAwQV+pYWjdH8H0CzR1epNnqtb/ELen10bCRbQlrsIHDCxy8sf317SiAC0vbasORFVPf
 MqdetGhY+DUWcjo/OT5ZRgT2rpXkjurtu8BZuKnNEIN7b2CliElWYKsCOVuvseuxeVMAXGJACiq
 YRIrj4C+k4FnmT94kJocFrUG2V1GH/pCysAKGXzyqUVgjeJE9GkwXSBPWdADGkBzVrbBazbzZtJ
 kh7K8atXy69lJ8kyePw==
X-Authority-Analysis: v=2.4 cv=VPHtWdPX c=1 sm=1 tr=0 ts=6a15e7eb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Xd9C5ExLNSSwwYgCP90A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 7eBZ7YCvnaU8WhNyJ7D7-36ocjH0qkz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260162

On 5/26/26 12:18, Priyansh Jain wrote:
> This change improves power management by using the standardized PM
> framework for wake IRQ handling.
> 
> Move wake IRQ control to the PM suspend/resume path:
> - store uplow/critical IRQ numbers in struct tsens_priv
> - enable wake IRQs in tsens_suspend_common() when wakeup is allowed
> - disable wake IRQs in tsens_resume_common()
> - mark the device wakeup-capable during probe
> 
> This aligns TSENS wake behavior with suspend flow and avoids keeping
> wake IRQs permanently enabled during runtime.
> 
> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
> ---

[ ... ]

>   static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
> @@ -1172,7 +1180,7 @@ static const struct thermal_zone_device_ops tsens_of_ops = {
>   };
>   
>   static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
> -			      irq_handler_t thread_fn)
> +			      irq_handler_t thread_fn, int *irq_num)
>   {
>   	struct platform_device *pdev;
>   	int ret, irq;
> @@ -1204,8 +1212,8 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>   		if (ret)
>   			dev_err(&pdev->dev, "%s: failed to get irq\n",
>   				__func__);
> -		else
> -			enable_irq_wake(irq);
> +		else if (irq_num)
> +			*irq_num = irq;

You can remove this check, it is a static function called inside the 
driver which is supposed to know what it does (like not passing a NULL 
pointer parameter).

>   	}
>   
>   	put_device(&pdev->dev);
> @@ -1232,11 +1240,44 @@ static int tsens_reinit(struct tsens_priv *priv)
>   	return 0;
>   }
>   
> +int tsens_suspend_common(struct tsens_priv *priv)
> +{
> +	if (!device_may_wakeup(priv->dev))
> +		return 0;
> +
> +	if (priv->feat->combo_int) {
> +		if (priv->combined_irq > 0)
> +			enable_irq_wake(priv->combined_irq);
> +	} else {
> +		if (priv->uplow_irq > 0)
> +			enable_irq_wake(priv->uplow_irq);
> +
> +		if (priv->crit_irq > 0)
> +			enable_irq_wake(priv->crit_irq);
> +	}
> +
> +	return 0;
> +}
> +
>   int tsens_resume_common(struct tsens_priv *priv)
>   {
>   	if (pm_suspend_target_state == PM_SUSPEND_MEM)
>   		tsens_reinit(priv);
>   
> +	if (!device_may_wakeup(priv->dev))
> +		return 0;
> +
> +	if (priv->feat->combo_int) {
> +		if (priv->combined_irq > 0)
> +			disable_irq_wake(priv->combined_irq);
> +	} else {
> +		if (priv->uplow_irq > 0)
> +			disable_irq_wake(priv->uplow_irq);
> +
> +		if (priv->crit_irq > 0)
> +			disable_irq_wake(priv->crit_irq);
> +	}
> +
>   	return 0;
>   }

If tsens_register_irq() fails, tsens_register() fails, then 
tsens_probe() fails and tsens_suspend_common() / tsens_resume_common() 
can not be called because the driver failed to start.

With the version of old DT without irq, the device_may_wakeup() should 
always return false (no irq == no wakeup)

Using the check on combined_irq / uplow_irq / crit_irq is not necessary 
because if the code goes after the device_may_wakeup() block, it is 
because interrupts are set.


> @@ -1276,15 +1317,18 @@ static int tsens_register(struct tsens_priv *priv)
>   
>   	if (priv->feat->combo_int) {
>   		ret = tsens_register_irq(priv, "combined",
> -					 tsens_combined_irq_thread);
> +					 tsens_combined_irq_thread,  &priv->combined_irq);
>   	} else {
> -		ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
> +		ret = tsens_register_irq(priv, "uplow", tsens_irq_thread,
> +					 &priv->uplow_irq);
>   		if (ret < 0)
>   			return ret;
>   
> -		if (priv->feat->crit_int)
> +		if (priv->feat->crit_int) {
>   			ret = tsens_register_irq(priv, "critical",
> -						 tsens_critical_irq_thread);
> +						 tsens_critical_irq_thread,
> +						 &priv->crit_irq);
> +		}
>   	}
>   
>   	return ret;
> @@ -1343,6 +1387,8 @@ static int tsens_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, priv);
>   
> +	device_init_wakeup(dev, true);
> +
>   	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
>   		return -EINVAL;
>   
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 2a7afa4c899b..83a8f3580ed0 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -567,6 +567,9 @@ struct tsens_context {
>    * @ops: pointer to list of callbacks supported by this device
>    * @debug_root: pointer to debugfs dentry for all tsens
>    * @debug: pointer to debugfs dentry for tsens controller
> + * @uplow_irq: IRQ number for uplow (upper/lower) threshold interrupts
> + * @crit_irq: IRQ number for critical threshold interrupts
> + * @combined_irq: IRQ number for combined threshold interrupts
>    * @sensor: list of sensors attached to this device
>    */
>   struct tsens_priv {
> @@ -588,6 +591,10 @@ struct tsens_priv {
>   	struct dentry			*debug_root;
>   	struct dentry			*debug;
>   
> +	int				uplow_irq;
> +	int				crit_irq;
> +	int				combined_irq;
> +
>   	struct tsens_sensor		sensor[] __counted_by(num_sensors);
>   };
>   
> @@ -639,8 +646,17 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
>   int get_temp_common(const struct tsens_sensor *s, int *temp);
>   #ifdef CONFIG_SUSPEND
>   int tsens_resume_common(struct tsens_priv *priv);
> +int tsens_suspend_common(struct tsens_priv *priv);
>   #else
> -#define tsens_resume_common            NULL
> +static inline int tsens_resume_common(struct tsens_priv *priv)
> +{
> +		return 0;

Strange indentation

> +}
> +
> +static inline int tsens_suspend_common(struct tsens_priv *priv)
> +{
> +		return 0;

Ditto

> +}
>   #endif
>   
>   /* TSENS target */
> 

