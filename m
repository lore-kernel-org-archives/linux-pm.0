Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308119;
	b=Qq3Hjq1kL/JNlxsmlTayGtQWYY5xoDNcjGkFnukQ6huqx5dDbTQpyesCS7iQPoPm003r
	 JrEdbcMWkmauRJGDC3dZxjDffcSAljLJTpkAFU0kDcybd3u3FGk3kG2SpNm2DzjxWQGYQ
	 Lyeu9ryMisycR6e7VjtNIZa1/fx+CJ1p7YRJrIFXJBRG90M2aBVfRXNouatwlMYtxLSxA
	 mpk+GpJ4FthlW2/yEB+oQ4U8GE20z9BYHn+L31tSltEhNOiouoJqo1yjMlPOuuZMMMy16
	 SXuLu5ad74lhYo3Evu1GB0PRKXkNX/OyEddTCxGSU8+TiBIKMCUqG+O0kgny3MKWJKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308119;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=;
	b=bwh2gP9QAxBQuaa9qHw+AIAg6/sfjfm15bMB4ZjKobV3FtZmhSdOtN9MC/nviJzj/Dj5
	 w4ji3zNd8pZ/Mdmrw+fOvBEmDT8+71gXHHUqGcagzLpOJ6EguwDnny9OpBM2gJYyOIuXN
	 MLXsDgwjdoE+sZgPTrb93vT4toHWGP4F3nocYNQWv3fgRMZfLXJ9CyroLIYakOJaklKrC
	 jpS1441LCa99f19vz0HjbnVnhchyCU3woAZsRjoPWt1OaY/CO1SOh9Q3bozDqZF95zlK7
	 W6RAjCDYFyEAc4G4Tq1LzlRj00PTv9JvkgP1d847TWXEF9i6nd/Y8KR/4TMV1s6jE2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oe7X6rYC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iGLOvKGP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DA606A339
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A78DA606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oe7X6rYC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iGLOvKGP
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7l6GN2433753
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=; b=Oe7X6rYC7ba/GxLY
	1OYvKjjZ6uf3OAffFNrlbabF2j6cVGaxzg4fn6/E82YNIxSg4iZ1C7APW8DdxE74
	ENiN0wjxqWTlZyELXOx21oPG5L5rh7pROa/FzwVB2r4PJFSq2xaf24BA5eVpoCqd
	n94N7ixOpjlD0E1R6Eu+wPx1tSRWTK3hiGZzlCoAtUKRUdCNFfvXMxxzcYwQPtfs
	SOPfW6xghtNdIDosOPXruQRUcpbAEF7vY8V4G+onFhTXci6VXJc0uVczIg31KFCg
	ZOL6jgxic4Sxf+mbUym3+gb77zBlCMN3xILGCGKR66T0CV+zSTfYRjfSKZTJWotV
	FVc2Ew==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hux848xx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so2771736a91.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 02:55:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308116; cv=none;
        d=google.com; s=arc-20260327;
        b=pBmFlzLtzBrXtSlXPGm9Z/XtoK6COQS+hNBSKFFaOSp3RzVCM/Qc0PjDUK7gNOYcEM
         d4JPhiBi5JQ6IYjZu1KjNeryY1RxChlFCFpMCaxivKKPlL5Trlx5dpxuqFc0tMz9asnJ
         cO9IjWqqCUfCI/ddKOUe1mJpjzQjasQU3CzK7zu2GFBFXrP47CAQB2su8eDUyD9cr5ng
         bZif7YORXRW+nZ3Jn/i8Pr/XiwhwT+7ASDKR/U2ZT1BetGy6rD2B0/9LSDEi2ZoMCLMD
         wlu6IK/G+6JfyLy3nTm8oyPv4NjehL76ohSZXkdTcqp07G+0vzxRXSbmXllRLCtNZMLG
         x/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=;
        fh=SjZW1pCo/wbZc0yKTbYpaJ5IShEQqOq0J93VDMxs74U=;
        b=fNHe7FrPQuaLQG+f6ZrmvjDeK9uA4jLC6B3+auSbhJu9Ya6KVaXZ72Sn3XGxt70MkP
         +nxNY/WFrvDmZcO8ISkCDaM+2yODYEhqSvCkcwb5jaP6JyK5hPKKUDI38l/BEpPfqL9K
         sFlQqga7UCFQxA/jPcrxKUrQKhIRPz/FSBDqD0L9UQO0af36gNBXb6X9Lmf8D3wgq4N5
         89VXSAU4GVOadYjNLO39xHHhc5+YyosndCVtYj7t2raJKYOIF+cAcEGSQoksxAvsAkYo
         ujxDX5Rm3KU3soLpbK/xdS5kNuruv2T9TFlbCKzsJ634Ix3Jw7EwV/2FOd/Ve7Yp9D8G
         KkYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794308116; x=1794912916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=;
        b=iGLOvKGPL228gMU6kednwrmkWHMzhMweiF54OAKArGCKzEyXK/cFBS7wycFEGnvPjc
         APY6t0VFszvzVPgTerB5SjY6zvioZnMy6i0SyscAlXhBa12w4ZJutOHQWN+Zlg70/WWb
         bP23/GBEtwzp31gQU3mclAltD8hxVV7D2LI78UCY4IyTXchVrQnDowoWrQQhhxZbKdN+
         WVGyOZbEbp2Sgq14d4+0nX7vsU8sLADQNcciKFy3lZc8scYRwoVJVkcpMLrw6IcHKILo
         b8sYJVoGAIyDCXVGTKDhVmSsp+peIQrZ+QJQPm1PyANJQc9mzjQboo6bOC2wb1S3kL6q
         2OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308116; x=1794912916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=;
        b=l9p32thzCQcQC3DybDrHZ5ruu4dOrS3nkNkL9i3k084wdDpdzr10MYrzjBxnjyoPCe
         kWkt73cjEdTqeypA2iZWnr1ReURFRe32Z4ljR6kN9zdXNnDXWzUtVe2H/5F60Sv9RbOC
         nPgU/kmXE05yg1XSGxoqLggQJrhroVObo1UQ1EFhLQyUeWsoRfgexdMuA5AxhTB3/4Ht
         rqsYJ6o/8I5v5GkGxHnF1tCAtvHeu9TgluVl0Hdmcs4mPxBB44nZM7WMdzayQdZ757z/
         /eBw2g7fODhrV5I/tZYvqE+bTHmIpojUMzI+SBb4H8jeQTzkYRJDAogdQxH58EcguyFk
         OwXg==
X-Forwarded-Encrypted: i=1; AL+hErG/tiaRq3DExTLNMv2L9gBGSYTvw0spmeTX0l8rFuXBZM+LkyUxmulemvgzj5Wh2lN6nT55J1ahRA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Lp1inYCWh1XfXiKGpf09PTL5HBRBHml90WxVVe1sw6/nYQD8t
	y6rkM7nEzo0Uu2SUlgp4gzlVTAv0jri2wK8MPwSpP1yQH46wg1FBDND/nLAyTHlEP4yRsMu5oAX
	bb1lCAIAJYbY14CRFTKK9jyenhBLK32P4PsKr75vb6y4sxSefCok3PFMMvCkk4tAfqxG7cBUSut
	xK1T5wwuHsCi4P5f4iFcuKCXvKNnyIRrhsIjXJ
X-Gm-Gg: AYBFou0Yfd+T06r6sHMWqzEWFgfuTv8x3u+wEBHchfYvFtzalyjnpG4rVrjIjfj+SK3
	kuw+Ey6fnrRwPopgRa0u8yMFji+/jK8fDFlEQki5J5RSWSL73vQKIB3xBFTIKoMPCOVtKY+L7X+
	PM2g43X0FfMziRPJGgSwBdstbNV/lmxkyqDVwvymyaHrODJqBS5rki4FkZhA==
X-Received: by 2002:a17:90b:164c:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3b166c84952mr2169244a91.10.1794308116509;
        Tue, 10 Nov 2026 02:55:16 -0800 (PST)
X-Received: by 2002:a17:90b:164c:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3b166c84952mr2169224a91.10.1794308115925; Tue, 10 Nov 2026
 02:55:15 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005131923.291619-1-nils@buechner.me>
In-Reply-To: <20261005131923.291619-1-nils@buechner.me>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:55:03 +0100
X-Gm-Features: AclHuK_HV3ZZmq-KfeYfcuWg-ilNBvuN8Akbycq_to22pxvhsiankk74K8OHQ30
Message-ID: <CAPx+jO8KitFsFdDFfza5WTZGwVzOOtB+Agr=qKESHf=54q10Ow@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: mt8183: Fix silent audio from
 premature sync_state
To: =?UTF-8?Q?Nils_B=C3=BCchner?= <nils@buechner.me>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX9jVJS1/onPkd
 Ui2km4AdXDSLtehwBP84+dXqFDm606bMvLGqRdo9MqvOs5vvzo9WqwoP7Ubvz4uNDT3LFxT4a7d
 cu+xfes16cdzME23uWNFKElYEtx18unzQUsrwgNxNFf7Bj4VRs4U7Dhzvpua6NFi7L2if35dhfR
 /WHdRTu9ZvuA+oGCu6bu06FoHKCp7LIokO6uDc0H+XCZxPfu6Nq9cSj1lm0Y660iaRzUlIHBltb
 yzkFMvbXaN+kM5Gg+sx3z/fH/8i4cffCBLAyYVDgLxtV0sYHaiqTvDwyol/Rhbyj852OvO240UA
 ByHBpENYZktZi07GbMZ+WPzEz5K8bj3n0KhyAge7GkAvKz+Xk/fvM1irEyWv4IJ6XQlwcqEAxUd
 q1iE0Xi8HY0gR6wWgkmQSr1VegPUj/T+tKqQ5l689Mr4iLsvgNU0zmcSn8RrX2DRIBm1nVWLjn9
 7SrFctGAuadaWmpSrWA==
X-Proofpoint-GUID: jZqHpF7AY8WRaadm8ZcOHtQ7XmadW_H2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX9VPALzKCRmdO
 viTg0VMm1b6OiVvkfU8iIMsHs/fWOLpFktZFGLbNrZtHA7SZLRlQ7cpEeuyAFPrTq8OenqLIXKI
 0NuEniMNBAM3g6lFu/NuaRUD/h4cOqY=
X-Proofpoint-ORIG-GUID: jZqHpF7AY8WRaadm8ZcOHtQ7XmadW_H2
X-Authority-Analysis: v=2.4 cv=JNSuIMKb c=1 sm=1 tr=0 ts=6af2f815 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=byjLVS86Mrn06biGc8YA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100043

On Mon, Oct 5, 2026 at 3:19=E2=80=AFPM Nils B=C3=BCchner <nils@buechner.me>=
 wrote:
>
> Commit 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until
> sync_state") made genpd trust that a power domain already on at probe
> time is correctly, fully initialized, and stopped forcing a real
> power-off/power-on cycle for it until the devicetree provider's
> sync_state() callback fires.
>
> On the Juniper board (Acer Chromebook Spin 311, MT8183), the firmware
> leaves the audio power domain in exactly this misleading state: genpd
> reports it as on, so this new behavior never runs the real hardware
> sequencing in scpsys_power_on() that clears the domain's AXI bus
> protection. Register access to the AFE block over APB keeps working
> normally, giving no obvious sign anything is wrong, but the memif DMA
> engine's own bus transactions silently never complete: its current-
> position register stays frozen at the value it was reset to, the
> period-elapsed interrupt is never raised, and ALSA playback fails with
> -EIO. The net effect is silent internal speakers on every boot.
>
> This is the same class of problem already fixed for the MFG/GPU
> domains in commit 818d56ac1d ("pmdomain: mediatek: Fix mt8183 hang on
> boot"), which does not cover the audio domain. Apply the identical,
> already-reviewed fix here: MTK_SCPD_KEEP_DEFAULT_OFF makes genpd start
> the domain in GENPD_STATE_OFF instead of trusting the bootloader's
> "on" state, so the AFE driver's own first pm_runtime resume triggers a
> genuine power-on transition and actually runs the bus-protection
> clear.
>
> Root-caused with a git bisect across released kernel versions on real
> Juniper hardware (audio works on v6.6, fails from v6.16 onward),
> narrowing the regression down to this exact commit, and confirmed
> fixed with speaker-test playback after applying this change.
>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sy=
nc_state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nils B=C3=BCchner <nils@buechner.me>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mt8183-pm-domains.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pmdomain/mediatek/mt8183-pm-domains.h b/drivers/pmdo=
main/mediatek/mt8183-pm-domains.h
> index 5e33b8628..8e29e5117 100644
> --- a/drivers/pmdomain/mediatek/mt8183-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
> @@ -22,6 +22,15 @@ static const struct scpsys_domain_data scpsys_domain_d=
ata_mt8183[] =3D {
>                 .pwr_sta2nd_offs =3D 0x0184,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> +               /*
> +                * Depending on firmware, the audio domain may be left
> +                * partially on at boot, with genpd detecting it as on wh=
en
> +                * it isn't fully initialized. Force a real off/on cycle
> +                * instead of trusting that state, same as the MFG domain=
s
> +                * in commit 818d56ac1d ("pmdomain: mediatek: Fix mt8183
> +                * hang on boot").
> +                */
> +               .caps =3D MTK_SCPD_KEEP_DEFAULT_OFF,
>         },
>         [MT8183_POWER_DOMAIN_CONN] =3D {
>                 .name =3D "conn",
> --
> 2.53.0
>
