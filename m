Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466672EA480
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161073; cv=none; b=Z6e+JLHwlIwetQuTGgptRgjeCUeHMCZ1ybrlp2XZ0HfN3RozMb5GBUquK63pLsWRbm6mDKoyL2jLv3y+b9otYYvOky9nH4fMlllvkr1cxj3DRZeLCGoWtkNUF5Q72ilzoiF+8WS2c6+ScOCWdHDjTYZ7ry3fgz4LbD5jbv/PA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161073; c=relaxed/simple;
	bh=pe5ZdIINMuKA3v+bwkuSgrAjyK9iXRBm1yCm5qbYovQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NuBjgKABWzalJMPks0SFC1OVmrFZsi7Hx9c050LEldl6RgDGZmfu2Yuj9xiseWHYMjjoDLteIWZ8QGZw5Jd0hj6pXF7ZOVxlh1Fo5qQHeceh8S6icSGzLlQowZ+mvds3AKSsmibbTpZDbt3nZdGmwoMf/tH+oQlUrz+nAkWqgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nznKsyxH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W+1ZJcMh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nznKsyxH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+1ZJcMh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlaRn3414006
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KtuLOFHTMC3S6hLH8z21W8AG1z44cR94ggj84/ysWsg=; b=nznKsyxHYMwCsNSq
	T4+2ZRllt4YRDs2iyFGVXkCb+/8kS7q2WN8F/GE6cx2uY/DS8OLi4RaURilliO7/
	cWarIWOF3jj5FSaJDujyxSER4SbYblYVN3UmE5XccuzzRsKdVFibyCvWKztf5DZj
	RkDAVURepeypU1KqvVkqGijly3+rOy/E4wmLnsDhJSZ1jPXR8HJhaw0hThplxgvt
	fVHKjh9fRMXZ9dYuN6dmHXCeUtnjq1Gwn5g8WxZNPfZkLHfqdIEvGa83I3F8Q930
	M1xPlSf8T5TaXJHb8MQnID2QpiCsE7JPlS7AXz3jqMiKWQxkp3frufnmUz5SzZIj
	/6ABEQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v68yer-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:04:28 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-96910ded42cso89756241.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785161067; x=1785765867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KtuLOFHTMC3S6hLH8z21W8AG1z44cR94ggj84/ysWsg=;
        b=W+1ZJcMhacpHTzDzwfzgg4KYM+wlpgRSMHq5zJwGyuvVOV6t+WgdX6giLvsAQ56Par
         GoZMSUJBDd4bm1V9s6ivYHjjXlZ2mlrY7Ee4FEPHJxjRBtoxXEGmVMU4kk2kkgqWHeLG
         l9GW2gLfcvLDv4q1o+aRYuZStKZFYhCgx0S0scCz5L2SQA80SlkCuPwhvyTkQfykBTVC
         HGGU4Iwy5/GuqD+Ron77n4TzFV9eRu0jqJwODigYSEU/CE3/ikz1WlmsUedw6paWVdSZ
         rZK1RdaSYpgVQ8/MD0QVYVzB9vt6i43jUz/ubXwBI0BA2Ff41Nhb+vNsHp9SssQEFc7F
         u9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161067; x=1785765867;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KtuLOFHTMC3S6hLH8z21W8AG1z44cR94ggj84/ysWsg=;
        b=WL5lDbhGj5iB76tHCqRYwU6DE4aFrZ3++XrI8tCrEWTlWmE7V4dYA/v8+ql3FsIOaY
         1oJvGunMNNP5Gqvh6y34JtXX85XB2H0O8V2eu86GkZShCmeGnsC2Fla1QtwrymdM++81
         GdU0uzDjjfCOQ31JEagb4wqXCtty9LC8aM9b/DjShPGngJ85a6AhQlD/RaXu1et6IGgW
         +4GWPrPe0CdzLL4u6eX5c+o6dD01eMqnyZX0GBsEjWAzkBfCkBYwy7dxQPJauBe8SIi2
         4d0Rb4KcrKYrHxhKiTx5LI7bKSJ4nYJFxUq+z36er6l5gVNHVJ4YArrL3xJ7PS7xhuQ5
         T5vg==
X-Forwarded-Encrypted: i=1; AHgh+RoIioHfpcyLWFNyy03cKOc4skB2KoxYjidPZ1DTypZTTBxnayTq3Hn3qKIRN64pnycc+mDUlOdgwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30RwPeMhb6AbYVyp4+cOx5Ghy8n/G6AGKqU7VmpCJh2btvH/F
	MXkIuYffACiW5WzJrS/rSSwvE/xbsnR7KHgTc7kONNgcDve/B5jXpi+LWKETDrJn4Id5PBogxPC
	ytQGrpf5pp747AomM/dLvWABvTI0IdPrJr8JK20cdlhz1IryAfMAgHAHcIrPDPw==
X-Gm-Gg: AR+sD13eHmL2pJUevwzeIS6O5fx1CPw4LMHaCSbwH891MZreUJPmyquIR4xc0G6469w
	Fdu/gAtxus+fFLORhF6aY+JKIgmKLK4p1WqVbxw/71tVNu4KJWfWdz6ER2vmbbRTa290J9doRfN
	IksKb7KbpuJigLKxK7rawHjP7ewOEgFuipBOFeEyTdsl3+vlHUE2Nu7CeqL0MORMlcXKZnjoEF7
	nG/E0ctIKgIIGaTE21oGi/hWfRhsGHaTh54CNkzMRwITS+F0inA0/HuAW4kHqp3PsgiQF+ud4By
	bV+1Q1MwPhFKohqR38v7X3d3UoEclvliYrBydy1zyZ4Pr04MRdHrGg/fmRF1Y10UqGKWI6BmnFL
	PRxm+znziw+qkLBILbB52S4JVaOKTZ3lM9MCXFqkL1+k7XQ==
X-Received: by 2002:a05:6123:4e:b0:5a2:5c65:850f with SMTP id 71dfb90a1353d-5c306cd4639mr3029395e0c.10.1785161067609;
        Mon, 27 Jul 2026 07:04:27 -0700 (PDT)
X-Received: by 2002:a05:6123:4e:b0:5a2:5c65:850f with SMTP id 71dfb90a1353d-5c306cd4639mr3029354e0c.10.1785161067202;
        Mon, 27 Jul 2026 07:04:27 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b842691sm249027595e9.1.2026.07.27.07.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:04:26 -0700 (PDT)
Message-ID: <cc136d7b-61e5-469d-8956-758cf79e5f8f@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 16:04:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] thermal/drivers: airoha: Add support for AN7583
To: Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260702094846.17325-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260702094846.17325-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfXxHtHIotKuCMa
 b8pcK67kXBVrwds6RG+byDKqq1fDTOMMKC4eQlOPk27bXFihLG3goRb2WfQ7DXT83ranqysEXwh
 SRZbWDzPn+w4j+aacaPehf1S+LbqH0U=
X-Proofpoint-GUID: 169Jd_s0yv3Qmb6uL9PkevyLtbvFK6MU
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a67656c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bkhZLDyw_siaIAFfkZUA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: 169Jd_s0yv3Qmb6uL9PkevyLtbvFK6MU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfX+szJAiYAG77a
 DPOMlKkM68QglOxCxFLAGhGj153VumbNtqDsqy5ckPvE/43nRwXXTsyoXUknHh43frc9egRpazq
 yRZWZsNKip1WLkLCdf0qnoD/YMxyA4awkgL8UMOA4ZCdlGhCTuNyQNGGJsBkHj7NFkISSC3QYMA
 UwIdWXq/UzoyxKCXsuHODZ7pRrvuxQFbIfjiEw4OOqe0ROgAT2sqdJ+Zao7BIeFA4RKljyhHybi
 z/8dXIAQA7EMfn1F4uLdpgY2OlyZHcWrmxUTg+aZ1YCBTzHKCIIxGahAFTQmbPUSpn7Mn9J35SC
 VEyz6B7VgyLQDhC57BMxNPdaOdO3GW9GmXDmC5754OHngdpwo+2lCLeG5nmWI+P3E4WMIUMUBmq
 Sb6a1cn70A0k24ZsTBf8B0g+69/qHTn2PFivM7Ote/9b5wqJNQ5L3gX7I6zBaqvKD2tEzUaYVNd
 JZBR4BnhIFlT3FvSLPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270134


Hi,

On 7/2/26 11:48, Christian Marangi wrote:
> This small series implement all the required changes to
> support Airoha AN7583 Thermal Sensor.
> 
> The SoC dropped the Monitor subsystem and only provide
> temperature reading. Some generalization was required
> to at least save the common code with also the help of
> reg field API.
> 
> Changes v6:
> - Add review tag to DT patch
> - Add review tag to fix patch
> - Rebase on top of linux-next
> Changes v5:
> - Fix alpabetical order in Documentation patch
> - Address suggested change by AI Bot
> Changes v4:
> - Rebase on top of linux-next
> Changes v3:
> - Property use chip-scu for thermal sensor
> Changes v2:
> - Update DT schema patch to implement dedicated schema
> 

Applied, thanks
