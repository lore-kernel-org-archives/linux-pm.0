Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5464EDCDC
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613548; cv=none; b=VSWoeaiWwqcneXDWEmyelIjmbIdylpIrPBijFfHCk3rwx79UDWtOp2R7tmDaPNKhmXdqD734ig7lzSIWFdv6eIY7a3gMsUPKxihkrvFG/6iKRTXhzcjVHS7ZO/9rChSDrCwoUKW22nWFVsOA0Ub6tQt6Yn/u6EhEi4qu87iQ/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613548; c=relaxed/simple;
	bh=1OM0xxmfPlmrzLeXTiGMugRceyJZCw9goaygkV520jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOIbOSBwtO/aoGR+uTHHXErOGyXJErp0kfO4atdjKlGuXq3YtEEV0lqFw+6ufKbhJD2cC1yOAB89ZMddi7cWta25j+eNyMPkq8TZNMgWzCRU4lDHdDCo8x6pYWpC7v+FHGEZakjLwCiD2Yr4Be9zXf8ZCaYbqrVUlYFiUEctCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kpu1VRu8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XYZv7BF6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kpu1VRu8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYZv7BF6"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe2gi379938
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 16:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DUsMfJUwaksHlxsEcq32eVHfkDwBOF+f2hC2dQXfwWY=; b=kpu1VRu8p/NjWQbl
	7pu2zawB1/ZBkYSHAPg1oJ70YsGgnFF42ejSyx3pIjvVq1jV8m3peAyeZEqlckUC
	o/BdpwZ0UEcWWYobFtHcY6FFSqSFqmrLIQCC+YM7kK+4IJOp+bm1p2mDgwUY6ykX
	b1FCcXaBLwKbFlOSTR8C1aJ5NCIPG1e0mb3Mj/qpSoj7jteovf2BNEW1Q9iYPn8K
	0BkkFMe92ZCMwjAAaF9JFGWKTiVUX6MBuw3SlOw1iTL4EjizzrkRY6Zi/vyney7L
	ldd3BOt90BbVagC1owKvQccsZ9lDacZw07mUrmln1CuvyHAkL8Nkm8iskhBhV6Wc
	fyvsNA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyqx3956a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 16:39:06 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7a77961b860so504900137.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790613545; x=1791218345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DUsMfJUwaksHlxsEcq32eVHfkDwBOF+f2hC2dQXfwWY=;
        b=XYZv7BF6qA961Q7esoMN2BEYDBySkEjaWDQvnQGrdvMKvESiSBWIRwDpfTAXbpZT/P
         4i19S7rD1odG9MxuLbey57iVgKZp0inYsO3lzx/OYSExXsv3hOQ1Lsfoima8ewnZ7VM8
         ym6HVWtb6PKlr5FgwyQBWDZ0/tzciK4M/IFB/+K8ya/IFpmwegiVOg72rz1jaQp0qxa2
         s5C5I8AXRIUfO/agFpdU3UvCXRqt4s30coHyjm+E/qHPJX13/Erku8Q9TvKo0JqDUUar
         mMTOaykvRhhhRLv5+yMmBRiRcs17VJVdHJebggkt9JdWPDnbhmtqyYpz1bsvgyETqMIh
         KmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613545; x=1791218345;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DUsMfJUwaksHlxsEcq32eVHfkDwBOF+f2hC2dQXfwWY=;
        b=InUjBiIDKEKQhhHar2VQvt5/fvAyBd23V0Ft6+y2GJYWS3PZZBAZT8OLCmB6PTVcxh
         TBb/RP9qiT0OoGmHucDQiXI7kJp7QBxqxNYYwEhsAybEOqYkmoUzg56oD4VIPy528oEx
         Yxk7NtLDgZO9p+/MdOrtqLN54v9nG/x0nbQ4bwoPiUUyb2MLSTq0RjuQ4p0Y+6UgQeFW
         igpzPcEKL+PQu69YYZ4yXTiZ7At/x55LPOHpmLGhtb8+lj1aPRT6jNfN/jervkmzFM4P
         19qDUDN33ojnKnz0a61hlTxs8Ien82/jMQEPIFLgSbfDIhb7ANLR/HOFG/wEDg0xQqxi
         HTrA==
X-Forwarded-Encrypted: i=1; AKwUvBx2LRIfDyzTutVJABcELzpP7MK0MfmxerMV/XcGwX7OKuzbGzJvzj3HbLD0P1DAX5j7/sceAkZk6A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIqjMzEIKJTSojpdJaiIydR7EDa9ufRGanLAnGSEXciz5gckyYo
	wyLRP/pNWSVscLgME6wB3DJKN51ubH1zteKfiPZP4smtSw51SuSaU6Dc2y27uqF5Y/S1Kg8JlAs
	I8I2f7rPAz2/IMUJXk5r5irlwCFU1Gz+i0Cyyyu7RUgxBMVdQTDWW+R3j3IjNOQ==
X-Gm-Gg: AYBFou36Y6os7CnIchj+i6gKfr/J3w+dfKbGrFlIkQzuNIBprkt/lVoM7CnZVGsFmXo
	JPR6L22rjqYs9dbCdxnJVaZwhyvnq2vjrRIMlc9V0Z2iWsR9Y3x0PMNKnIISRFWB94eXQbKFWlI
	3hpAnWK1FkprBSpocRZ3xB4u2HRwCtn/fizE65GHIMHzlsTdNpLCJSeSPVb8bnXsrQ8L9pib44g
	0kdr6He8Tr1QVTy4IIQ4L+OLfUQewNtLIHzp1Us3ApUAFY2rxwZoRpGBizN9XmvyJggZMQbz3Xn
	TpoclevvGpo1glldDvfYI0JYB9abN3xni3tAm2lM6CGe6tjlHdJWTUDW/n4AP0ZjW6ugdSSauXa
	lxyKA4nUzpy59pK7wIQ==
X-Received: by 2002:a05:6102:4b11:b0:7a7:195a:1b2a with SMTP id ada2fe7eead31-7af1f6265b5mr3903288137.36.1790613544919;
        Mon, 28 Sep 2026 09:39:04 -0700 (PDT)
X-Received: by 2002:a05:6102:4b11:b0:7a7:195a:1b2a with SMTP id ada2fe7eead31-7af1f6265b5mr3903273137.36.1790613544417;
        Mon, 28 Sep 2026 09:39:04 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.7.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf869c4sm4848055e9.2.2026.09.28.09.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:39:03 -0700 (PDT)
Message-ID: <65844a7f-62c0-4a68-8034-6f74a43e32e2@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools thermal tmon: Fix signed shift UB in binding
 display
To: liujing <liujing@cmss.chinamobile.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260903082858.5273-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260903082858.5273-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX03Xk7Z6+7JXJ
 z+YkPbAOcU7SGOwqQGQrLin+YyXPXIUbtnB4jcsKKiech36AgNU/SUDmoZLEdc45okPcqWICH+S
 BsDIhjOtgGhpPKvIFLTpbNeBtMVHROsR9Bph+eHt4ZTfuC339ONpx3oDbWpf7kAa8uILkUJdBsU
 AwOnpkZB4sLUqXBRa2y5LLcXnzgPB1NtAZcKdevXOUA929lfQjOduCyw9+xgLBUgxCAqf3X7tQO
 YRl8mie50CC7J3VFmXCdSXwj6UrKBxHpom2wggBtRfNZDuqBQWQq0m+olxFdzEWB3E0qwNDQTVs
 ce46vZFl8QxixmC+YlsUnsStuKcm93+Yesny/stDKhmMxGFAMpwnOX41QHEDmgCbvJzcnpnysBo
 H3gnu+I6Smy/yn9o4XsXhAaUsp9HyR6RzUbrFHIlaCXBVN98vlTiemiNyh0PmY/1wlrs8yRts4q
 K/lRYdELgxJbx1pi5Sw==
X-Authority-Analysis: v=2.4 cv=f7jdl+yM c=1 sm=1 tr=0 ts=6aba982a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=K71sKCzDSiMJbZmyObbiAA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=R5C9hjxsAAAA:8 a=zsUnVIdILLzLelk_SzUA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: Ngec7CH4i__xwjK-IV6AKrYZMbu3VZI_
X-Proofpoint-GUID: Ngec7CH4i__xwjK-IV6AKrYZMbu3VZI_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX1D+f2kF1YzeL
 vjFl5RD5eSO+xJ+FzBMhMaMtWb4af7+ZAmk2ia8X3OuZkRN7dRA/qnG1aoq3TvD+ZAoBwKC/bUz
 BidCpqZDxEURiszcre/J62k10axsyx8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280066

On 9/3/26 10:28, liujing wrote:
> From: Liu Jing <liujing@cmss.chinamobile.com>
> 
> In the thermal zone binding display loop, the expression `(1 << j)`
> performs a signed integer shift. When j reaches 31, this sets the
> sign bit of a 32-bit signed integer, which is undefined behavior.
> 
> Fix it by using `(1U << j)` to perform an unsigned shift.
> 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
Applied, thanks
