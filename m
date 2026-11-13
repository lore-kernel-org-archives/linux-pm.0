Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592072;
	b=1JvFmOY+PJl2o66AtXMt746TPg6Mwd6KrdUfnmxWZLXXInCBxbZ9pkqAuxxuFn0X8jxw
	 WN0+jnkuWxOeQ2SQmqS3ndvUVXuxQIyse/vUKACa0fNWmutNK9D563/VkIMyb/t/nnwiL
	 uLsY/IX55/kPJBNz4IEtnH4v3y0C6ek0WF8LN3raZ6Rx6ektGkMQfqMD434F/jnX5S+Dy
	 3g7xcuoG0oHCD8R3JcSTjvwf7Qzzr/DjfeEG6IFSHrSOzZWeIMYtYyt65lIzQoir/6DD3
	 2noisRW8OD31nVeCV926JcGZZZlMdDVL8CIx1x/vxGNx1il6cgemd1rNay9AxX6XGFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=03h8Stqm2jiHP1ePJ8/GT4xjXmJ9AokgbaM3KsJdgkY=;
	b=dUm1JrW0QDMS+HkORzYs+c3k8JQLzGfnylGuks/kJ8khhEpzu8bPehKL41NxEllC1O3Z
	 Sl+2jKPfl6abaBggZHKOyMXJCmOJ1riTQwDuuzDdt11fVEliO7yPNsfKF5HqJD4EPkPb1
	 uqNbaNv9EzMSAGY/U3Ma7bqMbni+focEmIHQM08qoO12SWPdPPrSVCxppFO7/VMVe2Ju0
	 rkoJ8WIj5/GTnZtLHOWPPpfJp+qVxVha2fcGPO6+GvNHLlbjOfYvqX42lXlyacCmKt0Ad
	 xLDEkDRK13A/S/31JtM4vv9RN/37Ozo8lY09sABO7DQrhDL54xbmCS1VVLv8P8I4Hlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O5Y2iAae;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L7ru3v3t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BB1606C0B5
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29BB1606C0B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O5Y2iAae;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L7ru3v3t
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFQw86074887
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	03h8Stqm2jiHP1ePJ8/GT4xjXmJ9AokgbaM3KsJdgkY=; b=O5Y2iAae3vxsFE5d
	bb/rkn64PBwYsEBMSAwKJaK6QUBOzvaT/JN7Sw+WKNElb9GGov+5+qBGIPt9dyjI
	UOCX/5yCyKcW57d4cg6vRl3v16ZA/YI1s+lltrHyx/sP7shs3NV680IKYwiZwKC8
	wKhWXV6W2DUQI4X61efRhfgyLDseWAywprIqlnavRxUKN8d86RxDtCnyzHgDpEYi
	J/0TzccypLE2Bd4fWDQ0AVjoaNovbbww1x1Gltu2UrkdksM/l+KLy9noKBA4e5Uv
	XfGLWfvUT9lt2CtF51P+LQ7LTBgxktLEPpwWiOSETJNQfotta1ir+bN4jfUT8Nzt
	FzxYSA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwu2mtums-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:47:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b8cef34b43so1832947b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:47:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592071; cv=none;
        d=google.com; s=arc-20260327;
        b=Qpa7f5JmMzkF/LFd1nHj2N800O4RpUVab7kMDvAavcHMrp1fottDM1ZA7r70vUXJAb
         RJOktAquoCv6REucp4jGnLQA/REYGrvKhJZOp7ZwEFGNXW+vUURgTa1E+rFZgzuLZilC
         e56tAQp4CBaeu+Y8RFeNtmzekdBRIVDCJMQ14I07fjOGKF89GBRMhYlS64cC2/n2hgoK
         RGZpn2JSrAJAA3eo5qRMXA8ZJauS067SqLLJpGZcrmM1K3pi9DSU/z5YSZ/fTvB7INyu
         jayYxXtHtB8tnTbcGhQMVTGnT2Xqe+CfKG2yjQ9uLNs08xdyOMjzaqTS9kQxeLiMz1Jq
         EJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03h8Stqm2jiHP1ePJ8/GT4xjXmJ9AokgbaM3KsJdgkY=;
        fh=kmvhkf7bgSLQ9+haq/KwgEzAqrPfCqxYfFDI2hgJbB0=;
        b=oNOwKDuDruMXE5T/3n58NBFXChT7nlyea8BnwfGKT4F+o3TOHJTgQFscorpVcTOH1V
         7fXm/1I/c9SdmzWRq8+aUPr1Icpj2fe73CFQMy/U69g65iblegzRxERdHdkZI9sB7yzs
         MT5g+YpoVjeNrhA6PoOXz/j7oPGHzpYTrvF2dPvFwNM65TTwp7VUN6/uiP1b4w4IJRKb
         FyF0oBsD4LGFO8qAywqCFBLrA/U2cDEC8xv17BpvI76ytWIsap3M29fONZ+2NRTVyOlz
         1Z/07yXrdoBAnkaSp1hpWYip8r/4sj84TGEps0zNvz7TaEJhoWSMreTnfiyB9kyTrI0S
         yPWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592071; x=1795196871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03h8Stqm2jiHP1ePJ8/GT4xjXmJ9AokgbaM3KsJdgkY=;
        b=L7ru3v3tiuBEzaUGmoQBcNGNJfoELvuh0XTOzwqZ8cyla4M59Ka5raZ866fQzX8SOs
         hmBz6LPqYqAobGj14hHWNp9ZtVzihPgDCmAjcnFbixpUR0Tg7Ef3SHv1j6uQ5j2sZoAJ
         IpYGR8T5dKRvZUM6RWGLrL0FDfsGMndGaoOPG0NsqeQCEHZe7d5vXFzCZeOiw1VV67ZS
         ixo+eeTozPPD95krBDHI6K5rtzz/SgHbTZOUXQtHdjxLOaL4LiaH67PSmt1y2t3j1qfj
         U+qMXKwD56p/1QMSD++65Y3d6klbZ2xKzX0x+Ke0OpW5OAIilMu4IdbcK7iqg+IBAsLk
         /hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592071; x=1795196871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03h8Stqm2jiHP1ePJ8/GT4xjXmJ9AokgbaM3KsJdgkY=;
        b=sUyerzDfcvqHlDcYqmtuUTkqC+4kx46oh3FJlAWWQ0dc2vFpw4JZGkgxvll9M620GL
         utG+OMYOCHLgClm8UsAIgIdWLUlqgL2Kb2A9GkaqBM0sgS3NlwAqnamjciwuYZj2Psg0
         QjkIgsy7USYWSGCElljlZxGqFSwpqR3avlQKMNYEF2QHgEmyP5DR0GAVxeWs5yKm874K
         bgfPX6H4HfVewIW0VPbnv6vf/bb184ZvAhohmU+P1YG+HaV1e1PKItVcPMlNL5GzfeFa
         t/fDsoojQTClFwzDeRjf7o9doyhAFGR+6Hvk6rFrKukWFfsDNaBFVQDMM+u0esFH9UU8
         JeAg==
X-Forwarded-Encrypted: i=1; AL+hErE943+BMDFWXNi5qXVYACvhal2LxDi33hdPIUCz5HYCsidMIEpO1RfYlnT3StKfbjpmicMtW/6zkg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/QxJoNLfSp5W31KsHi7m2ntg6amymVP2a2C5K+WXsOLHleEaI4
	Kq7aqtjyHMypXis8t2M6uynfkUo5sC7txInDiexHRNQBBt+FmCoFi6T5Hy0/PDeABxW+VzMPbWp
	N/Ar4MYHdbpfA+o6DVJhn0iWrdf+ewmgCGWCxZLDCSsa+P99ldOxa6HtypB6kkEY5v6flEoN/yC
	7ujQeEarkP+pg0dEJvm/w/h3+NLn+acmYTtWeD
X-Gm-Gg: AYBFou3Ou1UKUndaVhAk79BjURogFuSkZAX6ZbJfYqgaDKZjKR6Ec0OjyXEZFuMBdWy
	3gBViMt30ehczGZnUxaN5wDdwSPILmcmDP6uyVUcoRzzrvzVkx3EbIsdXgQcAqnJB2I2ZOr/6lr
	FGX7RJrgNT5Y/9R8NVM7Cg0yri791AQOkeGSjh0e/J3XDtjZ8YClmAzW9K3g==
X-Received: by 2002:a05:6300:67c7:b0:3ed:b2b6:9bdc with SMTP id adf61e73a8af0-3f7a81b6293mr3316956637.54.1794592070879;
        Fri, 13 Nov 2026 09:47:50 -0800 (PST)
X-Received: by 2002:a05:6300:67c7:b0:3ed:b2b6:9bdc with SMTP id
 adf61e73a8af0-3f7a81b6293mr3316931637.54.1794592070412; Fri, 13 Nov 2026
 09:47:50 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-pmdomain-mtk-mt8365-fix-defines-v1-0-dfd445dc3763@baylibre.com>
In-Reply-To: <20261019-pmdomain-mtk-mt8365-fix-defines-v1-0-dfd445dc3763@baylibre.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:47:39 +0100
X-Gm-Features: AclHuK8NzVs_OvZcfoqmQEpBpt7jEXwt_UF2F5ZEs-xe9awuz15iknhP_y45KKk
Message-ID: <CAPx+jO9wAPreJr5Gt5CVFqb=E-hMjQnwRWwdnvpus0MObio4nQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pmdomain: mediatek: mt8365: fix defines and add
 missing one
To: Julien Stephan <jstephan@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: djjQ20UAF-ceVjaNqNR7IYGS2y_uf85m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX1vGbqWoAZME/
 NVSd+8K23/QjE0hoabr+mkQS9Ym894bhDs1ITmkPrLJUWGH2gXtr4muBMjH5xkCYxX0hVcL41pI
 wsUIelgXmD6GGMOhPCSQTDnHr8/Mdl9NJ6AEVjRKJb7a9Wla6SmflUHFAMG8UgMeqtzEIeev5o+
 lnKBqA9dE9t9k3Fn4lD1iHColiSxTk5EfBLYdKjwlXg9NI527omTofFBjYXxan12z0R+CbsabOn
 K21eIsonOuOz0Di4RjtrdThybgayyJAGz3tIvA3zHutomlHUabusKfik7cTOHBEB/SzxC1MOHZk
 qpKpGSSZWuZAv2z4c0Kvt0UYzUlUWaDPvvSL68Fy9lUx6OqjfpwQz5/7U40C5/uXdZ2K7NGH8ef
 TiPHIPFEJ4SahrP/Ds0J/N2OkiRbE+vM4+1Wxr8Y2xBrMxKA8AbtfaXRJjt85mDQVQ3tAZjs8zN
 XOdYi602B6/UzW0Bqvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX8E9D3nIpjuJP
 pZ4JAeq6Wp4B3llcFligBNYX2hhKGAv7NzsGaz79we6du6psJAVUzFVhDfgCEedQjdWpwUskHmw
 zUc/RTsGeLEeIe3nIvaiQnPvnyJCeIQ=
X-Authority-Analysis: v=2.4 cv=ddQVTnXe c=1 sm=1 tr=0 ts=6af74d47 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=IpJZQVW2AAAA:8 a=uk3U7i1IYnWYCnW-BX4A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: djjQ20UAF-ceVjaNqNR7IYGS2y_uf85m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130070

On Mon, Oct 19, 2026 at 2:33=E2=80=AFPM Julien Stephan <jstephan@baylibre.c=
om> wrote:
>
> While trying to add a missing define for BIT(25) in
> MT8365_POWER_DOMAIN_MFG, I realized that the name was already wrongly
> assigned to BIT(22). Trying to fix it, I also checked all other defines
> for MT8365 and noticed a few other mismatches between the defines and the
> datasheet.
> This series fixes the MT8365 defines and adds the missing one. While at
> it, also fix some indentation issues.
>
> Cheers
> Julien
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> Julien Stephan (2):
>       pmdomain: mediatek: mt8365: fix defines
>       pmdomain: mediatek: mt8365: add missing define
>
>  drivers/pmdomain/mediatek/mt8365-pm-domains.h | 11 ++++++-----
>  include/linux/soc/mediatek/infracfg.h         | 21 +++++++++++----------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261019-pmdomain-mtk-mt8365-fix-defines-c6be65ffca95
>
> Best regards,
> --
> Julien Stephan <jstephan@baylibre.com>
>

Applied for next, thanks!

Kind regards
Uffe
