Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057130F957
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030988; cv=none; b=bCLJ9IsaXhtCXMloqFoPTdG5lYDN+abMHKq898B+g7E5qxZwtaEf9nx3glsRsJ6TAViYasMMifAklQvYheBqE18cPQ7tME0NnVwpgj7rwSWfT/Cz10UwBfbC+4Smp8jlrJaNBcRTUGWvlWGzYGiYN3cL7qmxng9C6DL66+lhDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030988; c=relaxed/simple;
	bh=VrQBuwIdXxT7Z1+JHyM0ITVDt++tMbrSjyb3f7XLzKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoVF9ptdI1siUq+366j7CZmIyaOb1eAnnUk/Vfg+V79/DsvcqPH0VTZejOXEA0ISdEhVlSuqPDzdyonm3j4VZ6c19wKipWTbM/4m96E405lqxpQa80NFSocoWOrMfPJJhnhOaYNGFJnd7Xob/JYz9urMwA4LMRwYAuRro7hKbLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TBlN1HJa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ABESqRCi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TBlN1HJa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ABESqRCi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H5ROjB3911825
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 15:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wIrpq3/8QkUhcz1s8YKvnA98tKnGMnTBrRkSl9CK85g=; b=TBlN1HJaY96Sz/4j
	fE7xMR4pcwIIKYTd9EEmy53O6RLoAtm9rXeO0XRDi1jrOYXxjESmLnv6H274+zne
	XYICsfl1yRKj2PeIY/P47yJA7STcv1PW8whkvuroIYEakY63XB+OOFNDiU4IIfoA
	Jd/ytocDyri2HQSO8aBlZbayCO6p3P6VignH8J0m5UmGWVQqoz+9F4gbHf+H54Dg
	lYUeWWevJ22KrGzSe/fks799QyLmc/pJW3xaXsPnaQQK+kp7N5ySLk0qXHmZV2xX
	dK4Zm+VxpugySeUtue7L8QLPDuNeqivaGEj0buzirJazJgv74dtJvaOVxxJ0fKwC
	UsOsXA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvyu33n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 15:16:26 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5756f9292c5so823706e0c.0
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779030986; x=1779635786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIrpq3/8QkUhcz1s8YKvnA98tKnGMnTBrRkSl9CK85g=;
        b=ABESqRCiWJ10su1KShO9YthmM0zr0obX2s/lvnQSbm0CXUwo47f+Q6Za2rtjx1iHHC
         sohSd5X7CdADN8lkb0OTu24+Wsl6H0rCcMwJ+PsRozdo/wJaewxBPxhK8t47LTOZv/59
         zxH9sm5a7XaLVdptyzfnyFDE74IfY93sxbmvomQ1EEOyRnscK0xd/btdXsurIoUg01hK
         DEFMMMaS3K2LphGDJ8kuaubPFQuv807MfxaGpr6a2m+J9LuGuCWsfPkjBwmyfqqnXles
         v7zvQvAohzaDgKrnlI2+gadrHqcrjRUkpqCl6mb+vX7UtjbBoo9nZQn8pjihhogdkVCQ
         TPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779030986; x=1779635786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIrpq3/8QkUhcz1s8YKvnA98tKnGMnTBrRkSl9CK85g=;
        b=OQo6UmXYmGhgFSTzXwa99VnGI2ggrVWZ4UO0fi/hi5ABLfstOpZAmYT1jljuwJWKAt
         DCw8Cbbf7GT3O2qDPY2KmQQesp6lTND86fgjl5b8ptONpX3CHHdieshLu+V2CxnH+Mll
         mWyQQyt0mZNHuVuJ/NXTGYeRlE0r/di/eA9VkYoG2skT5jzZbtLGm2tTc/2PsHVEbvIT
         f06GkxpOE4ZBUmMYN1LZuyYqjZ+rHtsWq0T9m3uWMNfG7oHlydWfiOQNa4KtFF2+DNcm
         MEyPprKE51rZT0xXEWHu686k7fjEKkFeak6vdB14eummQiptu0cKLuVd8TxfqB0teA8M
         m19w==
X-Gm-Message-State: AOJu0YzEyQm2rHLnVAe/T6eNaoy7+5Iiu7K/LK2nlZHhGTKzt4IIdCqD
	X/trVWV4PSjNtmxeFOLMaYtKzMRI1rBAZ0ZbqhM0x28RMPRQQy1bGPFSlbXuXv9x9K+SWFZBDAw
	hBvFjXe7yIExCNE2/Xig5Q7XkedbmK8GVpucba/uf9YpzNemP9pOPbvImk7fqUw==
X-Gm-Gg: Acq92OE260/QC+FYilDpKd/udaB1/2OHtGbsyNwaQIO2IUvYZwdJ2O7gfXBSSus72oD
	LbZtT0CUEvhV+nqxYYFme6RgSDTQkkqQQJ2Cf92TbLhcwQoC3rWuX/cCKe3A9WaPddLxngliVzz
	MUu58rKDiIV6TzrybPiPm8VyWLTfR2bEQUHsXGDjmYmj3PmR6fxGYrO6Ix4yp9zv6TkKr48POBV
	9rz/za7CH6V6b2Dk32oCe7Uc8WOEH0YS/NqboIU4Ca2TV8sDKi6oQncAkOT7R1m3pBPbY9WEAdA
	Zo0zJNEEPhqUCYxMZdTrhhgfwPL+tMPS7WAdYqBrWSz443b+IpAJT5ZrPcs/7sYkTR38D6rthKm
	8gz97Qlt7koCQZ31WOXu28PTBzkgjJ1GaWjomRT84mDlbQATwJQeqEwaw48FIR0p3jXPfAX1l2X
	2HNuZ71+vh
X-Received: by 2002:a05:6122:a21:b0:575:38d3:7c8a with SMTP id 71dfb90a1353d-5760be37410mr5778839e0c.2.1779030985863;
        Sun, 17 May 2026 08:16:25 -0700 (PDT)
X-Received: by 2002:a05:6122:a21:b0:575:38d3:7c8a with SMTP id 71dfb90a1353d-5760be37410mr5778829e0c.2.1779030985391;
        Sun, 17 May 2026 08:16:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3e20:6c07:e6b8:6153? ([2a05:6e02:1041:c10:3e20:6c07:e6b8:6153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5821fsm60048815e9.14.2026.05.17.08.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 08:16:24 -0700 (PDT)
Message-ID: <14f6dcce-70d5-4276-a228-f26f3770d805@oss.qualcomm.com>
Date: Sun, 17 May 2026 17:16:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260514113643.1954111-1-priyansh.jain@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260514113643.1954111-1-priyansh.jain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE2NCBTYWx0ZWRfX8w8AM82Bxnxh
 qohrdswvTuz1qUZlvGu71lvS6jPkRbtJyie+HUyUgmmxk1nRoocV1o/5TexPrXhFiPwLQJHDAF2
 6y2ZzC5ZwERks9e1TNqaYuPNc434u1tMvyFpGWZ3zAbL7iwbQp+DlwdCW/w2xOUsU0OdnKd5+0N
 YZG+RPeL31FEK8T+xuEFp36auZ3qUrDgVCtQSIH5FbzjhUGl9oI03xuLV54oIByr5bjfpluERmA
 c/gu7vSw2deXeKX0EGuBT2LdA0Z+Z3Xbji7MPrGIofXszf2hfISFY4Fj8wBDyfolh4ySW/16rf1
 2y4QMFh6SZLODQUph+IQrIUiHlXN+7yhjKMpMwC8G71g3FUJZmuXDWcA2dXVxZRkH7L1vF+FUha
 3uZucU8Y3+WsfcoiXKTGlNiAdysDpM4/Cq7L+Zgn7sIu7jWRs7G+ggN0UiUBjpGb954gu+9sufz
 Cjxnmtpp4nzMNJB/IsQ==
X-Proofpoint-ORIG-GUID: d_BcKyxVFwSVcCcEK4212a77gwQ-kFYI
X-Proofpoint-GUID: d_BcKyxVFwSVcCcEK4212a77gwQ-kFYI
X-Authority-Analysis: v=2.4 cv=X5Ni7mTe c=1 sm=1 tr=0 ts=6a09dbca cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=6AAB0q3k6GC94sigMGcA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170164

On 5/14/26 13:36, Priyansh Jain wrote:
> The existing TSENS temperature read logic polls the valid bit and then
> reads the temperature register. When temperature reads are triggered
> at very short intervals, this can race with hardware updates and allow
> the temperature field to be read while it is still being updated.
> 
> In this case, the valid bit may already be asserted even though the
> temperature value is transitioning, resulting in an incorrect reading.
> 
> Hardware programming guidelines require the temperature value and the
> valid bit to be sampled atomically in the same read transaction. A
> reading is considered valid only if the valid bit is observed set in
> that same sample.
> 
> The guidelines further specify that software should attempt the
> temperature read up to three times to account for transient update
> windows. If none of the attempts yields a valid sample, a stable fallback
> value must be returned: if the first and second samples match, the second
> value is returned;otherwise, if the second and third samples match, the
> third value is returned;if neither pair matches, -EAGAIN is returned.
> 
> Update the TSENS sensor read logic to implement atomic sampling along
> with the recommended retry-and-compare fallback behavior. This removes
> the race window and ensures deterministic temperature values in
> accordance with hardware requirements.
> 
> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> ---

Applied, thanks

