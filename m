Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869147B431
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578171; cv=none; b=sINPUPJAdoiEUVwZjtdl8judRx4+E8W4f40Q4Rud9O8hvXtpZD0e69Z0k3ALddQZd8r+UgJ4Yl8xy9h4OCca+meX82QinM2MpccPbzqGLJsOKCqXSF8zLWwzSamCWYcnjCDzZkrG9q7pftBdOk673Kaj/IhWbhHs6SOMjtd9DaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578171; c=relaxed/simple;
	bh=zJnQomuSfN7/wfctZ19ldu1++m3nFdjsnCQ/M/br6Uc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CEeYzJHvQoXm7jRCFcFA7n8v+aY123aR3xTDc3op5M4WPWLPDwJph7HSEcfxoDvbvkE3AiZ90vjbVeUz+zh3OOiK8rKIsmxUEx86N7z0SxdWWwfJVdGNTMzP4+sF0IGG/RHBBN55HBSlnb8rtateRisSg8EpySD5RoW2mCydynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AuIQRVYz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MvSLKmCU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AuIQRVYz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MvSLKmCU"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5A6SX2186641
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 09:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kOfGUA1U+yVoivEW94YksxDQ5Bn1/eVfmM6Ro1Ad+xI=; b=AuIQRVYzgBa37cSi
	hrwPu/fDtmhgDMCWUASpT75lZS6V0hxl+fAtl+2Ca9427IaEtNbzekjDtUwwYaGe
	PoOwj/xnRMpdNjP6ItTTnl1mbyor+T9VEVBokLgCOyQPzn4gZsCdl8vdIQ7T8i89
	VfYfs5xdi5MBih4MfhUtemsUqC/MZs44cPQ7Ephg//fjmhfAqbLR2jmwOIbpBxnY
	1EnUQIdHeXZWK5VkZsIjd6cmB/Ao2Se0PHLLaH42CNc0jOYoqCXz9uZa1FE7Wer5
	KvaqbSsicHScITa2Axo9Q0dWldlaFFCaG8E+rdbDRpJ3cVdyGLg7o2zWLVLEe5Cf
	IpURXw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv2ahgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 09:29:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-90ccab62c33so83661585a.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778578163; x=1779182963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kOfGUA1U+yVoivEW94YksxDQ5Bn1/eVfmM6Ro1Ad+xI=;
        b=MvSLKmCU+O7IUCYXb1aYgS9i6EWkfUlDzawqCVgy8tTWyV52a62Dl/3QL3GeHWbsHq
         Jw4xzMDvF51A74XAdVyVfZivFIxycXxH52KSF0bp9jH4KNPVyOGMNWIOFimHFclE5NBD
         WxgEBWZw+wtI2ydkPjj05Jg6wlBlNoqIgVDzAYsIvlAV/wXA6aSGfatkY4fn8ETK5CS+
         uXHzg+1LZJ6wpgNq7vjcESEBAnLbldswVGF3ypSMjBCtz3jN0GGjXfnYUgBwtwJzmVMI
         +8DpOnEOiDKEMv737ZEYgrigRa3UHLrIMthXWbbNJD7PFL37JzN2QcDYVYdhJh2kVPw1
         X/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578163; x=1779182963;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOfGUA1U+yVoivEW94YksxDQ5Bn1/eVfmM6Ro1Ad+xI=;
        b=QBEbmTcDi/QiOZyArgPOLEDv8ukWjXTl6kgQlYlqi9fzFGJ6MEvxxXDhZTj0KYdqTp
         7/qSjNppnCjKCPdnZK03HRcTJ9TRlUEVHocwe0QpBo3YOmxFxP9Yde7AX9xEyCMLxp3i
         CPbNRsc9n8Tw+wqSd8GJUGAx4juem0JrV3gZSG9TIapxWYW0sVq/nHEjHRAhkyDG+NBa
         tNL2Ifr1yOxtpPTJuiBv6JQi733bztkCr9/pENA1AkBZK6wltomMWqZ86MEko07AoV0M
         b9FSxoik6nsJPBbboN+AHrtSrlPvVRJEV6nQRh1FW1amAY6sNWm5zXnCH53irKnqUVIC
         c8Ew==
X-Gm-Message-State: AOJu0YyY6Rm89UEcl1d7m/z+LOtzgCSIdM/JR3yXCcWvxZSXaLb3TNOI
	qPBAn6k+pzif79ok2ov8HSAOzzIX0NMebVz4+Pdv4eGMkcKVh/ncDBYTOj14TcPIUsWyy9Ei0tO
	o32GOeMo/WYDGE7WSKCfexv7eTUe2CL7Xe28PhvHKCAwY9XEDF7XtVaGWW6bDQA==
X-Gm-Gg: Acq92OFgzvuO+9ki7SWStfYNjbA9fRC4UUkt8yOpbAuy3saRupp31chGonkpbYLlbCs
	JCphTOmQPcAEPEo6hWac5n4QqUD+t42CX/3A7uqOeC7khiAtFOvFfdsmu/gO+pHIUwm2oEvYJkL
	G9lPfBV8RLEukI7ZqmnMzwsOy+GcV4WHuOjw7pfYfG32/nrj3BUXNLAKEyKLGUfud8fDhVLF380
	kAOrBx86cjgqoMKD0IulO1N+ZAdxhWcMNCYmHnc8FgzRgmGeaQBw8umFAFW8wE0zBYGAD6tYnQd
	5syW25bNT5Sqpzghk63HTbGz8s+EfqqMkthTapqrach/RuYDz/OzBAnX6SPwRL1vtJ4XTnL+cm9
	vuq0cKy3bgbaZ//maqEMAGaui+eMGHKZ4hnzoLDJtwj1lLQicyWm43YOz66BGnFVzwrfah633iF
	c35vRh1cQg
X-Received: by 2002:a05:622a:12:b0:50d:9e36:f961 with SMTP id d75a77b69052e-51461c26170mr378830261cf.20.1778578163454;
        Tue, 12 May 2026 02:29:23 -0700 (PDT)
X-Received: by 2002:a05:622a:12:b0:50d:9e36:f961 with SMTP id d75a77b69052e-51461c26170mr378829841cf.20.1778578162962;
        Tue, 12 May 2026 02:29:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906a0615sm30214385e9.2.2026.05.12.02.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:29:22 -0700 (PDT)
Message-ID: <eab8dcf5-080e-45c2-985c-b0711185bed9@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:29:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260511071024.3130247-1-priyansh.jain@oss.qualcomm.com>
 <06073a6c-1f75-4dad-9309-9bc47a2b4708@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <06073a6c-1f75-4dad-9309-9bc47a2b4708@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oRY0-8sTyYXv5kXft2MhGoICKWBsPfnM
X-Authority-Analysis: v=2.4 cv=CeM4Irrl c=1 sm=1 tr=0 ts=6a02f2f4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=FdPw2Um4bHU1Oq3-VtwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA5NSBTYWx0ZWRfX6lpfgGz25g/t
 kbXObfNlDfMGZGv6IO47l4mAnrjs02lfjcSxSRi7aCfTA8u0UHUxkw86V7/1z8xDSO8+fex/CBo
 xiKOoX62GdWqpkSVBTwISJjwTrFfirJ2Xq6roLvnRKKZPeOCjqqQrnCSHV3j95rVlj4npyKie+F
 1Jqb1NVPjBnSCuoTI1lRsE8CbgODn7FN833ew3S4K5rcTmFj4W9M90SzIUAWddE1fd0EA4UsGGK
 hzgwakhAqUpQmgzBrUvXCz9PYeYrurzxU4xGKLz8ICstKWcfCMoGsQObSL/m5Uq7x/c5LbHloRH
 GIItsLEHsYebUbrQ36MfUuvqiZn1C0hY7bFwT+918QpkpBH3KGk7vAkCqEJhb+wVPnI0uAb7/uM
 cwSXObYw3X792m7gbreLr+UkbbsMidphetUazCslTK/L35l4tLeGfJem6A/MdOi3eFeq8yHB+rk
 CqiSse9iFJXK2JhzRkQ==
X-Proofpoint-GUID: oRY0-8sTyYXv5kXft2MhGoICKWBsPfnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120095

On 5/12/26 11:19, Daniel Lezcano wrote:

[ ... ]

>> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
>> ---
> 
> Applied, thanks

and dropped because of:


drivers/thermal/qcom/tsens.c:819:9: error: this ‘if’ clause does not 
guard... [-Werror=misleading-indentation]
   819 |         if (!ret)
       |         ^~
/home/dlezcano/Work/src/linux/thermal/drivers/thermal/qcom/tsens.c:822:17: 
note: ...this statement, but the latter is misleadingly indented as if 
it were guarded by the  if’
   822 |                 return ret;
       |                 ^~~~~~
cc1: all warnings being treated as errors

Please next time test your changes before sending

Thanks
