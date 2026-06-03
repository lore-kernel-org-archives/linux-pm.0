Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5BE37C915
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481746; cv=pass; b=YT0yuj88F5mTy/EcmNPyDUmGzp7LIQonOTjzQhLaTOvigB6/k5nDWgCu3KmhEEZmJ3gaFsczbyetAVCiapNtjjb3mi3PvPbnDZVoKlXGASEIvqtpaKsXVct/FyyXtaxQ+jUH3eWm5U2lvpXwUxjuK7gBn8jbZazpn40purA8srA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481746; c=relaxed/simple;
	bh=8OjRRSrn6GzrY+bOf7p2g/n27+g/ICdYdrrOe8Fld+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgOgklRO3wYLXN9jY4kS7bJhPvLwQSCGNvl2NkHpnRY2p7n+K6ffmn98H77fHoPNLkuV8HIxIzLOdODZLbbEhkArmrfenQjZv2ygRIJXVsoEUhxTt4B7vsHI/e4WQkmQ0Kg5EWk5pHW7EWEdXajui7hCnmPBJkmRXOykcCAukD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ezZXX1CR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SODMH1Hk; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ezZXX1CR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SODMH1Hk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536vCd81755426
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 10:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4g1x/DzNmKp7+EQtmsRUP0hUBgY5haHotigrNnUfOxc=; b=ezZXX1CR+YtOZz1Z
	EOzYTWtnYE5XMPNmnIHFU6HWZOln5nXjTVeLEdaSfNqD9IzhIwA35OfIubwcMLDv
	fqTyH0HPv8F9Cg1uO7kDWXWB59TxQUDjzWVysY00DuGKoHDxZMvj1JsEewvK3q8u
	GqCmqRtnHXeYnF4oJgI1AdoBhsqybwfvKHa3iMtwHIYt8SQ0QkQJQPPcCukeIk5s
	FisxP35gj5LleJgpaez6U3rBC/QGCO4eg7E7Y60rF8d7cB0nLn213R75e3TpiZRc
	klv2vHlop8PV9Clvl94XhjSFPlNfdrk0jxUdE4WVtj7jEDjOgwn5LVanphErilbL
	z2IZkw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejff00ugd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:15:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51760f997fdso12998541cf.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481744; cv=none;
        d=google.com; s=arc-20240605;
        b=dCtyqMbHmmCz8utyKRiyqX1dCAnzfBHQSScAQXzXzmeIGA3bGqoaG3tGZKAgSf3Uxe
         PQkJUNesNMMKEcRSEc+6F91iYu/XQbsLQS5fVBqZ7L/qtvSchc7Z76heyr8qQ9Dma29j
         kD//H/3IJNgfNTv7T5eiHqhmNTan+ie7MEewKwuv18tflaSJsOjMCU5tFsSDThVpPdmo
         tD1JsO3Yi1b/jaH/FmtKvRbzytyn96/zs58cDXuatentO0Fav+7BbdRU31VqXe4SCFXY
         ooUuca+93IQxpaMghmmtJUTpU0afy3o7Regmg17gOHedAk5Hi4yPJy6sgr/+fn6Ps5iz
         6wcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4g1x/DzNmKp7+EQtmsRUP0hUBgY5haHotigrNnUfOxc=;
        fh=PwfS8rHHX0sxor1mEqX77eqb33S4XgEgw4AlkUnrZJI=;
        b=HPWqoVnasxMcnNLw3tl7cy27XGcGh5IgqA8TkWRjaoV8SyqwInR6XjYKxTfdzVlfFX
         fLH5okqbee30n/4DHYDMpHPP6QVWOHR06PTjUmh8MRpHDMmNBa+z/i/P3337QtNUxTK4
         fSK0kJrvUhzW7flJuVn6AtpINEfzHkLrYeEZdnqiA2FLwx5IYGgqBcTlZ6nOWLAi7Apy
         rDMOgjYEm5bJFL/lV0CGJGWxWjiQ4i5BbYgE2Yfb7tQNpu7rHx8bq95DgseSY/PG7gOn
         ZYk2TyRYtNyTaPx3Je39pG1x5qger85cZcy2wfGQb/t+EqDCw3RfgwoG4lXwjK/U7AJJ
         rPtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481744; x=1781086544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g1x/DzNmKp7+EQtmsRUP0hUBgY5haHotigrNnUfOxc=;
        b=SODMH1Hku7LpSS5sj/7nRv0iqfqqHM7vRCBETCsMEoBMPFjZX+BmoSVmgrbEUjPJpR
         hoqu6m5BY8qyF7OlTEDkIiFy75GJiyjbysjpEqY2+4Zi48BLNNeOWKM1qTaZVhQTY7T1
         UYMUYotwAcMZ+rXrYoKNXN+6B6A7QBvD0ktan/6Cvp3xwmmRDhcvOT6M9rv4s3wALJS4
         QRSZMcMFuN6BEsLA9ekEvHDrJ0ZcCUYu7GQOHtddzzj7Pj+GXmQdOpgVRAZJaoKH6Y22
         RmT2R8W4jdAiSzaWcQTijyImvjMQwyjDq4Xg+73pvrYgXGxJNRhoIish13kq+CmzLk34
         GoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481744; x=1781086544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4g1x/DzNmKp7+EQtmsRUP0hUBgY5haHotigrNnUfOxc=;
        b=d/mdtlTuwWbd5qPUif3T9UvdoJX/sRzxrZrXWdRMwiCz7yTYmekcTDr+CWxMByUy92
         //4GGIjeiLwJQP3ZWPiBkqd5lCCwCwItFyhJ1yOkG9ye6slJg/I/gNOOtK6q0nVfWS52
         cIXN4q0jT7p2VSOOuygebl9ccOftvUq0cpMChXcXNnjDhFgQIrZHzPCt7hQhOHWNeuuu
         wSNnvu7oSWzGC6tQEbctffOyAvvQ0bjmG03TeNC27Z3njYFFRyO9JdBX8fRRiWNbHnTH
         nrVLEV80Uh9zTBslIdG6vkqTkyAIEi8UM8OTG1Sv2Zsmb0cbnPvJZX3qmypH+XFkNbP1
         nuGg==
X-Gm-Message-State: AOJu0YwHoKi3rQWnjKAGsNX2CVY3qmzGOCfGoH4j5J2uOP3p17Z6u+5G
	gtZK3oSPvXk51PK0rFQfb6lhbzH/pxtHuCD9Hu895luzzlllyrC9F/PZZiQ9fia1Aymjd3DmS+I
	W9GSoZUPXz4zlcK5RPh7JTuMocBbgVs3zP6JmSp94NzUg6suUIu70/qCzWiLU1zSXtPbJ6hkyCH
	qA6G0ebV8xdD2KC+FxIJN/Ei1EjHh86+nYplaIfLyevfTeL18=
X-Gm-Gg: Acq92OEuCgNUmPGvSixwRqt8lgguL1rZL5MH3BHQiqGG7IGJ0nxOEMTMlJ6PxFEAI6R
	A5NpmExLGv8SQEmE5YaF0kmEjx21wAnlofRNJvrj0iln9z9zJpLFCW8LTYFsMQXG2WMTb2zimnk
	o+uB6SYf7aJ8qlPKPLez9u8ZulgaWBIaQp39Ua5AH50HgE3OXtMSpk9jo/WVx6Jjit62nHQDsDh
	/lDymRUTuGx63ZX
X-Received: by 2002:a05:622a:8d12:b0:516:d66e:7b1f with SMTP id d75a77b69052e-51778705ddamr35756711cf.31.1780481743692;
        Wed, 03 Jun 2026 03:15:43 -0700 (PDT)
X-Received: by 2002:a05:622a:8d12:b0:516:d66e:7b1f with SMTP id
 d75a77b69052e-51778705ddamr35756461cf.31.1780481743337; Wed, 03 Jun 2026
 03:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528202455.136618-1-rosenp@gmail.com>
In-Reply-To: <20260528202455.136618-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:32 +0200
X-Gm-Features: AVHnY4KtDx-pa93XzpTaccSbjUaGmCNCCMJjyEwZU8dcHZlGEEBgW87g_qR9iag
Message-ID: <CAPx+jO_4Es8x77Jv3Lf0E0zWjFpaoCaVKwWMPkQLHzaPf0G+bg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: mfg: move __packed after struct name
 to fix kernel-doc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ZJ-5KF35Pw-2eWZRKIQJ1FjgU61A035n
X-Proofpoint-ORIG-GUID: ZJ-5KF35Pw-2eWZRKIQJ1FjgU61A035n
X-Authority-Analysis: v=2.4 cv=LYwMLDfi c=1 sm=1 tr=0 ts=6a1ffed0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=0t7_9_tBnCl6T0_iKv8A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX72/EpIWKqs7S
 qlLWMxOrn/SM68VaSb9q+EmoVgWI7AliezB/bBX5UBdLGKRnaSg+Y94WXxolzFbNLLlfY6l4n0Y
 vGFCCWVlFOyj1NnK1F08NqrLGJmZEVlgpIYeUGr3b6DWYYq6+8GUSJC8ZQADQhAt1bB6rdNYD6t
 8Tx6TKVt+hTzHhw0exWzMrCL03+IqXXpHoxEp/J7MDceu+weGBVp5Qqfv+aC9e1T4DG82l1XIPo
 h0ksJ+9oZIHHd2ORdlYyVlvFEiEj54NQKdL881yya37QeN179v8uREMLaNWDZbd4+mQ5C7x0iDH
 UrBvR7EA2vl8NvVJGR3dUdxpqgQ0syAaUIoebQad3CJS+Na4488uYILFjFrXIetjoCN6/gqSPEL
 svV6fRWNa9cpuLFk2iDXryCQAKpnzXz+sqbIwW5yBIOMP0YuykXkilrON2HvIJiHc+sd70rrK0H
 /jF5M+pKOgCtsvQsKqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030097

On Thu, May 28, 2026 at 10:25=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> The kernel-doc parser cannot parse 'struct __packed mtk_mfg_opp_entry {'.
> Move __packed to the closing brace, which is the more common kernel style=
.
>
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdom=
ain/mediatek/mtk-mfg-pmdomain.c
> index 3ce6fb74dd53..53bdab66cf15 100644
> --- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> +++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> @@ -236,14 +236,14 @@ struct __packed mtk_mfg_ipi_sleep_msg {
>   *
>   * This struct is part of the ABI with the EB firmware. Do not change it=
.
>   */
> -struct __packed mtk_mfg_opp_entry {
> +struct mtk_mfg_opp_entry {
>         __le32 freq_khz;
>         __le32 voltage_core;
>         __le32 voltage_sram;
>         __le32 posdiv;
>         __le32 voltage_margin;
>         __le32 power_mw;
> -};
> +} __packed;
>
>  struct mtk_mfg_mbox {
>         struct mbox_client cl;
> --
> 2.54.0
>
