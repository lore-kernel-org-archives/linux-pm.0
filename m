Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18E49D598
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671610; cv=none; b=WiVe7UVw/pjj0RUJslBK2yeCzO5iHH8MCvrCpenB6LX5klrs3fiL3GuS1XaNpAL4KCbjUFJ3g2IupOtNUVDlCXlTmiaktpotHQMQSzwwYsGBFjuf1sOytER1J1yXug8My7fiHR7zy9B7IMRzMae0WVH/vKK47I7kQBfHb0hGXgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671610; c=relaxed/simple;
	bh=NH4s1SWYn6fo9GjxuFogJLV9REdmr0FVcmwRn2mbUs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOKoaDcFaBsq+HodK/vbUwOYw4ITP7T1EKHLByGsgtpk+CfNmQbQrF5Dziv3w1SpMu6HOe3f7b4J8N3ccUz8ZsvqHS6A/IdnFiddOjf/pnV3Ln5zOXJOzJ8hWpOxbrPEp05U5/4xl4P5qpyf0zKz9T4abXX7N0ku2/+xYVE7qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlK9Suhq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EGs7Ipyu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlK9Suhq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EGs7Ipyu"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7TrUG3684701
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HKNQVnhogHvJ9Iiq7rPTbsN/SrZ7qlj7dmwTnmaWVcY=; b=hlK9SuhqeHIHRR4E
	tgCAqi27vqwIvTu16Vu6dSlK46JjhquepNiZ0LlvOAqO9pFuf3YKhzqLQIMIdRdG
	/23E6vlrOkfnEhJFSLs5ekqP9mB9xdYhxIQl64AsWbbyOmD3Fh0DdAnhFgFXc69s
	F/OcwoH73+CG3AfGLtL0Z1YKQLrGCP+LGN1Cy6BUMnFd59EU6rL/oj13BJROLu5+
	h1fjd8ESKXrKgZg+y1+MQkwwrLOVfhoulaegbKBGEXY6V7cjzHqQMke1SJ/iNyjy
	6Rh/VnyS9XCd5Jvxz/mzZD7zGF2AU1QlE+9UuRjFD8XTvvUzMtRj+SNdXkXzQ25T
	tkRmNQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144t1p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 08:46:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a3f673221so1118153785a.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790671591; x=1791276391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HKNQVnhogHvJ9Iiq7rPTbsN/SrZ7qlj7dmwTnmaWVcY=;
        b=EGs7IpyuLRz7IscVLEKmwUTPxN84x9EEFHbK0YIol5rP+tFWpbU1gxxAeI8al5hCUu
         nDXAGF2aLlBzTDq8MvSifv7Y2P7kV+zwCrnwMmizKsHJ2C3puTuIo4fiXJJ0rSGGr7GB
         erE0KrYFeaI7EvvPuf2r9d6tjzZC8Z80VL4YaRqu+VWLLvN2euxGsbahaDCawYZ2YJG5
         D1c4xWoAMQbepYjiYmbDAGTjo6+UslOxoZXCLjWVkKKWCxZtQFnXlDL+5A3mNlH/MzoM
         0IjB+SbXlNE5pNBeX3xe86GDEfavTaC3iAAWQXSd9VgP+AJqhQ5+4dg/nzoCh2M+mIoo
         1rJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671591; x=1791276391;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HKNQVnhogHvJ9Iiq7rPTbsN/SrZ7qlj7dmwTnmaWVcY=;
        b=w+ntwXV8U+spiyvR7YsuPwqQKh1bH+yDWEFR+IDMOumJQmnC8OkiaZDosxD3XaVoY6
         ErMI5Wc+lTGu5OxtAZya1rbon5qlKY6cHe7rQpckZizWcyr3YD9G85fmRvqu2lFtS6cX
         yKQt3s+Fdi+JOz9dBEXIBHPzFLUIHs5FAWfTn1p7PI95ocWbGmlafn12Jt7bxzC+0UCW
         r7Jg8pvnGFCsEtgyZo4tswj6hs3FbLH880O96nGlGzjIZZyiXTyd8FNg9hTjfmKoIrfp
         Qf9HO6MzfEYwo/tpN3nRUH6z51PmwksZ58wiRyR8iulC4Dng3LS/kvs8NroTJn3wjUNJ
         QYZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwD0xzvtrkQ/XQOfS/XI8kHm+AjVPO390uoX1xy939x9CU9zWN4L05XC7TGdWDszaxoQjkRTuikDw==@vger.kernel.org
X-Gm-Message-State: AFuF++my6acB85hdrs9zDqjMMnNhVXlORE8p1XuFDIY+gOcORe3rP7k2
	LBFlx5wgUY8145+NWuDpw0cn+LOxCBRUy3rIaKtAh0rgz6DzCwtq4ntaePE9H1k87fRKR9yPhUs
	TdWEoJstc3ma4M4T3fvxtHiyEglOf4Y8i/i7G70WGxezK1X15KmzF471w/dGsdXXlr6Pfvw==
X-Gm-Gg: AYBFou2jSfN0YkGMisc4iK2zhrVNcEIIbFW+IIk2z8oTqgi/bA1V7i/iZynh2fUuyEc
	7+KRhQh8Fl8clTctInStKT6gJVRvBvSUNGvbCUUPo14RgkUZa9D/W6PAdQgqo0PAOB07vj3AKIu
	dUNrlI7vyaIna4nWFynWy50vxPGVhPmhJy6DxFOXcJBxsZPn+Ny7cTC8/cwfynsXe7aDPe4TuGY
	r29NyTkfxrP8Znb/VJ3FNVFJD+AIvAlA43p2UEKI5s6GIGvaLNbwTuG/64GQt7SbwyYFVXDFEwI
	cwGGXVlUF5igagHHGjHnqIHGU+VU6m3OvVD+/9CUST58wQ659xklf7jHJ5OFvsM2wdtUopivsQk
	FvAJ//QhGRECgqQ/WI6aP6l+2J671JwgULoxYPalzQsa6E+kulBRQukqUuZZHMg==
X-Received: by 2002:a05:620a:17a1:b0:939:6de8:43dc with SMTP id af79cd13be357-93c47501d08mr2453023385a.48.1790671591520;
        Tue, 29 Sep 2026 01:46:31 -0700 (PDT)
X-Received: by 2002:a05:620a:17a1:b0:939:6de8:43dc with SMTP id af79cd13be357-93c47501d08mr2453020085a.48.1790671591013;
        Tue, 29 Sep 2026 01:46:31 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f79dsm2420041f8f.6.2026.09.29.01.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 01:46:30 -0700 (PDT)
Message-ID: <2c521063-9f79-4c6f-a9cc-c1128066aa6b@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 10:46:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/sprd: validate the sensor id from the
 device tree
To: Weigang He <geoffreyhe2@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260926042757.2109927-1-geoffreyhe2@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260926042757.2109927-1-geoffreyhe2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzNCBTYWx0ZWRfX1LVB93Ef4RPU
 712is+zaRhIblWux7NiVbZNhMXct7tmANVu0lqdd8Hkw+seoLxsh2dMM5Dah+xY/EGpHKiSf+av
 T0392bUp54zdPpI2tdSqn/SAz4jO0Yx9hVBjmiFm2Jp5ly9ojAEQ9JM1n661Aa3kvEFN2hi6ugP
 JZQ01rgHiNkF4Q12FbuxfUFjZr0mFzRn7/xszaeffJf26t6etTXoHVPqJRRpwd1gZZKA/OlrXTJ
 TyMBUrmuDHVDv8KfnbJa5vfusBndJyIf1CRsOkBS7DpDdw0bzNxenD7bKfNk2ZDxKjt/YWMexHj
 C4QVUazSivsDYijs4sx9Na2X+w6gjPuXguIImTGLG1ThVBL9nlGMjS//3xg3nFp5xqvv7Grt7Ht
 0qDvzjdz6pUCh8FKkw6ojMqhe00g9263mwfUP5rTB5Tj9kvMEt5vJpF0Cd1Rb1R+rikywj6QJOU
 a4Tbq9jdwqX5VymqyMw==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb7ae8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=2j8HJEekVYGnh1E_RN8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: jQmgOydC0aWsGv1TcWZZyU1sVa7z-9g_
X-Proofpoint-GUID: jQmgOydC0aWsGv1TcWZZyU1sVa7z-9g_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzNCBTYWx0ZWRfX/ALnh3k1YTox
 036hUqVlCw/WGw3nXaBWJAGtYdXYSPK/HsJQJ0Hv0RGuxKg8AsIspBK55Df0fn2xo6Rve0f53hq
 Atl1UvIsP+vwUrwlT2FmyBbpMDn3p5I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290034

On 9/26/26 06:27, Weigang He wrote:
> sprd_thm_probe() reads each sensor child node's "reg" property into
> sen->id and uses it without validation: to compute the sensor's
> register offsets in sprd_thm_sensor_init(), as the thermal zone id, and
> finally as an index into thm->sensor[], which has SPRD_THM_MAX_SENSOR
> (8) entries:
> 
> 	ret = of_property_read_u32(sen_child, "reg", &sen->id);
> 	...
> 	thm->sensor[sen->id] = sen;
> 
> Only the number of sensor nodes is checked against SPRD_THM_MAX_SENSOR.
> A "reg" value of 8 or more, or one that is negative once stored in the
> int sen->id, makes the register offsets point outside the sensor range
> and the final store land outside thm->sensor[], overwriting the fields
> that follow it in struct sprd_thermal_data or other memory.
> 
> Reject an out-of-range id right after reading it, before it is used.
> 
> This does not address sparse ids, such as a single sensor with id 7:
> they leave holes in thm->sensor[] that the later loops over
> 0..nr_sensors-1 dereference. That needs a separate fix.
> 
> Found by static analysis tool CodeQL.
> 
> Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
> Assisted-by: LLM codeql
> Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
> ---
> 
> Notes:
>      Compile-tested only (ARCH=arm64 allmodconfig, W=1). Not tested on
>      hardware, and there is no reproducer.
>      
>      The CodeQL query behind this report was synthesized with LLM assistance,
>      and the fix and changelog were drafted with LLM assistance; I have
>      reviewed them.
> 
>   drivers/thermal/sprd_thermal.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index d683fcb0f8ab8..b57277e2eac01 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -396,6 +396,12 @@ static int sprd_thm_probe(struct platform_device *pdev)
>   			goto of_put;
>   		}
>   
> +		if (sen->id < 0 || sen->id >= SPRD_THM_MAX_SENSOR) {
> +			dev_err(&pdev->dev, "invalid sensor id %d\n", sen->id);
> +			ret = -EINVAL;
> +			goto of_put;
> +		}
> +

Why is there a mismatch between this check and above in the code:

         thm->nr_sensors = of_get_child_count(np);
         if (thm->nr_sensors == 0 || thm->nr_sensors > 
SPRD_THM_MAX_SENSOR) {
                 dev_err(&pdev->dev, "incorrect sensor count\n");
                 return -EINVAL;
         }

(note the "thm->nr_sensors > SPRD_THM_MAX_SENSOR" instead of 
"thm->nr_sensors >*=* SPRD_THM_MAX_SENSOR"


>   		ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
>   		if (ret) {
>   			dev_err(&pdev->dev, "efuse cal analysis failed");
> 
> base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
> prerequisite-patch-id: c5a3be8688fd8e88a00352acb1374e91fcb52a03
> prerequisite-patch-id: 67693e2c08624df0841619cc085ce9200f4385fc
> prerequisite-patch-id: f3d73f7c19be7e952aa8061303f53f9a08576a88
> prerequisite-patch-id: 541e578709d048f4c8115f1d926be2f2c03ecb0e
> prerequisite-patch-id: f23f8e0693435497645805822d98a92e57fb46f3
> prerequisite-patch-id: eae82895db8ba67018a777a91a283ad6bc4a55b2

