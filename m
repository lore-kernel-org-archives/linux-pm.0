Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C113B531B
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158861; cv=none; b=LA92kFZxFGzbMsDTPx0uXYkNTWHUbeLVvfZIguTQa3pN9nvmBW5v4GGBQDzjGGD1FwHUF1Tf3Z/LKTN7QzLf9FBUyLd6w5n7VDWs58xl8nO+Y31HDWTOQj8jPVCnvfyuDSqMDw9AwcgUtUCTAHfQMA/isghiP+ztxt0BCvRRLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158861; c=relaxed/simple;
	bh=4+OZXRJn2PTrFB3cidnhlXmOLT/TUxoYTbD5SdiW0vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsyIT5mPg3qheWutkjpx7msboJ1eB37FBtcsRcKB69QdGcGVFMJPDi2dd/VxSJZkN1HZI6zuVOBdHNFged3nhOidgMj+jQo01mJu4JtyxsXXqp15hTGZiQnVH51KMhMVGvKlILGXIB/1CQBedBUOcoS/vxbHHF0v4ojV5FFjqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h+Y6CQOH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H8qQPdL2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h+Y6CQOH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H8qQPdL2"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6V0hA280759
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 09:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V9NYOzs3gNV4L5c6n1IErZjssEPAfF6D24GIAKU8Q4w=; b=h+Y6CQOHmqD3430D
	Fg+7KdpmH0tqpl+2HeWW9MoPmj7pAHW8ZnkB7dVwr1XRSwts6SPcnhwdowJpE+x0
	NDI1ZuexHZY6LE9WTGn8r+qQvsjIIOZAuUZ95l9R3psnfiTbs6bOuTB53UAezKhT
	L4Kxhte16DnlO2LbB99ZYyGqQ4iWMSlXNk6lJ2sTfm22ry5zzauggn6fmG2YFugG
	S63dJ1WRk2hzs/qjyoupI/0eSHa5NodVD2trkgJoO0BxfjDe5P4JRWrdWL1iWZHd
	yPYjN5n4X87bIFp7STiWASK+KqN4KIeANEqPDuroYkOsC0y/RHjAPea+zCWt2OTO
	UyLMNQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86vj2h2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 09:27:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8acb4b340f4so5151076d6.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 02:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776158857; x=1776763657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9NYOzs3gNV4L5c6n1IErZjssEPAfF6D24GIAKU8Q4w=;
        b=H8qQPdL2QA2zso5hD8kJ71eJT7KXeQgOKRQ7latvXfz8AsWYqWOqmR1TBJxUTF4F0x
         +y684pNz8PqX33UpNATzuEOH+Y5Tc6DQu0/PDb5B1teZremxUycGXbGRx+UwQh1QCqw7
         wv5SCEvj1fvc6FSZU12W0e9ZtJq8XE2hfdTOYIGYw+tGoCwGFxBpudfw87/97KSlN6T0
         Sae+IVrPws+5LefK8i7QFH2aVU3rPkQfRStF8CYAS7+fRjGKkjuS0EPp2YqrwsLKxtk6
         Z3MM8V837QTyB0eWz6lBBf8a8XV8bG+9/XqfrH7zDqdS1YC5ZzItN2mLbJew5YOWUFQF
         aNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158857; x=1776763657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9NYOzs3gNV4L5c6n1IErZjssEPAfF6D24GIAKU8Q4w=;
        b=ZqINCmgb3P4rx2LPM0OGhFXcRNy9hftxHyXpOXDBw2zB3rq+c7Z0bi0auzkJ6cpOMy
         BTRwWGLKrAKukQQ/JQJXPYFItAeYo8eMOb9+FnN2wAZu5A20DCQxNM1/3iLvr7ITBqSv
         ptECRa9yHYdGV2kkNsjWv7qngFA4cBb9WuBmIpMatzJBt+2f3o7iO/ayMVOf4flO5tib
         QBJT47Oke5uN9/aCFHMnWcnjqAjoVuogyGklepNmdoPtfddjMo35xdMaIyr5XA1RsWu7
         TYMSCRJGZiMOhkra6Y47d1cKRaSeW1AxFhHk5w7pW3uF7CRDtM9ON1IT1pGZABuqU0jd
         Hy9A==
X-Forwarded-Encrypted: i=1; AFNElJ/018AggFVpEmSxvWaVqDwD35NqGizS2t5dPCEypadYpEF88i583BLCTi6IvoafK8/rfSlOJt6c7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvX8JM1omkyxaQyh7dcN+qQQhaIQyXKJTvHNJwx8P0WzKkkMXP
	3bv1XJ+EQptWTcAdJ2/qZChxp6dFWZdYtIJfqYWDl2il08XZ54KRoZnNy2OTQWKzcaKKN/hJKFf
	Y+W4LErOIipM9BpTgz53INGjIuRL4U2OiPKgtTZjseAc3j1XoCtQ4aboM8Uadvg==
X-Gm-Gg: AeBDies9r35OuD3k7XvEXzbPcsmSEZxf445BUcOjukr6v/0EABc9mx3U6icpZHVLh7g
	vtxXkgAqD++WQ1dEzO+v91RyzKU2FVD6VzFGIMA0z5TZwEsIZZucV3dPQ1W5odFNm+3B9kr3RzL
	Im4PmUq0yXZT+a88j/iIFs4IVKfJ3RRLDs5uNkhqq0q37G+PMzqbGJYU89Cps2JJ8+LkbzSi0s9
	K0cWfkGZpIrzyUwUnLaLT6O5yEXitTjuLY/uSECy6MActPJ5MHztLj8MDrNoVaYu0dkHPvhDjIQ
	P1sFDLKtknWWlzVN/vOjns0lM0ZVSr39RSSOyuNT5KSpVcxY2Zn4yEE34ymMB+NzVRY9nQdHXJn
	aLTDEJDPa6dvvFdH7+Au5DiaIRBgdL77cpFsbdXlArebSlUffDLRDo2R2EZCE5sMis1pdOJZnxp
	xRSIvqmNTM1zBzGQ==
X-Received: by 2002:a05:6214:c6e:b0:89a:732e:f805 with SMTP id 6a1803df08f44-8ac87629726mr198075366d6.7.1776158857595;
        Tue, 14 Apr 2026 02:27:37 -0700 (PDT)
X-Received: by 2002:a05:6214:c6e:b0:89a:732e:f805 with SMTP id 6a1803df08f44-8ac87629726mr198075176d6.7.1776158857197;
        Tue, 14 Apr 2026 02:27:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c886asm383094466b.46.2026.04.14.02.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:27:34 -0700 (PDT)
Message-ID: <7fda964d-5b4a-49b6-837a-d8276f688a8f@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 11:27:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add power domains for Nord
 SoC
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
 <20260414035909.652992-4-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414035909.652992-4-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -ivTvGQRb-8jKcUT598EmmGwFjN6B5Kx
X-Authority-Analysis: v=2.4 cv=cffiaHDM c=1 sm=1 tr=0 ts=69de088a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Jpqku5WnjNLMWeEkFAgA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: -ivTvGQRb-8jKcUT598EmmGwFjN6B5Kx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA4NyBTYWx0ZWRfXymBCOQXMm9je
 tY46UlQUY1ABmGwdd1zXJB8YQdBnvAVSvt/nQqZULaq8JMjTei/UaOQwwHbAA2To50QFT+IJMWu
 UCKldXHSo33EgajYfYq2u5uXN0lzpl99Wf71ls5kI7I7RRXYElQTr2MwwD0gtlH/pW8V5CTp/1S
 CzpXm7VQB7Llyc6nPlakvo8VLzWfWv4WldLN1oLPHyWmIUvr3SN6gy0Fv2OYmVc1qP1XAG7UxK/
 jAKgYKbi8alUoC4dNwreDMtD/nJ65DspPL7NwUW5xu7DTx9zuSuPuG1TqEd5E2un2zVkU0gP18x
 bBYb0zwhG5HVWyH4CvE1qJNvrdBnZeOtU7O6SH1FCwL9qU6/TDTMl+xiUsnHN2xgXxiH74OhajY
 7D9h0gD6FkAF9/169YI0a7EOuIMiBHDXI2BTDukffJ7Eyx5iQjs9o/PZfvWnRgLAwQtJbpZA7sT
 N+NpYZDNV1H+l05cmdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140087

On 4/14/26 5:59 AM, Shawn Guo wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add RPMh power domains required for Nord SoC.  This includes
> new definitions for power domains supplying GFX1 and NSP3 subsystem.
> 
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
