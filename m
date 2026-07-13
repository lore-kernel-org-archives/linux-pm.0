Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E6366052
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940771; cv=pass; b=U2uaotUtbQR8n5XWOHbZTZoKQp/oe+UK31e7WDO+UvhuKKueaLKNRn1HDa1zUimEx9Ixr13TlX7lbFIaDSv1cOB/g3PX9r4nGuFNxhiX26xBIBf8Z+iEHt/eZllc7czK+q1iqw6H1ZpeykK4lMBoCi3IaW3IuPGT3uo46ZQ3Rq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940771; c=relaxed/simple;
	bh=wU4adGyulZDWHqdEHT6S2Ub0gI9p8fXNMrbZKLgyLEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mq9ARex1Z5b4WYT/rInGb+bfbxk9dp0Bh+lSMG9dPGml8eeD5z2JkEMwzcjehIMQLnI9wemsrrqlIL7oCUqSUk3CSsd+fyJZnvDJb+axoOp1thgzTPeknowys6g9DAGvttdh+d6fFQLA89pAKRsAqKyoPOh+64my5bnp9/YMS4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxuR6f/b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LmE7iWGl; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxuR6f/b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LmE7iWGl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9RF2C1123067
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kvqsLA6Mvt2zukd4+gfC9bRp1ifbJzmUNc+eEGzl1K8=; b=DxuR6f/bxOGO5KQB
	RZ/enNONz0Rdsd4+l1m31TX0ZtALLxRB2aZZ4Bvwlq9otL0CjXf/HxHi+EeJ+DGS
	woR5CIoZx3YpXBtO0ZjEUFav2Ih1xlYDg5ps6CJ672D/7yb8iIDc9Nw6olArMEHV
	HFsPQIxyZAzd4upN/mTsvRorElOr6ov8OmRtOK1E3b2upECnWP02bHAN9sBFQ5pP
	XntXO7Wkgc5T7ENe+2f3GxoX5n/BA5J1SWLQLV6d37F/sG4cRmdHS+slqQgLEAeP
	KuSI2ENJKzSPaK7VL23lN3pbrN/RdCerPnUzXEudqwmP7e7QG1DsJwAxPHbIwF8N
	zKPiKQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda0bbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 11:06:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e632390d2so598676085a.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 04:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783940768; cv=none;
        d=google.com; s=arc-20260327;
        b=dEhIc/nIAqxLCF4ds9AudyHwyYITmjxJgyAsoCr200lkKyvA/twdOjqCNrBJdJptQO
         rlXYPPWNiWdylWR6FIUGPZL6mxWL80ZaTdmmFjRflGN8ir1xGmnUcsat4B4iKNICfNKb
         LZHugacfj42zb10ejml5SwL6M2EgzcCC5f10dCSVFDcfApU2gavemHaBY9TwKS7KZGHK
         OZc3CbAyi8tPXhcaUBFBG3cKaaH15dWIwTX3H84o9M1sDDs+UMOAXB/QW7Vo11TRi3pb
         t4QjN2j3OXFZo47hp+BC4ByQEPttQYOZRQ78vwzMliPI0oXPtBNqnEWUhSyRvtpiN+Rj
         waQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kvqsLA6Mvt2zukd4+gfC9bRp1ifbJzmUNc+eEGzl1K8=;
        fh=77hHMzu8mjdtB2aCPDX4OTqfd0bP3sjHk3t4ZyuYcrk=;
        b=HGhwl94mLDtjWShYmLTQMiWMSeKGxGxJCdK7+vIgPSROcktQh3UkxvqMlt4C7jczIo
         V2h/nbuJxADIfrsSQXiNcB8q9Wz2K4F0KeKhnCXHe670MT0Bc4hMR8rV2w3xHdBxDuow
         N6IE3mv6BqNpB+gM7ZHe4LsDfwqcrx/OgrYPUyl0d2vB8x2EG3DyDJd7CCi21V6h3WOO
         ceyf7vH1YP+glsiunJBJQQ8VxeDb+eyU0hRXtmNeDQn7mKJovQfGjsehfgw2xwW84e7L
         aGv8ecW+WR9HnWa0xXh+ROXEEa8M9a8d0wC8oIQkb3HTdJc5L5tHCa0KagITVuSY1FyO
         ygaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783940768; x=1784545568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kvqsLA6Mvt2zukd4+gfC9bRp1ifbJzmUNc+eEGzl1K8=;
        b=LmE7iWGlMxYq1/UTi1S9nF1y9EB/rVelkyDlBjWbjlJlhH1hFlCxFD2K44xZDKdcFL
         OTd7vhvKxJrzStHYB07h4zrUwy5VVZmaudJZmjVBqJ7AJhs5Ia06oqJMECU3Sy4fbB+F
         ewIy5i7xjOnpVB8VUgfRgGGlSpTIXLxJyx4wFrQZKvzrPf8jObxUpIfnRwN+Ahqwq6u0
         Z+m97txg0L5ORpLoqNJgC64mGgNaYNDbMHcTDa4v9HaatSq30DGhxynWnKRPL5RCnXDR
         aa007lJe3Mk2Rs9eVtO1INIF1IjPURb30imVK/XzYscj8IY/jwYGwrlK4K46RG2hPrcK
         IgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940768; x=1784545568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kvqsLA6Mvt2zukd4+gfC9bRp1ifbJzmUNc+eEGzl1K8=;
        b=Tzh50K1VTabd1AiIu8xOSNw2BiTIHtoLWBhTFd5fpYM9X5g3PHElcyjgwqrhdiPnbG
         2/KYL+GlngkafeK/cHbqct9+ziTFPS2ywOvb197awifCI9el0NfnpqJmkQ0+7G7RPK7c
         smKWvME3fv1H3+y/pQRlHEOdzabgfmcGMdRSRukvbu7Dv3iR/NQGQUkRT8CRSiA/Bf4X
         29pbaWZDiIzwyeATcUkQPd3iJ2cZU62HqC9em/PTuAzkRrG9A+SYOqbvAIiXoc/xphei
         d5sfBa6fJ6qXkM3zglSjfvGTbnMTmg3yxVEOdn2GDi2EtXGeYJKyKGj0q4LfuJADiE0A
         V+4g==
X-Forwarded-Encrypted: i=1; AHgh+RotEFNWRE0iqKVXYbhNESaGQJKpOr7mKL5OqGmm5kU9czYDCl1ECqZMLQzXgPYeICqpo4cKs72Z7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf56iEEz/lFYyerx34UcylULIHeNv5R5Wg9g2tNd7B7sn0Cynx
	nu2qNYwid+nI0/RnJf/6foPAcQWYTMNxwcbH78Zlo6tXGGR0JAb/RqHvOQAWUHb8JTAwKU6iCby
	6r1dPXmdvSXCJuxoo/E952mfJQKnLXYiWRg/sVNnG6w1FwPPmmNuZqVbTUmvh+BLfuqyljoBA/+
	yBrvK43h94+PH4vuzCLD8AosBhCMqkhy37TH7W
X-Gm-Gg: AfdE7cnFJuEBZMR/5fTHs+eHXesBqBrEOcRXmKPbd0MTtixFepg6DOtaNO2jicY7wA9
	WQ5ANiZncY0+Ez7YqlKUQjuZ5gdho0cNbRBdbcA9PapBgu5TCV6eURR3kHkQwhKeGoTO+cGaKAJ
	mzyuDQHVfbfrAR7vLWJMblADMM1hcRQR7fv6+MynOrcNluRzrSd426l8BpjSBuceWvskO/
X-Received: by 2002:a05:622a:4cc5:b0:51c:7b12:1210 with SMTP id d75a77b69052e-51cbf34c183mr86772231cf.78.1783940768054;
        Mon, 13 Jul 2026 04:06:08 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc5:b0:51c:7b12:1210 with SMTP id
 d75a77b69052e-51cbf34c183mr86771971cf.78.1783940767679; Mon, 13 Jul 2026
 04:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9a082c25e4bda4d73b261eee951efecab20612d.1780499882.git.geert+renesas@glider.be>
In-Reply-To: <a9a082c25e4bda4d73b261eee951efecab20612d.1780499882.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:05:56 +0200
X-Gm-Features: AUfX_myYmQelNutM8s1zx4fXjQ-IQeu5ofDTxXjw8xb17nMcZM8N1mjOg1nEQTY
Message-ID: <CAPx+jO874b1EbcPF609NzZMCXaXQidA==eV1sgZzMde7VbvXKw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Grammar s/may needed/may be needed/
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfX6CbtQz3biCg/
 QrVhIlcBDl7i9ujgtt0XsWdSVBm0klXBpw136mNgKd88xC6SwTMh84ENzz0AHzkZv/6rk5DsK6k
 wxUvx9sKIq9Ly/bQv6RnhUEzo2XSW9I=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a54c6a0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=hUYxl28pOwIGcUTX8NUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: rIdRXWM4wBMrcQvUbErhQMMSjFhqNx7k
X-Proofpoint-ORIG-GUID: rIdRXWM4wBMrcQvUbErhQMMSjFhqNx7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNSBTYWx0ZWRfX51xzhq4MsSbF
 Ovoxl2//lDdgzGWSO18DRkTyJ3XNR3ZnG1/soGrC4hHhnha3ZYZIBchz4pRNnuCBYRIBYEt0XOE
 kynCBCfHENAj/T8V9yB1Q97jkMHhSsRmdqyLLIZozKAZ88nYVRPEr/QWG9f9FEPgW72oboP8MWa
 pwnod8bCunUEyEKV2wMAPtJK/ksekXfEVCSh6rPd4w+ujeQHmKbxVaHfRem3Tu+j/+rdQDhCnVs
 CzjSF1+ZR0C3L+Z0qPkzAPDY8K+WUhsQiNjGXKcwSf6TmXLRVqysHtryNpS/4SRucUzEKeJZrBW
 4zNpDKhSakzKrbnzdZAAhDkbsANNRccpXnYv9AiaM5mRmK+5MisW5RxIhD3f8AbMwSXy60gFZPY
 ImcQHYJec5EiWexFZnPQtuFtmR41YCK18CtAFuRRRZxgb1iFoY6S8ZjHT0fR0w02XqKN7RSP+AV
 DwP33oi0mOAU4Jw+YWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130115

On Wed, Jun 3, 2026 at 5:23=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Fix grammar in the help text for the ARM_SCMI_POWER_DOMAIN symbol.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/arm/Kconfig b/drivers/pmdomain/arm/Kconfig
> index afed10d382ad7f66..ba0b190a63d6bb18 100644
> --- a/drivers/pmdomain/arm/Kconfig
> +++ b/drivers/pmdomain/arm/Kconfig
> @@ -21,7 +21,7 @@ config ARM_SCMI_POWER_DOMAIN
>           enabled or disabled via the SCP firmware
>
>           This driver can also be built as a module. If so, the module
> -         will be called scmi_pm_domain. Note this may needed early in bo=
ot
> +         will be called scmi_pm_domain. Note this may be needed early in=
 boot
>           before rootfs may be available.
>
>  config ARM_SCPI_POWER_DOMAIN
> --
> 2.43.0
>
