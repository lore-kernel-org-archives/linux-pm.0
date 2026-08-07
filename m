Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72C47886E
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107938; cv=none; b=fWRiPkDZHwDxkEFia3ldMCp8S1Cui1CcamA2x2+ZtGUVRiqD86/xdIknPGRnpfMcjbVJJwjkcD7pSO4OglLc/RZHp8tDVkwyHwnIHjz8PkMJvkBxzOwcAAY9kWj9YuAc0mEXVHmWB8Isp/XN3mlGugxX+BN1ZPvN6jpgeFp+4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107938; c=relaxed/simple;
	bh=HYxymFoJm6RTuaDqJ7cRBG+V1mDHMjPSgSeI7t5ZWK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phdrNOJRTU4gl2QfucghVCq1sen3Fu/NoGFgU3XCtx1eKDlhmydVv+9dKQCwghh8SUKrcPzXSZuc8tjKrGlVuQQ6y+Msxexyl38HFU4nnYZRBuCmX7gW+bzfb9LL8VYOvrFG/XRCSZyahB4RW2jrrZiqq3lTHFTIrssfiTilH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gv9eNFme; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gzNc3zst; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gv9eNFme";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gzNc3zst"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgKe61294574
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 13:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPSj/US9YmoirR4APoqZkFkgfkruTVQ3Bn0PlYTwpLo=; b=Gv9eNFme9NRtsz64
	WtQXMjIWbpJKt2IURqnywaVa1kqIKm8HVzxpy9TIH3+XxGH2rb9gYjT4onAqPnTh
	BkYxZrKZXJG7aLH7w8qhyyYki3/4kGRnjiVfgdZo2AwEKdazFKGKT9PIbc96zMGL
	uYet+/wowckoYnQluPWFzeCnXCduzT//yRMTczEBeaejfSg9PkzXxOq23c0Haxcr
	u1Dz9FJTFtX/I7eoJn25l8CFNKgfU59I7PyLjRys92HxhB9sqD1ecAZCkozaIxOG
	OnKGAuXsVwAdz4UILFnGaV0nntXBVQ15MEkl+E/AJXagzfN855hwmrYGih3+RnSX
	adpABQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gv273-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 13:05:30 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c2ae99c28cso467984e0c.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786107929; x=1786712729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPSj/US9YmoirR4APoqZkFkgfkruTVQ3Bn0PlYTwpLo=;
        b=gzNc3zstz+vE6hgheZny7F/f55fcqggkyW/aIjhmtCEIStj5h+nQgwSvzK7+eLoCUv
         ZQd1k8gI0vplzlss/5mqhzfx6gC6mR+y9thawd548kAEbOZHOK668p1gjbixPe7yjlKL
         mpsyDjrakOeFF6cs5riw6sVztMi13Omy9MlkJdObKY39Y/gsIgbAB0/cMo9pwjBBnvDD
         A1sMhBhcULEsCkCPHOgKXbQiqpu8HPQnYKpg4a3Y8XSb4p59OvrOXqxdvMhjZhA9zcWu
         KJMyiLkWJjQdsh8MCFrh06nlhFAlGGe0/vakb5lV7V3AXbCCitM75MgkKSKToyfguzrv
         +aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786107929; x=1786712729;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPSj/US9YmoirR4APoqZkFkgfkruTVQ3Bn0PlYTwpLo=;
        b=Of74QkApzQ+8EnuTBuFqBODP2QL1bAUrRm0Pr1ip0iP8swa8C/CcMzx1BVqv9OsjUj
         L63h8U764/G+UifvkMdaWUjVDrx8ivGYxkf7KWztwmczjI0gPvVFo+dp6PGYhdRio3ia
         rxTLH4z2DXSlpP8GQKkSYPTg6Ac2nNDwXZRD6mydzrKrGbHm/elcGW86J/jlt5am5zUX
         5NHKwTg8u9UZKQyOybRGzI0FbCmg91xSQVt8CqhB+7UbPERnQMjg6g8IZNeF04rPHSpm
         IlvhrQLJ+NGU7atzvJii38dYEO7OAaUms5jSeZzW0bnEmqGZID2rjF8wOXCjvmbgUfcL
         BrfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyybXXrHcSZbbSdRJXDT1f2jF5UX83BKXRbxhwd3ijaX+OlK3j4WYK/eXBZM2yhchHKYDcJgJWFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSAUCCNemPzCrwGN69mQ9hKgilp+/zMd2azuKm71bZyypigBp
	b/buL5/5QcpdCx1VTV8zosCGCE1L2Cke6qefeGjJ7ykr64cNVNhLpJcYBpKfOuBtvD2xnP2p6qL
	LjGPaBC+uANYQWUx8PjRPol8ZfJToX4AepnZp3jUReD+sLHzIUNgvbnb1NSMfrQ==
X-Gm-Gg: AR+sD10HfRkg7iVr02pRITxPm3+SEt9pmfxkFMtnkLgb/kiHsrGAXCObRxzRz4HjNC/
	B+eNTVH6S/fmoIotjVttx2qAUHRpfF6oQFLbd8ppBAyp6E6oIybByjj0YIdAq3fZnrPg5muQsvv
	psejRTewcOI6YkjpaFPBAnHt3Z81iZbwk0EwRju0ZvbPb0NN9PeVYLwafajK/im+6GwXUhJVYat
	N8Sx7V5uudyLK2TpO/s+knxns6Xz4Mg9wVh6WvykVjqLkYXnqxdrMFFpYxPTDewm3uCL0eGlgRF
	0PUBJHAyE5Rgxt358HwKFz+mWTh8nSjMLuywYe24HFJ4v93FeeLx0SznKw5Ua+Mx7p4CyJ4r35T
	iIZ+eVRcFlSNmjv44MpcR/sO69dON1DJDo3blnZ40hBX32w==
X-Received: by 2002:a05:6122:6609:b0:5a0:370:f12c with SMTP id 71dfb90a1353d-5c409440bf1mr405010e0c.11.1786107929345;
        Fri, 07 Aug 2026 06:05:29 -0700 (PDT)
X-Received: by 2002:a05:6122:6609:b0:5a0:370:f12c with SMTP id 71dfb90a1353d-5c409440bf1mr404933e0c.11.1786107928770;
        Fri, 07 Aug 2026 06:05:28 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145971sm5546657f8f.8.2026.08.07.06.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 06:05:27 -0700 (PDT)
Message-ID: <d490d92c-01eb-4cc1-8b03-fe39ca087412@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 15:05:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/qoriq: Disable clock on resume failure
To: Can Peng <pengcan@kylinos.cn>, rafael@kernel.org,
        daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260722075625.452684-1-pengcan@kylinos.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260722075625.452684-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75d81a cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=DKkMA6O2ID4Q9JsdpvQA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: M3uFE3KzJ_wjR22jjm6JfykTHoKUgg3v
X-Proofpoint-GUID: M3uFE3KzJ_wjR22jjm6JfykTHoKUgg3v
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMiBTYWx0ZWRfXzjyyM2JTpqj+
 WR/jle88OAQTOCmWowXzCN2hD+AJ+etpkIcjIAXtB/FSYeHm99AU+sLeaL+SbQgZKV5mUbDJYBJ
 cMM/Q8eJlYqUkJwg79rrlWC9swH3C9c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMiBTYWx0ZWRfX24UBlr/1boLD
 KZ6uOBpchz4BjZeT533v2sIbmNk0nTsHa+nBNH3BmX4qQ7UcGCKIP5pLzNbnmuElmjzVERqQU0w
 V8GhuHXNmWM0hVA3bhc1Ix42KwJAY8CsAINOaPe6suChlu+IJ37SGGU9aojZaUoOUcF7uE+IjPZ
 227Cna426Vk9oXL4/zK9Cxd3pew4GVG92+EASZGAkgaWnuRtwY2Zzst9FHnFVIt4vVstKbNFvMd
 mrCPde6dAnj/6iLJUGqidzsdQpQ5RxcXtc98l+7NODMs8GBWUDAT38VJPZK2JXsD6OHRSbdrHkT
 4AgC2ubUF+n7LIgbixAnJsbkv3HhODLAO2r+dUgoQ5Kdngd6KderSpJnvAzVlh7mhHNrV3iuJRM
 U2kSL9oeY4qBO/q5MXboRwC5S1PeuhRtaUG7cslQ6Jdjd6EUVgr+54jy1LD71O6olWycobsOjTI
 JhTw2WThjh4gktWl18g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070102

On 7/22/26 09:56, Can Peng wrote:
> qoriq_tmu_resume() enables the TMU clock before clearing the
> power-down bit and enabling monitoring.
> 
> If either register update fails, the function returns with the clock
> still enabled. This leaves the clock enable count unbalanced after a
> failed resume.
> 
> Disable the clock on those failure paths before returning the error.
> 
> Fixes: 51904045d4aa ("thermal: qoriq: Add clock operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---

Applied, thanks
