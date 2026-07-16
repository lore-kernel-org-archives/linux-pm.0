Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E6E40A93B
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204974; cv=pass; b=I/68cdsGLSHGsTxiGbOVnPh2ojqqVF8Ru7qJ/AqcjGoexWE4fo7tNjysfbBByiwirPQ8MaaUeWC7VhNmOKZRPnGOlluK2Y3Oiu7D9giwTdf2I3Byqn+7tX9i9Te5z5vjLin95DCEIkJcaDWpQb7v1gtI9rmaKWRId9mlcCtkDGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204974; c=relaxed/simple;
	bh=r/hBnNL3Ov/c78n1mA5VpQYJqU/cCKxY9z7WPMqtsQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oobf8be7EmiCXUpgvtUltbLOMqnUiixmUXZLDixJeYuzKTT7+HdkZtyrcXVMHZFOXK1YXgjVNAYA5RHKxe20pfvZyft96j21IZ+XEz9jS+kn6ou34U4TnmJymxk2EaStCXDudnF3Mwcx2ogI+7QenSWP8F8sPPNuEgSbQbrfScw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VzaAQwRZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Az0l7/S5; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VzaAQwRZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Az0l7/S5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBidMs2475326
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fD35Co9L2fRUmoJr/H8DQU6WIjSPhg2ZNGVyubNNIeM=; b=VzaAQwRZK1f5q0rL
	NbOkD1Dw4Y4qiqnJMgN82ti2juafflgk3+2iqnHA5sM/0vRhpHVoO6GhZRRyK+SJ
	vh56eBTa3IbqhIeB3R6AKVQ8axaflSdp+lJwSM5F0iNBs9/1usJID8IxBuDMiRT5
	lrlHpF87AoH7T8Sp4BsdJzLHNk2YUCKPxfiNoDD2fAyBfOz8aJUnAuJ1PNKQPARl
	0dGG2l5sJYZCrmscz8kWWlgsBspZxcggQqu0r54HsfYFG0UATtmc5NvCgSDdl8ze
	Z+sJnRsZqXIexuwXxE8IwpFcTCjEIgxz0FOpV9/ExTMS5hMsKr6P8O8+0vTNvS/f
	56KewA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7sbky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:29:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f18c4d1f82so132690386d6.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 05:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784204971; cv=none;
        d=google.com; s=arc-20260327;
        b=WJwG4hL4JOkW9HB66iZyxasWmJpMfwIiHnntFWSiIBr3nhG3xEFzACUII64ksmJ3Bd
         VCsNVA3Z3jRb29hsKUM60lK87t1o4Xf3k2LXpHvYCFQOZhg0P/sCpVfEgtHLDFGUiVZR
         Slt7lcfzhhNzqmVUzdFUopDHtcxSO+t1ToqcqCKOs6kmffVuqXtoMJIpHMQGv3R/F8a6
         Lfs1KDOGXGcrnlpMBUnOUVSbaxi67LTm1Gb+lzKnu3wB0k5hfHGzZZAaMzhYyVuYbV2q
         ovYQ1XY5mNDrb4jSpsMwQ37OJGdKFwAsFlqGv43nrMkwyhXM3fFspLym+fn/ABSNpx7f
         yO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fD35Co9L2fRUmoJr/H8DQU6WIjSPhg2ZNGVyubNNIeM=;
        fh=0q32m57tFDtyHZIXGVaL0vwuXYPJiWWFHTcevYTznB8=;
        b=nriD3s1+Km4MRcFOefR/Jfd8tauF3bh8ZWH6XlZhL8jqeWPBMt8pBzpf/mpBln787v
         Wmlan8qNHRjgXLokra78+pcjKmM+DjwDd6Byt8CoOVbG/ZPQSwb6kq2xeR3XfgDxGfHH
         OufiUGkJ1rRDv6IcgaaXt8O8DmAq0mxHaLd7Vi6OOWv34h+z1Vn5YxpySys914nHiku4
         K9gX7Foozm+ZAMTM9tj1ctWCEDXMxAcS+IgdW0U3hEruMZTrXlmBnzIWFOhR5uRV807D
         n+A5RJ3APw2PmEz7oZSvCc9PfiKIHSJm/Se4H71jysGlAplcKqhOpddRlN2VF0rJmPkJ
         +qOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784204971; x=1784809771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fD35Co9L2fRUmoJr/H8DQU6WIjSPhg2ZNGVyubNNIeM=;
        b=Az0l7/S5d7+z5LTq8umOOTnHKKud7HEvUtSuy6TEpAahCKu+MBv7+BubS36eK94XsS
         BkjjH9jQ0Aa0MS37hwxuZbm6tKc2Lk/3zR9LWcY2dClS5/wr5MXcPn1k8DAHPcmiGuPS
         FsMtui3oijc1Y+tqbHShKJwsPyjYBObKgVWzqzZF0cWzARl+qZbRBSwIH648jklcmnMe
         Tnhh58yUw93pa2XRwU0FQ/SaeEA7DwELbKfOXi1xKJm+/+rRqvTZlFRWL63+C3SUmxyP
         Oh6zQ9iBkKWG01YZyrQRllNcUNHpJDbrrtQFTmqSo5kZA3UEz8FV5hAeAKuhjt2pghNP
         3xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204971; x=1784809771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fD35Co9L2fRUmoJr/H8DQU6WIjSPhg2ZNGVyubNNIeM=;
        b=X//5J1m/ft08vxJ2YQ23G22M117K+cVqilVUoh8gydkLzmnJO/JINnwEhJnfGT1GnI
         jucyqbLkzEn2kkeNnQRq3jB5pZGSxNK7wQCS2663otSBhXSo9BJIpOvLmZG5wriaPu7/
         OGMKTT1kbv9+u/azELTNxF9NEUBl4KFvDWNSNGlslbC3TFMlZn5+prb/Y0naBs7032FH
         nzFtHHkslvfXri8lxE5cmPLx5Xc+OSDq9DuD9Gqead7pT8F+YB47L7+pqy8XPqWUBF/U
         sjIoe8nSgH4nQz4YdddkkN/dCJM8k6dSVBTudZHuDBas74yrfcYK0QgZuFNzoaqKPIy7
         fmQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzY8pffCNrWfR2trb/efdSQkraIh5OjfQXo4rp7Rr0gQz5A0UZJfSvqnQ+ivELUriW3NaGM1X5rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlG2+pChzbeMl98ZxXSgFn99j5Rz1JJ/Dp+fiHWiEfTH/ZMSEA
	p+HmM/Yo5pamJgk0ObEmICrq0GUU9/UZaEZlz/MX2Gl+dJuAjRkJFH67vUR8MkyzU4d1z+997pp
	ir0QI1E6E0dYJtKLNJx6uPJwlnG7FtvMaZ6WCD0a/ZyIe8N77PhxQn9IPO3zs2r012EGoRBWP2I
	ueX4lYM9xrudXoS/7i/D3VayPj9y3Mn45J2zFM
X-Gm-Gg: AfdE7cmvLfYp4BlprdpFcByE32MEn0WOrQ+0DVEZv+U/vhei3NSGFOGspBJm2w8MZJA
	6YGlQQSWc/ZesGNTOgZg/yvQ6tqFFZ/qENnOz+KKnhDc28ZLEWVari2JgBask81n9hpUMz0gScV
	5v1BGqnca7tWPfvhn2i+gpd4nMqmvpqKGfbHJ1rq8TQTe6xK9WMRXY6Qoq6A==
X-Received: by 2002:a05:6214:3913:b0:8e9:f5de:d613 with SMTP id 6a1803df08f44-90758e377fcmr78621346d6.50.1784204971438;
        Thu, 16 Jul 2026 05:29:31 -0700 (PDT)
X-Received: by 2002:a05:6214:3913:b0:8e9:f5de:d613 with SMTP id
 6a1803df08f44-90758e377fcmr78621006d6.50.1784204970981; Thu, 16 Jul 2026
 05:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716092252.251107-1-panchuang@vivo.com>
In-Reply-To: <20260716092252.251107-1-panchuang@vivo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:29:19 +0200
X-Gm-Features: AUfX_myMSwYY6dhSGBH2nU9UYe1deZcMtMoGCmhhiudYMdA3CjyG1ApDQgI05qw
Message-ID: <CAPx+jO8OLyX5YYrXQALQ0r7pJFXuPRwWGuLAt6bJOQZ=tiADcA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: starfive: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>
Cc: Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Ulf Hansson <ulfh@kernel.org>,
        "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXxSPImVWMldhO
 kHnmHrWwo628W7jeCYHbbudEzPySUGF7GvexTzSR/A5UL1OMY4PMM18iuliF+IakQ8Xdsgsu6zw
 alLhvNNBYWcWlCjIsMDiinWZMqCjp4E=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a58ceac cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=1WtWmnkvAAAA:8 a=IpB9Dso-8iwkxyQGB6oA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX5umCif2tboGF
 sHY4Bzc/sNnQK1LZv1U5iGT4//ekbVv+FaSfQc/Y/uPmuU5V+htP0IprrgExnHqrIAin48DxV1b
 RSsv/QxPTAogocvPcv2ZD0EEss5qh/vPqYKbTkBzFAtRlRgHskEo8Mxq7+GbOJOHV5UY/LZlt4L
 rZ1YIXjZWenME/x2kS+Q5r3/GcjPH4zG6XWjyLGwtrP9lTQ00fVoRSZsY2er68yLlrpT7yEZG6r
 7q1Kbedz2ddDQNj55Q3qWQP4VW40DGkZNZZZhLHAM9KR4S7OQfbkLqK92Jl3hCDBoBLmVivBxhV
 1WJdbjzmQI6Djl7NWLsldntniLgT4AOjgH2kDIgwVvxXuIM7NqU9qZDlDvrtG5qAMpztYdWrtQG
 R3Kg+NrjMppXn7ieT9aioDavFPgo7v5e1TMhSPca1LEPeGztsV0udgZqgoiLDY5PT0EjS/A16s0
 Up2lLAni8wFR1pd34EA==
X-Proofpoint-ORIG-GUID: yllOTwB2qi3bY-LT4pP8_TF0dNhTQhf7
X-Proofpoint-GUID: yllOTwB2qi3bY-LT4pP8_TF0dNhTQhf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160129

On Thu, Jul 16, 2026 at 11:23=E2=80=AFAM Pan Chuang <panchuang@vivo.com> wr=
ote:
>
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/starfive/jh71xx-pmu.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/pmdomain/starfive/jh71xx-pmu.c b/drivers/pmdomain/st=
arfive/jh71xx-pmu.c
> index 74720c09a6e3..aff07b0f5523 100644
> --- a/drivers/pmdomain/starfive/jh71xx-pmu.c
> +++ b/drivers/pmdomain/starfive/jh71xx-pmu.c
> @@ -276,8 +276,6 @@ static int jh7110_pmu_parse_irq(struct platform_devic=
e *pdev, struct jh71xx_pmu
>
>         ret =3D devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
>                                0, pdev->name, pmu);
> -       if (ret)
> -               dev_err(dev, "failed to request irq\n");
>
>         jh71xx_pmu_int_enable(pmu, JH71XX_PMU_INT_ALL_MASK & ~JH71XX_PMU_=
INT_PCH_FAIL, true);
>
> --
> 2.34.1
>
