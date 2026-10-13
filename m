Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011D37A83D
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881445; cv=none; b=bM4OY1xBYU44ZgwaE8ZOh5Q7aTT+zfAifu4h5ztybyDl5fAwSHj6c5MLh3HjIIPIpfE4psaA0bVFOwVQUY+FCxj3eOvD43OgVAp+c+lBo3lucdb5UytU91+h7JsM3YKV0hAvTBzrmrN0kALJAmN2mwvYMPcc7Mtmoa8Zj+Ob5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881445; c=relaxed/simple;
	bh=rrsiypGh0+gRn6w3CWCp3ePyqfW44mmQknjAly7nC5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2GCzLjo5d68wWtzIDDuxttfn1Bo8qN+gHaFL9cN705yBnYq+szLYyzbpvin154QPrkw0p3aLRRf6TjvjCsyPGROdI5cv0rLnvWrRMzrgwP7rWu9pfSphlXyVwnn5+cBRUui6Hp0FNBfLqOLLAOprDhkKb82oJjHw6ieWxnFNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iIj4RWeT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=asudoHAc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIj4RWeT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="asudoHAc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8AFX94071943
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 08:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XlN+IOV4cTreUmbElrbiU6XHdrsCIyblNEqpVHZhJMw=; b=iIj4RWeTko9Z9QnC
	YzjnKJocE9i4x8nXCIQzeeRxl5s/7iz4xAfsYDrheXUYWOmA8mIgx4rEJCZ90M7u
	VRU6gjdwZ3NWz6v7ehJUxoH231ozL32mOx3KFmajAy5Xta+EkcukXv+KjRUTwJ6C
	hZHy9R/7tria0QW+STmCFtqQU/SXBAbD3N7YTHDVLg1jRRX+nWkAgLSvFHoDMuNj
	HS0M7reD2DPpc8EfXy8eDlfWe+wRqbJj9pWsY3FCgrzB7/4PZiameJ2qoLqzMJ63
	O6FQu4cnB9r/b3zYi7PZmTKta0jN9DtydcSsAUgBhLtiSD+CnLfkV1NqnfB2ogjh
	xK/cyg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h92jjumhh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 08:50:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e46c120dfso281061385a.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791881443; x=1792486243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XlN+IOV4cTreUmbElrbiU6XHdrsCIyblNEqpVHZhJMw=;
        b=asudoHAcm3h1Vrp4nXvMag85PT4aJc+fnDtgCFiOtT7q+Rm1k8rvBd7z5aROATpOjJ
         SzS+gt22SBGeNme+JcSj9iSTawuR230DxCF5owfhHrkPWUfcGfJS8szBcLzNKTMxZbIw
         pMZZlEvHnRDgg7pEat6AKBpzEqWE/k2XTZFLvQSuIhVNn9CAvngP1G8kw3uku4VXEa/i
         mXV3nYgnWUSQugQ4w7B/P745r7CrPA41/O9FrisXml2Cac9WnhGM6n7fmVDieSq5xCH/
         aHAL8e/eH62O3dK24r8XIUkjlDZT5jWi2hLVSv0AR80YE1Mlo9qMUA0qRFrnlbNia5nB
         PIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881443; x=1792486243;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XlN+IOV4cTreUmbElrbiU6XHdrsCIyblNEqpVHZhJMw=;
        b=ffM580JowmEKGLbrPM4+a9H0htFGmZA9L6Kb9zNNqCml34uPVN7ezuKO+bXxs0cMu2
         gr9pYI95xfcXLizRnEmdA1tkmG7/EvJyqBGvLLpnv+eHjDhgBD8bzeh+qgzopw3I5IQc
         vaFIzfsDTbl+eVKZchnMlLUtYc5vmY5+vsmTCCb6Ji28ag2YN8eRqlz4fBoUo4UP/Lzs
         kvFtMB/ReLGJfJXLLCb1o7gL4jQ4kBrC+wGDPfPq1rKyLpjeBkXQ+E+AmDibJYy6RaOS
         Dp5tAOtcyqnS3EVVOFUpvolghdXX7SyO29fwM4IFTORbcrhtfJ1p4MJYbAH7tK3AOqsJ
         L+DA==
X-Forwarded-Encrypted: i=1; AKwUvBzK4djAxxU+93n4XXeo72mYaRSyZYKWPgqFCfvuSWiXXS00gWZDD7xVmNDAoskB6gQI0LFdZkZLgw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKDGJxhWSLQUzZfpv2xBYtblIOy1TjDBVhshyAIO9nV9h099+U1
	Epn0VYuEgjr7sPGJY5OG3qRFrextPvoAQ7VA7X0swEWNrdiU8yJXBzjOc8+9H6ki+sdrbE4Y1aK
	W93hVJeSIcY5YSuKmzv+cWPjg1PaddEqdX9scmKTGTiyVwg0vAjj6Bw/joNZRTg==
X-Gm-Gg: AYBFou2wCMZpD+ODKAKEtGFGwWbtk3wxZow8tgKcPdxFvF8WTKoIqc8EQEsxAjbk5d7
	/WxzpynWGhLjBGl/EqmNa6ilAJzvWK4ESld5CND7kGV94Ue7dgmVJUNgLaPQ8a47T7CClNb2OAy
	x3/Hn1NO7YhjoC/z2Gs4hcJbjeV8YjxPg0UbYz3aCV/rk4SM+xI+7c8ZgPESIfJgMTaOY5VO5bD
	Iw+tdDhEBrXrd07pGl1FYz8f7AxKVv6IHp6XmRhfZrzTWD5xn977WoUqBsyMVVZrUDO+mhDzbfO
	L44oW9hA/e+iSJCljTtb9NBUkBY3bLYmFA986SG/baLmJn3nxutf5Yp/XkJkNpTrQc3mbt2ufUF
	snvLDqkbLV5YtNqDH+2l3aThgeqAAqpdcotd2idyf6Gvj6ZQ59P+bgClrETzb4g==
X-Received: by 2002:a05:620a:400b:b0:93e:c12c:fbca with SMTP id af79cd13be357-93ec12d06bamr1573657485a.70.1791881442702;
        Tue, 13 Oct 2026 01:50:42 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:93e:c12c:fbca with SMTP id af79cd13be357-93ec12d06bamr1573655185a.70.1791881442030;
        Tue, 13 Oct 2026 01:50:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2e0dbsm370949065e9.11.2026.10.13.01.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:50:41 -0700 (PDT)
Message-ID: <196b51ef-835e-477f-a46e-575e37bb17e0@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:50:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] thermal/drivers/loongson2: Use bitfields and
 per-SoC thermal ops
To: Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou
 <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <cover.1791512067.git.zhoubinbin@loongson.cn>
 <1375bd12403bffc496261953772a45833f9b5a3e.1791512067.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <1375bd12403bffc496261953772a45833f9b5a3e.1791512067.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1GYvPI3Ceozr2aVvqUl7mqzFZ2JWrm78
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfX6VQ+WvB9/M1Q
 AgvWWn0ZCoxXwi3Ia0PHLxCFP3lAfK6bqs5vABxWVa6fcvq+fq85lgiLp8w1a9VcP11UVOAq4bh
 Gx1iy7FAkbc0eYyCw6Qjg88iPh0hRZA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfX84uo6zAcou7l
 E8b/hQZls2BqmsFJBqYUtgx3iDvaU0XBjO6f9v3zrZt4tnJNVYAZq1+C9V0g190btyekt3/ukIO
 g1u7hUsJwbVCrYvIYZcuIqJP5qw9a4Bpl2ys211T09muFAHellDepn8KhG3tGPFMdsvo3HN0jtG
 8mjCBAFtkd8RwHbIQHC6H3UKb+7BUhpJJsGJUVb00KdBCDqLR7BiZHPFfQXyfZJ/to4fk4UGIh4
 vI/Xqji9d4Pe0io3Y5vXyWrWQNpx2eOAvbXb7y1ZA3s1aw11D6kxgUZO6p1mp/JqZlhXCSbIt+7
 rQeoW39NaFndeUpwksQ7+1tI5bzedLb1XSruEIBEEuvyM0yFamr+mJlotM7fkJbCU/3ga/sO102
 bbTTosfcBXwptpMnxVPaewGLzJebA4kzgbo5wSHT1MjxUmSk6bE1gh+M8d7DcEIo6LvTkbEl3w7
 NJbZ3h1PfmmFvUGhffQ==
X-Authority-Analysis: v=2.4 cv=GfKCDgXL c=1 sm=1 tr=0 ts=6acdf0e3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=ua90ykTK0mPAOTE1wUAA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 1GYvPI3Ceozr2aVvqUl7mqzFZ2JWrm78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130035

On 10/9/26 04:58, Binbin Zhou wrote:
> Replace open-coded masks and shifts with GENMASK()/FIELD_* helpers, and
> define named constants for the Loongson-2K2000 temperature conversion
> and trip gate calculations.
> 
> Split the temperature read and thermal zone ops into Loongson-2K1000 and
> Loongson-2K2000 variants, and keep the chip-specific trip register
> callback in the chip data. This prepares the driver for further SoC
> support.
> 
> No functional change intended.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

Please use the bitfield directly in the previous patch


