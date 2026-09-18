Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8384CDDE1
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726755; cv=none; b=gCalIAe1T/LUoNDNHJcZN0MW6U7ey987T6Q/Pqm1zJDRARA/6tc/pwRO/dCf53R5JfkLgUBWCYenHoIlmYha8LirbBN5hI1z3tg89nt6bpOjIK5zb5+8+bWlV7+1G+mqK5nAgzXIyNKzrWyfPTM8/h2vAxwgiMTmlrRSPNKmvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726755; c=relaxed/simple;
	bh=8fjQJiJEzWPsbO1frulwQqvRHirJed2i4uBwsSljtNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxkYmyRVLKyM7BEiOHFC2s+wVie+r2TxvWsiqcQYmVrCvwOI/htK/GaTDun8U+J6oJXurYf3Rwxtz8GXXGvDtruCJQeaufXXqcUoaTNdQ/pmFVLmBBGGw1vajKgLRkB6hJ8UMZM+pxzm4zvZz/OlJfmVMrAPqXiOPzPUS/4Lhts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=adl/+FLh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fTdbz8KL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="adl/+FLh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fTdbz8KL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9dOWH250726
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 10:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iHkJ75ewzmbvKgcRo7Ae3mDKRV8Ptv+pXDHjf+M9sE4=; b=adl/+FLhGpkds4YF
	5Wu0pL1wJyLDZlwF8otazc3I/JEC3tBX2alBFe19Y1JwoydHubHxIb6m2MDZyUui
	d9f0n+KfMPx3PDd+LncuqGyRb1Zn3S3foEtntbE2IhSBHyX8Kysm91y0ih/M3y0D
	Z0FqAqQNkGc1NhMLZt9PK402OLh6SXGPCQB0Suo3LirlgkW7ADHxoCQl8vt13+4k
	XmUeQTbN9qdbFCq72mwy7F8I/o8tBL2ImKyQJDjN0QeHVN0QBKTlJkrJvkrhSRrz
	bP5XfoupKL92lmSgTabvD1xRzbcfgvVLfff3l7/AAz+s3AuBzBflSj08KdpK6/3H
	uwWb9Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs2390cd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 10:19:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a1bffc2eeso155933685a.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789726747; x=1790331547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHkJ75ewzmbvKgcRo7Ae3mDKRV8Ptv+pXDHjf+M9sE4=;
        b=fTdbz8KLKsuCiSBUPeq7aSXD/98QZNwOh77OB8jt4DU9fm9bYkSTBUlg7hDGUrMdHf
         1/gyX7uDVHldxKf4hxb/+sKQATPkWpa5Rc+WYsq89YT5TC/stYwHYAx1jMChofBrcNF0
         5uw+B2aa4JfCkD8r4iMiM5Z+HDMqAlXoY5afyWXnno2XheS6RQwIPUExHm7ekcuaF9e1
         C1gSmNREfmDgs6aVa65PhvD6lhJdq1JRZkvDWsWyp7J7hzIR+UW+THqwuYg2YC0jg7kf
         9TWg/jpzsjf3+1E2WjxPvIUwXjQdJhzADYFfU4l187QgAdQiVY9subLwDce2reMdVCK4
         Lecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789726747; x=1790331547;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHkJ75ewzmbvKgcRo7Ae3mDKRV8Ptv+pXDHjf+M9sE4=;
        b=Ba6lW4UMZS2EVn/2159/G4eSa48qorM2g5TleiZBcclJGARC9nwb0D1x8881+Vkg4L
         dfhF55cuHMkky72eKJr0ajvtcbyEI52fLiVQ/TcxLlaCw5tQ1YsSn3Q0L6eO7O1T3El8
         r/2LkLBErj/agU99u7C80tlxJpdcEk0ZLn2joDA7leks99VyNCutmaYWBCMRM5JcChaq
         UMi4AtzUOUnLyGX2hsUe1iF3WLrs3/dCWuaUD4rg0vaC7p6IWFtIhWlwlkwS/2sx9sHS
         YUr5IhQ5D6Bk4yanVz0W8gqLXy5ikWKwNjh7+rhJsh7RrQpQ34uRNRXwRuD0ZO0K4Wd8
         Bgzw==
X-Gm-Message-State: AFuF++nk9D8IV1fjmKd+PMNWc6r/yiOa5sqz3n7EcHdDRsgWRaTB14S9
	Q3Vn07rSACZ1pUYs+91grTlHIE3XWvdOIZN4aSfZ4akaKrYMXtA6BhGgvCctOicZFNg6n4xZOzq
	9COcmE+DSNAVEkDKE9g3UEmJM6RPHmtTah3yvXtOGlTMikpwtHnO93gZT7dl56g==
X-Gm-Gg: AYBFou0VTd2omKEpPmtZ8AwnkiOKMUnEOVQwIngawOGxBZZRrFLdEzFZ4Zk3VzZUa3o
	k/719X7TmhiLaWeqRO8s3gRZ7yyXRk1BOi4SYpaBVLH9Qov0AZrymxlTPykDFHPVfB6rc9fKjka
	SSEvkM+c48sqXcBpjLl0NnqcQkUzprlg6KbDUXGZFpzI8QUaRAmIQPPCzuftwIHzZDSOxEwHlLm
	Y1T8DnJOELwUwhY3oA44B+Z9p2WXPk/isPO6LWj1tnztsCojJazmdW0v8V8svVqnwMjfnhVFrUj
	KJlmF1+QSJmf4dbOhys6uSmu43e627+baP3SESMFUGzkkjmohmOd7oKcMXdwmXRRcpYdQmKJRDD
	MqP9eXYczL+tYLSlajATaTWQ8W4pxyZvQk0uHlb2I3lC38dUNzzQUX7aw2vgaKMw=
X-Received: by 2002:a05:620a:268b:b0:937:5298:7820 with SMTP id af79cd13be357-93bdc6a6c91mr259104685a.8.1789726747215;
        Fri, 18 Sep 2026 03:19:07 -0700 (PDT)
X-Received: by 2002:a05:620a:268b:b0:937:5298:7820 with SMTP id af79cd13be357-93bdc6a6c91mr259101785a.8.1789726746850;
        Fri, 18 Sep 2026 03:19:06 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:82ae:cd75:d970:e66f? ([2a05:6e02:1041:c10:82ae:cd75:d970:e66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd2160c2sm150832725e9.6.2026.09.18.03.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 03:19:06 -0700 (PDT)
Message-ID: <a2165ba7-e259-4e0b-a533-3961649b1803@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 12:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: thermal: ti,omap-bandgap: Convert to DT
 schema
To: Bhargav Joshi <j.bhargav.u@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com,
        daniel.baluta@gmail.com, simona.toaca@nxp.com
References: <20260811-ti-bandgap-v2-1-6fec2a71c394@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260811-ti-bandgap-v2-1-6fec2a71c394@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0MiBTYWx0ZWRfX7G7UReYpZ0l8
 bzu7DA2eA8x22B83sFGTN75vZX12liUdoSqnoZ6Z9jVXis1D/Jdg1pjpRx7wR6OyJmB4xWHVDl7
 TfCaZkZgr+bxG7HWmn2GFEzegz6eGWU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0MiBTYWx0ZWRfXxnZtvoDaNMUg
 dGVyLC+YFEoe9ZcEsXNvFKV4FYaEzaGfAkgC+Yd+lDI9IQnW737NKkQHl2D841Ju9UvA2tfL1sF
 PF8AsRaeGPHXBdkMqaGeQlNk8ZifnFL48tluIO8MJPgiByk0r/mkB4J8Ehzsl3WFE0RtyKpodLl
 zcpZ/KJ5SrrmLMAMN3gOfctNrkQuXAV4Lkf0f92EHoQ04aj/3wN+Pn0mFPPpOyDQFcVomtc0KBp
 tjDcW47ZcDKY7aVI33RBo+QCOVWD9xFR27okHniyX+pMduO4IQNcs+DIzmZ+fg6CJ1d+jYz2/JD
 L8PjtODqsobQcP2voggKaIAF71pNY2L0ZyCwQZzyJLBx463Ruh6p3NoxZC27TGyuLvKCarmP7Rs
 8k7ikflQ0Mq00CYUeJLCdSyP1XfSenHcTNMK4KNlHv3NFp0RcuhgaocWkybJQzFv+O7pxyhTOdH
 TYoMzRHmh46cC5d2ZOw==
X-Proofpoint-ORIG-GUID: H8WYhjTISSoiIEF7KF2Nif80w9tWVufx
X-Authority-Analysis: v=2.4 cv=I7zw19gg c=1 sm=1 tr=0 ts=6aad101b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=XW-PbBF8hWzyniDVdj8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: H8WYhjTISSoiIEF7KF2Nif80w9tWVufx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180142

On 8/10/26 20:49, Bhargav Joshi wrote:
> Convert Texas Instruments OMAP SCM bandgap from legacy text to DT schema
> 
> Add "ti,dra752-bandgap" to compatible which was missing in text binding
> but used and matched by same driver.
> 
> Document the "#thermal-sensor-cells" property, which was missing from
> the original text binding but is required in practice by all in-tree
> users via the common thermal-sensor.yaml binding.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
Applied, thanks
