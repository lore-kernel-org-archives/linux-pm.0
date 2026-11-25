Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620272;
	b=Vf5jTKPUttfg5LRasoOJFGUA0EXhistAxrwMuHY50hTEzPRk+cTGLt5v1Dx1EcdtFT5n
	 DcqffrIqJTWCHDXNy4/l9wEhdL0G6nwbAImfG41t9K6ALRWA/PK65OURbPpOsQWhaAW3F
	 NibHsUETioMosKbwIPl/VUa9XlTfGYEm8ERwRKl1GLNaYh0SaxWSTD4pgw6XfaPo/d3mf
	 9UjU4M86eXkh+YtsXIuDHCS5KDjf67sVbcULZFr9eH3ckFRMKf/Ml+I7WcMMHVbWfwdb6
	 g4b8K2BibgAL8H+DYHiJgdUzL0MElAYQlx45U4C6u884+o2nlDD8Mp1YbKVkyxvSxXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620272;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4PCqqxbAPdHLMDmL/jc+BeC5eGbqxuOHjdxp6tKk8VQ=;
	b=JfB/H9efzpxjndmFmSahKYsHZyz8j84OV8u8TOQUldlllvnnDTe0954SOCg5MeS2Wq0s
	 /GGSzLlk6FNhUOKZg3D8sUs0+E9oJZOMU4DoVNYxNkSqVZQ+muklzZiXlNREeUIvFCfeI
	 O9jDgbDr64cXNxlPjgKy76zGa4MNj7LgQX14+DCdqWZxSv3WaQhvv5sKW+7Rs1V6kDxks
	 rKgYJQ5Vo5hesKWAHIiHb2MW5ARFaHXlxj5HaODKvrQ7iFah3rdlgk7vuMqauSqZQBVR4
	 iESjlQYL5mx/UX4X0pvvbzXeJyQRNQr9YvU7ZX7jHg/LsURPsFBSbroeFyK+Rb0AUeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XOigGna7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VOB2S497;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463B606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8463B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XOigGna7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VOB2S497
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEM3fm016345
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4PCqqxbAPdHLMDmL/jc+BeC5eGbqxuOHjdxp6tKk8VQ=; b=XOigGna7XHOQIbMm
	GNzcHCAVLmMSg3BMLWbKcIUDcT4fSVApjAmbklR+6DTRGWWZT4QeGyR/gSwXXGNz
	FtcIyrW53cY55DrAMJDwJ5vq+delAmX6I/3VTWHa9nXj9HpG1rxVYRKxYOHOnh2d
	6R0rQN8nvkR22MxYoqwvFMhPEyne814gQ9NFPl2raSuMMZi7a3yfwORcxgkme5cY
	j2tEr8Mo8VkHJjBSDS/DTbPrBulmOBFf+egCVCLnhY0CZhkE7zUGwysTuh/Kx4ma
	sVhObKkDO1nIE/t1DhpV/cI0SUTmWOBbJlbo9yLeudytEokGWbTjPHAzF1c45Bpy
	mEAkig==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahr8t6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f05c68629cso38730185ad.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:24:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620271; cv=none;
        d=google.com; s=arc-20260327;
        b=PpUMIyMzFzcdQxurMC/vn+Uirx3b5yAE3sK331RFR8NEUrQ8CQAJydkio6E2AQBA2D
         qKA9G4RIFC2rh5sRo9G2U1Km58RgotwnE4XjOAk3K8HDccXqIdsz38O6XfzYSV0K/3PS
         aE0BkYK1ZKQ/XD+P7j26sOCREFOuMu67a+9NFU+TnB0IjAo7RT80iaXw57GwHa/KGqPx
         8yUTRQDvd0hW6v5IgluYL2yRwirFkdzsjSe0Ww03AM5kNHP7XdZWguHPm2B9CdQtK1FD
         lKL+UwM4IThWSj43vTenfbqm25JS+lBvBWvdHe20lrQnSPFMzJgIulB3FYoQGrksGZT/
         xiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4PCqqxbAPdHLMDmL/jc+BeC5eGbqxuOHjdxp6tKk8VQ=;
        fh=mVwYIpfnjncwaJfIwTthfNmHAc6pZKT9xI8OsxShEoc=;
        b=fuU/XPoMkCRzDY+oX7zBI/tQ4hGCd4Y/XmNlEvO+Pb7G6XkssNslBgneiSk+Yxpci3
         csU9EuRPZBU6ucudlduVAxWCcW0S/YfUg97VHQUf9ONm4ivliLn8an6vZxwFo/QIDGCr
         c8VV2TsVtwCNIfZzsUM34LICUOQ+nnRRBBOdZpWPwNQF+z4GJueriHwYDJK9vvIHFMZt
         oQjBxpNGlObgMW5Sf2ZDLDAiKDsGa1e0XKEMxyJjHw4PF1fk2kT3FUBV9qjCkPD4xt4C
         DnBBXRmrnEmaxuxsd1Msb940tmKNE4O6GTBckRnzpNy9qZBnGIfdxAHz2keAE4sUs8c4
         pr1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795620271; x=1796225071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4PCqqxbAPdHLMDmL/jc+BeC5eGbqxuOHjdxp6tKk8VQ=;
        b=VOB2S497wqCcvZUYyT9461tnP47i/P4MfiYOK46CZjJv5X5NLhXKYAKmgbdOV1Nv0S
         Yo/clmaAnfKxZnBKsRqoIPoiJh7GVDU8TslMQi31LDmRWSpE1nWRc8ZD3sYw+S69t1tD
         bNFGEL3xVL8lOgq64lQHofFq2fJN1Xh271IRt2ck6bSywYMjq9cLELLzhaZKiHZx8+f8
         0J/o2Qzdmyel9tQME0Tj821ZKymmuJM+yFenSG0ObME05cBOWY4G5qDTAuoRaAI/GY/F
         +lEhjBVqoWocbw4z2h/YGIF1cMI9Pk+XB0DZoozKzpzrFBZqu3vhp+Rk5YjMRyPJa/N0
         gdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620271; x=1796225071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4PCqqxbAPdHLMDmL/jc+BeC5eGbqxuOHjdxp6tKk8VQ=;
        b=hzMUnAWLOOhPxyBtgpOsu34R/SwocpmJNQkuo6bLzpfUtlmhoBp5C4917mbk5tbJvB
         /AOVj3x+Kbgdjtzv0Q4GqIJgypP342zFcyf9Eccmfd+S4KDkhUBofgZyOxwet53zWTkp
         ageWnlbtIc15nGA4O1Gs5l5HLA0QmfDVw+BorIlr4YryCtTfokA+HaEON8j94aVUHKhp
         ii4SU3bHxldGcQgEElgqohqOwnsATQKjUoTnL0DN/DsAYxAY4PzlD0L2EurKNuoA81Gl
         0L23HgY71IA7s0ESuSDrav4QYi2gZMYcX7/VQ5kcE6O2FPtDm/VDcgcJhbK+5dVmid8I
         khTw==
X-Forwarded-Encrypted: i=1; AL+hErE/khPQoLeAEcTujU8geAxD/otPIqnBxJ/sVRM0Jh0BTGZjHM6vdtt5aFxY00xiCx29etmK6Fe5tQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9O8kYkwoLLJwqTXey9Nh+rIRnK8fvP8y2gUstVeDjNWzVuULrO
	T+K5cJ/BUYRG63XfxDHA7p645tgNIHmup1xn9/3Ip4DaqVh1x2vYJfuso+rPeV+IW9BJnnd1Tsg
	ny5xb3lB6MTbu7VQYDjzDWEZXXPUqjuzVYBmE6YbZBpD4RO0JZx+SXL+crwqQK7Bpie3992Vk/T
	2OrwEt9G2aD7LAtS+D7b01IGkOrQ58IrBJ/yPU
X-Gm-Gg: AZFdTZett0zNFMV+kKT81wVhZEM5Ls2iehvSZ15CXXTg+n9zMWMt5kY7W5/M/KQoRcL
	rOwM62/LIEy+J1pTp+bOmEXq7B6CJySBGiRDB7Pk4NOYE8CK6hreyv++vCPVndJBur+4aj8ODCF
	69YSyfn5XE5CDb2DERjNl5NEYooJbMY4SmIpq7WBO30/OuClhHkwQm/XRUHA==
X-Received: by 2002:a17:903:b4b:b0:2e2:d09f:d770 with SMTP id d9443c01a7336-2f03f18fcdbmr179271845ad.26.1795620270913;
        Wed, 25 Nov 2026 07:24:30 -0800 (PST)
X-Received: by 2002:a17:903:b4b:b0:2e2:d09f:d770 with SMTP id
 d9443c01a7336-2f03f18fcdbmr179271375ad.26.1795620270479; Wed, 25 Nov 2026
 07:24:30 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795094118.git.geert+renesas@glider.be>
In-Reply-To: <cover.1795094118.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:24:18 +0100
X-Gm-Features: Aa3M54pJ48YM6_SXlU_kkTSYJ2hI-57deYpRMNsa0r9P3GyWSoliI7hEQs8n9Ag
Message-ID: <CAPx+jO9dY9yuJ5VUmuNi7t63nPNuYj3A7EWkwzsrmrZbiUQQFw@mail.gmail.com>
Subject: Re: [PATCH 0/3] pmdomain: ti/core: Miscellaneous cleanups
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: uxwmcZnwQjH2mfUpFdFkdJDMbuerdQME
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX3GFiP3rx1v2Z
 SZAxE6hVchHenD37+iLiqG5KSg7gZQxWy3jbbVcRCL5UZgfR15P9BSKN5FdBDXc4WX3FGDhDOKo
 pPBuA1zBExN1zMBH3doc24HTDyBieVQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX4t8bBgfyuVOf
 QW+KSK8C/EzPqmQvxN6V20vhKtRsYitxS8ho6mviqWJbHf7h8ATZacTM5jL4VGnVlL5wC/wuHzW
 ufSjhYg6VT/9JhHFaTrCMSYbw5A6X2K/Evnut24vc6oGlgWA+i+cPrbGSpYNH4KI6uZTMQxf4OS
 Ven3KXFrictTp4kkhS9a/bIfe+OkQfvX8T4kOa7Su4XrbM1rcHlBeocpCevw1bv919YGgRSfAxU
 z8kJKoLGObPW3+RcqGbsXLpb+TxxebzebNFadosw4FItSzwYve5hq7j3LKtTUF3/QJl6odo15kr
 2Y3bRnAoSApOn/a5zs4xrlBRP08qd07tXSVDdeM7t6C+RZAjJPtbhXHZ79nbZ03d06IstT+1B0G
 cYmGDxFmoa6QLeNvbGP2pOu3EmDiXzDrWUXsEOaa2Ji1XHvrRdJRyOz1yOYj2mJiZ44cJz49SH0
 eRcMnshcGNAv3Rbk7Lw==
X-Proofpoint-ORIG-GUID: uxwmcZnwQjH2mfUpFdFkdJDMbuerdQME
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b06fdaf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=61mVU_RYb79rVc1cBGUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250061

On Thu, Nov 19, 2026 at 2:23=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> This patch series contains two cleanups for the TI OMAP2+ PRM driver,
> and removes a now-unused generic_pm_domain_data member.
>
> This has been tested on BeagleBone Black.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (3):
>   pmdomain: ti: omap_prm: Use pm_clk_no_clocks()
>   pmdomain: ti: omap_prm: Remove dummy generic_pm_domain_data handling
>   pmdomain: core: Remove unused generic_pm_domain_data.data
>
>  drivers/pmdomain/ti/omap_prm.c | 15 +--------------
>  include/linux/pm_domain.h      |  1 -
>  2 files changed, 1 insertion(+), 15 deletions(-)
>
> --
> 2.43.0
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>

Applied for next, thanks!

Kind regards
Uffe
