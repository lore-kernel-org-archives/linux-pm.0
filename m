Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71436F901
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146466; cv=pass; b=T6DkfDX7uj9pXv/Ee/yiUThguqTnTARdfNjyqwfk6GimsX8k6NzDBLrLwJfqs3gAORvmwGddlSPXG8g/vUHx0QJqWmVciJ1Z6NVSSi6GvXjNCInkNVgz63+3K68uMC4PUq6SdngDhaT9r58Pz6Y9mPcTccfPD4Z2MFOwn5eYZA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146466; c=relaxed/simple;
	bh=4IkRrpqM8951uHU9fku6S7khAgR8gubGxVaPfcIAafU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMhewqfmqvZFfTE1MAI1LgVPmDXS/3PZBBzZAi8Cq2NAGs3Kds/9vEb6snxqogprFwWGTr7bbVH7s58lpdbPvLRV5johyWQ7Q+pUZyr0Z0v6Q5wq9EJiqEhD3nMFdUrwQc1xr7GsdXY03bZe/I2e4LaCq/4n7a0SPypo89lQQbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=chWU9KHW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C9RwnHzK; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="chWU9KHW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C9RwnHzK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9WvAC278847
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmDiEXxACfljywIFz1W9JSRHmKR6p36Yja9EDW/O9BQ=; b=chWU9KHW7HHUtuwi
	ckvJe60dImllbKRrEXpmMbo43YJLOwI6raHkUQD+DgAlCs6stQKakPt8Ji7/+xt8
	pUi9OZPOBY10f61PgprMwz3cRIxeWuad4Ip1Fell9knLu6U5KMIOnHDRV4XF8k+g
	zDxgz0SvApLDoFIzh2s1jnhFj6oAyxjCfgQg+mf+sNcMy/SwGahJ7goATVTbU+8z
	pKvxnxCtzHii4tkT3y//ITKDoMpqG35gjDeDwGh3hV6YvAXuAHwSDQLlRIntkgva
	hmbzqaOitfFQg6cDCQTGQg/NJUuVhkRV/flLziRJBj2/AqVFm8u0DbGVKqIpbABQ
	ooAPsg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fny9whdn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:01:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8eeba1d9e47so41136846d6.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 03:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785146464; cv=none;
        d=google.com; s=arc-20260327;
        b=LyYSYfBHKhnacH0bX0rPPdZL23p9ltyHt2nD0dDJ+CXcKpH1nbw5USwMmall2Abt2V
         Zr+qGCsCX/kPWrHazcNhjN/Jd2cip0EzFRMkCBgL1x0ecw8wDOUebT8kT04/CkJYH2nV
         8YGoe/tsk4tC8hpiSEhwcCkUoIhXy6FT5kEpEZeaXvVim5i7JyIhXBAmbvUg948VNezZ
         Hsh0WZh3F+2S6cfSznFKUq9M9yucY0r3FG7S4ecYn2Lm9d6uQEZrd25/+jDB9nKZVDBS
         UioBHsUI1uEDv1FZvyh7+3ZxgJPyWPrkuvQBnNl8Dp5NOdJd4KJtDZP2bSQvFiXXu9wE
         LWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KmDiEXxACfljywIFz1W9JSRHmKR6p36Yja9EDW/O9BQ=;
        fh=xdL6cKG0m1iDKT0fwN8LMzqRJqYbgcZHhINukx9+7lk=;
        b=BQcoyHaIE7JUWDO4MoOnaImHBKx2kddNNiXNPtOWuuicsfVfpjMOPPSTgEhOdHqzF3
         3lmoNT11jy3Gm7QynXE2sGXxmE4udXp5sIAtI8LEE5gtQGYTJYqrUN5MRjGqd5MopIC9
         M7BikrVxzeP/mO5zLxz4cDLTQVG91guwkd1zmq98bFccFqSvm0J82FKL9AYPPnS3sHfQ
         XoIyH62oDxSwdl/Th/4vzvw3VzpIWtIErj0IeGi7BMkotO09xrsvPydLOMJPKvb1ZlME
         MEmv4J3PVm69nTHmfAlA55Z57b0FJQElRu1dx99RQcMd2llzLnZ4UHx6ugGZSnptU0J4
         6g1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785146464; x=1785751264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KmDiEXxACfljywIFz1W9JSRHmKR6p36Yja9EDW/O9BQ=;
        b=C9RwnHzK05Jv24esizZ9a884xhfdrlKk39rbRpOP/i7OieQBn8+kSIVsleSQZ6QwDf
         M5HNUcpMeMhu6SmKX+nrfS2vtP9Tkg0pg+2T+olWQ0BdXD5eC9+VL1A+bQxyPwIMVoEb
         T4BwTcuZIhCfsxiW1MaaMYNEFCPME5S9kie4gJFyEb4jF7/vNGDQmoIirUGTEzgnS5pa
         Xnr1euw/OllZJ7qlaWzTmbOrXh6occJspwcRTZbXS4tk40DE3/GaEYKjN7cIne4dn0E2
         ufMuee/nYzVkOB0tRUCoNQtDUgdTiO4KCZjdV+FGoZsmRjDXHMBlEOkdqPdDpzSxLcGh
         QhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146464; x=1785751264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmDiEXxACfljywIFz1W9JSRHmKR6p36Yja9EDW/O9BQ=;
        b=FcPLxg84GDJAKVhdcpSePp5ikVkTDXhxQALZk20A5LiYaMaWR+qc+bz2sfiOKceHdH
         LtaXduK9AHciadezWU8oIdznTgw/BOuXOVWvLLkkbYMS0/T1y+M7+eIoMvJYD8ihCkTq
         cci4GFOjyMatpRfX73s99W14OUnUcDna2v2VyUIzxhj48+wIMfD7ZN/8ikLHYCoqTL4B
         c91mjAhSVNGnFGEyKefwhu3THSouUfyVsKvc8tdWrpgq/yb458Hg9u99CJecEKczyFDg
         kAXB8f+CBRQOwdzoq4Mq4tY5aVN094YaMkug7rzuevOg6maYAUnhzehO5b2gVLjnYNOe
         AVXw==
X-Forwarded-Encrypted: i=1; AHgh+RpDroGSHmdKfGtnx6QhAfMh22kA/bPgjE3J4Am6yteoWXXVEzuVvYyPmo0kndMMBrp9lnsnhRfo/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIx738Zzld7A6TNDSgUFBBl74iaMYx+8OS7F+Y5tOxyKqGAaKl
	TnrU+l8AF7gS0Cw9vTJfAZ9FzWKzBBPjyvWNZpl195QC1mOOp2rmZgJXNHUmIxGP9CRWzgcbHhi
	Q8FLgcxO7qBg8A0IQLzyFsOIGWaBmp90hE936DAL+fCUTfCpW9K+K155pZ7RVIiboPkRqP/gN48
	/azDbHjWx2CoY7y+2cG9dWx8nA4oYVzzAbsXUo
X-Gm-Gg: AR+sD10FAfz5T1TcLhplNYqGSVdC+/h9Q2PQud5R85gTfWYrR46XMeUsmiw+UsXnZrQ
	BtcqVT2+5ijBGbnh8pIRz7S+gq+Z0A3TQ2g8owEys2YV4r/o/ysCJZFsUmUUwXUWXJ41fMA+NZj
	UTKJXAsT74BOVQQruMtwggCOP00psQfVC8HascjMEP38zLHUVSF52D9HkhNQ==
X-Received: by 2002:a05:6214:5a09:b0:8e8:b302:8afb with SMTP id 6a1803df08f44-907ec5e5c77mr86121116d6.0.1785146463816;
        Mon, 27 Jul 2026 03:01:03 -0700 (PDT)
X-Received: by 2002:a05:6214:5a09:b0:8e8:b302:8afb with SMTP id
 6a1803df08f44-907ec5e5c77mr86120416d6.0.1785146463265; Mon, 27 Jul 2026
 03:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708092038.741308-1-lgs201920130244@gmail.com>
In-Reply-To: <20260708092038.741308-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 12:00:49 +0200
X-Gm-Features: AUfX_mxRMxe0tuzgdBvzQ99tJNh8MEcfgARzgUQyUvcrVWwi5yEYYKrgP-hzda4
Message-ID: <CAPx+jO-fnCyJqKz6sZR=y4=-CWLicrT5gvw6xqoecJk_dimGMw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: fix remaining %pOF after of_node_put()
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
        Irving-CH Lin <irving-ch.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>, Adam Ford <aford173@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NyBTYWx0ZWRfX11kQCFr4voHc
 4a5v4OlaQ4DagHbA7rnzrO9pldR+g+5exd6GZofG9fyLHV1+oOmiyP28lttcD0sqdC+bEE1G9wn
 xeqQ1y2oQYKOLPFoppg7TZumZBlcLjuzMh/8ne0CmlX4Qhpp7a2wuWtALTFwZ4iFhZ1MadvseRt
 9CHdH68I4rkG+qd73O8Cu2AGPvuoDt1DvXupZSbKvbi17TiCdHcJu/CzIFtYbEl1Em+aoAQshD2
 t0vigTuhPDVJOBmZtEYO+oilxFVA4Zhz5SwRSPqybjZzGVsl9e4sW1Ady+oHH8hxDzTnj9bVN3L
 t+GV92Vez+XJbmtGjhCvM5n/iCJQK9Y9MZz26YeF6RgWjJ0kq57zelonh18ImnK4OaCVchA8HOO
 JD0yapsAXIofrmZfTw2KhP7BAug1Q9USnzX/K5OSkdBD0wvKwsrAoC9TzvTF6c+0b0zesK1MDzK
 UHYI1kGelPTjxAR1ctg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NyBTYWx0ZWRfX3Sy7bNJKmcEp
 qWZa9hB21zdPNfzSAHoHZKBqAGfUGLtUs59wDlVakuTyyEkjCPKFkHsM6Cxnu6Eqd3rOefMYQ1b
 P/UC/3EnSPRa5p+Cz70mMbfSBQDchTI=
X-Proofpoint-ORIG-GUID: tY-S_jJYesuK7KbqaqAueNTnzRW89IVa
X-Authority-Analysis: v=2.4 cv=E4b9Y6dl c=1 sm=1 tr=0 ts=6a672c60 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=R5A58VEcyW3-00s9QQ4A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: tY-S_jJYesuK7KbqaqAueNTnzRW89IVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270097

On Wed, Jul 8, 2026 at 11:23=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> scpsys_get_bus_protection_legacy() looks up several legacy bus
> protection regmaps from device-tree nodes.
>
> Two error paths put the device node before checking whether the regmap
> lookup failed, but still pass that node to dev_err_probe() with %pOF on
> failure. If of_node_put() drops the last reference, the later %pOF
> formatting can dereference a freed device node.
>
> Keep the node reference until after the error message has been emitted in
> the infracfg and SMI lookup paths. Also drop the SMI node before
> returning when the SMI phandle is missing.
>
> Fixes: c29345fa5f66 ("pmdomain: mediatek: Refactor bus protection regmaps=
 retrieval")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomai=
n/mediatek/mtk-pm-domains.c
> index e1cfd4223473..f877d6694dd5 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -1032,12 +1032,15 @@ static int scpsys_get_bus_protection_legacy(struc=
t device *dev, struct scpsys *s
>         node =3D of_find_node_with_property(np, "mediatek,infracfg");
>         if (node) {
>                 regmap[0] =3D syscon_regmap_lookup_by_phandle(node, "medi=
atek,infracfg");
> -               of_node_put(node);
>                 num_regmaps++;
> -               if (IS_ERR(regmap[0]))
> -                       return dev_err_probe(dev, PTR_ERR(regmap[0]),
> +               if (IS_ERR(regmap[0])) {
> +                       ret =3D dev_err_probe(dev, PTR_ERR(regmap[0]),
>                                              "%pOF: failed to get infracf=
g regmap\n",
>                                              node);
> +                       of_node_put(node);
> +                       return ret;
> +               }
> +               of_node_put(node);
>         } else {
>                 regmap[0] =3D NULL;
>         }
> @@ -1046,17 +1049,22 @@ static int scpsys_get_bus_protection_legacy(struc=
t device *dev, struct scpsys *s
>         node =3D of_find_node_with_property(np, "mediatek,smi");
>         if (node) {
>                 smi_np =3D of_parse_phandle(node, "mediatek,smi", 0);
> -               of_node_put(node);
> -               if (!smi_np)
> +               if (!smi_np) {
> +                       of_node_put(node);
>                         return -ENODEV;
> +               }
>
>                 regmap[1] =3D device_node_to_regmap(smi_np);
>                 num_regmaps++;
>                 of_node_put(smi_np);
> -               if (IS_ERR(regmap[1]))
> -                       return dev_err_probe(dev, PTR_ERR(regmap[1]),
> +               if (IS_ERR(regmap[1])) {
> +                       ret =3D dev_err_probe(dev, PTR_ERR(regmap[1]),
>                                              "%pOF: failed to get SMI reg=
map\n",
>                                              node);
> +                       of_node_put(node);
> +                       return ret;
> +               }
> +               of_node_put(node);
>         } else {
>                 regmap[1] =3D NULL;
>         }
> --
> 2.43.0
>
