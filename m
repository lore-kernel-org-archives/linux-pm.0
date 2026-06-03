Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78366352038
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481717; cv=pass; b=aMf/ukR1uz6+jC1PCuvwlwYtZMi3HlSIBRfcmru8KrCjuaKfM5cNNQxsjVW7ehtwOe0Ki/Yj47MVMSIxVCQ0j3KBaSNClRe63+Mk+d3QM2KeVEk4hDaG30cjCrDVFZAxY4CxhrUMfLDWmCUcKwCKlWkMnFxPd1DJVZeGHvmz7rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481717; c=relaxed/simple;
	bh=5pmslMBEuHY1i+W3/K7zGjJuBQnfRPah3RIXbQjolQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMA5AeHmcr3GYoiE0QIzf+9JXjIg9D4pxFDgb0aBEyfYWd7r1zQzu/amv8zNU8siU0Z8RukRFdkRc9zC262gChGMCI20UuA34TN0V+GfivmRJLsDvtAFeCheJxi0bKl8q/jAcewAEDjoAyjEVFUcOoH3pIBbGz7WepPabQ4zpHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ln/Ht+Cx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LUMgeJG0; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ln/Ht+Cx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LUMgeJG0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RVEA874144
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 10:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cemMVSwWpUomfLDkEQHTnLgIi/llhyTHZDSVwZ5DF6o=; b=ln/Ht+CxkbGrBgNy
	wPjkkVIlTOOgLK2eipmC/+xX7OCKCHzDFzzB2Nm52nMjfKPJOUj3n5mfl6UwjcpQ
	7Udc9IUF1V/oDCXW1QBbbmZc6Sn5z1BMPWq5dBPOwXUXLyk+wIrSW0Nvt1Vk4OJt
	TrDaAm05OwjKwc9RM8jNDlPAZ+cAkDZ3iNO6fT2slHbotWYq5QqfJIyxPTkzV7m+
	AK7SEr/dt7wcZC6a5ecldZ/zraKys6A1ornmHmSD+X4oANirp//WIARcW42LKahf
	xkSN0ge2lV56EWn0rM/ph8mP/psnmHQO0fSqi0YcHDL7C6C0+O3w7a7EXN1xguQn
	byisqw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ej6a9jxes-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:15:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ccf62978bfso103955786d6.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481715; cv=none;
        d=google.com; s=arc-20240605;
        b=RWg1LfQcK1/4Z3PryBHIKak6iLlugFyGOFSfcTThJvYJCyqhFfRueMW+FrB3TpJQoY
         yjOOoIqRklyTBUHrAzGWBIxbHv3N1tj2LwZQmounE2YmLRXjOWtvgAWfXevLLg+89eV+
         7HwPAp2Sy9b8UiowmGMMkbI5kM53ofovbWJ1oqnPmjohCz/p6cNesSyh8OXY5op6FXdN
         EIRfJV15c+BijMxMojs9mzd8JQPCpQX+LJCprccZJQvOSuGCWB3WFwD78LiAtSa7pH9a
         IWlqkxUeKlaUDyLJ0tr26jpe7tjJw44FC3x6JrlJ/d80xjJqvMtoqaQGFLsY9g4SwYOj
         1H6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cemMVSwWpUomfLDkEQHTnLgIi/llhyTHZDSVwZ5DF6o=;
        fh=vBbUApj4QNL9ljrFVT540XReZSA5s7i6GJkW1X8wckk=;
        b=fmrzeR3LoNKgePgOsV0P0zWXxOtBwvM8s3YCZxgfK/aJAVpfvVf2MXRJjkgWbctKSu
         eQGyZUq7i3DfKTG0Ry4wOzqrO4DmJ3a8wussirp+tlbyzJUrsmKDQb8Hi1JzEEL5XKA6
         OokfBS8/se1wF7f2TxThsevPWCjO4jMrsOX0kAHCECuOPEiatC0eGSo0/onnWXyX/etP
         BSQnWYhE0iWvgXd6+rP0fDJ/6nauPajXvlRTnrWcyzg14u4aV133U7rsV+yXXAUL02J4
         KK2yiyRFpbbvxKhSe1fvovq8J6d86WywFzhAwu17L2WxUerywWkRylKl5vgVYK8c5Op9
         L8MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481715; x=1781086515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cemMVSwWpUomfLDkEQHTnLgIi/llhyTHZDSVwZ5DF6o=;
        b=LUMgeJG0WCDUL788QR1QCIWZ2JzEhrfifU1lHdesUXMXTtKagMb+UNDgNmAHy3NwCG
         yNfQUb/JTsewpr1wnd5yBVvRX7v1Lpj9jMScxdp5lcvhPV/HWFyEm9XEztF8jNhpSvVM
         ZBKvcYdR59aVe0L2ZkhAC+mBKIS6W60QPlnuxAoxmKxwk7c1bZ9S5uo9L9oZMmBZ89H+
         7eBzAV60IE6xV5AQ9peTjhet3SuuzUwXOpocnayQ4nFBYV60NkrWcQGn/+soV4IsM22U
         8BwyVYbG6uENICg5A7GCwv/pi3/wwiSRLlth6lxS/txvWBPr34fpQy/cXmwaimLcdOa/
         abqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481715; x=1781086515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cemMVSwWpUomfLDkEQHTnLgIi/llhyTHZDSVwZ5DF6o=;
        b=iVg561eMGB/kx/I09z8KFlmZFFJhPsJOBta9zmybkykv+QoNy1BDvowefPquKl89Nu
         iy4B5aAuaV/LkE0/xvGJQKZX4l4X8l+0RelEkoQeQe/GLS7RARlgyn3QjYi6fv01uWwm
         pmrg5n1cz1dDtIfKv2/37NvHtP5wEvYidYniNDrzw7UZ2MeThVEUgPkZTwq49uCwucOn
         oNpvYQv+FjRYOVKLXlQVj1LfA0EhpxEq2fwfrVclxTCXXr7ZqSqfjhYyhwLm0oekeyqQ
         xIHf7dFFeeyrdE30OSPi38+Gr4UvS6ZroJA1Qyx8gPiMQulVOgdPjvtd1JlLsaViiPzi
         ALAw==
X-Forwarded-Encrypted: i=1; AFNElJ9K+Sg1KIXdv9RXjpoIIAxQUf6lSP36GRSQl8PzpY5N738Gl4/caBb5ggtCi55mvqvbpFw0VNsl5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhpYLj8eHPQUQBbr3cVFkR05Axqmi6IR363ZhAa795zqeG6v8
	uZAdUhc4MyoFEE98z7riCqv6xJ/c84jeD2O4AZeAcL/CVrC8NWVe9U1JjzGn/LmFrbVgThEiFxg
	e3ga+/QMyd4cuOZHgkaUDi25FoxiULqmpKuprb8vECjSF78nQymY/BSTSyav+9XOaZ90e9HziP8
	Djv0dUHlJsp+OUazETRN0I3gA2HvLwoAX6d/7x
X-Gm-Gg: Acq92OHjuM3nXpjX+aFiHgoUjfZzYDH/SAV6w6ErDUfng/k7cfoYxxx/mFgdYhIr4Go
	YUASIjRtUu6p4t6BubgPENZDQGviWodOY/gY8evATYfivF/t9b6qCzNs+co3CUtRjUEkR39twJT
	3GOU/fUaspx0qPXnuhuAmu31QHyHItQMd4aOkeEbAE6OM8h/YqnBZlfDK7ENELEQD+r6Y4jPFPF
	fO2BwhqLTDhCgz0
X-Received: by 2002:a05:6214:838e:10b0:8cc:58f2:339f with SMTP id 6a1803df08f44-8cecdc3aca9mr28775396d6.16.1780481714562;
        Wed, 03 Jun 2026 03:15:14 -0700 (PDT)
X-Received: by 2002:a05:6214:838e:10b0:8cc:58f2:339f with SMTP id
 6a1803df08f44-8cecdc3aca9mr28775016d6.16.1780481714092; Wed, 03 Jun 2026
 03:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-clk-determine-rate-noop-v3-0-f3f829fbacdf@redhat.com> <20260505-clk-determine-rate-noop-v3-15-f3f829fbacdf@redhat.com>
In-Reply-To: <20260505-clk-determine-rate-noop-v3-15-f3f829fbacdf@redhat.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:03 +0200
X-Gm-Features: AVHnY4LC-7sv-Yo8uO8EA2lGD_GeWV9mrQovi0mZKLxB119HM7ymo5rY21qtuRc
Message-ID: <CAPx+jO-zN7+q2CWGpMnistOqwVSipdQLi9b=fMwtZg_xy_Jxwg@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] pmdomain: mediatek: mtk-mfg: use clk_determine_rate_noop()
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
X-Proofpoint-GUID: eXXSVJ_EJ0nM587lqLW42hZyOOotScMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfXy5nRi83GusvO
 PjMpnPcUtz7mTq/l2RMw/2VlBUtId9PzfllndXNqOZPtGcxZysTeDrtv/O/bc4Pj1uQhBbWi7z0
 Od7EtB+4XBB2wQHoWNu+sj7GXgM4c2H9vwcaF6NxQMmFUFjJzJMw8c5HFVOmDzOcZr0nlAyHijn
 EjXOTQ322DpP9+ZfBo9COGqPTOUGYX5lLM/aAigUpeofcPVeCIv+pP4shDvih/BI2UuFledLOoO
 AlLJkCqysPHB6nkuBVzzHaN+tnE8gH7r1g9cV4VdDt/5Pu9bsn2NT6dCDY3TyNbEMtM+GwT1Qx6
 RIZwx7eEoabJoA/krl4nJP5Li9oj4OvQ1NnzXI/M4Nu7x5czQj3nNuGt5HHtyT3wlcntxH0r45j
 G4QeO24/DhNKfHFoSZnVEUE3OQbOmEr4+sdeYXDo4Y2yHMQgY+CgFrwa4pXBsALNZbMsQWMHLO4
 uEGJmNHpeb1pl0/lTAw==
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a1ffeb3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=QX4gbG5DAAAA:8 a=IpJZQVW2AAAA:8 a=JfrnYn6hAAAA:8 a=rQN42pXJ2LDxoJgk6j4A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: eXXSVJ_EJ0nM587lqLW42hZyOOotScMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
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
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 23 ++--------------------=
-
>  1 file changed, 2 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdom=
ain/mediatek/mtk-mfg-pmdomain.c
> index 3ce6fb74dd53..64fef838776e 100644
> --- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> +++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> @@ -310,25 +310,6 @@ static unsigned long mtk_mfg_recalc_rate_gpu(struct =
clk_hw *hw,
>         return readl(mfg->shared_mem + GF_REG_FREQ_OUT_GPU) * HZ_PER_KHZ;
>  }
>
> -static int mtk_mfg_determine_rate(struct clk_hw *hw,
> -                                 struct clk_rate_request *req)
> -{
> -       /*
> -        * The determine_rate callback needs to be implemented to avoid r=
eturning
> -        * the current clock frequency, rather than something even remote=
ly
> -        * close to the frequency that was asked for.
> -        *
> -        * Instead of writing considerable amounts of possibly slow code =
just to
> -        * somehow figure out which of the three PLLs to round for, or ev=
en to
> -        * do a search through one of two OPP tables in order to find the=
 closest
> -        * OPP of a frequency, just return the rate as-is. This avoids de=
vfreq
> -        * "rounding" a request for the lowest frequency to the possibly =
very
> -        * high current frequency, breaking the powersave governor in the=
 process.
> -        */
> -
> -       return 0;
> -}
> -
>  static unsigned long mtk_mfg_recalc_rate_stack(struct clk_hw *hw,
>                                                unsigned long parent_rate)
>  {
> @@ -339,12 +320,12 @@ static unsigned long mtk_mfg_recalc_rate_stack(stru=
ct clk_hw *hw,
>
>  static const struct clk_ops mtk_mfg_clk_gpu_ops =3D {
>         .recalc_rate =3D mtk_mfg_recalc_rate_gpu,
> -       .determine_rate =3D mtk_mfg_determine_rate,
> +       .determine_rate =3D clk_determine_rate_noop,
>  };
>
>  static const struct clk_ops mtk_mfg_clk_stack_ops =3D {
>         .recalc_rate =3D mtk_mfg_recalc_rate_stack,
> -       .determine_rate =3D mtk_mfg_determine_rate,
> +       .determine_rate =3D clk_determine_rate_noop,
>  };
>
>  static const struct clk_init_data mtk_mfg_clk_gpu_init =3D {
>
> --
> 2.54.0
