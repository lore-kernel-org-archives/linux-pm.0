Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3F233933
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722415; cv=none; b=Kz7Qvz8AcQFoJUIPfgnsyUkp46WpEVDY8VCx/mhLftEAkbWkLdPVEBRT+BHZMcV8Ka8/+Nz2nXnu37k6WneXjP1d12tTrtplZvK5cyDq2eLFYpnJZ1GO/7XGB1HlUcFYId2Imr637oUwRhTg8unE6YZA2HlYqxvHf3DIVvCWo8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722415; c=relaxed/simple;
	bh=NvyAVROrOefxr8HLu3QgE3TOubVk8y3z1riRnQQPMYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGb7qWoidFbPV93UVK4mCnKceVEm7iu8lro3uXdEQahPWWTgQXBPH8kgJPY04DueN1jIj94QsxZZYqZqpcuXWYV/LIZS3k4a3z2hiELibd1SoQPbJEFRgsF6t8nCSc6Oqn8QK5M4edfUmQ2vBLCrbyjz7Ett2+fIWkLgKdSEIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b+PkJmu2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ixdwDUK1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b+PkJmu2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ixdwDUK1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xodK910635
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MPjd73s24XN3Lhd60fpMGq4ueL3tteKhpMWhrIgQc7c=; b=b+PkJmu2PPx3leZ3
	sI1rZ+nWdXlx0PAH5Pb9L3dcIuXK4OMcbSM7Wq/eyNt8CNVJVtAHpj1C99wsVSA9
	QbS+oXji7IqhzjRyUaP/tl36x1uZsvbh4byaX2oErxGm2lLF6J4tAnEA16SEpbxx
	toGPJMV06MfD01Fv6SUN7FL5OvU9ZgjEfVphAKge2hBOS/dI0hm0PDtBfxqcnk2h
	oBmQhHjCivTEgLzNmSnuuBg6vw8dhcQzjO+VreoLsZzFA9JcW06Wy+POj5NFhSQ3
	N2aGdyyJclOePxqjOmL3RFv3WQCDy1iqo+L2Fa5ZdoV9NfCB8wmcNesP67cCpmzY
	huM6oA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grtdpsvu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:06:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93bd22160bbso132240885a.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 02:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789722412; x=1790327212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPjd73s24XN3Lhd60fpMGq4ueL3tteKhpMWhrIgQc7c=;
        b=ixdwDUK1Sgd4WgVFqDbDb19U4r1+TtEAoayHpYnzGPyWBTOsfs7JXoynugNch+7Hcf
         mhwMnjftGIeEDTE9NfZmvgtI44EKoj8AW2jlmgBaB5ekzU+5roqKRTMhhkuFKsXv8BBH
         Ej63UhL8HqfqNmVNdOWBV84sDPSlaoi3x1F/dwe+cBIRs0ziX71WTF0rHBHBFeMqhDQH
         48rLF6OOpMPjwAg9fsscBBIfZfw0X8L1K4RU5JnDqWG03G5VGEysTidK3BbcAkktMk2Z
         5cXO0+MJFXJZjitvWFQ97UsmzE+eHxF23zEENKAyC3t/9d5cHACatVa2NSm/X4A7m+uS
         Iytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722412; x=1790327212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MPjd73s24XN3Lhd60fpMGq4ueL3tteKhpMWhrIgQc7c=;
        b=H0io4/K8wH3Tdl0mlzLx1dUKlVZfHzzOKdTsaHczSe+wq/pEFtrnel2pytAe/Aq8NC
         YaAmrL9OSFCsVAp+xOEdGskG2c86h6V+0kCm4350UuuDxzm5G3hQesM4dwokVLXeHaCJ
         eV2v2XSlOvTqaYMjlo194j/96mvgphQFqz2vYZ8m/HbR+tD+0PdL+YEH/QzZ6wXwyxuI
         HA5K7Mp7ORX6ek3IX0qGBvLsuT2RXBG8iGx/WwW6ruDgQuyhiA+e5vvYqFO2UabQ+H7u
         P0+9+me8Hr+fjmolKzo+jw5VOZp68F+vvwZ5a8m25DtuerfeVL3rADDii1F19CjS/vFV
         zACQ==
X-Forwarded-Encrypted: i=1; AKwUvBxt/sbPIlH2IZp3+F1J74vdoykIJO4HLlD7PNoWZQZKw7h37vE7QLx2f3CTDnDjafa4+V5tmBpRbw==@vger.kernel.org
X-Gm-Message-State: AFuF++nSv5daao5ZkdCIYilIgWX5BT42wVTY5e7Z1PTHFz1p3cgcxQa6
	fyHrVPaeBayo8QOhT11Dzuq9tcmZBgMNEE149Xef8loC0xxL7VkPnPT34pUoU+xtgX2pYEUyAEE
	UKPSb6waadAdoGuuHeW6y7aDRJY+Ux0fG/re+u6/mIvzN4pw7h/mjbv+k8jt8DqXAtti3bg==
X-Gm-Gg: AYBFou1BBaT57R4YeurOyF8S7ywsyG6Hwwo1VaVfC+6jZlzxL9vJdlzmg9ZAuC2BKDJ
	nTgRVSPwnqeo3JLy3Fr+LDhl/R1VOt6B3eMhzad5mor+P8vdF05eeqADnI11bQ6tWNGR0czV2jm
	2sCkw7qbFRYUAHigLft7l6asigOoVmYg124CYdiiolUoJAw2C17CU1xezyXWM82WaTA44hi4aRz
	B9izFUQTYES4FzOX6QMAuUkrSoF19WkPhM/DnQCcXWtP1UXBq261YuPSs0cY3yj8mHxXEWRgSdO
	L4LXEJyTlyc+hrwZhQZv3rX/xG9n/8+IQiFaslZugWCovA6lj12290Qh69OTBT3u568uWYMVtBr
	Jj4OpE5skU4aoPYtCHrFyQYf12HQKPxNBce4Nh2UlN5j6Z7pL4RL0w42iNhyyE3w=
X-Received: by 2002:a05:620a:4586:b0:939:acf1:dbc1 with SMTP id af79cd13be357-93bdc6e5b95mr252595585a.23.1789722411632;
        Fri, 18 Sep 2026 02:06:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:939:acf1:dbc1 with SMTP id af79cd13be357-93bdc6e5b95mr252592285a.23.1789722411208;
        Fri, 18 Sep 2026 02:06:51 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:82ae:cd75:d970:e66f? ([2a05:6e02:1041:c10:82ae:cd75:d970:e66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7ceb92asm37739405e9.6.2026.09.18.02.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 02:06:50 -0700 (PDT)
Message-ID: <7f2ab477-15c1-4ff6-a249-71ce07a2afe0@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 11:06:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/thermal: fix typo "binded" in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260917080002.23952-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260917080002.23952-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyNSBTYWx0ZWRfX6HB6LY0PcFaF
 9wkkAHmGOFbvTWg/vqf8o7gOvYlvo11waPrKv4Ya+LEMBllz9zGD0Gc8mQaWVGeolmLT+1fePSQ
 4yMB/Ze0lcYXzr+DCLWnKhWKrrnVMPd/rNupVyOPBJPBsiahrafJndsk8cqL8jwRbZOTUABrvzf
 tdTbEbnpnsyzlmCnfmHNheskYNyW36d4T/hYXrYjp9WOsp8+gUfcLsvcZVWyjM0dhQZR66dzGpF
 cjmAeU1O8gZHIi2a0/UNwIgg5bowmDq+j47NGnU4mlOCgc9jCu4Pu1JxhBfAmPo+LTn+6DPah+W
 lTuDKcvP7QREF35BHEpxoVmVDfcCtIVRm2CFR2N8YKw6k2rNkq0L4/HxWlsPet7nO9EEUiAN8z2
 DbAk22KcT4GBuY2os63wiqLB2W9asosy3efIb57svfDq0fzfplXjF2uUx7lzZ1M+cm9K48WZ4ke
 u4Wu27+u1+kG+ZuUnag==
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6aacff2c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=JfrnYn6hAAAA:8
 a=pGLkceISAAAA:8 a=rfXbHTV4jcTqxJDe2AQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyNSBTYWx0ZWRfX6LaNjBYLnr6S
 xGQXploLDAzFbcajEC/TlKAiLgjccHi+LsjsLgC+Y1V5WZIcHzHD6936UG9We/03tWYstNuaqjy
 8Cs+tqW3yd1TDrD3VOEVCNhagp+J7WU=
X-Proofpoint-ORIG-GUID: iEHaQL-Jr1ijT9oXajtYo1Hmkf61DucG
X-Proofpoint-GUID: iEHaQL-Jr1ijT9oXajtYo1Hmkf61DucG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180125

On 9/17/26 10:00, Hemanth Selam wrote:
> "binded" is not a word; the past participle of "bind" is "bound".
> 
> The tmon.h comment counts cooling devices, so the noun is plural there,
> matching the wording already used for MAX_NR_CDEV_TRIP.  The tui.c clause
> needs "is" to read as a sentence.
> 
> Only touches comments, no code changes.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
Applied, thanks
