Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370B355F5F
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481732; cv=pass; b=uyfd4bwCkG0S7TXyCe4vYr2xTs918eXGQt40BqpS22+eMC8H+cZJhyg0I1pPJp/3BJJb5ELu+6/v9QWHyqaw+6B5Nwj/QyHPBKHhW7Y7X6jxPtbfDvxluON9vMa83wSun9yDquJcF2rFy+nqhD8p4KCuNbsKNhqaZOVxT8g7aE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481732; c=relaxed/simple;
	bh=lzTW61F7FVXYw60jP6Wfpf1RzHEao+jpP6vnuLDj1Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uu7G50NXN7SNFsCLcVFXPjYsSnwkgbgiLXvww4XCxcPjJ2azHgfOcIxARuCsKmNwc6F/lDHztJJd3KD09S5mEnZf4xOz9vylD6k6pTpuJkD8zLaBgV2A2KJ8lJGXeUbHXDKNjtktBly5XpD1lqAVnxMDsz2+IlYbpF7Afz8/zcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MpFPzKKz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hRSsVvGJ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MpFPzKKz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hRSsVvGJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RH0q2076090
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 10:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1wg/7kWgNR7muYHxsUG9a2q2VRHHh9+CGyvHpauJHDg=; b=MpFPzKKzt+MaSdEO
	wRr6hsr77rQQQjcUU4dDxlAAo0B7obT5CxiZ4wO0Xl5V9tlU/5J65c/PJXaicNCI
	nYYDlCmrQ5KTqnZALPv4QvOhpT0qECxQ5JiOTQkfexerrqFeO9EKpUqQTzbxCM99
	r1axIFFcYeIBYLXJxpcNfkn0pvt5rGQzfR2d68Cw/vdNLZ+GGOu2r0lu2TewtY89
	7jegl/ERFNHAF2636p+zAWafNnBoKKKxegxfNH94CXskEylj6eNcOyKLO28WgCq/
	+rQkSJ/8NAF5fP5RdyMDLIDuLbauIkdIRnrF6Fh6fk+yNLWRn4nJjmjltHHrsDfk
	B8vHbw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev19130-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:15:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915767b341eso311605185a.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481730; cv=none;
        d=google.com; s=arc-20240605;
        b=d/KRbjj+UPD4Y2w8sG8p/F6mUtgZnKlcLpt8DENEQkfTzRCxDG3w3VLc7wSjV3+MNN
         2zS1my7dZhR00QilIMrjwS+RFOh5qbGMTICo50eQFxgiczWmzhBhiWPcZXkkbOcvJNCI
         FjPp6tbAczTmr04KdPgX7e3g9wICVaCNNpwm17AKFdrfAAlJBoc6RE9+VoV6h4Rcv/cG
         hm+2wgCKsettrf3lahG2MFvS7cPtpPs4auYLSnKNrnLXaGnuWQuNcbJxiMgZDdcGi6s1
         pwrxdcLq/fC2LeRu5yJLRDUnp/rxUbjbB9fzMW/cf8+zUT7rQZg2wqyASD2Nb1d+qoWa
         0r7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1wg/7kWgNR7muYHxsUG9a2q2VRHHh9+CGyvHpauJHDg=;
        fh=7LLPfXFIEbslcc7iI/ZnRf5KdgERcIyF3jQ5iUq6T+s=;
        b=EA8RKvnwSB7or4DL6/36hjLa7ROKwAq0QC8l8jaQ+at6WioJji9DJcdPwKJUvq67Bi
         Tt6qoMX7SYfB6WtnO3hU5vkS+M293xzAg9XSpkAiUkWqeCoZNUzQaFDIXk5bOFBreteE
         gluiG9SpXiw1KZlwYENa/yFO5e2ilKtnwi5B11Xs0oRoFP6zTHv+FwEAD+TOX7inpDVo
         KTNc3TSe/tN6oBUYm9NyBT2kuHxharq+ozYq7m4MD6NS+XW/VPT1adIgHLPEe2ZXUA6K
         XvfWMMXGEmxDm/u31tTP344nOLc6hvRreBnVTWBHUBDpJHkZJwTdrd9lHS+yEfx3ejdb
         yiow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481730; x=1781086530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wg/7kWgNR7muYHxsUG9a2q2VRHHh9+CGyvHpauJHDg=;
        b=hRSsVvGJVahcSC0Hqx9em2H8j403YbU/ufp3mbe2NX5nGyf+tFJ7G5jHDF+bnBMki1
         IsfSdsY7ax1Ui/6hQhJ4msJjj/PKDkikUrle/CC/Vlj3EmZaQVSdE5+OffQxjtcqQ3is
         ZLQZ/dU6AfxrSZLfdNM31/C+aLah8P2PO6Kwh2WN7OxaZSBLZsGvnQ31BqfG8Bfi6YY9
         cYl4eomNf6Ac9U+A9PszfzdWYfQCrgTaHNefK8bpMjBYDHUW9XmN6pf2rUDKyXpzvT3e
         /zHFUKE2Q4ZpHoSnBaGjj+ljoNWDlDioVTMspiG25L4OwiiAf/WUZTcSSI9mmWwSK4gg
         ItaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481730; x=1781086530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1wg/7kWgNR7muYHxsUG9a2q2VRHHh9+CGyvHpauJHDg=;
        b=KqxAxWLENuB2pU5dnT6PwOoD5Ezclz4rfQ2p0Xci0ciNCkEBxg/SBGGY7Tbb8OBaxr
         cTyJ2aYsluBdZAy0c/BY9/U9lzO7alQidX1dAvdWA9c/UNgnouPPDTs0Xb6D1Gwv6fSq
         /vaCnWtzVAoAZB5GSYmPrKbZW1DHKcfhSXMMFJziHWhYrnncMnzOJgakvJg9sl3j9S0W
         IXImje/F3J/XVaeubT6pHygdMqDRhRKUe9pezSsx1pKoBEgCLq6KzRhDlPXUfhkRnJQq
         GxiR0q5qYVAq24O5beSWOnuDqFE3X5n+yQrMFf10WOsUrYnAk4jVx3IZjYIu2+DUOp12
         sHZg==
X-Forwarded-Encrypted: i=1; AFNElJ/3x7Upz4I9uweNc7YlRZAQbMyMcC+5W0g0hskvTaDWL8ulo8zXXGkpLlLH6n4ECL4qaH3ilJSOCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtiSsohZTDO+5Js1ZO9PKoiGdcbOpXj8FJ1EcZ80WS4wdu6h+D
	39CZ31nG5pQNoua2BCb4AkrPUwImQIbPKP9MkCsrI13Q7yZx7WzImRIJ+m9zgtING4LDQfBlfnB
	AiNMvTAog4DOBHXKs0aWpfxBgQ1I2ioGHgIA6rTgvP8KGvuIwkVjQe5AUkTRHHY7G9F310j30kI
	kWtXFFGuL2FzE2mA3gkJub26U1i2WckzEZrIfl
X-Gm-Gg: Acq92OFQj7HWXd/Ylw5gjtTlcZRvO3sl3NztJQCGRRfFQJxUEl6EHBRLzkidgb1k7B2
	oUiKeUG5bj16SPed3a4AX/vM4zAFlRsHhuEqGB/9s3xLj24pm+vIn5cK8N2L83P0yjyARS7ee+4
	TslLrSizhEvpGFlp1R9I9B/lZmkJtwkms+MKyv1MFEZtWNydVnIBYidEdrZQv6k1ukbJBVuEPpZ
	LHAAL6ixVNN+I3B
X-Received: by 2002:a05:620a:a0da:10b0:915:8f08:5fa7 with SMTP id af79cd13be357-9158f086487mr166584285a.52.1780481729763;
        Wed, 03 Jun 2026 03:15:29 -0700 (PDT)
X-Received: by 2002:a05:620a:a0da:10b0:915:8f08:5fa7 with SMTP id
 af79cd13be357-9158f086487mr166581085a.52.1780481729302; Wed, 03 Jun 2026
 03:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
In-Reply-To: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:17 +0200
X-Gm-Features: AVHnY4KtGB2TT-BqNW-Fcf-Dph8doazFYHWPd16dxkZfhVyve8a1Cpv5v5zMIwA
Message-ID: <CAPx+jO_LeGn-bKpfHwp1gkeb8czb7nEQgdcoUeHc1Dj6BgvFOQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: ti_sci: add wakeup constraint to parent devices
 of wakeup source
To: Kendall Willis <k-willis@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        tomi.valkeinen@ideasonboard.com, sebin.francis@ti.com, devarsht@ti.com,
        vigneshr@ti.com, vishalm@ti.com, vitor.soares@toradex.com,
        ivitro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: iMx63GRjMGRh1BXgz0bnyDwSUE_UY9bd
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a1ffec2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8
 a=m8ToADvmAAAA:8 a=VlitpaJNd95OzUvVioQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-GUID: iMx63GRjMGRh1BXgz0bnyDwSUE_UY9bd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfXzQaxLgsxa1+A
 ToQ0pHzEC3XvMqADyuzTuXTgNMxBBpR+pUa7OEiHSKu5vselVcfBs4EiMGWcaa/l/nQKxE9gZQ8
 Q35AFAXs+2UEp7wTW7uCw5ZB9lG+VDkXa75bC8ze/w7XvCzgytUxPB//pUyeFO3X37XX9MXwMh3
 IGjlmxY4Rgun3wq9GTJfPEljyqt2SW+KHzpq69SSUtePeJCP67I2AaYdZtC92kQbbrgtG24r9pu
 bd1BADaYWUr+QdAbZFQktMPC5qmyBTlrzvvy4SrLP68/FsUedj5o/UOCv1jde7RU6SUbMI3y+ZT
 79KBEHiv6e4wsz8n2dvvl+sehHk0D4Bs8fH5kcEf/YRTX9T4fNaesD4U0SNg6ipXmVGE0oAuNZc
 t5BVtZ+XosxtaBMLNQNCezd3WndwqJxh1Hn9eA1VuwVCWvgLxwsLrT0E0XvO/cIw0+yr7KJ/lDG
 mfVM6IE4ldTbzaToiRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030097

On Thu, May 7, 2026 at 5:16=E2=80=AFAM Kendall Willis <k-willis@ti.com> wro=
te:
>
> Set wakeup constraint for any device in a wakeup path. All parent devices
> of a wakeup device should not be turned off during suspend. This ensures
> the wakeup device is kept on while the system is suspended.
>
> Cc: stable@vger.kernel.org
> Fixes: 9d8aa0dd3be4 ("pmdomain: ti_sci: add wakeup constraint management"=
)
> Reported-by: Vitor Soares <vitor.soares@toradex.com>
> Closes: https://lore.kernel.org/linux-pm/c0fe43a2339c802e9ce5900092cd530a=
2ba17a6b.camel@gmail.com/
> Signed-off-by: Kendall Willis <k-willis@ti.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/t=
i/ti_sci_pm_domains.c
> index 18d33bc35dee1b3bf6107af1e414db377d515199..949e4115f930b93b18216fde4=
6131b5c8931c9aa 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -86,7 +86,7 @@ static inline void ti_sci_pd_set_wkup_constraint(struct=
 device *dev)
>         const struct ti_sci_handle *ti_sci =3D pd->parent->ti_sci;
>         int ret;
>
> -       if (device_may_wakeup(dev)) {
> +       if (device_may_wakeup(dev) || device_wakeup_path(dev)) {
>                 /*
>                  * If device can wakeup using IO daisy chain wakeups,
>                  * we do not want to set a constraint.
>
> ---
> base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
> change-id: 20260506-wkup-constraint-9b0261b04df1
>
> Best regards,
> --
> Kendall Willis <k-willis@ti.com>
