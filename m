Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550A4EFFA2
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890521; cv=none; b=sIY28D8mIFvr3d/MbtSa3EsQG9zTXWGx55DnW1ZzVD+jQIv/ieTcBI9ZPQ2Gz/P4Iho2kf1kyzq4Ojm5wBve5INmaQqzQxiqMFMvfsp7HDr0+raAa7c8+qGEIglv9DsdXGCEB4dh0J8MDgfZv3GHOLHHz1/nke85SAKZdKbPORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890521; c=relaxed/simple;
	bh=Ca7l2SoQ59LsCYSjUOtHSvzwcobgCe6/+3uN6E1Y4kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxD4VNHbVjK1Z8i6o1vWOe7Sa5vSj4yLrIlU5p83gZxfL2++teiwY+pEsFubrTqNETqBXnhiYU+VbBYgK4LBHWUQvbrl85vCV2LGwaomV1TCGgkJgx+zUo7RFSu+uW8Z96WrwwGlIUee3QgwrMkHH0LloW8+0oLbX+H3/3vRJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aKftdZKo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TPMsHn8G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aKftdZKo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TPMsHn8G"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DBB3LP949406
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 11:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x7c1avwBI6cCr1P3gl9NUcM/qSQ9a1RvEzOrH3fu0TE=; b=aKftdZKo/F2L0EGM
	9MuWtaw7fLgd+2/RpTXU4GjRogB6eNKlOz9q5loS5TVXU1o4eZxpvsSs+fImrcwB
	VZr2nXJ6e8W/fDLMa4PtssqSqCkrDsfNpuKxLu3yOZ90RmwqPEKu6VhQtZNTKdsb
	F6daRsKrKiuJvYN1uFD8YXiHb5sF6UeWAf2BYKIg2izpAPyrEpoI/lvPQOHpOIu3
	ySCcj4rzmFvDdrwI8+TMYsISuniZolhQQNZ9KFsdC2MsYA4dZZYrA6UQduBlCH6N
	o1XXa2vR1cwn/aUgvSUbfRFzpfMS9lrU+UFEE/dBlF3HlmRmBfKP6+a7R0bs2TpH
	IAF9OA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f6299us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 11:21:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93edac58b24so26414885a.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791890517; x=1792495317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7c1avwBI6cCr1P3gl9NUcM/qSQ9a1RvEzOrH3fu0TE=;
        b=TPMsHn8G8kXXn0DCnig13wR414Gq4MrXteVvGBtTyYAQwfs4Ku5GmdYlscUydNqPsI
         47A46+SKQneNhGf1LPIvY1P0GdH+rHy+FiKDlEP5fCRtpJ4GeIdovlULmuqVs044s6yt
         CH2GxZrPs4HbfjeLkpjn+O/J1JTpCwmIUFcPLucPaRGS7t8ukp86n+8asWRmHw4qYB/f
         DKFCgOb+dQpf/6UBmCOdRaD87LTrWycxZZG0q8MOWEXb3a82iLv7eFoUgkKN4YeqKrKP
         +EMVPMvCg5YkRC8n9DDkP/tRBIC0fFW0H2aWHNPZbNQmWJPhoaXAb0pjaDqUJ+tj8qqa
         g/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890517; x=1792495317;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7c1avwBI6cCr1P3gl9NUcM/qSQ9a1RvEzOrH3fu0TE=;
        b=eGz3qYWTzepgcK8aWao8C0XajhjJWxNOf91Uf1J7W65dOXW8TZgrgUY5/AKXeA9j6F
         ZBdJUvRJwhE9Ic1Y514JNGnLbLrGsquSdrpFqbAHqlpTuptScZAa2caNPgoppbJKrY66
         IW6hI/M0VG2nJHv5EikF2Hm6PzUjN9aQzx8WYiF+s7HeuTgRbAbrpEqa6q5fK8VU0ig0
         v8bPHhC03Kr39d0redgsrfKSHCY1HXJkfZDF/oPqQ3Rm2KhexPyozAyKgFsu2ywmj7Ju
         wJKPO7Yuvy3f2Dd8Un/Rd836Qtv8F+edIKlzQPVj7JI/FunZYBeuQsiMSgNYqwaQpeKX
         9CRQ==
X-Forwarded-Encrypted: i=1; AKwUvBypjT95YaikEH/bfIqZsHHopnuDAEw8oxzPGrIrfnCwdpyZLjQ8AxgnG+wsiQbruyeLb2TLwXsUYQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJpJB1xkrr2qEDa3DGJYPspTgZa+wrw9sf5/52LtL2VdxvxFej9
	M6uvxtQP6k7TSuiHN6Bg9vhrmKjgAkRxaXADgSSSKoWitb5Vb0ng3hfG0WVbrPLw+vtdUIhJzjP
	iV3Tigz3u3XOUbON/ssgQXvebTuSjFnsP/CIXaootZyXTVZoqL5zMzaM4ncvXK2iwdmkPVw==
X-Gm-Gg: AYBFou3oTTNSgUuN23rp3fLctSHLKiKGl+8tFSJtyMJQfstyCpBHD53Hx/qtv17PYgk
	4g3TE1zNspDnvWMxWaTfSka0VPmHstc9JrI5dwjnyZdpYmmKMZKIM9726X79KPWMsNWFmT+Im3R
	x4RdUjP3x44/Nke6HPo2ZHyJb6xj3+l7L94h84y2gyE6YrZD74fNPPpUOaR1g5nm6r12RCwRQHZ
	ynRu5MkCFdXxj7TyH5db7cAs4bff1dubHhPFBQXeic/HlCWxSbeghtA/6f/KSK5uIpR5Hb6rqpL
	RQPrfk3iRzyVfCSJUQNjLZKUauWC3NzqkdU3io0WQt0Ga6XkfNTsS2LUUnc9JzMkuVDZPr8CfVM
	T6aiGo3B0MAb2TomMzRvP2Q==
X-Received: by 2002:a05:620a:6498:b0:93e:e111:2771 with SMTP id af79cd13be357-93ee1112d0cmr1076495485a.2.1791890517105;
        Tue, 13 Oct 2026 04:21:57 -0700 (PDT)
X-Received: by 2002:a05:620a:6498:b0:93e:e111:2771 with SMTP id af79cd13be357-93ee1112d0cmr1076491285a.2.1791890516636;
        Tue, 13 Oct 2026 04:21:56 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dc0c2bsm6114822a12.11.2026.10.13.04.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 04:21:55 -0700 (PDT)
Message-ID: <32681ae8-3356-4570-8631-650fcd88c803@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 13:21:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: report full batteries
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261008-battmgr-full-v1-1-4f5485a9c421@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261008-battmgr-full-v1-1-4f5485a9c421@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6ace1455 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=adyeotTpviE2zRAQUGEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NSBTYWx0ZWRfX5JNopfTyPa2D
 S5XDDmiLWs2CVgl9HtTJ/0cdcsbhuMZJI5LrWakTrDXO1P/N9snW8gPP9yD3XA/NibItrhS+bFR
 ZjEq7qtI5PWzdUlvF50CW5s/RksbrQw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NSBTYWx0ZWRfX8MZ3jv4hiD9M
 5qC+20NnmSyoxWqbiYnoHwtTYwPoRlGE9ghRIN4GraE3a7xwpCGyf+XKDknROjFSFf2Va49YjIO
 Njzn3pmaWMxu9u+QjZiiCLtJX6uOGojEmEaYtMQI2cpTX6ciR+EbG6gQfyCV8u3quBxSoWDOypo
 qphV0V0n/26agWy5CmIJm9QNfR/hOv6Xomovr94gXirikULg5mXLHG4CK5kIp4fMTRP4H56Zzgu
 Pb73m22SU8nZO94N+ETC6PadywVW6A8qU/BlRypLqoZRlmopkte+Vm/adeiBRM3Ncx5VOvN5PhR
 sa/DPgLrJwDGfSLyLsm4eZJJbCVAz2Wwjn6qjprcu4RCmCatjIU0LHLdFgAeOsf5594lRVPXihA
 y0oCqV0O70yfjyio+cCavOLFWcnh+0JXQ38h3e2wS7fqiK3l/ikvQOLxqrYmf1gwXyKysqWfDTx
 YM2WIlvEzPHLT3fGu/g==
X-Proofpoint-GUID: D_wgHDi5Dcq9srB2OuUPzIdGGjrUPI2_
X-Proofpoint-ORIG-GUID: D_wgHDi5Dcq9srB2OuUPzIdGGjrUPI2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130045

On 10/8/26 11:14 AM, Bjorn Andersson wrote:
> The SC8280XP battery-status response has no explicit full state. When a
> battery reaches its full capacity on external power, neither the charging
> nor discharging bit is set. The driver consequently reports "Not
> charging", which can make userspace show the system as battery powered.
> 
> Use the response's power-online bit and the reported capacity to identify
> a battery that is full while externally powered. Preserve "Not charging"
> for a battery whose charging is inhibited below its full capacity.

Let's define that bit, as it's not obvious what it corresponds to.

> 
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
> Assisted-by: LLM
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 7716eb9e1aff..97cbe966ea84 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1261,6 +1261,7 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
>  	unsigned int opcode = le32_to_cpu(resp->hdr.opcode);
>  	unsigned int source;
>  	unsigned int state;
> +	unsigned int power_state;

Reverse-Christmas-tree, please

Claude also has concerns regarding how this interacts with charge
limit (although perhaps "not charging" should be good there?)

with that resolved:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
