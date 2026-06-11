Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5D3D47AF
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174597; cv=none; b=hRQbL4w3wH4DScwD4Ji6SNViMzxbjvGSA3Sr9NQJbsUyAQUiujlZvtL4voVFMuiicXuS+DVk1bBCNItI89Qq5NvAKLbJEVnAsVxZYc2c0rieSOUnzXuXHjCEV8bbAW1u7GypjSVssOt2j0LClV0yqp3sFj0uEbZAFc2yXbx6hX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174597; c=relaxed/simple;
	bh=zmNw8D5zWNdKNVzgv5ao0F5vgRAQeg0ZOCSSRFKMbzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnsxKGND7M0WwtoCzG3nZG1EVg/xgt1RzU7QO1fJf0n6o86bjcAUkf8D98JkPy/113lBYP4ZA60T0uwv4gHRJWr7RsnpiWQ6+CJ7g/dz1mQkw+JlbpZKq1m+QYwjyr0yJoRHm4SWShSSmrg0uNfyaW6ZxJR9d8P2HnvAYHunVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZYyu8GuP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RjL5FUiV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZYyu8GuP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RjL5FUiV"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BA11rw299664
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 10:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kSoVFawRRZBWzshRPZGQRk+ptUMUxsYND+WmlIf6M1c=; b=ZYyu8GuPzXmQwecG
	/46W6j0yy8QoY2yaWBVkoaYJXyPoCqSUqqpO9TuoSDJRCjod0KVPEiyxxZa8WL9n
	uu4bLqwh3zjurJHH9r5RW92S7yGrOoJk/5e3RtqHKzAGop7yjCzuBmwue5yBKy42
	p53S98jB4FJQz8l0J/XujeMMqHfOOoHPNsh6o4XdLKq+TKZUeA3u8qxE2urYwpsC
	7CYjLJXCNO9soKoPQxaM818l78Mo0jkNUmaSd/bcwy8F01lpGgy+BqMyFh8Yw5Ta
	7Tmmt30KqitKhXN78BxlzEznoPwUibWyEw6A9/qEUye7fig7M0ZwNc/gyMxBPK+y
	CyP1yQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe702y8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 10:43:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf0b7425bbso147908035ad.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781174594; x=1781779394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSoVFawRRZBWzshRPZGQRk+ptUMUxsYND+WmlIf6M1c=;
        b=RjL5FUiVqvr7WLuaqrZ9pv3fTyXWxAGxNZn+S95u/meMehKhLOipxdTx8X9RjNfGqB
         PWS6wpSazkPY88r1c0NAXyJ6vCtX98tPSA9ifYlgPmlqP3eAuv1FehK/a9fj0mSlorhX
         DO1H/wcuUC3qaoEU45/sl4lOHh9ITzTMGGQKTga7GM9fu/99rOgnvtAWJN6WHLzU+mot
         XZaPL/x44jDJKlbI+yf3GGi4fSVJgq8NlZBDlPMbMqo2ISoAPB/p9Z8dLppeRr9JVi8o
         LJ+9w39OJZTlVG8D53DrWZTrwMMTs8S3BSszGv0gYDTIO/ULAH6MYlAfhlwjGuKu62kA
         uXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781174594; x=1781779394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSoVFawRRZBWzshRPZGQRk+ptUMUxsYND+WmlIf6M1c=;
        b=kMMDMcsxyO8/9hL8G6NkeLSu74kotNaiUVqrzeZtVBhT0dxmH0gEvVE5ID4R6K/Yzs
         6ZlPpwnRhkdCgllKyt8+I0GaUMOMD6SX0L9Sq2987l4LDUwZ/pCanqXzdtc6KpOyJPSv
         wMCjW+2HyVAUcvGXd11UUI9acRcOT+qXho4JAmlNvNR4nGt9IWvhGMUsUhMRBf/J4T+Z
         bNkxc3rpMKKpNcOBD/qyK0jVXVQXKNpABn23MideAEB2l1fzCQw6d7m3GjeinrjddOqM
         +FSN5nyM4PqA8172kHzD0HCF5GmQkgRVGQkLWCFwHtI4Kvr4JUHYASDFb+SdicSNjIpm
         J5IA==
X-Forwarded-Encrypted: i=1; AFNElJ+Eru+TrL97ocw6RSjY0PMHDRX3fTZEg5ehdozBUSPXMC352j1ZBkZDBGKTjQqJaewCRVYm3rLDWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuaJ63RNTFqf7T06WcLOVMGY3LxLT/7nzbCqXL5PV3KXe1/ohj
	/Dc4ZQ9fzGS2Sr99Yj0vqwXjg8Eyz32JJu8dCW1uRWbkcgzEPgnY0dYA8fyj/yIxuW/yFkvJEDa
	MAvNWJtYJ68Ty1jR2Wagcgrgo7O7qb+gCopuF36YDcNXgDTZwdbe9hyviLU3H7g==
X-Gm-Gg: Acq92OGHqqDT0ANRPZvq/s5RymmOh08ZhWZBiPaVy4SvPlWt5oVUjo0VeRIEjYcr11V
	0wcMlur8sOlM2tLLZd16zZKS0awYiIFMSxDUU8CbKnY9aldJq0z7NehYX55QOr2ecqNNXqeRXcX
	+bpWS50tFPifKAdMhLZD/PV0DkFmSggNxJBRntg8GJ43KA8KZFig2UrGgPHOsj9wcaQgkhZvzLQ
	uzv5dDbdHSRZwTI6uHYK2b8isrtY86aqqw4QEshVLTEXNdImQ7JafLZUGW2pp7X7vo/7PPBNGOA
	UCmEWNIRnB/ndvGaZlcYV8kh5GlCx2W23CNQLLWITzpk5mt1ZxmQYaheEUwJabi/N35q6VnZfvy
	Hj0KaFpHWnWk+9ruNlaSw9aK0D24VCaiEiSkv3lX4eN9qqETfHuLXvFWjRaB8VJsA
X-Received: by 2002:a17:902:c40d:b0:2c1:4d9:c8db with SMTP id d9443c01a7336-2c2f51c94d1mr25512305ad.37.1781174594281;
        Thu, 11 Jun 2026 03:43:14 -0700 (PDT)
X-Received: by 2002:a17:902:c40d:b0:2c1:4d9:c8db with SMTP id d9443c01a7336-2c2f51c94d1mr25511865ad.37.1781174593840;
        Thu, 11 Jun 2026 03:43:13 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f84335sm273881735ad.19.2026.06.11.03.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 03:43:13 -0700 (PDT)
Message-ID: <d095233e-ac2a-4b50-8a62-29fe1e36c2d1@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 16:13:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ
 with ADC_TM auxiliary driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
 <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
 <ah9ouLQFI7VtHCWL@ashevche-desk.local> <20260604114630.23ca427a@jic23-huawei>
 <aiGPMqHcz_AkUezI@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <aiGPMqHcz_AkUezI@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cETKs6d55EkevHgdt8OI0da_sfsm434p
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a9143 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=QyXUC8HyAAAA:8 a=8gGmNC2uT6na8rc2OTkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNyBTYWx0ZWRfX8Dq6KMYDY56A
 BW/YUKyecrdUbqZjgHmZIRbtItPaFa/dAI1RJ+i1CnjgdB7OxOzJngQN8DaBJguZhxD1G66rsRo
 Oki/ELspCvXv+ALi4Nn44/n+4PeRaLvxSeyA3/bcH3tmwghAuvXCtE0PM4mKU9SysIaNIO5wh9O
 Xn00VgSNIBQpYqzvPt/qPVU+NLN7VDwpmCMSGkta44ox7tiKpuMlWZbrn+LsRTL07BWfVxzuXGl
 hUY20erslOKfse6scLKihAfqNFWsfFQoGAwc9aLREI3tub+jfZgitQJwT1K4KSN+08uJWlyDIVJ
 onSfgalCHjulQWeUPTeh/CfhUCOwI1KR1FGKnTaPnOvqnAFWY+MBE1thYGtf+6g45qVq+t972sW
 J4W72LCp7fImGZUORu3+PzUCAVXjYuf9VDLWnEn8Ap+wBaJ4gYZykvA3blgIfL18+j/zkNCYyRK
 cB8VFu7cpyYxAphz/AQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNyBTYWx0ZWRfX9BNY+2LV6+di
 D7qWXSC4HaOE9U56lICqliCGRpvvxIxWIftPT5YcNC3jvszBhofZMve4wOvLttpANtmDyu5G4V5
 eSACrhutDM6SnbQOMH3D+0hivmHvliQ=
X-Proofpoint-ORIG-GUID: cETKs6d55EkevHgdt8OI0da_sfsm434p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110107

On 6/4/2026 8:14 PM, Andy Shevchenko wrote:
> On Thu, Jun 04, 2026 at 11:46:30AM +0100, Jonathan Cameron wrote:
>> On Wed, 3 Jun 2026 02:35:20 +0300
>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>> On Tue, May 26, 2026 at 04:26:09PM +0530, Jishnu Prakash wrote:
> 
> ...
> 
>>>> +	ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
>>>> +					NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
>>>> +					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
>>>> +					adc);
>>>>  	if (ret)
>>>>  		return dev_err_probe(dev, ret,
>>>>  				     "Failed to request SDAM%d irq\n",  
>>>
>>> Also add a patch to drop this duplicate message.
>>
>> There is another thread going on this.  It might not be duplicate
>> if -EPROBE_DEFER is returned.  The message won't be printed but it
>> will be logged for helping debug deferred probe reasons.
> 
> Yes, and I explained that it is duplicated as long as I understand current
> code base.

Hi Jonathan, Andy,

After I checked for Andy's first comment, my understanding was that
devm_request_threaded_irq would internally call dev_err_probe in case
of an error, so this dev_err_probe print above would not be needed.

Please let me know if it's better to keep or remove this print.

And if I make the change, shall I add it in a separate patch
before or after this patch in the next series?

Thanks,
Jishnu

> 
>> So maybe we have been a little too energetic in removing these.
> 
> Or maybe sashiko consumed a bit of LSD :-)
> 

