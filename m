Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5F36DA15
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459766; cv=none; b=e1+0p2RdrZBzfv4G/mqSRtwvc6EgtDR1ItNB9COZVakNmTp0wK2FN0scDQSCudpU2csC6+v/nYDUSrLzxb6v3ycGGt8yswOGnvUhmmM5LedqLsfF1scQlkAtCw+jz10e2Nd4rA0ccGPq1ZzCED/TODUQ8bFAUpWt5dz2igfrp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459766; c=relaxed/simple;
	bh=fiIzkd4DkCzSduACmyKvM8AaOAgbNhQE5sookbvgcMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lA+iJOCSR2MIA5MwWF+be/rcKC5INQsOME36FeF9tfhgWkC3I0iXNzrVqb86ZTb/yC7oNwD49xH6TWlfEg4Hiynt/nks06CjX9ioeP94O6Sv63OY+5ep4Pa4icLcOCrGm63bxMNoSQknSH9r3yNUwkKsVivmXFYTPcXnD6ML6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NeXfaGkQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cp1crcJt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NeXfaGkQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cp1crcJt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWvVU3718377
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	26Et5sU46yB+jreySryXK9wYTo7BTLA8TSZUEuTO3uI=; b=NeXfaGkQPX1Mb+Vl
	M+s2WLiS7a5DkDI2k8jzSm6YYeABaZMK88zAdG7QhPoo8I++t9yxiLXAygUOWfks
	lXYOwFa2l14EkoxR4611fZUxHQbBYUg1P1ZeaYt6Jew4MqVEClWOwykSgrZHQZPX
	2mJjmV225sUXiwvIn2V4PqKssRHofmfJX6W+SDXWy2q+gDmYu/EcsvAgpPq7JFaU
	7oxyv0p4GlylTg6slc6kunBrw2rTQxayNVpQj+5/o421DX8xyMgomplMN61oy1hJ
	xfyB0LBnxb17mZqs8vxkVsL9fHwMIdQOwZr/3is7tabqtw8shkEC+fan0FXNflb9
	zNLt8A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwessx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:49:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ce64c41efso56275611cf.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786459764; x=1787064564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26Et5sU46yB+jreySryXK9wYTo7BTLA8TSZUEuTO3uI=;
        b=cp1crcJtQuaWHIN1oFoGcQuvru8qDSDpPtCCLBifGKG+HDA53I3FZvpswxmXeu2Mtk
         Wqjtv8o/HQvwAMSGB1oOYH3/FJWUk9PbMbQ+TGcwRgvTpSB8By7V2E15YkAaGpF9t8il
         2Um63Glmp2jCiuM1h0R2o+Ua9BuvrzAyx8Y+6SRWcov83Whn80XofWNGUqmG5U+uRg4M
         S4LYZ1eU9/mBsmKE7v+06ogoM5wJD4Ft+Ox+8YSHkGSaSKVXh8DkmljzmDI/EafdU0o7
         7HejNWs5L7G8GKb3+2myk87hsqkquWLyU8eEJ1zn3Pf45y5VhvSo5uv/L4SHGHoka3Ir
         2hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459764; x=1787064564;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=26Et5sU46yB+jreySryXK9wYTo7BTLA8TSZUEuTO3uI=;
        b=JgBBuPEF7D4YrGin2b2rzsUN4FmEFCf2lcZ3MuS6tkIpz/bZMfN5Wv5VBdPQ3JWmmQ
         EyTzPuM9yQjh33ghwag8gDHvqCaDAKY9zN0pfsAQQlf7B0KQkPTHl/avdXq6ijo233ei
         DJ2EWIJ3yIsZMmd/uJTkfyyhwjVCuuBlOsI7t8mJJgbge67pateX4c0Rb0xr2CWtugHB
         aIQ7/JZq9uRPbxhVXTh3DUKyHCpON7ZaJhvnnsCyEHT82MXhanpabeNpFd1woZF0rI83
         xAHq6Flqq3TUs5a3v1YgokvGii1UFhVt1ghC3hXY1dDZeTPMLrz+GmrMEZWyb3z3OIOe
         tN+g==
X-Forwarded-Encrypted: i=1; AHgh+RpSI8hayjo4/oDzikX17lgM8bUMU0o/ph++7qCv77VgNSS1aRWqJi9yz+DeghRnxIgYMboPYQBJ/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbVkBeiPkNAxGmBv9bh2zvhqxmiPiVdeONnbVqOws1s3fp8Kc
	89E/Y1PlEdlAerUnsjuMwPWNUZJN/N2c8FVYRt+JlRXs5+/M9sHxeGBXuPSeVnK+y5HZEDeUXNO
	/jo+ECn+mLxwhD/0dJpccBjZ/ubgtdf7F87I9wJ5ylo3xu3BQbM/2OYm0wH7auA==
X-Gm-Gg: AR+sD10IobSaQOBdKcjv77xTzMopriY8FqYmCN0PjGoHVnz1Lo+h3fth+vbys7avLyQ
	8yWP1tmorOjdpcWmBZQLMoilZHbxhkMoI3bPYYkm0lOwFM5kVQEJw5rRH7t2lrAB/lfj3mJD3PB
	04OEdQN9AM99Bbid1ZkHW7SNPi9nI1yWeAIBySnZuMnUxJXun2Zq+0LXxrC+gKPOIRZ9lwcfG9F
	CvFK/hBQXXK8GcKhEAByAqzaUjmxVcE6lwocALkpV86gCXuOgKa1oA5B3etVWhgPsRkOXqCNB7m
	nJR5DCSABRWwu9YDBrEpqTLxoSPFjNOpMCfdvVkAjt496IprrRC0AqAnUWEyrIyL6RPShYaLrnm
	jZqBW5pBAOkcLVVUOCWy5wcojuBJwv4heb1SO59RgKjFc3u99/n12K9N/At1PcMo=
X-Received: by 2002:ac8:5f8d:0:b0:52d:3352:f7ac with SMTP id d75a77b69052e-52d585fad1fmr30012131cf.28.1786459763886;
        Tue, 11 Aug 2026 07:49:23 -0700 (PDT)
X-Received: by 2002:ac8:5f8d:0:b0:52d:3352:f7ac with SMTP id d75a77b69052e-52d585fad1fmr30011801cf.28.1786459763489;
        Tue, 11 Aug 2026 07:49:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b467:f322:cd3a:615c? ([2a05:6e02:1041:c10:b467:f322:cd3a:615c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977e86b55sm79799185e9.4.2026.08.11.07.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 07:49:22 -0700 (PDT)
Message-ID: <c0b20469-29f5-4684-a96a-1cb772211dc0@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 16:49:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 file
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, broonie@kernel.org,
        jishnu.prakash@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>
References: <20260811094544.2939556-1-daniel.lezcano@kernel.org>
 <sf725msufnhfdecl3ovz2grdg4k3xfudbzcjqzrw355utpq2cw@mcuxwm7k2y3r>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <sf725msufnhfdecl3ovz2grdg4k3xfudbzcjqzrw355utpq2cw@mcuxwm7k2y3r>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JycPP4c2_pF6pq2uOotFfUx0GZyLpvl8
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7b3674 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=aizVvqpepTetrpbQpYUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: JycPP4c2_pF6pq2uOotFfUx0GZyLpvl8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMyBTYWx0ZWRfX/dIimL0ek/15
 Upa8dNjTO0cR0tIl89O3j9TPMRKhMd8K2d/bXQETwTvFwg9enQ/Z14+ZLUKxkGiCz8JsdryBDFJ
 AfHOyaOry34vW7olEc6oJI4J1beTxT4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMyBTYWx0ZWRfX6oEGlvLqnMsz
 QGYsWciYCkemv0hfPtNjYkiQWLAWQeg87Biz+dpOEwrIHQkmQcTo9BFsKvE24PfHmK5B98uuS2R
 tiXvZyN2lRt/H78bzdV/CAXjnIoTgVTl1o8rM537xDrfjOG3IOgY1QDY39DpzM1bpafO/mz5d/Z
 qtLKIolD3IsHU7OgOGuKk8kQeFXFcY/LsL7GrQcJDZ9Vm/Dbz05xJasxIQWfrjI8x4PCY9ixOFH
 bxsapnfoQZA45RVjOb9CRzSgyrWYys850pzan2cqtmEkBM8ShBCjYo8iEqI6vBLO+OyaqZsLuGl
 KH5rgDWtK5jiGnwOTfhPR+YuHxknoihc/Qj5ZD+T854O3uwZIDC9i3m6SIhozsc6UdrRc0yddy7
 WCwflY40ddvE/2Yv7XV8tQH9HcReEl29cg5gyh1wtRa/sMLDWwOq6liFhe8zykErWHHXld8JBkr
 iHHHEpovnqSTUSdpWmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110123

On 8/11/26 16:10, Dmitry Baryshkov wrote:
> On Tue, Aug 11, 2026 at 11:45:43AM +0200, Daniel Lezcano wrote:
>> From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>>
>> Add missing file resulting from a manual application of the change
>> below after fixing a conflict in the Makefile.
>>
>> Fixes: 948ee3a74f35 ("add support for PMIC5 Gen3 ADC thermal monitoring")
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Don't you need at least the SoB of the original author?

Oh ... right :/

