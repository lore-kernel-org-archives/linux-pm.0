Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97E495AD5
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613670; cv=none; b=OXh+35vuj51UoVl8SvYDB8EMuKepAwIKtGcWICpgtMqAPQEDj+PMD+NiOBEx9OZ+n8I6C/OKDfMzECanJJ/eDAM3Ho5BxTQo5i/xXrtcFR3mZzjWpgyG7EHizWLyHNFLvueOF3V20Uu4O8fY3Y2xe8CXEqaXrSH/1mHbTmSrxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613670; c=relaxed/simple;
	bh=b7wbpm7186exrmEXMnpKBlh8UDpja69phnBSq3imT24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxSNgGeonjCX9GC6Rs0zaGGO8DLxaSmcdYLoW4kR1hDzVpP1tV585rDB6F04QmTF49TC4FmLj7UGWQo5rkImqVWLwzh068qrexjvBjYLN8O4hN9DyFrLOtAOBFgv6zZRQXJIOo/gOqN0/vXnzJCPQmierMh7CXOFvbxBObRwJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4P9827M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dy0XPEzZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4P9827M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dy0XPEzZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SFQhFZ2249880
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 16:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6c+vR2Xl2NMRz0OkFfpsOTaX2BCXiS4GI9DqBySoalE=; b=g4P9827Mh66irkRl
	91ExcjOaJCPoK54PQkY+q5QCdcS/izq0X1WKAEZ7B1VaMNnRLYlJ9NiyQ20olTBD
	EsZ0JRuEmtOHGDOXwWFoc4wl/mrO7bVZ45smjU7KnCjktw8hzuZvnMf/ej4UXRBb
	b75ibyiFtDPW4N5uVWHk2F/OPjVgofazhbOB2/DOAH56kRa7/XMpMTdMhuzGnwY9
	578dCAU6Y2eL+UVwNdGc5I/cBK/w+7EywvG4QWrr6qGpqgadUFMskkITzv7pbLJu
	5IzfXbOigin1qWC4LTtpVv6CMk0zJHXFvlIa2jEwU7XnHU8fMBur87OfZmkIqOyv
	BPbgiA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfksqx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 16:41:08 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-986e5cae3a9so1782941241.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790613668; x=1791218468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6c+vR2Xl2NMRz0OkFfpsOTaX2BCXiS4GI9DqBySoalE=;
        b=Dy0XPEzZvZWgKWJ1iAN8jgrwAMsYA1Rm1beoPKp2LxwT5w2tlWJRtqmuqU/UW+4cCz
         Mk3nri5YlSwc7sOoo/mxbbOhobT6H6W7vqGsjIkKV8Mjp/N/LRm9eELhupW2MWwS/vgK
         cMYYqcKpUbTD4WEpfHJQejK/FHvW/F3B7twNNWrI5zQgFgivjxprV7rSH2Ufcgi30b0M
         BXjvf0Wv1FIB1lr1/OAKQZ1i69ZMCiJ60fRdVFgrXA2o5kxF49YXn17CFdVWy+IPt4hS
         fc5BCvrPsPTcMTUYLUGjcCDtbZARGaSJkkBahw6RuuAPYNHD4ikaBiWG2CHRpQR5jymG
         LeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613668; x=1791218468;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6c+vR2Xl2NMRz0OkFfpsOTaX2BCXiS4GI9DqBySoalE=;
        b=k08KBbFa6nSIymB9GqbsSsMHQC9NMdFt0nQlu3LUhnSqoUGiUYmgTbPHAxPBpl3UUj
         +NrAqvxuwji+dE0C1joRs+J1KDTq8eefIKgt5/64gCA37ukKTBR6aOgvj/c7U04KMoNm
         B3P9nGE1/870g0hgsSOuBPZBUQKaJMfhcQKxvgVKN//ziEchghaWhOFH9kba5lHToOPb
         9HXQmTGkefXyphWgcLdQR+ag15PqzVdoIjJd3zeTa1EN19nJAO8lfT1jLbGGxffb+WDY
         AtjEFxMRVUpudIgiRpnQjYAtZWUUFa80FDTwpG8lWeWNeelA/0MWpGLqS6hAUnXtAlll
         WpVw==
X-Forwarded-Encrypted: i=1; AKwUvBx82jczxP9aUx79VQVKmJUAAu2tFdLFHIufWC6AzaXTYDR8ATzWHWzogQmtjOTpnSCGbIKNVVq6DQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK9IiyjTjZlbJNfzuMzXTL/9A6bgMVsqi1z1ne5PBXIwJI4poB2
	tkyi+MDTSk3Ad29C/xX9Um4S6RIlcxToZQpUkDkzubsWbFgTn2+d0dkd8a8XtOcIJa2vHl/SvWY
	1/p75ycVWzNSEZRyI2aGqgSwMK7boLOJ/+zABZawi3YriTM0cFB4p2aZY/9Nvlw==
X-Gm-Gg: AYBFou1cJN7AAmE8ozmzOjAet2TGTQ4VirXR7L/bIGlF4MuOeJN/UbYXJ4nNw1J9En6
	XzqItGXIPH00ajmcwP2pwhsaFaYV5Cn3Sm/zKAhcyxo5DRwj0vZLGSwNpcD/0bQC8G8HGqU8Lyt
	LVNg15rqsA0qxdjq7LJwntLS73b+FMtktkjP1RIYKqJVsTtSWj+vkB2y805cWEULFiXUTeZoS+C
	yraEdwgKmSGHynZ+0sHvYKr4AHIQtR009/iitJDBJR2zp6tKfN35sjyJHxpyNgmnGsnvF2qF+eB
	+2TtqVIqiRt4jT89i81+kW3AJPZuTLUQcxe7I370kvRI3j6AKkv2WNBVp2NgLCt9YFnxDHeBLAd
	eGEObvJeu97kJuJ8JYA==
X-Received: by 2002:a05:6102:5613:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7af1ecf76c6mr5100072137.27.1790613667699;
        Mon, 28 Sep 2026 09:41:07 -0700 (PDT)
X-Received: by 2002:a05:6102:5613:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7af1ecf76c6mr5100048137.27.1790613666989;
        Mon, 28 Sep 2026 09:41:06 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.7.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a2acb4dsm28397941f8f.0.2026.09.28.09.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:41:06 -0700 (PDT)
Message-ID: <d009d500-e938-490f-8375-f016a2494984@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Use common error handling
 code in power_allocator_bind()
To: Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Lukasz Luba
 <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <a3dc82f0-7333-465d-85b4-8034b1591442@web.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <a3dc82f0-7333-465d-85b4-8034b1591442@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX87btJk/PGY+C
 BIy8rKvMBv0922XVPfK6yGaHUppL0Q4fyi3TVKtJ8uI5sh6gC3snpI+poLoh6YbkIwtrvwAzCYw
 q0NL14aTPZU3Qx0OVP/XYxgr7o3jhXcQF42ZQFTWr/RCVYcyhZTt//wNArAyOTXJ5pENa6FI/HL
 y9qTF2x4BpCSQvjrl/vq+4dgmu55axKpxgp2X6ucoUHtYfEFG4WEY36LzcYBHoOFCUqbaGqzAK2
 CLcPx0ZXSGNVQyh46LKUCpMmH86Ew4tyW9Azi0mZq7bSSniRgHWn+v9worV8CU5K49xovHUZ/MF
 9xhf4CgpccWCq5agyIw79vsgrz6nmkcoL8Ts/XVSicNKqu0wj6xagdhVkX7gLnqR9OE7vMLmYJ4
 gOdYA/MYY8kdN/fYZHf7ax3a6qlpa1blY5/Tkgftqkqzq+tm+M8rqGpT3evMUU/2D84flllToz8
 vUd0CK2VBPpFXwlQQSA==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba98a4 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=K71sKCzDSiMJbZmyObbiAA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FP58Ms26AAAA:8 a=HHdwwCC6DbPLjSqiHdUA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: ebHMTfoChCQRNE7gyKm5to2KQfuUTjvR
X-Proofpoint-ORIG-GUID: ebHMTfoChCQRNE7gyKm5to2KQfuUTjvR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX50Eh3XVvGTz6
 YVOu6KRWljtbv7pv9Rg4475UDij0N1X8Gi24LUWJHhdsMKwLOWKV5tnQSTzH8VD7VDIYDbAt2JC
 bmprcsXnTF/B3asA1DaiC8mLoE2fYFY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280066

On 6/10/26 11:30, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 10 Jun 2026 11:20:37 +0200
> 
> Adjust labels so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
Applied, thanks
