Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429A3DA7E0
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242242; cv=none; b=I7Ee0lEygz3zRGvaAUQr8neCxDT9ElbqQrysQfbv10ofI+hGYM5Af67RAoD4BYstmXPJVJifjZoU02I3mJfKHUzVRZe3DHCQZPw0QeZGvJCidvY2QNd5g/wVLLTAguYE6ko7vUxIcpHWYApAsZYevbhMzxc6/EJIQf5B4h7d0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242242; c=relaxed/simple;
	bh=J/+kV5IflBsYM9clJ4t6z7UqtuIeJJPDMTUze5vvHLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufSMSiq/03G5RrRQBgxDjq5qwp0Nx1Ky95oVX7HG13cB3FOJf9T82IQBzbox0BtWXOvWoVwW4XuLRVeG/7LvvY55EdvragCTxeJnqZGis8uzMNzzJu+6GK+q3xi2FM9jnkiu974DU5rxwvFkm8fEkFW8j8HA+c+7CaFft4N6wHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=grVZ939b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AY8OX8ls; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="grVZ939b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AY8OX8ls"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6487Kgtd318082
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 12:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DHVkjAHeZu1FWC+GkLJmTs5KPwOBnP/jbBXlbQonYLQ=; b=grVZ939bjthbnhx4
	XpZzU1D7FaXx4JrzBO4hFFWrchK9brRo3YLNNtONjzZdkzid4tEMPAcUevvkevxB
	gm95lURTZS87pcxJVWyAnlcBHL7SFIWXh4VIvrTTyJ2zsSP1mJ1UGW7hPrPgDtHi
	XuSey3xWSIUBeocEW7iznbQYelqdllR5Ohw9HmyVXJPEF3SaAlkroHg5kNxR87I1
	t+UdFBlPX7e0bMP18Hxuxc1FPL8SfbKzjkIG5efiANKFEolMW9SIp1wE1C+uKO8w
	7z2uk8O2lMs7PAUmy7vX0QAjtxC8uzln76MFHhLX9LDpbeXMDk2cY49xCaZNTFb1
	vQdDTA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1bc013x8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:10:39 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6314bbea08dso3603137.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778242238; x=1778847038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHVkjAHeZu1FWC+GkLJmTs5KPwOBnP/jbBXlbQonYLQ=;
        b=AY8OX8ls1jhhnDkBldp9PrBgbdcdWCtzj+r7dnKMkQMNlHyfFrAVN5OdbxFg/VAAI/
         qfWXhozeLVezYFgajXIuF5rkkAZHJ7a/IXUOCV5IXNETOHgQvnJUEGmW2DbQVJWQkbrL
         fo0EGGq5u99YKCdthGWS7GVftDlwFlbcYchNNDYAkBU+u1YzDufDGpIG/o3GZppHRihn
         ud2Uy3C8+Qoa9OsJwFSY2OW/C8MWefFhvW0FWpHk7xeJlGmZBL0LixCv0OHGQSn3U3wu
         g9gyqDYQqbtP7pG2VwRJ/SoTIppbaMe46i2z5kg8jmXlpOp65T/8IG/QMAydunYlbJkj
         jnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778242238; x=1778847038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHVkjAHeZu1FWC+GkLJmTs5KPwOBnP/jbBXlbQonYLQ=;
        b=TR54PXzDeRWNUL1eLyPBF+qSncZavg6k1F+CpGv/LQC4bAmgQbW39orbTdbXYZqfMh
         DUOmP2ylPg6krbAeS9yD5/y50UmhhNsk8iBL/gv+6AepixUnfE6+GGnGAXD0q5+cjNyv
         xh47eiEssbeCnbHxRuDIPx9l5uT4Nht2L+kClUZqq7jC1kNantMKVTH0zpsX4s9iVPl5
         5lLNKaJVOeuVZqqr0dXNJRX2tAYsjF6O3Ar0+8hJEOyV4rqmohPxbLnj+3hiv70xwZ//
         wMWm5GshSJpbr0ad7ygIzcVpOVlg5EXhdN/6gcRgQrP5+NeLpLTTyubsDQJ0FUpq54fd
         593w==
X-Gm-Message-State: AOJu0YzUEVjk4nzAssxe/CSQY0GMM07YZffO4qg+/j1Xn/m5UeC+13c/
	lYxuEEmTLlhF3zg9nqc79u8Gt5AtJY5scQA8rFDxDrgJhLC/57QmzliheI1SqNRLAz6i3aVhM6k
	IwGE222cKQ/k26j+VT5oqxCh0ihDBLWgca+vgOuL2KMj/Y7Q2cuI800BJ42Jfkw==
X-Gm-Gg: Acq92OGTERWHJf5tzavsvPeQWmAcPqjfIvdwbThwXg5Kgi2XXr7/QWe1cmQhfqsrr+e
	WrDjFPpyCQHzlEHlRXmJ7PCohRgysIRMKUkMERw1g8LWyxO0YXFT6hV/guZztVpBI84XSHt3YMJ
	6u3oAXGOSTeAqC43/LNuiZ6lmMQUQWFVO7ppwLZy7bTvM7zfQp4yLmdxeZyr0PANbq85nxXZ1Hg
	yJBfqSjgEkpt1cDmtEUOzTPUR1aPKcHYeR7rDLLDyo7GUoV9spGcR0dhsnMv2ffnVBg/M9JvS3T
	RFzS8kcxnsiukS98vvO8ZnxWO/BIjynEmjIrQf53Cj2J0OBTA2IZ45yWqIDruWh1VLQNQ2qUWlZ
	NEFRAnIDDrL5gPXlRv3va737bDu9JHcoGGWs7idIWfCQ2qebWD9ZhEbd5HKfLhDnBj9RBVRZuKy
	FZvz8=
X-Received: by 2002:a05:6102:cc8:b0:631:4d8a:1514 with SMTP id ada2fe7eead31-6314d8a227cmr58935137.1.1778242238518;
        Fri, 08 May 2026 05:10:38 -0700 (PDT)
X-Received: by 2002:a05:6102:cc8:b0:631:4d8a:1514 with SMTP id ada2fe7eead31-6314d8a227cmr58926137.1.1778242238139;
        Fri, 08 May 2026 05:10:38 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0dfd34fsm584028a12.14.2026.05.08.05.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 05:10:36 -0700 (PDT)
Message-ID: <c97ffe81-7664-4647-b60d-fd2cd6f54708@oss.qualcomm.com>
Date: Fri, 8 May 2026 14:10:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: qcom: tsens: widen temperature limits to
 match hardware range
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260508100700.772985-1-priyansh.jain@oss.qualcomm.com>
 <20260508100700.772985-3-priyansh.jain@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260508100700.772985-3-priyansh.jain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNiBTYWx0ZWRfX8pBgbRZZ80jJ
 KCjJK9S7xesDBrvvGf4LdYsel0NeD0DdUHnMBD3IdVhQFX59xqPqO8QINQWzty6coGvht361+nw
 zyalsrDpwIfcXl9C6uEPyvxUlLTruN6mc2mzIjawlnlLKFy2vTkLSmhb8Z67RZtZnZGeGDzRLx1
 YskhoBexq//2rQn7PxUCN6vVyJ+x9uOr8ej7ZQxsz5FN5Km6LZ+8Vx6F3DWrAiu+ZBSsbkMYAKT
 DfVUhBtFUBlEC651H7ZGVoC5MFCAMfyHTKPYsjVjrotmtZwnkY5vNWNvLvrjCZByFFYL8dzFepf
 DI6feyNfTnKMKqykRHoTPIeFdeGqMVwxk7NvMN/lPqgRGoNjKn0OjqSV+zhfDB+3BgKd2FbJY7d
 hMhW274KZ5vb30qonYtunGZZYed9w+5/1qpbIAJzK/WE76PY3ERWTCofRlDoUzEImqUqLtpp61b
 fkxoiVzaxDplVaCmgLQ==
X-Proofpoint-GUID: vKA_Pf48sZq_TVLGTA0OSU9kS-BpPy4Y
X-Authority-Analysis: v=2.4 cv=JJQLdcKb c=1 sm=1 tr=0 ts=69fdd2bf cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bZ6dXzqpLwj25owkuuQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: vKA_Pf48sZq_TVLGTA0OSU9kS-BpPy4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080126

On 5/8/26 12:07 PM, Priyansh Jain wrote:
> The TSENS v2 software driver currently clamps trip_min_temp and
> trip_max_temp to -40°C and 120°C respectively. However, the
> TSENS v2 hardware temperature threshold registers support a wider
> programmable range from -204°C to +204°C.
> 
> On newer chipsets using TSENS v2, devices may legitimately operate
> beyond the existing software limits (for example, up to 130°C). When a
> trip temperature is programmed outside the software clamped range, it is
> constrained to 120°C on the upper end or -40°C on the lower end.
> If the actual temperature continues to exceed this clamped limit, the
> threshold is immediately violated again, which can result in a
> continuous interrupt storm.
> 
> Expand the TSENS v2 software trip temperature limits to match the full
> hardware supported range (-204°C to +204°C). This avoids repeated
> threshold reprogramming and ensures correct trip handling on TSENS v2
> based platforms.
> 
> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
