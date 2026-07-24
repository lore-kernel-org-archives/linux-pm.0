Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C533B970
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906754; cv=pass; b=F0Cu9wHDH+OooA/mwIHwN1ygcFJy9KwDTgm7PUfgzRYJFGpCIFqGY8aZ6Vj3jKepZAU+E228lgIi9x2uIlpC+vTX1naBaKWCtK8NEaaBb/M7NnQGtQPOpZn3BfoA1ZeR+Y/2a4PgZSksHagFhO1GpY2NJa0LCS1aKCh0eX9SbEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906754; c=relaxed/simple;
	bh=XUNtH1yfCDhLbrMKASUM5kdLjT6PAMVipTy93bQ0VJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra/UQsBoQthUJgDLZhCnZp84j4ku/2xw9awO6RGAECMJT1NfX+zBj+aV/jxG855UAB13DPYAuilNcxJK5Ra/fZNTYMeKH3wW6R/R+a1JGYDOf3hCPUDLFtmYB6jQvDXdr2MPudumtvQL+UqRgHPC4AXZbrZn/N63zBgC7OetkNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdX8vmXY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JMrHFyyJ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdX8vmXY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JMrHFyyJ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODb5Go2933428
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EVzRgfkUD4JBUm527N3SDHxIqvJx5/qjTVgYiEvrz8U=; b=JdX8vmXYgiLsdgga
	VDfAI2QzOnFN+oMi5LDZiaEWcU64KTI23UWiipG9UKkg3tn/jRYNR/0+WDP3iI/n
	Co5tBTs4hVfTThCD265yDnsw3QqF36F0RwcWIZ0JxQ69bB9PMzJs28ZK6r/WTqca
	yGAkhT1Up8NrfnuXUIpc2lXDOs9A5CiV4k71J13CRnqODu22IWamPZKeNBIHBpw+
	bfcGLnSIXfdoUQ39b8Sze5wC94G6Izs6DdECHpH8EiCIUHVa1nCryk/1u4Rp+2Ld
	HwSTv4AkbsAIRGm5a0YUJx3vuqpNiDz/6kXMiLs5S4NWyFIPtqiHnqnRxYpyzkpG
	igMAQQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cj8js9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930f5da3467so85926085a.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784906752; cv=none;
        d=google.com; s=arc-20260327;
        b=n0Hv8bz3Cy9jviZxecZC/xtEK+8GaLwSDx6BXuySQsxH3pySQmtBIC+0NrWJSosT+t
         cvXtaSG4h3xJcBDpquhgvAHABa0THc+b+SUHGeCqVg9B64jV4HkPLHzwv4lw7VHsgMiW
         WbarEy44NlhZqeU2q7f1Q+xExzdFosu0w5a0AVgBg5SMr+yTSkPT0p8kJ2LMaARobcOU
         FhDYuBU/jkq2EGdQZCN8pm1zG5I4gRUkcuE+8/P3uAm4DWykqbIRzisYyJ5qe9gVTHXe
         9M4OvmPVvouIDVc/Y2ZM2UeYMaRt7DE/IUZygodZl+16FFoA5iONBmc4KgtgYe8Y1vZN
         Z4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EVzRgfkUD4JBUm527N3SDHxIqvJx5/qjTVgYiEvrz8U=;
        fh=1VGESAbT4jzItdBlziDepY8AW7Zwlqrkrq4HUi+Y7cw=;
        b=Ooju4j/nxtD4yz4aRjauFGJlSP7qO1gifOstMrOq8IvPJyVKmFnREWAET6MwP4XyMB
         tknVAZa3hENRXufwPrMPW2CLn/s5uRlphsYPPZUrlDtcJau4BmFEIuT0Dpu+9EsRP5kD
         p7O82J2NPhrg6bpxlk2yjkAR97iZwYxC5xW1io0t+gGLvJFSOJ5lBAnvl1EfU3CHsNkR
         u4+RFSXi5TsCmQ6KcuRs15IQC3DMbXgCip6ZAT63HgwDjtGlUriOiW2cUv5UUgGPKI6B
         RU3ve5E2WXun2w125gUC2ijb2iTNfISX8TpDRcEJ/DboZ5xgDxz8AfDyE2G6N7RN6X1/
         2lDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784906752; x=1785511552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EVzRgfkUD4JBUm527N3SDHxIqvJx5/qjTVgYiEvrz8U=;
        b=JMrHFyyJuBRe6l00cY3dKbP4OmC7j6NOLt+DYcVDKVrwMn2yPqadvpWQUjfaol8d9P
         Fd+CUboFtO4u5J4OlUkC2KMDon+0jPC20SVZCaqzfOfS3pfmlZhV184MhbMMZbSfFj61
         r2o+bP6SCIVsWsQipop2yK5jINFPpaRy9mqsEOlz6DmZI5prg1oRQwFzx4+bjsM8l6zR
         DkHfWSbDsonbi3En+Ps0ggnFZ5eVHz+7vNFwROJ+/BXTIfv51NhikXYF0Ayzq71kJSli
         BdQuPAFF6sBx7P9Tga5wcYfLImNg0cQ7l4jLvrQl4EiTkG8zV6Ci8EEqWHTdYniJprYa
         KPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906752; x=1785511552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVzRgfkUD4JBUm527N3SDHxIqvJx5/qjTVgYiEvrz8U=;
        b=pyhaEBtFiN4RPqSVjYBqDjpzMI/EwAvBrgaUYNAagLLba5xa0A5WbMaopC3khUihD+
         kjJZbHF6HpLUrj0KERXRxBGOXEmA9m4SMYg0Zqt6VZFxUpdNcIggr+NGfPY/Npgx6LSn
         mEDp/0ricmH4c0LSkhyEVYEklFr2Z1m9WIpusJ0xo1BRZxv93eF1h5L3CkYDU2wWps+W
         33peIqbgs4MYUXEEgKSJidmS1s30u6uy5oxkA8JiatmDDQhVCW4lriGxL72MTlhZ63jx
         RV6AZNY/i6QKlnbqiyAFs/imH5n6ejTutzlP6oCksOCUGMboHlJOuKYofpPXH9T3BpPX
         Rsyg==
X-Forwarded-Encrypted: i=1; AHgh+RqBvjvrPyVlKGgcXe3KUGBzLi4lr6fvlya4NZuG7Uz3NiCyEM2Wj2FWcSECUv/2i0MdP/KrdVszzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjdsXlAv56bKPqwnwVAU+5dpIsJqw5CzG5KhR0e8U3DBdbAZIQ
	MsqDSI54pvX7QavC0lysKUfqjnMGGp14a3JwyySutnAJASS6SzYz/dNjCLlkDBoMDpZ6AE9e4yb
	ebakVBQ0imy4Mpv4U1ZipN1Ic23hl6aRsKc6cm9NBxaRMeCXtwOPQwWXx57wusRh+TaDO7LfYmO
	QxA9eAr/Kzf9KkdP/NdAUOBM582evHZBsCYFpr
X-Gm-Gg: AR+sD11ON1LMaTc7PZZDNyUV1ylNS6dw+b+p9mRKx8or0q2VR9Updfq2eytW1qUnvfH
	5seZNVUVz5ljnHAFmfcnumUnIjEWyM+VbGpfizhvHWOmKdD011NEIxxi7H1b8qPUGvZnJuiiakz
	E3zD/FfQRjGO3mHosEySUZ9guFFBUaHDkPoJR/4QRMF8uJMX42lD+w8qTVxQ==
X-Received: by 2002:a05:620a:4414:b0:930:9c64:330 with SMTP id af79cd13be357-93103a4e832mr831462385a.87.1784906751796;
        Fri, 24 Jul 2026 08:25:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4414:b0:930:9c64:330 with SMTP id
 af79cd13be357-93103a4e832mr831458185a.87.1784906751389; Fri, 24 Jul 2026
 08:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716114247.49685-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260716114247.49685-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:25:40 +0200
X-Gm-Features: AUfX_mxVC_giYxUaohart3sP181-Oh1lGOCSPJ7_kEvq1OppxaW1JXZvQ16t_ZA
Message-ID: <CAPx+jO9t=te39Lg7BijMvSV5xzGKp5hNVETRhd7-N5p32jFL2w@mail.gmail.com>
Subject: Re: [PATCH] pmdomains: mediatek: Avoid setting RTFF's CLK_DIS before NRESTORE
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: ulfh@kernel.org, matthias.bgg@gmail.com, nfraprado@collabora.com,
        macpaul.lin@mediatek.com, irving-ch.lin@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GJE41ONK c=1 sm=1 tr=0 ts=6a638400 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=QX4gbG5DAAAA:8 a=fzz4A-KDz1Fdncvdh-EA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzOCBTYWx0ZWRfX7PmfPJl/UbUw
 vKeSHrjYTgIk6D/F/4oxMv79R/PXK17x7ZxwcbO2i6azIGUaxpH3S2rnwOiBm/YMFnCWNpPIOHf
 dm2BZSPGk8KoRCA5gXp5PLZ6YmboXCcjffj8TBXxrkccGmlz9f1cbHeYb771ZQZT3GWcNy0jPrs
 lxOpUJlq5IpwH5HaC/K1Z7oHQ3ea+tvtgzlDNAPZWDjgghbjfGjND8jGh2qQPf0H31HoKkRGdHm
 ZMEGLzwkgDr9RJ4lUZ6zzYPcc7aFc1ysuGZkBH1JQGjFcnSSaDZUkOnAJd990ec4miLWivn+whF
 3GQLoaK/ngto/la6GnlnALfIM3I6OFqXjv+RHcATr8FXXhB8fqtXlv6Ej3aNqD1X9YtFZ1Pj7N4
 RacgLdsSu32OZDmfsXzwDQhjtOSqoufBUKteVaVzG3HH1cD9YXuPfOGoKp3+bGKkzNsQMRw279K
 BuWY39GEJSeH6TBJBEg==
X-Proofpoint-ORIG-GUID: BdPoNKQSRuyUjWkpJnbgxLFCjyjLv45T
X-Proofpoint-GUID: BdPoNKQSRuyUjWkpJnbgxLFCjyjLv45T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzOCBTYWx0ZWRfXx/lII9vSgN36
 zg6Mc/YsJjPvSq9M5QeJ4Y4hIU6Dnfyw9IETHNJt2WmRBXhDY5ifl8VGDDQeIDmzRHNb6PIV0ky
 f7zAtturS38n2xLRgzt2t+4TejNLAXQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240138

On Thu, Jul 16, 2026 at 1:42=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> For the PCIE_PHY (also called PEXTP_PHY) type of RTFF hardware,
> there is special handling setting CLK_DIS before performing the
> NRESTORE sequence for resetting the RTFF and start sequencing
> from a clean state.
>
> That special handling, though, poses an issue in case the machine
> specific bootchain (bootloader in particular) ends up booting the
> kernel with both PCIe MAC and PHY enabled (not just power domains)
> as doing so will partially corrupt the PCIe MAC/PHY registers in
> an unpredictable manner, producing either an initialization fail
> in the PCI-Express drivers, or even a hard lockup!
>
> Resolve this by simply removing the special handling: in this case
> the bootchain, or remote processors, setting is getting honored by
> the later check for PWR_RTFF_SAVE_FLAG presence in the RTFF ctl
> register.
>
> Fixes: 9d02c94342b3 ("pmdomain: mediatek: Add support for RTFF Hardware i=
n MT8196/MT6991")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomai=
n/mediatek/mtk-pm-domains.c
> index f69cf69ba0f6..df8e93638e08 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -480,16 +480,8 @@ static int scpsys_ctl_pwrseq_on(struct scpsys_domain=
 *pd)
>         if (ret < 0)
>                 return ret;
>
> -       if (pd->data->rtff_type =3D=3D SCPSYS_RTFF_TYPE_PCIE_PHY)
> -               regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTF=
F_CLK_DIS);
> -
>         regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_B=
IT);
>         regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
> -
> -       /* Wait for RTFF HW to sync buck isolation state if this is PCIe =
PHY RTFF */
> -       if (pd->data->rtff_type =3D=3D SCPSYS_RTFF_TYPE_PCIE_PHY)
> -               udelay(5);
> -
>         regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>
>         /*
> --
> 2.54.0
>
