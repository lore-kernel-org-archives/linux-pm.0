Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AC4F3EA4
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726588; cv=none; b=e/7OUvAmF5jaJpQSN/8lkDzkcilX/E+7PDE1Xc9Sk2uSFD333Eu/rT98xbYJ4tMlg1tyUDKRJsOe0RbLHz5+Bq2FUGh+OHaXQGx3ZpNEC35o5NW3Je35tL1ss4iniQqyCrkAg1jOa3hr+M7Zi5dbzjnBnVBKLz0XSbEsTLMbtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726588; c=relaxed/simple;
	bh=GKSirKHvfn9lZan03ZeAgUC1tA3Nnr12Pp3mvCfeg8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDhWkm7TWMM74SjThUzJVZHFaCZ1KJOzMQrfcQhjWMEArCDiOrdZ9JC2LZkvnPB3zeD91uD7SY4BICPRo8FD7v8fWCGhky9rqobpuSuEq6LJ3MAUyXx5OlFVTEWi4Z3MOvguceW8RncCgqs94fsbP4jIKLtj9pddcpble6ZTVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m62CTU1Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ng7N7n2Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m62CTU1Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ng7N7n2Q"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA3au33208424
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 10:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lkWvd6wXs7ggjF+yLAJdymgWMfkLNdqnHiJr+Shk/Qk=; b=m62CTU1YnGapAeDc
	+qy7Soc6UKFvvtv+bZtezgCUvRpCy7x9WoLiUAuzSwXaLcsIs2vpyBQiqiD1qxlg
	4gu7HD2oaZnE2c7oBLTBTO+ZWNzFqctmWuwsEiFldYgdTJI1Rc94jm1zTORMfwdN
	Enz3kgmWZ7vAm8RKEXb5U1ZAo6GvmEqCjfSiyLzXlWYp9N82JQ0iDG1ZmXKQAU1S
	k92qUVLmxi8kWdJo5RtKARbqTr9LqLWILs3fYPDOjPlkn2jQ4D/Y3XpEGvCNjPOp
	IX43ijDUmFzVlZqdhl1kH0lIZtaqNdTTlzNNRRWDhO1K3MV6JGS43+G8Zm/8vCwc
	aiiiwQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs37dg1db-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 10:16:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9104c2ce026so15140266d6.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789726579; x=1790331379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkWvd6wXs7ggjF+yLAJdymgWMfkLNdqnHiJr+Shk/Qk=;
        b=Ng7N7n2Qt9EHMGJEV0tbpOphKfQ7n6eBEPwF7NODJLVbhpTNNgFysN0/zeXVHGgLiM
         48FV13CfdpDyvrgUBJrWck7LuDvISq4OQ2Sypnid9FQkuSud2kLcmiV1X3WBttqQ6bbC
         nn8FYPUI8+JYerDca85f6GRbsyjU7qstYAQETUcMz1zA/wR8TITttWwPtZLER9ntM5lw
         X+ffrunBK0PHZ4hTz5jE6xOvno5sx+Bdp55uhDxFqABZbzeTN9G5uBSMgy8DoDnfX3PO
         6TM3CP4W+L9qHwDEh9xQl3/r53cxTQa+yQERhVciegosBtHjcmBWr2QGS0dUvD1ikfla
         YpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789726579; x=1790331379;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkWvd6wXs7ggjF+yLAJdymgWMfkLNdqnHiJr+Shk/Qk=;
        b=n9MjyCCA3lirItUqdLXSJTDnavHEso424uXX4GpqOWCnTslw7pvOZaLAu1IuvGnI49
         ELgOoSbSSUx+e+p0JJJ7p44uQ8JKfENPEWicJcmqlFHagXmGdOm2qsfELQs0XkMb8cQS
         m3Jh/QFZjTYV2fHy1mT0LB1PHsqA0ZPZj0QED8bk+EiWKKQC3zy4Hs+ZFR3h0MhggbvU
         ml/kDa6xFyzIpjjQvjKyPn1BM898xQ0YdNciw+xm+HGCCpd4c4ye9qnj3WPvDkgh5oUw
         XAjWo3+CbW7t/GaP4DT0RJCGJ04lNtohjAbud/ry0oz0Y1zWUDQV2v90BYCn4roV9cvh
         iG8A==
X-Forwarded-Encrypted: i=1; AKwUvBxiWD6UdqOiVG86sciNyZZfYGoXhJfdlARxgQK+vln0vOQMdqMgfDONyDmbN81ZJb/hu4OmOglpdA==@vger.kernel.org
X-Gm-Message-State: AFuF++kD5Cm1TchSvfB38n6VwHDxLGUQSkncpeEeiw456UUx2JCItxN2
	EWLkC/fwedzvcVBdqu2pyZQJAemqirn6w+6iZ+0bGEthVL83inl6YMbIPXhIh7f9m92LSvFnJjl
	A99GtonkwLR3IjSITrXBN8cWGlvj05On6dXFi9kvua9SGT2fQjsgTVvIqYPcVGg==
X-Gm-Gg: AYBFou2n9TKsYj/JHIBoLjY8ms5RiaPJ8NpV5ydM25hQZ+kRruGOm2wGcicEbs1/CeJ
	4wGqprGAAAQhzEp9QN9gAsbYFfV9pNREya9iXc5+4OxCd6bxJztmEfY87ifhcnWb1JelAZkPhCJ
	MNa6rtWOAXcPkI8/ZOg8t6xKrfkJ/UzaY4qaNk0MkE0lJxEXt9kwrAN0IX6CO05vGwbA2d8SzEo
	RgoP/xUgt9/t+i+VoPiVcxQp8xnFQ5+N4A4RGOhSU3iPsD1oVPepfpSdP5Ab4yepVr6FASRBPNC
	NlnDqrfKktmZHGv6I55z3Qqj+sjeRYKY3iVEa/4wphsBgRlFNINgSpc8C8kGaVrmyYPDxUZG2qy
	tZwi9Lvd9SgQneiqZBotamNty0IuHygojxizvBToo49Bh3XSvOPEeySiSHlVxBDU=
X-Received: by 2002:a05:620a:2b96:b0:930:f337:ebeb with SMTP id af79cd13be357-93bdc6d5ad6mr217943885a.12.1789726578890;
        Fri, 18 Sep 2026 03:16:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2b96:b0:930:f337:ebeb with SMTP id af79cd13be357-93bdc6d5ad6mr217940385a.12.1789726578407;
        Fri, 18 Sep 2026 03:16:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:82ae:cd75:d970:e66f? ([2a05:6e02:1041:c10:82ae:cd75:d970:e66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd17051fsm147325645e9.0.2026.09.18.03.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 03:16:17 -0700 (PDT)
Message-ID: <dcf28454-a583-4f6b-a11e-483d63be3bae@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 12:16:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/imx9: Constify struct
 thermal_zone_device_ops
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <5cce9ea713edcf2aa3c0efd5d31e9d9fd9f40a88.1786220585.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <5cce9ea713edcf2aa3c0efd5d31e9d9fd9f40a88.1786220585.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0MiBTYWx0ZWRfX4L1WkbEygO1Y
 s/azQBq2wr/bqqR/xzNqXRm8PWUhkxV7VsUujYRIy47U4I1kgWi0NCchCW11J1RjqanJBnaeHgC
 /VGRyNJwxWpDFF3nZ9pzrnXC3MLit9c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0MiBTYWx0ZWRfXxF8Ky+9J59BE
 9aX7pqbtni6b8Bsd6mYJv6xT11KgMZdREmYC0Rat09a9K3RuhFpOBalayEzSMPuuQDFiViJtrvq
 OaricF3OAoToAAnNw2sqo30XXj4v9ftt7EBuqvK6bJtKdTmQCtDo4+hK/ff/sUjuubpAoi6SlOA
 H4OPKerxvbLkj3/RrS0sPBVKOzjji0SKkJDLGgh7KJuENnHLx1H+LpLo1cggH7j9Zav3R270+2B
 98dv/k8EIuWCljq4lB55YFbHM8TNdZHAa7Ih89RSiwB2nz49BGhvxCSYkrFja4eH0OOoLbJlLZL
 vxDRdG/Lx/N5szAhXiEC2XTKfyDVqDC2Xa/SXfh/vRRr2HQ2jOhUdV1wqloPtuLTaf1dQql9DKv
 ZbWXlH048rgfk7n4LGBxf75JXCa7KwfqpNIY1upHe/aMJ4AY9sHiwWKs9fAQrGQUFu0cNaHAZ7H
 nD6C4dkTLP5jZO61p5g==
X-Proofpoint-GUID: l4wdPzGdZ7g1HhO-K_DK3jKHM58EwgUf
X-Proofpoint-ORIG-GUID: l4wdPzGdZ7g1HhO-K_DK3jKHM58EwgUf
X-Authority-Analysis: v=2.4 cv=R+mWitRX c=1 sm=1 tr=0 ts=6aad0f74 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=_H6WjYdI7YG0SsD1Ov0A:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180142

On 8/8/26 22:23, Christophe JAILLET wrote:
> 'struct thermal_zone_device_ops' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>     8567	   2144	      0	  10711	   29d7	drivers/thermal/imx91_thermal.o
> 
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>     8695	   2016	      0	  10711	   29d7	drivers/thermal/imx91_thermal.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied, thanks

