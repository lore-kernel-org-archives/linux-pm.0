Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B7243E495
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481702; cv=pass; b=tCTqpSKCshtJKBf314PK0OdoYNXFdBqU7MBvDJ8p/z4R1n23ym1yuBCipxeEo6UnHyVvpBizfIXEs/zBODH8ySOt8O10UtmFG7D8c/tHT6zTe11BanvpRk7l5M2ej/gOzRzD5LnTqhBC3yQwg8f1TZI9Zh1lovc/+Y9tkC85kE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481702; c=relaxed/simple;
	bh=PUyrwgnvUcXnbFOm8tl59p8mT33ommTvgNayNM2a2hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3l5pNeN4FQkvBaoqAAMpp07mD9L08epjufQZV7sI83p+U9FMEXlkRHXiIcGCq6iBmhRolf24t6EMkeE5LT/ENaEKDSGlxW4NcrUj/w5tOI8m7+OZlq5fqzR6DOyQLpIio3ixC/KcfvJj3oHRjiVcX6FyGtE801nJfZu99NAxu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmAGzEcN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L7yqXGgE; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmAGzEcN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L7yqXGgE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536vJVE1755684
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 10:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G5uoXQRR+x1Y1NzAuMH2inF+ukyI5BxIekcDkuuPxWo=; b=SmAGzEcNzMg6EFVj
	AJxaoFZzHAlq3ByG7/Al8YvqP1vWkmRutw/OAjR4YxtfS3B2Ymh2GWsxwnq71NBa
	h2UXk7QxDOu7UtdUSzPwrvUkENvND2wgWHL9TbcIhr1yC/aGridG4+njldF6JQ6j
	ZQzMai1HHyZ1iw3tXnZUJl31CyDDfvcGHRk1vZ4Wx2UJb9KnsV6x5w4JzbiozVd+
	xVhpVP5oyBtADnKRqkrWDNyojEGs6HOx1/DnzpPJfz46un779MUCu6D9n8IH9l0I
	1ub8sAGJhafr6IV+vflXwme6o8VXQxYrq0jnup6Tw/4K3FRxiK9NAxGW1PvOZg63
	yTCo3w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejff00ucs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:14:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517615db531so13801841cf.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481698; cv=none;
        d=google.com; s=arc-20240605;
        b=aS4/lBJ0nCzPLNc9H6g7ON3RMkyvbvLt3ofojiVckbufbj4x/ZnGG7Uec8d2dgkQHS
         hd8YG3TdVRQ5EwgLmLhBoM7PxV+TajGl6Vh7utXmv2490cLuGu0MCTPUWJK1ljZz+8yp
         HTfP3o+zJOMndoq+EFc1IgWmnWSZjDSzyO+bkFG/UKsW3D40fLBEflJ7rLL9ug7xksVT
         Do7+9qry9YFuxigyq3z31O6IkpDgwa7U0G1FPFVx70vB4TGXG4umd2K7+tFtwrgCPfqa
         IKS8aGEp/zGm8Aj+sMc8hbGjQFnorHa0eiNLd51KJy0MlRbfDAB6ss1sB/Bti9jFnbgI
         96mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G5uoXQRR+x1Y1NzAuMH2inF+ukyI5BxIekcDkuuPxWo=;
        fh=Yshj0JHC6piI1JdV2lNrghFcc8lfZjjuMSPu0Cts12I=;
        b=cK4DP1Ucg0ZOOtSqhePdQcAbAx+P4OUBj2DjGGHUPJ8W2aRj2pTFoXr+f+SbZK6MYp
         1mMeGTulIQ7fu9LqnODxsfg9eZt2M+4MDvKYNeVxxbApyyb13pWz7ABviJhrl0jUVFhz
         K+peUtLLjOyfxeDnFdcIFwDCP0L8/zqQt+hJGM2nakbl6SIQ1e0MIvWnIlzaSS/1cV98
         imTtWbqlfUgPLs5UmMvPYKwcEduNSVWx0sA8gXXLLxWIf2m0tWf8Ky92XVb37LmCtNJ7
         wqGhecNuZ3fAow3bk0THAUZNtX9Zb3rn+eTJ/BZV1P6DHGU/zxD5IjjBQtXWNqCczFn4
         57TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481698; x=1781086498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5uoXQRR+x1Y1NzAuMH2inF+ukyI5BxIekcDkuuPxWo=;
        b=L7yqXGgEzKbT+Z53lCtWsZ4riATNiWlvH0vvr69d9EoZKo47qmpt4bSGmZb83N/Dfx
         4+8tJbAx57NviFstoI6bXwPlMqj5exYS/BZT84QXQPHdIOHYMxSDDLJFco3qVkKJ8iAE
         UVrFzYIH3YzFL4CqP1y4SzvkwmE/0v7o9AMQ/dJudaIndExFbaRKeqnLEYq97U8zDM5H
         FoAzwlenzqNLawbQ2bH6foYS4q0YP8fubecZyufG2JqbIk7n4fjYhUGAMqN9C8cOpggy
         aiTGNuSXM4+y2UDMeabGBR1UplsscYr6YsrE9VlVNIr4OeRsWkah7r2lGTO+k7TUkdF3
         vCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481698; x=1781086498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5uoXQRR+x1Y1NzAuMH2inF+ukyI5BxIekcDkuuPxWo=;
        b=g++GpdxcKC+CSm49m7mF0inrlgd3luKkFLd79Dq/EwTVBNInIu12HhX9HRxcYSsEB7
         qYsUNhb5BE2O357QYakxfAbAO1hRDfWFpSFLXnt0MoEdlvfZV/IhXiar+trYSFImWxHO
         OHNmgSpPCVsynQyZiUABdTKm0bB3xkmT81S4/VUJD37sZWXjeGAWQ5DWuexCG80/wdMG
         eb75AztHl0mnzu6jgLReVoCh/utgOqFTTf4b4I5+DXp1r83zb7ivxT1gDCenQvQvRjoj
         gYtAhx4xk7UyKuOJ8piOqJcymRZp6BscZE9qPzrKtiwER3fVeBsUXSKh5P8DjrdNT/Pe
         sW0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/SgP1WBLeMRgsJLqiOxNpKqNH8amibiSh3Rzcw9BLngbKT2qv7dMnXcknVCT0U0AZQg3EYdqWUig==@vger.kernel.org
X-Gm-Message-State: AOJu0YyD2CrlVirozQkPDvQ3A8qB5Kj+4mKTFxqRDRntOdWgzL6Zsvvb
	3XHmj65YWVsimXgzhz+CisSNcRXsRwD6Oz55FGof3CFsEkIgiqjYus/f5ZTBQe3VBEZ+5Cat3zg
	VGvIjPqPmEeQGvwHBtiyJz9+vrlsf8P49YL9nGHLlgyyR1dJ/33b7TOXl7Rmd2hvLRcsPEN/QU5
	7lS+ePlN0nRapPTCX9zXGkeWDwN5jqkz/NUme0
X-Gm-Gg: Acq92OFG3/MjY9cRRRp4DuIxCwUHpSSNW5djo3+86smzj3Iq8qf/lQ4tmp6KCRQnH1G
	v6hJRF1oD6paCR9d6+r49vGCkwyrtib3aXCAec5F29UxEzJbkLV4QbmJnNq6adDXU58mGa5iwGY
	QJJWCMa/olPaqupf+zC62KJYilMrsi91O5eMOqWkPwCtl2FlNKHQmTtkqUppNlPGPWhlyHVCQrk
	f12CxofVvuQB85i
X-Received: by 2002:ac8:7dd6:0:b0:517:6afc:b644 with SMTP id d75a77b69052e-51778770b85mr39837261cf.47.1780481698264;
        Wed, 03 Jun 2026 03:14:58 -0700 (PDT)
X-Received: by 2002:ac8:7dd6:0:b0:517:6afc:b644 with SMTP id
 d75a77b69052e-51778770b85mr39836981cf.47.1780481697866; Wed, 03 Jun 2026
 03:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-clk-determine-rate-noop-v3-0-f3f829fbacdf@redhat.com> <20260505-clk-determine-rate-noop-v3-14-f3f829fbacdf@redhat.com>
In-Reply-To: <20260505-clk-determine-rate-noop-v3-14-f3f829fbacdf@redhat.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:14:46 +0200
X-Gm-Features: AVHnY4KYEhjVLt8HCP2S1uMOezJVDgrkFC02GzF0MnbWrCfiBI8GGzmmmTGcP78
Message-ID: <CAPx+jO_E4XLZ8s8iuMXwUg2pXZKCo7V+9PWNyX=NmUnv3QG6bA@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] pmdomain: mediatek: airoha: use clk_determine_rate_noop()
To: Brian Masney <bmasney@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: xrzViWyBMQxZ8x8yf7JurIkW6cOvnT4w
X-Proofpoint-ORIG-GUID: xrzViWyBMQxZ8x8yf7JurIkW6cOvnT4w
X-Authority-Analysis: v=2.4 cv=LYwMLDfi c=1 sm=1 tr=0 ts=6a1ffea2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=QX4gbG5DAAAA:8 a=IpJZQVW2AAAA:8 a=JfrnYn6hAAAA:8 a=qVNBMPF4TgRESbWuf7kA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX2q7yIeaDZ0p0
 AAMq+Q+PapEzZ4CFNUu0JifK0mOJZGC2TYxD/wFhz8KV3gdaKNJ+hTRmGejSk5Zk9kOIBqBVKsw
 ELG+SCPw9/YOE2RqctYkCZqwIy41Jjg2ziKAqEe4Ayb5/Z6H4ALHgWufqwg6BUekXMWuCbpwWCh
 Z4qupZd40eWszlI27owdvZ/4TvY8onvfMg3QGJ/mOKf4cantfJWwH76vi+QoEGGXZGzo6wRTcou
 tzhjW71OayRYndBDQGVS6BiNwGP3Hzl1LkjhfrVz/e5lPvXnYe2PCRv0OgcqhimpGFYpyPRq9/m
 rxsz2+OSZs2xXsseoIzCF05OkicFqKtbU3fny6fBNp9//NXv6bITtwpSwRjqx6twqBgbPCh8Qs/
 9da8uDuER3P3jo1cv/Lo9XMSqitWvLPfhaFZvDmi/La/u7IxOd7ycR6an/YBjeSl/CGfQu+SSKR
 SnxaVqHljW0c+SNfHSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030097

On Wed, May 6, 2026 at 2:49=E2=80=AFAM Brian Masney <bmasney@redhat.com> wr=
ote:
>
> Drop the driver-specific empty determine_rate() function and use the new
> shared clk_determine_rate_noop() helper.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
> To: Ulf Hansson <ulfh@kernel.org>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Brian Masney <bmasney@redhat.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> ---
>  drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c b/drivers/pm=
domain/mediatek/airoha-cpu-pmdomain.c
> index 3b1d202f89dc..5efd7a38f4da 100644
> --- a/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
> +++ b/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
> @@ -21,12 +21,6 @@ struct airoha_cpu_pmdomain_priv {
>         struct generic_pm_domain pd;
>  };
>
> -static int airoha_cpu_pmdomain_clk_determine_rate(struct clk_hw *hw,
> -                                                 struct clk_rate_request=
 *req)
> -{
> -       return 0;
> -}
> -
>  static unsigned long airoha_cpu_pmdomain_clk_get(struct clk_hw *hw,
>                                                  unsigned long parent_rat=
e)
>  {
> @@ -48,7 +42,7 @@ static int airoha_cpu_pmdomain_clk_is_enabled(struct cl=
k_hw *hw)
>  static const struct clk_ops airoha_cpu_pmdomain_clk_ops =3D {
>         .recalc_rate =3D airoha_cpu_pmdomain_clk_get,
>         .is_enabled =3D airoha_cpu_pmdomain_clk_is_enabled,
> -       .determine_rate =3D airoha_cpu_pmdomain_clk_determine_rate,
> +       .determine_rate =3D clk_determine_rate_noop,
>  };
>
>  static int airoha_cpu_pmdomain_set_performance_state(struct generic_pm_d=
omain *domain,
>
> --
> 2.54.0
