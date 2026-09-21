Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350A310779
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001197; cv=pass; b=jHVBNIyQQN5f5l5nPhO/pXz+boQggpYPrNyKiaHM5FyczPwd2+x3yMIN734kj8FU0TiXH7l+OWDIxX4UIe4dIBasYQkT7TxCnAKL/8fN9laJvGbz03CsQqOjDQTDzUTCSYmfTRenNWOLVwHkP1YqSIHxO46JRl7XzOItK788VaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001197; c=relaxed/simple;
	bh=V3VrbB6jf588eglCgxMX73QpjqOXaCmky/I8c9HrzKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoWP6sBZUXApdnhfoyGsDieXD8+/QTwi997pybiYWCcpE4iKMDdQLuKDW/3kZKQR9TmwFxnRooWs6mhmK81Hh84BnTbBwc6BUGNZ5QxGYkqGKskHybdlJO9y1FZAuCv77a9VUg9C3TDoE9vnp2firUT1tEckTClnXVe7Ta6NlnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+QKy3Uh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iFCiwNg7; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+QKy3Uh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFCiwNg7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEGOt92404083
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JWFmv2D8/n3cqAMWWL5EdMJGzYRCNgACARfCCr83z2U=; b=H+QKy3UhNAihHc5Y
	1pf07KnUI2Kp20ZvSqQ4OhyXB06gEN9hy1AUzLFUli1/snEjvDvCcJKL6PLz44AT
	IjqSdg32U77FHY3S+FGW8l29866cCIdfYINWiJWPq3G2sAC0fnyMUCvb1OjTjxpz
	ebiEIT7vtkUgfyJH0cacmxXDsK39H7QZgOfjfziBN2b1eZRrNucJjTXR+LNzsv42
	p5geUTyOnTTXZkT+P0j2NWSn5SJmkEPcGKm2AXzVkLrO0xPxTUKiRQqoowi3AAmh
	UAocMShAMwK/m+X6M4/rxko1Gu1WCdreYQkJQUxhcME9cIuXIWA79NFxAoq1YXcc
	9q3yrQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3vauxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dd53f2b27cso38675465ad.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790001195; cv=none;
        d=google.com; s=arc-20260327;
        b=lRnJNJRCqjY/0hOV181tDKB8fyrCggritv4Oc9fIxWVSkVHcYhyg2mavODcAVltCJ+
         r98FgOkCmixHpd/1ah2Tbr9CNHVgn59ZidwlpA98EIfJpkgyOBkJX4bnZzlWS5hE50gX
         alcGU2zJkUtrnQWpo18O8opz0Uubl7lY6EWvOAIuFzErbMLKLhs2LzRgV6UDdhZfyZmk
         CnqnxMz9el4q89mrLhfiTzFBHLGan8KjejGZZcpqozRwGijIE7Ja+JMVWFWdGH1sGSRi
         RIWgsdEQZRcF2Zl+svLXkYTX1G0b70GOWTHNI1kvSVn4T2S38S2nKH4Kc2o9q6XX10z/
         wmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JWFmv2D8/n3cqAMWWL5EdMJGzYRCNgACARfCCr83z2U=;
        fh=kSaOKoTsDF7zX5OsfXmdYpdAkEedCZ/KpZl2ZZhBpH8=;
        b=Zw2lW2g5Fwt9RESKMq+MUy8016/zXvVU/uAG7+lmGN+axIyKwKi8R6YZ/F97W2PLJe
         KLj/rG41HxDcSQ1Pp4gOV1zy8mTaUg05ASSpQ2J63nf6oNY1AMzQF3/TELyzlESaVJGl
         qkLUsQ1gglp7hbOlRNUmm/2FVBMvGaNPUem4Psyp0XZcAFf9NleoYCVv2BYJ8txwNwXH
         iSMs7JEmv0gdGxj6/9VeyGILE1XwzD1DL4uX/+ttJ9r0QpzMRy2iBQCZ5y/uZgrKy/vv
         Wv3TUawoM5tLzt5ZouhGVMJPjnC6l5tjKOGBII4nRNCe/xBSfOzwbOqYM3m9c88G2eC2
         QkCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790001195; x=1790605995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JWFmv2D8/n3cqAMWWL5EdMJGzYRCNgACARfCCr83z2U=;
        b=iFCiwNg7VdaKtxGqkEtlXMA0eRwIbWPNe/IxIF/nzbOfNx3MqF8BnjpgDjQBJ0SgSK
         Li3UsHTkxhVuN3zQ2a7T8oi7ij6VRiyZB5RNa/rrrPVSHkpKhXkjwMISAU7uvVPikfxf
         uh3sELSEsPrMhebXH00A5o2LcpdSflnxwiFjcQO068zEXrkmSLnjJsoItAhJ5nM7OFXl
         lejIjKYXGgST2qq6w0F53PUc4sfLu2RxGrzwknowZTkyutGhnnOljDB/cNGliN3J8gQV
         EWnBQKZy1eO7SpIuq8V1NPl7Jkl3QpfD3FuAfCPv8yn+WphOkmnAbS4zqTZahfNfXXLd
         pwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001195; x=1790605995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWFmv2D8/n3cqAMWWL5EdMJGzYRCNgACARfCCr83z2U=;
        b=AJ39sPWnI/kemvd7jX1JEI+LRIMipubK8Pue/EhdZs5Olf1BfFz8ODbzEYrC2xME+Q
         qXFsREuwy6JIhGCAmr8e9tbus1LJW2BtJyzf6I/4RoCuEJBhS0DIJEaeHJjw9ww9Cf3h
         Jda9Lb+02ly39dSDtFnguwlds7Y3QMU/TxL4hj5WRsvpdeckXCdTAaZH6TV01p9BjfJM
         lXRxnyL/+gvAW+AXxadMydow3HfztLzo1Z8ECBEBloVX6gtHOcnSuMqzaOYFd3BT2nEA
         L8ZIUL4pP/bSab4O33Nl4xNvDvonf01ebl/N3IKLcqpZnF51WdzW60vQ4ja6UyizHF2H
         ed3w==
X-Forwarded-Encrypted: i=1; AKwUvBx0jRl22Xt6bEbmmhDTgZXl6Zz8+EEbH2vJtlFO3wiecxVIQPrZLFoVVy1+BCQly4OzoEjegoxXCw==@vger.kernel.org
X-Gm-Message-State: AFuF++koqoEzrT2fW5qnN6oLYn0bzj9pRzRZP6qXKntkLwgHDc+ak663
	i4ctv9K2GI69pZ1OFe8im28VMePZYOrqm6+xwmm7JRshPmFqqPLNa4AomP2i7e/Gz4nsqj/ostw
	yKzG5FffF08KY6tYOMBrDWgwrA8ZsEexjuXwckF0jSQWUTkZ0XO2TVb3JRPGDaHlTzKqTDQpa+X
	1x0nIkSHypzCeupY/lccSgBJWuVqhQuyHQYqke
X-Gm-Gg: AYBFou2TaYd1wi0sgmg7ilNgOPOuHEc9vmcjLeDhcHZjfkK9k/GU1PxMxDaXCyuFXjU
	nPwl+TkOVB7CYHDiOaI77U6ByqvEX9M5SjeLCq/5m8r2aGZCLW5/zIy9mli98UtrHv429YXUje0
	eHsWUYobTEEec5I+287beY+QFriRJvchZ6NzbixCIYOtB2zxO2ebPnlm0h1g==
X-Received: by 2002:a17:902:db0f:b0:2d9:6db:9fcb with SMTP id d9443c01a7336-2ddb1ad911bmr168889525ad.11.1790001194746;
        Mon, 21 Sep 2026 07:33:14 -0700 (PDT)
X-Received: by 2002:a17:902:db0f:b0:2d9:6db:9fcb with SMTP id
 d9443c01a7336-2ddb1ad911bmr168889115ad.11.1790001194225; Mon, 21 Sep 2026
 07:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906033806.84671-1-hppiscas@163.com>
In-Reply-To: <20260906033806.84671-1-hppiscas@163.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:33:02 +0200
X-Gm-Features: AcwNN1URykOcgSM5mzAR_6Hv1HbdZSOKSvNjzwgzfex8XAPfx0E_X-1XkjOVQ2o
Message-ID: <CAPx+jO_-ZD2We5Ap95YZG9rinGj40YXxCbf=fZ-g4MKexbYK8w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: Propagate SCU provider registration failures
To: Pengpeng Hou <hppiscas@163.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Ytia1IYX c=1 sm=1 tr=0 ts=6ab1402b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=Byx-y9mGAAAA:8 a=YTAltBPf13rpVPKIVk8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: -SArfHO6CJ7o4jhnZ1RXkMCvcLFFGzjp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX3v8bpxkRqPwo
 M25NtUO5/+XomrJo0gkvpOjFlcIEiPBWqygGzKNZevKD7LPRoNd9QQCeGaTmBWtOVa8DkH6Fhp4
 Ijs3Lt/5MM7so95T0i3cOdSJPrLG99M=
X-Proofpoint-GUID: -SArfHO6CJ7o4jhnZ1RXkMCvcLFFGzjp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfXwZ8tevhKPxbN
 uWuzsCbAcmo3ZMeKEmv/TZ5Q7bg3mn4sEH6ol6InaUU/EZ8GDchtOCh0sClQBvgC9iEcVciN7RO
 iAGzSg9jdLHfPeMJSGKK4HLYeGktD1ekumXBDDifrtQyqsvJqaf7R8VpM6MhE32H1PsxM/ZdetN
 eSUHNz2cRbaqeXyClf4WEl08OdK0GcyxDNHltu+ll4wcLqzmdxJ9dJc6Wr7QRfRwCT2oRwQHBCY
 TFUWMbAKVRNiybuMtE15k7i54cBu7bna3t2ywIq0wcUKCahcKyyg1J5hCoz11q/67npwzv0A+ne
 RTH3ODHbd09wg6acZjfCit4TJVmzOJ8L+PRDE/UkB9F/CxmPws0DG9z/fBcJj4HWBI1Sb5hKk6c
 R29I9VeLyAUHYfc+WSZVn5GDD9HleZDXJolxVK2epsqvwEnmBohwz/A1+RiYrVcWdTRVQ5uxNhk
 EPODbiGEOQrU88w0DXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210211

On Sun, Sep 6, 2026 at 5:38=E2=80=AFAM Pengpeng Hou <hppiscas@163.com> wrot=
e:
>
> imx_scu_init_pm_domains() ignores of_genpd_add_provider_onecell() and
> returns success even when none of the initialized domains are published t=
o
> DT consumers.
>
> Return the provider error and remove the initialized domains in reverse
> order before devm releases their backing storage on probe failure.
>
> The issue was found by our static-analysis tool and manually reviewed.
>
> Fixes: c800cd7824bd ("firmware: imx: add SCU power domain driver")
> Assisted-by: gpt 5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/scu-pd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.=
c
> index e3f9e741daf7..05d4364f34be 100644
> --- a/drivers/pmdomain/imx/scu-pd.c
> +++ b/drivers/pmdomain/imx/scu-pd.c
> @@ -474,7 +474,7 @@ static int imx_scu_init_pm_domains(struct device *dev=
,
>         struct genpd_onecell_data *pd_data;
>         struct imx_sc_pm_domain *sc_pd;
>         u32 count =3D 0;
> -       int i, j;
> +       int i, j, ret;
>
>         for (i =3D 0; i < pd_soc->num_ranges; i++)
>                 count +=3D pd_ranges[i].num;
> @@ -503,7 +503,13 @@ static int imx_scu_init_pm_domains(struct device *de=
v,
>         pd_data->num_domains =3D count;
>         pd_data->xlate =3D imx_scu_pd_xlate;
>
> -       of_genpd_add_provider_onecell(dev->of_node, pd_data);
> +       ret =3D of_genpd_add_provider_onecell(dev->of_node, pd_data);
> +       if (ret) {
> +               while (count)
> +                       pm_genpd_remove(domains[--count]);
> +
> +               return ret;
> +       }
>
>         return 0;
>  }
> --
> 2.50.1 (Apple Git-155)
>
