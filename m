Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A22F7AC1
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084002; cv=none; b=cZhJVkJ0tGdGye7iKv63qsU/Uj2NEX1V1aCGaZXEMHXDIuXJJlq2BUPgSr6cClTpyMxvx2P3DzH0Xkr1t5CempZYfhpwzr/AJuvpsT+tpqdUj43KtBKXTx7uGlxobk6VTXf27t7zkVYQnYc2/ytX+j4tsKSKoJb2xeH197et4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084002; c=relaxed/simple;
	bh=dfWU5dYj3BQEe4knfdrGEtREOTcs2SuFMqVcgJeSZrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KM4hFoTyhAmRXVo1ZZ9rfIk3GnLngt+6MuyWl2rXOI2YoRXT6GUgNFsMhdV19fZBdDQZGa8DNaBMfa4QYu0X8xI1MeqegapSD7zRgFjYn0YyCp9X+IVTOlc/pxKmuiSX6PW8tUvKFrG3OCgBA/I9+/UjWAwv2GxUeoM5auBJcho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CnPBhQxt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jb94o9ae; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnPBhQxt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jb94o9ae"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7hnhx530869
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 09:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7QtHwMUeXsyPxSQjQqL73zv+JFnpAINM6rZU7wAG2nQ=; b=CnPBhQxthA3sBLC1
	FtD63LOo6GyfL2cBmocXFU8Hot00Dr16VBheg2JTDSjEHqJ+sZfOsJmlyFE5MvLo
	0xGl0tAzlt10jZqRqVBFQDpS6btZe0zKy8Mn3YcLB6GxThPgOBRjW+eIAubdfa9i
	mKbs40KS89w7AJGqtyfefUkUWnH4+Micg+U9Qwz96h912eLrVi8CzqsdW4ub5Y8r
	TyUheMVvF2C8cQvcCITjcDwhUqAYS/N5xvU3kETbTougPQ9M9bvl5+nG5PNwArme
	x2z5KP9AwyYFcy2WVQHDKlAPM++3yvX36qw4Es6KQoyyqD8yhqUeNqPB3m9QGZ8I
	skxk8w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnh1tfa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 09:33:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5178ac43d27so17985901cf.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 02:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781083999; x=1781688799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QtHwMUeXsyPxSQjQqL73zv+JFnpAINM6rZU7wAG2nQ=;
        b=jb94o9ae9RIqVfIwTpfm2XXGc7HA4u2rudwezfouIsBeXVxzglgPjot6n6G/KZj62s
         jem8YjL8kt5MeLsDTc72dbGmK1WqcbWFcUnSKFBgfo/5svum/QtarC0jfB3uNykP16Tl
         xXNNx6UyWwY0Nr30jyqfNyBD1oqIbT69tlXVoHjunOJfR2TIWcje75KQpoteYRynBK0T
         YDDFjflkn+S59UPyIjRiBolFTy7iIctTWxCbjbDcWKTNtMtRCmevcv0Q7rn7Ev0b4ZYZ
         i1uGda1shdHNUH/xGiEKdRJRBJ9Z4wpDMaVd7MTIjzVuTkW52gRJwAKpuL5kU77gPfIK
         bkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083999; x=1781688799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QtHwMUeXsyPxSQjQqL73zv+JFnpAINM6rZU7wAG2nQ=;
        b=TRH5P2KLHBEFhmln9pK9XXQFLj86Nc7Vv617qvTBXupcB+y69c6Ro/w8BTMipATJCJ
         YTGIgC7tbRzWLX3+K9K1DRBZdG3+rzdIuT8XRxMVeKsW+zPw9BIspzi5nItGQWlYUk6N
         9iXtxF96g9U+mWaRDEQ/jZLXWJ9hzc4Ua03XHhKzVFged4b9igYwgtc6s8xcBWRsVIPQ
         ajMsTrmsY1702/FGaLCb9lrEIonu41NZaOoRnSiB3kftrMD7QpfgDLjBQA/P1i3a7ghW
         DoI9255rm27593KKgXTYewrCd+OWtUQJwrYrUVVS5AQxPDqUl838x+K9I2Y604YrgDVz
         xFZg==
X-Forwarded-Encrypted: i=1; AFNElJ/EEyJE4pZzMyjkUmFBGokiGkC+A1WUmWz+dcVgrhitZ+nSW7NcyEHFfyAhHPk1Ym3qhxXccaNVew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4bA8DxwSZnWFwm9SdNSgrDcPj+tRGYlAm6YH28w8zSA5N1G6
	i4XzrtKhoMtSRS2gAG0wnxnIYmSrA14oidMUt4AAV43SUBX3/C6Hps4k/LcldAjRDCji7oaOy1m
	d/znm0e4sdb5g8/LkhYyM8yrZHgW0dXMUyUbq+mpL0O3Klkf1UwJUc5yiwab7kw==
X-Gm-Gg: Acq92OFZy2DiC9DCgVj6+eF9rWpJAoF+e8Ro107DSAQMNhOR2qB6PpN6GIit/t1x3aO
	5hNJDWaKj07EI8bbiihGBESVSZhcXnZd7VVDgy7hqm36WtjHIG7AFIuYWUHlH+lhs30BKxXacFM
	hsyfbmceepI8B26iOvymW+BmUnVZP+ofgcsrR9bMj0EaL99XGbLWgX7C1RYx/87cFRxHHmR69Yi
	Vr9ujK6/H5sLb0GcGJmF/JwV7GQO33eHxNl1dxHj8WE08YUSqFZp8fJbieY/+xrbonR73rFJJGw
	ot+EeanYCG25fgUPVehnN6EzxgbqGz7EfPPujq8uxyvWnxBbCcEDJX4koxb95aJlBjTRCn3ltg3
	UrZgYwbJf6bwLBfeLckJ9K+c2LENxYwU7hIKaXtQEYn+iPid1sth13ydP
X-Received: by 2002:a05:620a:2a12:b0:915:6433:2599 with SMTP id af79cd13be357-915e6cb8633mr659876285a.1.1781083999346;
        Wed, 10 Jun 2026 02:33:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2a12:b0:915:6433:2599 with SMTP id af79cd13be357-915e6cb8633mr659873685a.1.1781083998886;
        Wed, 10 Jun 2026 02:33:18 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912365bd3fsm6107733a12.5.2026.06.10.02.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:33:17 -0700 (PDT)
Message-ID: <ca6a652b-b13c-4b28-adc2-3101c053b959@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:33:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] interconnect: qcom: simplify allocation
To: Rosen Penev <rosenp@gmail.com>, linux-pm@vger.kernel.org
Cc: Georgi Djakov <djakov@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
 <linux-hardening@vger.kernel.org>
References: <20260609222454.37352-1-rosenp@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609222454.37352-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA5MCBTYWx0ZWRfX4HbYO6GgEecO
 0rp51saP8x5mO/ehswtG07oF6Ws4261RAW01537iRWyQ2V+jAfog3qb3V41U97b0XMjv01Y7WRE
 5YAl7pDSfCXujfSeTqdv2abf3DL/xChNjGdmBL47OyKh1sTpkyCXJcE5SI5stpsvcZ6fj1UzfuX
 Lqj/uV9U/jgC3I+ENowbygoaJTnvrRdUQyV8pdl0iXiAkjYYov3MeYC2FTJpL8JdIezrVuURMua
 0q8xfSKtbL+VOaBkxHdzy8RehwvuIJKOIAcc1k5GPVKZK2pyKF9EUBNfF0xbateQGaWXuG/lQru
 G28JGLhNpk7KZU4O+cae8LKAHhXgbZgQlqdxKWVZ0KaXBoZBNgaJsHm9jzTqOVSCsJzPL2h4B4S
 pSan8qoSv5zKSZk5CyaLq74ARk8pxeZuCaz3gAImkHpweghrS4hzXRdyVWNLpe1re6m/7bZHWGB
 jPMG3Tk6xIqzV1tZdgA==
X-Authority-Analysis: v=2.4 cv=Xce5Co55 c=1 sm=1 tr=0 ts=6a292f60 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YpBc5yRqulYp3uqBtjUA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: dXhVV3QtTvsbK59C6XEIzV92v0nWBDxP
X-Proofpoint-GUID: dXhVV3QtTvsbK59C6XEIzV92v0nWBDxP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100090

On 6/10/26 12:24 AM, Rosen Penev wrote:
> Use a flexible array member to reduce allocation by 1.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment after allocation before any array access.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
