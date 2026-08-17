Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5183B1B4
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976946; cv=none; b=bZm2lkotFhlc3I9e5fKTHVzAlGAxLiewMCL36k21Ty6gtvs/mRDVHjaKZURb+Ng9Y3u6eGPhboo0IPZ+Q15tCcImb5h3nm9OuxizKM7drooTu63XJwaoixUOj+EPvB8y2LuRn1dIdpgaSePzvkUkByAx3jZyC2DpgxqbRnN9U8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976946; c=relaxed/simple;
	bh=UiTjHfYjpPtQv17SamOYFpLTKfUsC0/r713ZtcvvPBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBg0KY4KwUp9uT7g4garsqfznQaFF6WvDWSKFB5oQJnUDL1yjGwtGJ98fv5ahrp8z32/aLAATv7DkXMpxVOvlwuATvtCOgbR7PRa+uqeuZaMTtrfVfKF/B9XJqxl1CJ55RYnO/Ahd7caS6ZJNAc+Y/v0ais8T51PiLzfrev3nv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OAtRnz90; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FPGaCFhL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OAtRnz90";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FPGaCFhL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD68hP2749203
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 14:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PmRFHo2gTVo8kNvX8VrtEOpA3zAcJQk9MWz/79eUlwQ=; b=OAtRnz90yH/3NuRA
	HXvzEGVIS1T1ClFC/1wxOPD6ThrZjd6dqH+3OMsivUW0pQqinzbvqqMdoQaOUgWd
	v4x60tkCMNNJhDvb+X6HdBWN1+rCjw8F8T7fvIM73/2twwXVP1G9CHwgSWnavTIj
	o7kaPCn1L+Ed9pittAZ/qBhSdO6LjawsdvM/mVjefCMIHoJwgLvuXLzDYqpHM100
	0M8bAuWhnI5eZ3HV/3dJ8w2wsEJxv/m038LXdbWBXJh1Qn/poeBKeaYG/O3pVW9t
	ceAg08N2s/dvmCVz+CeVixzH8UqjJoSnFikPjRxf9KApM6a07HHUD12lPuy2kOg8
	bdtw+w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3y779920-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 14:29:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d57d17d6cso4790661cf.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786976943; x=1787581743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmRFHo2gTVo8kNvX8VrtEOpA3zAcJQk9MWz/79eUlwQ=;
        b=FPGaCFhLLqCWzbKSfZkqUMLD9tu15NjSJpqdroMDWy4WDDt8Lwoou8ZpZY19lwOiOQ
         F9NYVAgM5nNJ5V4uEXZqJc7SMJglUBUtAGk1sdYRavwWWuiqsqZRAMtd6pvKDCC9Sc58
         WIQuiQHthzbNJlPVXlg84LG+WZY6AbatJA2GGEkAvuPs4fFIdl2CX5KEhgUZ1CoPJA97
         oFJYoB1AvuRVeuxaAOv6J3UFw6HmaKeACcH4WiprRDh3cdbWOy4RWyBlZ4OAQTG+fDMb
         OMVVDQTogPn/DkDsWVVz2GUzmRArAEpeCwYrcojWMVv937iCCnOMNeSN5xflN6DlJgPD
         I48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976943; x=1787581743;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmRFHo2gTVo8kNvX8VrtEOpA3zAcJQk9MWz/79eUlwQ=;
        b=leMLBh9iwFh2ME2y6ymaFetaJbFq+b5LlQxzshzZMpWyhDgQh60sYDYav1b3savm0W
         GMVmTj1gDdN5fCYic7nkJqn3ZDgHSwiHuxSMIi/EbCkFp3WJpK0vkcrq4vF16nIym83U
         AS8kR6+eTWyd1VYG+kEYUwV9/JmR6ePYHWTISWnGBdkaOJFE1siNRP/jvEqSFNpjfDeD
         QHOMm1YJKPoWfehAD5+s0glMQfQZto4L1BxLO8CvTxC95Z282Qf6HLWtZIlsRFL9dOP+
         JnyWeXnIkHQV8i/Kv7XwppfWoVfJn0hh52yJtfwphIZzQBM6SYF/cUqlhIfCmraIeIjW
         bH8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp1aucuKT42nruUSXV6gTpwCLrkJw/Dwu7IVs/zRKaUCMxXFmbLOFjHVq7CH9pAHvhbSjbHgQCT+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/tavLfvvHav8yP+z7Yhykcxp1ygpF3sbGQJ1ZSgrIi4IrHxq
	mHJiU65ABxCQu24RBTCIWjqqiYNbHPjKCInC/djRemDH9Z6DJ3Ph2ab8hHXk19iQW9bLhcuYUbH
	KSJ4kczoGxPZnF5YRquoXlcIlMz6BhQgTKBQ8hwByiTapwcl4w3dkX+MZ/gdrYQ==
X-Gm-Gg: AR+sD13g6OYOBCHBU7rc2kKUMtOEYge2WqFw/dl7yvmrCSvAvGJFhcjm6RmJrndKPYL
	NnrHPHX1vK+lyLykIjZzGehm6z/wVikU4x2JUlATw92cIdnzXTBRjoaOXuGXZo1Xlnp9+WbQxGl
	PXT17dIR2QUpVUQkm/jVFx4Q8iNSwjN15YfB8UJ2GFy7SfJZDmWpnKYKSgYKAZGVgmsOp6t9qw0
	KJjFMO8StDMdQlTK6Wy10ac+2Ob5WZSIBssSn1TNOSlxdxTtt46rB2vLleLysuwKHhaMq7fKb7m
	seFgO7qf8DWy9uYcSaKsjTa33dwLXgTBtGUansdHr5aRvneaba6tqTLlsBkmULVrMcjk0YiPgdi
	3nX0ETcyppEC9zGBeZSCUu1+m
X-Received: by 2002:a05:620a:4725:b0:934:95d9:85fe with SMTP id af79cd13be357-936d2382755mr1936461985a.3.1786976942677;
        Mon, 17 Aug 2026 07:29:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4725:b0:934:95d9:85fe with SMTP id af79cd13be357-936d2382755mr1936458085a.3.1786976942327;
        Mon, 17 Aug 2026 07:29:02 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8530d3bsm829709a12.10.2026.08.17.07.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 07:29:01 -0700 (PDT)
Message-ID: <bb0be682-c3a4-4669-89af-94a9c2653177@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] power: supply: qcom_smbx: include base when petting
 watchdog
To: robin@snyders.xyz, Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        stable@vger.kernel.org
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
 <20260812-qcom-smbx-fixes-v1-1-eb48246be599@snyders.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260812-qcom-smbx-fixes-v1-1-eb48246be599@snyders.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfXysYoq9DwwQW3
 Uv4x1yJ2MQmDA6YTKFlUMc4s5P22J0bls4b9SM3R8NRo0GXn5Ra9T6kmXnT4bH6pfDLZW4eMKvJ
 +dpAfk3UM3r7c7qRpWl3K10uGsnMMhtJ5C5ka8BnnJ51G2+2RRYzQD8sS6iJVWqVom7oOcJ0Z7B
 6nxDO0ekVzlgANHeFGQJ03JAP7AWYW3iT14S62za7a1QItUuYLrTebINMwbmp/ax8Ac6S0wL9Vt
 KBTKxIu25ZctOPzHfkGm2BWrjLYe6sxH7vbNZuHFNdtfThGxtKOLtSEMlE4iOGEIB12CZ2gwWS2
 RhLqZ1xRVUHQdFhAGKkdvsekIhTs6oI0/RbRIEK1sYzzTOkM7NUDP0mdu0ucw+BwG6JHUOefS3d
 SLNv2UhyBLL6xS+/0SmOGjSPyaCunkLT5q8J5CMhtDMyjhOdMLH2s5OmCylTzocw5iDzozOzRUx
 wIZJ0HxvJ9YVKupdfjA==
X-Proofpoint-ORIG-GUID: a9Dy82R3C3wOG8g6C1Jbz-BbXozrFULU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfX6j1F4HHdpGvV
 6dRNjzdMLrjgheIkCBCDzwICJ9tX/IrcrFxW2NETmwKZQ4UqX3b+q80zh8TUd9E9NROP1b343cg
 6093BBQqst9HOPT3J+hgD0IKCF5B3DE=
X-Proofpoint-GUID: a9Dy82R3C3wOG8g6C1Jbz-BbXozrFULU
X-Authority-Analysis: v=2.4 cv=WNhPmHsR c=1 sm=1 tr=0 ts=6a831aaf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=OsHF4jKAAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4rSUyN2hDD0KhXNsd_QA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=aAwnOj5LE8VeXseigifb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170111

On 8/12/26 1:29 AM, Robin Snyders via B4 Relay wrote:
> From: Robin Snyders <robin@snyders.xyz>
> 
> BARK_BITE_WDOG_PET is an offset from the charger peripheral base, but
> the watchdog bark handler writes it as an absolute SPMI address. This can
> write another PMIC peripheral and leave the charger watchdog unserviced.
> 
> Add the charger base, as all other qcom_smbx register accesses do.
> 
> Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Robin Snyders <robin@snyders.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
