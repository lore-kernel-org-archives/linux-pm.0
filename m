Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75C03EF0A6
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526019; cv=pass; b=GDlJX+eakdMnuVGscDckUFII6OOq0qOOyzMxs54/0xIBdKlw3X4Vq4e6sRknMoDe4MLOuPdaJlOu22vvgm+/mghu6lTXf+OdBZaN65Z74wwxH5vA49uyW0eaHYEilwIAh4wXspPPoCwPoUaZDKB7XvlHGlMSC7hBvIln20dIRus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526019; c=relaxed/simple;
	bh=xIG+GI8jjmqE1bJaEa0aCpDJwSUqu9pO4odjMFq7XNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7HH+oJ8wZHFlAengr7vsQ0wHn505xU48n3+cxRhWy7slo93/2jQR8rgD37B+S1Ti1TnAwnBCqA88McivTee+BjkTUFB7psRjIfJRUW6VSriJdTqWsXt8ddCSm82i7rWlVUDiGP6IP/jhqDLSso5ff2gAudIvMJx1fzTaZRrz2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7sFrA09; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zfz9L6Bz; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7sFrA09";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zfz9L6Bz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8YqJC3847944
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J3Pf6ybetTMox7LP+PnSCdMNRpptpmQ3Q57LrgI5uBQ=; b=L7sFrA09AFPegeVd
	dwP8/Th3CeYGncUc4G8wz5nz+cru39v3r9jFGPTdx2eJYIGC/nJkbn7Mhzl0oAVf
	PAAM5fTe60+L7xOyrbw8+Ay04V9W0j9MPsGUr3mfpb+PmxpshMEBHDiP/as4Q8mJ
	vhxO+n65OvYhvbUQI6rKOM/JBL3qiTRME6KI+brCiZO8Fja4G5gWMkwjDsIP1JS2
	WyPNlIQyw2cA+SBz9kDrJQTKnJxzk90AzEEUoICMkAwbsgbThSfbarmxmESDRczJ
	TQQAqZ6/h8YrTGqfWMrSq4rrwE/tSOnEHnsWYvfwj/dBgpC/W8n89lDQdAQ030st
	Ibhc8A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5k32t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:13:37 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c134f0501aso175962e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 02:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786526017; cv=none;
        d=google.com; s=arc-20260327;
        b=f+kqlZmWV2kNOsHyI/0Vdl3fyDyzN7qvlV/+BZZSzQ6NE+QCGXimvWRTxrKqQ0mHoP
         Qb4iFUrJMSWxqHNNj01Ts39BsiioOcLlMuHap8lUlHi6G76/8vYE1IZnDFgOiwOpuiqR
         e4kTehvOWHriY2VsZAgn3MdcB1xbZ/fQnqtpJXmu+mvR2DTvrg4hxRJN+9x8uee6ALCk
         iM6QkvNLU24b/eDDbIj0EG/o4VSdlx5NSFjixAQYyeNOXKo2XOiENjYLFzLxEWKTHmsR
         UKkqxaJYW49VM2z40fyv7/tWdHrOiDNbj2mtcrqfaygUcgPY1WlTmvPZRjoXJXdjEPo5
         j/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J3Pf6ybetTMox7LP+PnSCdMNRpptpmQ3Q57LrgI5uBQ=;
        fh=MRdL0HZNIAUtN/0265Szf89YekPv7BLqZ+u6JKmbN+g=;
        b=Tw9DjmVNIVCEKRJV8KQcIZ3tGgORWeR5sbdRA17JW9+W2TVn725eqA8dNWKUupw4l+
         wjTG1eLntweAEWgKDSYiO6qWGJQhibrti9jg5M6FKOzY7EshK27W0pD9k8EirvXgPcZG
         KsiL3KAWbtB95EogyaasZycdIE5MCAG1F4br0vg/L7uekuT+LvhrodILXHL4P5ZrM2AP
         u5Nn3h83L50wdvS/YS1KAFDPnVyn1zFaJ1gOaXnSCFB0VvFesJ3VCQys6wmmCvWeZ7C+
         qXIiEHWK0HjTHwO8Xr80EsKDE6Q5rvGjO22CEmgT6KBPp+CkoLVTF8jS7INBYm0i4Tts
         I+qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786526017; x=1787130817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J3Pf6ybetTMox7LP+PnSCdMNRpptpmQ3Q57LrgI5uBQ=;
        b=Zfz9L6BzHkteL7tUojVPEzlK8W7yDGCNGusc/s/xh4kO1Y8yDIUSRuRCDOplYg+mHT
         yC7VPQnyFv8mmMBc1gB4i8eiOJXVwWMFpX4TfRLki09951qmd+kzGnyyGlRES/+6Bj7r
         XL5nB2/lX2d2P6XzmNwnKe2MOlOt5UqMIxV1KTnFbhjsSPBgeLyoEpdR6HOw+HQNxnu7
         jJEgjSWrULIgQ1+9+87CelgXoeI1xFNP0pyGzbBq+28Xm6/CTO1CclVFpd118Dw9br4g
         4p7hmAH0GcH+K32oij7KiOFt7kH1naz+MCcm62DWMVvHJehlVMe5eGWBjkYGitliSspj
         UWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526017; x=1787130817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J3Pf6ybetTMox7LP+PnSCdMNRpptpmQ3Q57LrgI5uBQ=;
        b=WDQMTkp+A1ye8SAmXp0GijU+C5ZKmBtgRERbVGGLFwqvNHR030ZEJ1PsWzusur5nW5
         y10wsyHvRiyrSSTONAaW38VMi89A56dfuGFff/Vpco8yN7WdP0aRZITEkIstAoHkwWN0
         xyZeC7OvyPiz/Wr4lQvRr5+lsBLFf6djzwSh0e6WUJbdtKW97XFtRYT8k2AbAng7uh6a
         zLYf/SdrtjA50VW6WwFZxnA6Hzu9e6+bI1mPmMccgnjQZAM/ddD+ajAvksE+qDw4oxzP
         v9RP3SMerIwn0kE9xhadKWT4BVkrqGgZMqxKeQrP/84+mNDal1nxRg9aqw0S1+VuM5gB
         bKVA==
X-Forwarded-Encrypted: i=1; AHgh+RqYhfPedTXiQECt0qfgdM0NcabIrAXWOFmUS27Vh8G8vIDlXZ27boUyZwfri4BgERPqAgnw6XeJqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyozpHF7ozM1eEHUEqBJlVeJKwnHFynqe0VPUptU7nLYe6fjJvn
	cXHUKmT8Dgcw716mqvHQK7fDZKJqiAp+KWwmMd3DsRG7doiohmYUPNfA53EZaJVh7c6xLlpfw47
	OcWG0JBB58JGh3HwK4Sb82SExP0rw8RUjxeDKFbk8+S39oOI24fQsjFjORUwO0UN8Y3LLwr0Tsb
	Q95PI74uOfw6mpodYn0KOBsZaX+AZlFr/do6ET
X-Gm-Gg: AR+sD13BrkLS9DKnMjP43Kw3aHBVGhFrFLG/Zt2v+ZGejciHHB0KNax6bypcRZbguW+
	fVlZ/6fSG+zYMnIUHHQz719/WhliX4+8Fxzkn9tBj9EYtdBRhyu315lJARcT7Jn7p+sfymR4+MT
	zasHion+qgTxpCTwLfJsiYG1qtmF0wXP+f+AiNPCzHd7a4SHih7eIy/8vE92b78aMqnLwjexTMM
	BPI5EQn2Pr+599o5g==
X-Received: by 2002:a05:6102:c13:b0:6a2:b2a1:f16a with SMTP id ada2fe7eead31-76c877585f8mr619076137.2.1786526016772;
        Wed, 12 Aug 2026 02:13:36 -0700 (PDT)
X-Received: by 2002:a05:6102:c13:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-76c877585f8mr619064137.2.1786526016415; Wed, 12 Aug 2026
 02:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808150506.78534-1-kmehltretter@gmail.com>
In-Reply-To: <20260808150506.78534-1-kmehltretter@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 11:13:24 +0200
X-Gm-Features: AUfX_mxrjM8iyAWaDhMnquvm67hwsMzBGMAivc7nk1vv82k5vyDswHGVflOUtdY
Message-ID: <CAPx+jO91LMn4SJXvy_zi2zOcmrDane07Mnh_+bKLztozFyPF-w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: mfg: initialize prev_o in mtk_mfg_attach_dev()
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Brian Masney <bmasney@redhat.com>, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MyBTYWx0ZWRfX0ADD+j1X8NtO
 x2yCbACdyYEV5BxlYo/AaxyrNRhl3gGoasV1cBfmdG30Q38epHJ2girEwEb8Nz6UJhXZrTF+YoT
 jkZY9/7j0yqKqRSGUXiawvAKKf299yc=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c3941 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=xhlwbj9xLX0jMGTAeIgA:9
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: GWYX9zxE6DL42iv_D45jJCkgT1k2IZCK
X-Proofpoint-ORIG-GUID: GWYX9zxE6DL42iv_D45jJCkgT1k2IZCK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MyBTYWx0ZWRfX+8ufN/DiAWn/
 aGs41ZtXI3q1oZS9gPk6ZqCvumANINBazNnhOrZLbGuUauV0Rd79Q3ApTPNr0ZO8xiT046MZpS5
 II/YkXAGRWtpkZKl1KeW7X5JL7jZQGlMi8oxaIa0JgnwfhNvXoBLsMjIymR6nwBvOewZPaJVwxs
 QKyu8rScV3ski2085WhlJpUFBtJwzTC24Le9Igjx3d4/UjdvH+Xmfk54go2xPur8av4iKROSpIo
 X8k0y2lyi+dfC2QSGu6F32XZv8ZHY2xCfNvpVZdwztozOlz51p92Bc6KZQZy33deda37zSXjyIk
 xoG5RJ/SJ7m0rL6umvzARr3EyEFN925N54XyWxF4KJ7omK+mvbmf8TIAgkG1VwaZ9W/xbEvv7u1
 KVSb5pJOqiEtLwqeMpJ6U22uBnPH45hbWLOUp0K2y1UZbyGvm56K7xyjueHdnGLm5Di4+vnhV0W
 glTGX+Q7v8uggWM0uEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120073

On Sat, Aug 8, 2026 at 5:06=E2=80=AFPM Karl Mehltretter <kmehltretter@gmail=
.com> wrote:
>
> mtk_mfg_attach_dev() reads prev_o on the first iteration of its loop,
> in "if (prev_o && prev_o->freq =3D=3D o->freq)", before prev_o is assigne=
d
> at the end of the loop body. On that first iteration, evaluating prev_o
> reads an indeterminate value. If it is non-NULL, the condition
> dereferences a stale or invalid pointer, potentially faulting or
> incorrectly skipping the first OPP.
>
> Initialize prev_o to NULL. This matches the intent as well: there is no
> previous OPP to compare against on the first iteration.
>
> Found with Clang's -Wconditional-uninitialized.
>
> Fixes: f08e7a4e8d6ac ("pmdomain: mediatek: Add support for MFlexGraphics"=
)
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdom=
ain/mediatek/mtk-mfg-pmdomain.c
> index 53bdab66cf157..9a8a38d98cce7 100644
> --- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> +++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
> @@ -657,7 +657,7 @@ static int mtk_mfg_attach_dev(struct generic_pm_domai=
n *pd, struct device *dev)
>         struct mtk_mfg *mfg =3D mtk_mfg_from_genpd(pd);
>         struct dev_pm_opp_data *so =3D mfg->stack_opps;
>         struct dev_pm_opp_data *go =3D mfg->gpu_opps;
> -       struct dev_pm_opp_data *prev_o;
> +       struct dev_pm_opp_data *prev_o =3D NULL;
>         struct dev_pm_opp_data *o;
>         int i, ret;
>
> --
> 2.53.0
