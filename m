Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794974143;
	b=cHO/zQLmNiyLNMAN5Rh6NjQLatj7jdPMpufj0b8x2H8fzJqq1yAI34xYUiboUmjJszZX
	 3VYssagnHKxgcn4GXfKw7QfbmEwhoqviRZcm7M5irX3u40WglJBosi+wt/i4mGcljsg6S
	 F+hQe0VfHqPg8m8VarqWkSteU36/VoTAuVQMy5JiG027mvUKVjs91NiXIFxj3QQYeHrn/
	 Z5NmubJQQYxY7lbQYu/GmXrQ9upiFhGnzLV63+v5vC4wsxknKleJ1AloQMjpbj6EedEWy
	 0etN8oo5vne5dflsIQXlNdbKMO1IPatCB5WMGzSizakI7aDnNsvJyW5P9J5zR7qd0pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794974143;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=siGlkVwFK+kAlmr7HRrTxVX0dPih8LkYmQDCGq/74C0=;
	b=jH10gip3G2hU0zHhcR6rSNbSAJCgbpc0+NfqxjZH0Rd4cWpbYoOsnUDq765MrzetuEHe
	 5fHEy4zYuKMg6RK/njbK4LXfdQv/Rq26L1duKfpX2Y1oJigHaJVbze8zs+DTTQG6+iPHA
	 9rb37QgAtv+Zf+lryM+93PmPTZ5FTypDgyc0GREhMFeg1FEMjPcsR3BHo/NaIkhG23hxd
	 swvZcsuB1DOOIqGNDth90vBX17uaLwvEM3Joo+R94kjPaCRkiU/s+0p7YpOITHSkMv4zY
	 LxFFLgWhwrGdMAC+aKPO5TRXptMvwV2hxY+zkmFvn26J86Aos2NN4Igzn0+WcfKIGFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mW2vvBmq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jDNucIe0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A1606A32A
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C85A1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mW2vvBmq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jDNucIe0
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2V1fF1430592
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	siGlkVwFK+kAlmr7HRrTxVX0dPih8LkYmQDCGq/74C0=; b=mW2vvBmqHXZC7iwZ
	fezB4fqyW34Rb4e9IE9D5A9AraL3KfwTeC8T9IwN96u/QDDVP7O9y3QCYVPengej
	0W22Sk6b5JsbeeN/Jd+zE4VPYPpaP33H90fl4xXhwpEhWX18GXjI1RUmDl/rclLI
	K5t1eoPlJ6LIbbugOw6SbRiW/EngOrI4XBLQjbJyuJZsOs1YmMWWY3f5cJmjlPqc
	DB6vHoNI9ATbd7aKZJxkxto+4iHl9Mg6tVNbHgX+JTixGOF43k6ArOZWc0xJYbiX
	4KmWVB0ryp0w87w+nqS2b2WK6tqtdVRwPac4APgZIYd1zk8ykk4rnUWSUDanYH2t
	PBL6xQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv912cn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:55:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b8cef34b43so644944b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 19:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794974141; x=1795578941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=siGlkVwFK+kAlmr7HRrTxVX0dPih8LkYmQDCGq/74C0=;
        b=jDNucIe0Udqg1nARcSW2RLa+XuYo8RPY8jjXFiwryZgpV/O7RETf7nZBQamL1b+rR+
         Oz+jCbms4BBSwkXUfUdI3m2OPNf6v9F1B9o5qBmM3+Y5ZEEpIJxfBL2V86XEQ2AO7tks
         I3G5Ju2u+p8Zcp0KvfMt1/ZVXyObuc8ensJzCghTvfnU7ZbO+Of+X7p+H7X6xY5k81b4
         wQ+mDS2pFDgRIEGK5het4rP03FQJLlZu7OeSIZnjGxQRl+zNJQkh645azaaYx9NDp/f7
         tSUlTgXUvFE4q4EAxaW706Xos72wEpJfUVJd5C8HefQS9jNb1a0PpuXbyFOTNAAGoNm1
         35bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794974141; x=1795578941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siGlkVwFK+kAlmr7HRrTxVX0dPih8LkYmQDCGq/74C0=;
        b=BtnwORS3lVVYN49hGCcsLzqP/9LVCn3LKscdVyLPkJPT5t/KFVy2FfmMR6NJ49D1+J
         T1sHMSspIQlBhDxvfy92HZtgYkEwUnOW/MpFNqER4OG15xmg3gLMWqXC/G3LIyLz+mti
         Cd44mV8anYHRzN8Yj7kSW8gAYAviUZkavLF6LAFuFTBeYxXitkvZGgOUslnIYjuRs1m0
         BPN9F/LT3Kp9pqTWBxyV1we8Yftuxt4/7iaoWeYjWR0qMU2k7TkiRuswIkDoGs0h7YFI
         jHp5IXqSB/ezAQZnpIs8gOP7rpAeDLZXBvWFlJ9mShy0hT001E3J8nVmxK4SjOr5ziw0
         6Xxg==
X-Forwarded-Encrypted: i=1; AL+hErGc6ZXeTNWEpCF1j5HmoCVWDfNFKvQ7LyBz8QxdlnrGQtTwr91G5VPkb7lkVVf23xa4X4lP2bjIrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/8Dghu1xgKD/vd8j7HQAQLHQoWP2yM9kAnVHlCcWcBmWOAHh+b
	j0DFmuEfMwn+X10dEFbok4hnPM2PH0qmJIdySaUyLu40et+zvuYhRlZgljXyLMtXQSfCx5DqZPD
	++0NTvQDsuwC8eAqEKmlybYVqJO0YDO1HEEaaT4K/J8IIm1vaXQog3naDeOd4yw==
X-Gm-Gg: AYBFou2gVlMu4/stZWH4FkQJCWWVPSHLL5VlRfeNBkZ7p2fc4RNYgmyzAWPUS/hI3GW
	1qIuFK0xNjdbVJ91rw8U4+oXmnqxkYwJKCwGkK0dW3XgI+U3xyC4M/20tmBQf0KajtnBVc+j57G
	sm4Fyl4lyEzXIlaf/TUIhhV4QdtDq9icxOjRGzt5EEmye9clAVDn+hOsRFaonNmn7PI+kXAQVqt
	3DFF+FlN8TJoqvH/c4TNe1ZmWKkv13xhJVFyqLEIBktyedJiIXMjWgm6rFoCWkfUt7Su+ZaydXu
	o6OY3zpbCGXo7oPhsFvEMve/Y/eDRkZFmygigTg3EhrKhsPeTeRR5rFUJd3xSDacOI0jURhQ6PA
	kPxdjhdy5kZPhUwbv/t/TDBbvTRChuSDvvF+E0C6yyHHYn/yQAMnJKPkKWOFL2yez6gacAu0kc9
	FdF0EpgZ+tQj7MXDP6/3ZTgI4x/BJQqaGWdqPFhrUzhmg=
X-Received: by 2002:a05:6a00:418d:b0:892:e080:4edb with SMTP id d2e1a72fcca58-8c5d55957d2mr1107249b3a.60.1794974141385;
        Tue, 17 Nov 2026 19:55:41 -0800 (PST)
X-Received: by 2002:a05:6a00:418d:b0:892:e080:4edb with SMTP id d2e1a72fcca58-8c5d55957d2mr1107218b3a.60.1794974140866;
        Tue, 17 Nov 2026 19:55:40 -0800 (PST)
Received: from [10.133.33.86] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5c7f99fe0sm421351b3a.7.2026.11.17.19.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 19:55:40 -0800 (PST)
Message-ID: <77166c44-71fa-4e28-9399-3f7c4b8b999b@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 11:55:36 +0800
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
Subject: Re: [PATCH v2 0/9] cpufreq: tegra194: add Tegra264 support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: bbasu@nvidia.com, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261117154954.625126-1-sumitg@nvidia.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261117154954.625126-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNSBTYWx0ZWRfX2XLhLUYnKFWT
 HeyKYi05Vhwa6JR0ZcxW3diJafObARoEIQ/V1/XMW112R1yXQhhgYbYAGxPQ9/GXeRoAYylLh0y
 Q2ONkclwb7H1Yfb0OIwW7LEaUZeF+Pf9Gyf8qAOTBqqb06W+e8PRs6fSOqUa4qaEtbAX3Hvbv0H
 +iQ6BILbMZQ1bQYYev2zrqCzo0eBskaFofnt2B3Q4azuDNQj4rTcS6ze1Hem+LxLVI3QiojGxDm
 Oq23AT52OL9kOf6O6jRfpCJtbEcZke/0fc2WhTqfLfYTKFhP+9Cbh9MEo3cajFFlSabXB68Ss2K
 HpT5bNhh0XM9ir9iF5V9C0OYV1sX4u14wnk6lGKPF1DSVClPDDRfScGHsfgACWLlYoQ/FHMbz9I
 OuCG6zzrEcI25KYu6hxG+i8ewwzUC7Oe5UmNQP0zuZPS+RyuO3PHRzy7cH/J92FVKK5E1+bJJHj
 b9OYMufQ4BDymVLtmSg==
X-Proofpoint-GUID: PFg19grd6XRWMHtQKzr8h5Q88KZ6T-tx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNSBTYWx0ZWRfX2aONQ105zDfs
 KVxXRROhL0rB6kOtHw+OeeivYOCyac8YG73B2QOXbOE1yHeQanqgMcZF+6hjSBvaefs5SBUpiGO
 JvvKzjnj1h6RTL0OKBKcgKpwlyjaM9A=
X-Authority-Analysis: v=2.4 cv=LuQHWXdc c=1 sm=1 tr=0 ts=6afd21be cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=bIqCZTYioKoOuvliMVYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: PFg19grd6XRWMHtQKzr8h5Q88KZ6T-tx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180015

On 11/17/2026 11:49 PM, Sumit Gupta wrote:
> This series adds cpufreq support for Tegra264, which joins the SoCs
> already supported by the tegra194-cpufreq driver.
> 
> Tegra264 keeps the existing model, where BPMP provides the NDIV limits.
> The driver derives the current frequency from the core clock and
> reference counters.
> 
> The main differences are:
>   - Frequency read: through system registers, as on Tegra194, but from
>     the 64-bit architected AMU counters. The reference counter ticks at
>     the system counter rate (CNTFRQ).


Hi Sumit,

Thanks for the update. All my v1 comments are addressed.

For patches 1-7 and 9:

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

I left one comment on patch 8: the two AMU counters (core and constant)
are read separately in a kworker with interrupts enabled, so an
interrupt or preemption between the reads can skew the computed
frequency. Please have a look.


-- 
Thx and BRs,
Zhongqiu Han
