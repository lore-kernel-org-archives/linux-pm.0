Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781243;
	b=WqmC1m2d71EYox/Y95i3rMGFz0V7GFXnATB4UWIC/8esNhxXanqSpQi4TbN+HC0cmhGb
	 oWa5gHTRzztG3UOIjXBl+2zR1VwtY10Dk4J5ufq/gZw5RpGGBtuuT+fuAwCEpj3shov9A
	 bySW9wC++czTH9MK2vwQThKfhznbd8b+487Hs1yaBPE6QS/4D9LiAr7HchvUTNc1ZxheT
	 x6Prq7L297mp3lYOzldLJ6zdK6fDWoGi4DN4S4Z2gHsqhuXK/CDQKOOQcBOtsVgXhFohc
	 AhfVXzL5uyeegUbd2PM3eVZj7IYlzXgxKjnKREmRjicx6Ede56krwmdNpApk/Fjkzjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781243;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SOyvDr/OZBYmgAj7NapYrDKSeLtN84nxi5oDtZUBZP4=;
	b=ZDzsF2XDFf/6qTqTa15UPXVmICfmT5eFeNTuZWa8A4TLyRhDzeeABnzP16tGt14CGfHn
	 X4Dhc2b1WQZ9HRisCnl+plIIl58GOAAkAzfjz4SrL7y+YaIZXHFtFes1ecywkwPJb4jdY
	 YrsEKFVIn3d02UBrZJMjENR/v2Hh75lLcDbVIrIyNkU/PaEp/YvpVzKhgHcGeWB2wZybB
	 1f1+MGP2/AtIEr3eDikjl875WKyoK3zf9JHl8Sx05XFuNQr0qasa1lqwFgkBG1NsH/Mm5
	 tZ+/3objAexYA9qPYqfn6SfAzkFs8n/Z9wgHidO2hd9h1H9dkP7lqZzpeP/mysRTxZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kQ2sDyDH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hWKR7Uq6;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAE606A31C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 12:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFAAE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kQ2sDyDH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hWKR7Uq6
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAp2mv1047057
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 12:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SOyvDr/OZBYmgAj7NapYrDKSeLtN84nxi5oDtZUBZP4=; b=kQ2sDyDHBMC66aOU
	gd0tesO1tntmzSFbpZE1WyRA7TybFx1A7bW81OXNR2BUgZuBQhdXlOkZQVDaQy4B
	8Hyn/d8UFdOcE9CW6/84nJ3RkHCGctCT7UEyPaOcfpqGtg2beKDAWLeFdRIzFwZx
	vr0Cu66TI/S8rkbrzA5mi4OaMar/7ivoyyC3ujWLpDp92Z8vL7oKA6Xpxof8Danm
	oaYog0stZcVbI5YUWhyDe+eUpxrq4czjWopczQk2VUee2FxfGKQZSfr/7NceMRDL
	2PlDPLB/un7dMPRSdqKhWbvWLvvjryGg+vvMC0vXzO7yfoJsbf3UmhUhLFcgVgcW
	uSu7Jg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqkv7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 12:07:22 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-71ac6866f4cso438377eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 04:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795781241; x=1796386041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SOyvDr/OZBYmgAj7NapYrDKSeLtN84nxi5oDtZUBZP4=;
        b=hWKR7Uq6H3sVJlnndSCvKtFOiR1+riNrKq6aTBw/WLEnatgpWDbGdX64vHP7osKZiM
         iFcu0OAFqWB8vvCfMW411rLY32LDuwuJAoIqhzMrItz3a3jgYWTVfRuP3oHnu1g8CkGX
         xGrvkyLnBpojP48BBeM/8XfWa1Tx4sESK0jzqOX/cvdwZi1CCb13L6+zV8i0gwQO5B3u
         eSBH43eIIhoQRuDAktXPKU2ZgOIXdGASKOUIAJ/j2xCcWBPhdMz3SbEBGrGSOPTX1lvw
         8tylAXd/BSqtWIXqxybaUSXf/PZ6MN4pYoKyx/oL8UDicBDdP7hkKPtwHUDOCETHm6p3
         hXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781241; x=1796386041;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SOyvDr/OZBYmgAj7NapYrDKSeLtN84nxi5oDtZUBZP4=;
        b=okyMbl2TjUwG2XauCRJ2rWakbu/+Np/O0INXKVu3OaXnh4ipcY1PpvYnFCdlb3XILT
         CWUQcGvKDRtLmxwuTEGkL6tCkyBfAlqsn9HFQ29w2cGD5PaNdoRtu1VB0FWScAl6+sUW
         G6Lw9cT5hb2FGBQqs6EO1lkgY8r6z0FICC1I6TtB2m2dCQAZB2fKcnl5YqDKnWrsN1dh
         d7aiDnfsJp8CKAnMA9R9jX+hV+IfrEMM6R3e8R1REiD3ufPo6YwAN8oowoLipClfH0Ow
         Zjbq/eLqJhM15dJSkzrbsLaXComv3ezPqu4HSFrJ6lObWV+78CPJJytdSGBcylaYLY6G
         pDGA==
X-Forwarded-Encrypted: i=1; AL+hErH18dDqsot3in/B+zYo/TXZaDc7SeCNnFFgrm0KAzr3OnahdBQotugY8YqxqtwGtv3rnAKob7Y93w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9WNKgabxuPDxu9vaDWDPvHhKiYr4welpxD1tHOjjZ3nMRag/YF
	wcC2mLzxturBshlHIeImvIt/UuKBQvYrilFzoWFqV6SXvtUGZs7HpBVg32+txHixZCgyxtO/K+m
	0S3sR7TBGBxxPek83hydU2b1EyGqGU0BDj7VZRCz9DnyBlB1M00lX2+5MhBvSRA==
X-Gm-Gg: AZFdTZdeGZk0ufCDg6xzih5sC8FEctHgM/4a4P7dsr8CeUaqOnQHUudAN2Vm+26sdXf
	DTyjtBPgpIi4b+0IpkkjqdjqEPZ6xHzQvNIIhxwHzfvP89eb6Lu8IlpD47+8rK5UoiYC08186tw
	u7wCiZNuEwEEhoo15H/1OOQ4Ag6kI5vRlpF94W4GNm0KBdx8X6zeTF4jAHgstUDOBG5JL+8f0hv
	LFUILolbhXOkGJCzbClb845+BGlM70hSNv5VHww8Az8KLORVk5y6onLkrdl3DU91+uYorF2LmjI
	eoyFC6LYg4Spku65Vwoj24UD8EmjoOrpfd/EjrDXonma4Zr1WPrFrZ1h+srziL+BVGgYMHaG4yR
	vft6p0HWkxp0ol8YS8Y+nuLVJNQQSCAMf1X2mubLCZH6tPwFxAU66+Qfi
X-Received: by 2002:a05:6830:1409:b0:863:92f8:b6c6 with SMTP id 46e09a7af769-86392f8d238mr1518667a34.3.1795781241177;
        Fri, 27 Nov 2026 04:07:21 -0800 (PST)
X-Received: by 2002:a05:6830:1409:b0:863:92f8:b6c6 with SMTP id 46e09a7af769-86392f8d238mr1518596a34.3.1795781240639;
        Fri, 27 Nov 2026 04:07:20 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51a161e387sm346402866b.47.2026.11.27.04.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:07:19 -0800 (PST)
Message-ID: <10915364-1d58-475a-b11f-36b41a18c9fb@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 13:07:17 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: add RPMh power domains for
 Seca
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Tyler Baker <tyler.baker@oss.qualcomm.com>
References: <20261127-seca-pm-domains-v1-0-013c28eafc5f@oss.qualcomm.com>
 <20261127-seca-pm-domains-v1-2-013c28eafc5f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261127-seca-pm-domains-v1-2-013c28eafc5f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SZK7V9dTlOkMaj1fGzPaw1t1MClhfLiP
X-Proofpoint-ORIG-GUID: SZK7V9dTlOkMaj1fGzPaw1t1MClhfLiP
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b09727a cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=2ZRMiqlpstDxVboJcQwA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX8o+cE4lESlS1
 MG493+u5MwA+H9lZZT87intKzM8ZqwduDTVFLmp1cbNKUD2bMPHTiKdrckHTWHMa1FgxL+Jc6s6
 /lB2oVHWmGHFwAZ1/39pyfvr0VneR34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfXzEJoxXF/iQoj
 GnV0xD3wYetFCXxvPBtg3NIHWfs2d6s7bhbYHtZ3k6tk5zl6+UguXeQB+LYAMRwmyJwLLYLMenz
 kGq80V8FhqG44m7X2CT/6vqo04imoD4hhlhK5l9qUoZdMEdM8zX5YKYa0xdCU6fR5JJIivY533B
 PRnTaBrGFkvqCZYvUUukX0sTYvYa/88y5vvnETUHJOiACXFd6Y4guO+gZwCwA0Fpge61VO4Gfds
 PUYR0USxhYbULnzydKVIyn1SiAdcvXLu23Ag9gOdQE1DW74Mn60cEJUQv0CiymU6rBkKhJd0lbS
 D0DLIRqnYwARAguaZ/LwTNYPYwEclgWEFhcjc3LbvGz109YrMa7eMFh7V80Lr8h3mam24Afc/au
 KaCLWK7Mxtw6IN/hEY42WDUWIXm8Irs7ic0eKHH49eIz4cmop81vjXvwjFQwxHniyTSEI5lJV0V
 oAt1bbqophZolUUaWSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270048

On 11/27/26 12:43 PM, Bartosz Golaszewski wrote:
> Add the RPMh power domains for the Qualcomm Seca SoC.
> 
> Co-developed-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
