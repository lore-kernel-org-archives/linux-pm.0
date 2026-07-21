Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A1397E96
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644195; cv=none; b=mYV1L6n9YbWfrylLhoRhP8QHzTJlnM3aEVka6sr8t65PHc/LO3cv634LXSCywXC0AFghWn9a5gBkXW4Qn1LqJoqw+5KODF5dJ6GJvZopBFP5Nwpc2uvseZUYcYu9cIlyHZnFOWY5ibexroozVXtS7CY0H+q8I2APDqArgPxfJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644195; c=relaxed/simple;
	bh=Qo6asdBsJFAV0Lv58WwH8JVlF5O6ZEi9Xu1l25YSNHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ia7jykkRlICn828qlLSXyy/HZ7sxnQzSlGqY9dqWYQKcTr8ISJFFkfxTMnDaOxnsv9IW0erOKvLFgSio1gaD2CeT8wiI7bpSApAESA7maD+FGBaifaU2+xW5YCEVMt6ny2qg/4ZWDG6/4yNnv7HL7onRXWeFUn1/oH+Iu0zvHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H35NjfHO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LQkNLYIZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H35NjfHO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LQkNLYIZ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDfwEp1707182
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 14:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UEeeYWBcq3yKMtCBpuULdCl4OrC79zsAccK99GHfkoA=; b=H35NjfHOWu48YFiR
	1DrnUwAsRLGTZl9PAJAZawf9ic//r8Yz6n5B9iCcUTvzxmtmdIxWafCMkHAdiBd7
	z8Sonusa3d8MXQP7MDa1zsATYsAA1jc4JygqyshXQkyAQXZ1XvQ5cGFDuMOxZGLa
	AoZx7oOnHxrowfYfkS6ZveOMkFjMlOel29yTPpOqrwC+pUHXTc3JRkk+vTuvrgHb
	JlJwbFvN3LgRiaSRoFhvfGEc/1yUdkbtSN2uDeqz7r92Z9MXqtZf+2dwb+5L9A+D
	mOWutJiPsMUN4gd/sa/psro2OJfbFW1QF2nD5t2Qb10Y8lYT4EoW0BxSo5tYVfYW
	Xto03g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9ae8dnh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 14:29:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930bd2bfc45so50024885a.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784644193; x=1785248993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UEeeYWBcq3yKMtCBpuULdCl4OrC79zsAccK99GHfkoA=;
        b=LQkNLYIZsjlYITMIU2kgfuRhAvnRRP8d6frU17bia+PmBkJFK/ysVFitcoLnf056i+
         dhMZTtUnMqImHTx4HiLgh7xNMCB3a6ukaSwC5iZvtIU9GJ+Z0ONmF/lq47fCGHVdZtgr
         n68upyanSqc+9V0U041CifJNe1ID6UR+I9Fhk4I7ADRJ2g7xE4FfzpSK+AWzMCeLsPLg
         D+wk2EsNZwPKRYnPG09EVgQk5OjYxUkt0wHKLtHf80k8OabN6eZ+PbtvYdvAdHWTU/ij
         dyxSY7H58E7ONqoOSIFdIJ0AbO2XtkqIXY3aIX9SRBW7Jkk0nY2mjy1z0VjeUJdcZN/C
         Robw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644193; x=1785248993;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UEeeYWBcq3yKMtCBpuULdCl4OrC79zsAccK99GHfkoA=;
        b=jDVdreJy7EnOpGORMjy7d1XUB/tH8xnAfVG3oEbL0Wh1+4Lu6hYvJIJVHwXrRTg9nM
         WzrC1WSPA0+/sLLskoedXqaObxF0jBvxNUTovd4avWO2NI+DSjFIItYWb4dbKNN8nT+d
         q9j1lJVPXBy2csVN7dlifRIhPTy7Kle7WRghgG7b2a4M67qFWjq/XxlKCwhoVEgdQAp/
         4/ANEES11qHB+ehVDfbudXi1CcjEyo0U7QYqKAakzgs47VlmfwrZtePU4grmgZ//qrYe
         11RCgFvOqicaY/PJXb9GuJXHO3t00zjxYUBzOD5NcdMrM7jOYcELl6CLbAVMXm6FciUU
         +FHw==
X-Forwarded-Encrypted: i=1; AHgh+RpYmlEbpOnEsoUoXupAqHjOKiTcEKw78OB6qpOLG5saqMian71dESAJ0lY17Szm7a+shzeRci7hLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UDNLomeUODKJX8ZSwnYrtj+F02yfB0GHdQ2fMbX+VWu8an7G
	W6SWwTo3pF6dAgu8Brme8QGiisSYOwZ8aBfkJXVhILEn+ujMgMnfFnFQfESnlAjVkDSR7px4FNb
	70s7NHItMXqP/2FZKKLt+Gt3v0MjyAfNZQJbh4oqNkny1pSVzR3tcpKmtzOgsRg==
X-Gm-Gg: AfdE7ck8hG8gy0WA4wWo5IaSDD3NGj1q0sAMIyrYp/PenCwMlckI2x8T3p23Xn+BqCD
	sKUTLUCpdjVVmRqclcSyU2yGfdJ44Lq5jqCduRFksVrdfk/Z/6wgMYlMLMwMf4UnjZvnAjkpDyA
	vJFnezG8BKhXZ+MeohJSiRgs1bSOEXchKd/EajVmzef386igve3kztDYAF6eonNmCKhzccYYc72
	T34QGgK5RNd9fZwrTq6CdEAm1q+07ACPHxA9V3XhhmUDnS/sW6w41U2rEscF81CJANqmjgx6Drn
	uGGRkuiEWDmBF2FlKl/cMH8I9UBlDmvDv6prf1cz0xBiB9Rbz7+rxmF/h6PkzBPKi3GljEu18Gf
	EDpISsyG3fgfH3unqSn08sWpf
X-Received: by 2002:ac8:5f47:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-52674e0c561mr27287681cf.7.1784644193091;
        Tue, 21 Jul 2026 07:29:53 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-52674e0c561mr27287371cf.7.1784644192705;
        Tue, 21 Jul 2026 07:29:52 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705a099e7sm598982766b.20.2026.07.21.07.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 07:29:51 -0700 (PDT)
Message-ID: <3507b575-0f66-4542-b86d-431763b237d1@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:29:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
 <20260721-eliza_evk-v3-1-92b10038f13d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260721-eliza_evk-v3-1-92b10038f13d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: isB6mZP_PRO-HFxpPzK-mgNVMD2Ow3NO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfXxzGEr93Gg3Ar
 xCJ+z0y1wHe+bWjMCp6+7Aazp5GW7phdiJmdc1nW//xeQIof4nAM5AiwHIhRrLj01jsdWZovSdJ
 HzZoepTi0cV5b/ummdgBtwmYB/ntMy0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfX2mGphn5cIjY+
 GIWHwoPs5aam/+ga/kQecn3pyEozZYvbjGFB7TBYWcS2G3F7VjHeVslYp2G7PHku3ot+F8ajXIc
 2zpzFmkj13BtiZFxbUahLqdocDYlWXUlNeSNy/5K/i7YQyXisi1H1THPk/RA/nchIA7r5fxIG27
 i7UNrodYtTeM71QNqgfZNS/r9HuA0FD1w1NPcX1E/2MSsq0m4k3fMl3qhKn0vANitBZ7qFZFGDf
 8BjRaYQHMiZq7c8KSvqRmkL0AkBcybJDD0XZlUhLakqC67IT0YOBIotoqyCpoWNX1yNWLbUMKjU
 ZXdmep1k3yNof0ZMYejxpEk+ihRxXvTLfDzyXfAllyR2Ro16Z8m2l7I9COyw2XXP2hMuM7Ooukl
 TcarVcf9XUI3bPerkPj2+Cb8tJMcPUYKOr81HLpTN40ZJCU/5UkhMK2i9AikYozetFdZdBLfjBJ
 5LVmEMjlJ+YVHKXcezg==
X-Proofpoint-GUID: isB6mZP_PRO-HFxpPzK-mgNVMD2Ow3NO
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a5f8261 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210153

On 7/21/26 11:32 AM, Krishna Chaitanya Chundru wrote:
> Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
> (PCIe1). Add PCIe controller and PHY nodes for both instances, and update
> the GCC clock references to use the newly added PHY nodes instead of
> placeholder zeros.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
