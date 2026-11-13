Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592104;
	b=N9zSX/k7b/af5gDDA1C4ovLz19UTVlz+ud544A44pU8Rx90KkM6hebNfmglh9RWARPQT
	 XcZewjekA/GTsj6cP7sXvLPnEei5FFqbJLbee6GCN0+4gYM724SP/s6CM4ouozRAwFY76
	 qIEYBWN5plT98RoNKcxo8M7/UrvEvtEPjkz5lKK8BqrSixsJK/7NyC4e15Ih2DK7+yqw8
	 zF9hdCv712tnhoVnLLTOtOzfojEaLby9yjYHqvrVfm+ikmbbwa3+UZEGAI/SX1OZUhkUM
	 VxWoJsu52atIPB8GOprUx4xFoGAn+QOCu1u2ENQofwYZZfoRw2ExMO2axLAybWBfxrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592104;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Y1gktfBHpWHBxsfGL/xBUGKxuJBDF2lVN2TGmLj0SVk=;
	b=CNHSqFpTwnqoKP7UEfX3yRuRaTQbgTN+NvVaGU+EFRXtlqBEPP01Bv+qmezFM44SPBnm
	 nLv0eiITJTela5GsktnljXn5H9eCju8TqKPuXgxtn4GPxgqWGV9mg1sUeQSLyhCNphxAv
	 9k+5rHNQRinL0qDq/i1uvf9kAdp8CEYRC9XB+CcBLL4zzXmAtK2YoJkNHdj49KIU/LVB3
	 3ECv/KlWS0AyZEjlKyzFJLWvgRieLQi1e6F3gAB/gkoqSTrBGRiE1/jZeggV2Y9ZumsM/
	 JUbeYvz9oze4mnObYcm+MudHMoMZcQxXz37z+0bIMi95ffdJG5QkmfhS6/9xnJr3gPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BMatpwbj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eyXx5eHl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF1606EDAB
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6CF1606EDAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BMatpwbj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eyXx5eHl
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADH3fkm3868345
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y1gktfBHpWHBxsfGL/xBUGKxuJBDF2lVN2TGmLj0SVk=; b=BMatpwbjJXhz7tmC
	ljasbfmlGO95hnJLqxJOCrP4eQA5/NxRquVwQI3nLTw2AQPvJfq6nrHByqab//Or
	5cbUlGEvb4Ay1pzSqsgpN9VN66PuxfhxglCSwt38Bcz5q4qZEJMmu93sMzSrplGf
	jpt5AhTtjiAuqNRwyv3gZisR+GTvitPePq3x637xstffZODbFPHWA6ygF6EFyNef
	NImCZYdSZCXJxJ46T/kfSXeFigDFJ/2LEFXabR7rv3oDAZ/HTgWrm08IPCrIHaAT
	ZCIYO+VDeRCRqlUe1Kgnhgr8042q0MdFVDTRgX5Ceh4yC0Ttwb4HqH4Nq7uJFu11
	UrX1zA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx6ma8527-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b15e47e57fso743833a91.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592102; cv=none;
        d=google.com; s=arc-20260327;
        b=lVEjM2Hv5pbxC3TWKVwPqZ0DW/jKC/+R87jqiOrCd4CNNtevxTIYgCh/LCuz5kBmIi
         YeT1rk/tN4GwVFGBgZ5vDuYciCuR4pepV5Ppur9J9JoozWPlFsM2LdFNUEAuiBsFF8U9
         CFsknqQO5t/KSSNdKxqCf89yNKCp1RB8qvWNTYXoVNBLnpluNzM7UnVWS+hgI8Bh7o26
         TWjv85osAghu6bDL7LUPwH4QcIN/jSK+BD5SR6QBQfsOzLASdjy96hkBT9QuVbiKkjd/
         u9Toh+TCp3zyaZIZV3O3z8xTOXgY09iU+lXKvW51t1uJeqekoLdNBqdZdIGH8ljWQoZh
         Gs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y1gktfBHpWHBxsfGL/xBUGKxuJBDF2lVN2TGmLj0SVk=;
        fh=vHUWxbBCFoNVX2NTp2QAru/eoJJUGP1BcyYFjd1fEDQ=;
        b=GY5cKG5EKn7DJemp2LpnB5VkclQhipkFT0QrM3FKPLj6F28Mbdq+QRVzUpRosjHhuf
         ttIwr659lqdAxgD807JNXAx9GxvTlgRD6rq73zXfoNa1BA11PCTMALrlLPvtRKeb0ZFD
         XK3ZSBh4GDFzwIQiPXqB+RTjej8DdxjN7x6PYOgEsXEuwk6RI36tVj7+Im/DVPHu10z6
         JyXMQiAEUBbiblv/0O9XtSRlwl7wuV+SncSTY6uMLllUDFAUyE0fE/3pRB7+jv+TvADl
         AgRePq4OBBV70xhPCcYCoEsPFHbv/XLMbSdb/WQYSzIDPTc6MweJBc3xpUba45/krfiZ
         2F+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592102; x=1795196902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y1gktfBHpWHBxsfGL/xBUGKxuJBDF2lVN2TGmLj0SVk=;
        b=eyXx5eHlWjvxQ7pOghP2ubvUgEExQgX0/gUBQbUpxTN49gYoxLlNmvm7INGY7PZJcY
         kT7DM47eXITsRGRSwJejVust9xBILN+xYTdIu8RgBgGwbzR38Hwe2paJ1xryS7cxdjWx
         TzD7+ZzmfWWq+wImSmNtgZYNhJsZnoAhWVPUf+UIdDFKkzLDQ6wL/g8gP4stJ740NlZ0
         +OQ2ucpKq9djWPRPDZRA7Pqs57bQKv17vgmqd31N2O1wHsu1lWeBnrkvTTEUCFuYRkHr
         tuEr0ezMWBgDxZzoeFzzt/TMipnZhAiuPIjCQdIdwfYtvI68mVtQmN5B/bnFWQhU1xd9
         INpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592102; x=1795196902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1gktfBHpWHBxsfGL/xBUGKxuJBDF2lVN2TGmLj0SVk=;
        b=GNOEdiSK1jcFJI7ilkhc/nttmOriCg0xoWkZ001q+iskcfmYSKukQM3s9YbS2cSv/3
         NcUujneVJjQx686XwnM/eEe+0Jmbl+pAQWpzs+Pay7qa78IrifznA9JaFjsR6tF2OshJ
         w2WNBADjFPWC/J8EvnD9s2v/Yog8V1mpngHMpWO54NfEJuAJWFO4LcDbUY9B/J/804R+
         p4HuV+rcoiB6cC5PB86VdseqR7TF8QzWLYaubWBt3mX3FBef4Qs56Walc+jJiZjANkiZ
         pXPIR93S3TgjmRO8kwthbiCTmmr0KKvRjbQND7Pd7+kzvAD/3Wboh/fz9hvQIxq/1iI8
         deMA==
X-Forwarded-Encrypted: i=1; AL+hErEIupaYYSCUYpih8pHJwuWN93+wX/afIti4nZjVzZFIGkcdygdZMKSez4VKPCl3gY3hy/oddYBPvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZvOciSB/KpNTvBFoRwSldoCCAtxGKYqSPWJmD197u3l7pBZtO
	MQ9UilEANaxGhSQ5quFWZrJH1Aos13LEjm5m+zNTUpM66dIY47SodfSkd9kEeQlYFRZF1UXSLv5
	Brls/zYINPNIQzlIXWuWFbppROkpzGG3tyfWYzqbT6E6uMjnQd1XRIn6+0wjMNriJ3vW+0XKFeq
	i6tV7xXJ0PMgfgpKmLSWhmfG0sEgZlsMW3vctP
X-Gm-Gg: AYBFou2tcl8FtqE23IQ8drwK51aaym5NTYtkMaAoQ4cBdwr/DI35AxdeTLzQ5ioRDXR
	CeT9PMBaQOdixYoQNbvIxTypNQucMjl0zjUhZxovchkDddER9qp8EtDUVsDfOHUKVB+rpwVY5lt
	GlcaUe/fHjMf3e+3EDCA5UcEoU403L7N4zBM6W7eH5hoXVxnTtNZdgg/FnkA==
X-Received: by 2002:a17:90b:993:b0:3b0:e2a9:3466 with SMTP id 98e67ed59e1d1-3b1b09fa555mr2052179a91.16.1794592101948;
        Fri, 13 Nov 2026 09:48:21 -0800 (PST)
X-Received: by 2002:a17:90b:993:b0:3b0:e2a9:3466 with SMTP id
 98e67ed59e1d1-3b1b09fa555mr2052164a91.16.1794592101492; Fri, 13 Nov 2026
 09:48:21 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021080517.2161-1-okerixx@gmail.com>
In-Reply-To: <20261021080517.2161-1-okerixx@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:48:09 +0100
X-Gm-Features: AclHuK_cX9nfIfMsECKx5geydS7UVI339oofu71FfWZMTLtQ_zkBB1Cw2kA9Opo
Message-ID: <CAPx+jO8N4yLD8pZ2vr9_3MD9==FFMdvQG+=1JjDoe2kG7DR1iA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: don't clamp gfx and gmxc before sync_state
To: Oleg Keri <okerixx@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <rob.clark@oss.qualcomm.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: lo6fdDqmfu94tFCKqA5tpuZ5oKfqyfc6
X-Authority-Analysis: v=2.4 cv=RbcFmFtv c=1 sm=1 tr=0 ts=6af74d66 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=4GocJDDa9GRkIFf5CVIA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX+9V5eHBpS8BG
 8gtpLzgbmbApJJVPodC3T4vUHFr95+QU950s6KZKLOIVG4O7iEsoA//5YUXdJk6KZY7r87alIhg
 IEhukDar6Mx/PnU5A03I4rR6qZaGFDKnL17zdwgmrLvvs5ksJ/P+N/2NV1FbNcYNCl/ly5nsuw3
 bivfrB54Y5afa35SdwUfLSVDr8YartcTMy1xX7TEotpWUZ+XLbL1LSOPHJoa9hXXe9y2U11bbfh
 3f7eO+3zX6r5SlT8yo7CWDc5p9S3g7FCLPA8YXEupaXJqFZa4wgKt2QJwGmBYo6fHybRWj0SP8g
 3WrynlAhO2l/2JQEFgXNl2cew2mugASElgujYLTC2lenXQjJ+Jkvq+zjs8Gk2LpmCSQazb9y/9i
 jlnqgtGdnhw9J2q2BMHkKaE4Nu/reEyPbvVjUNhddWnpEB+ZZR5YRd5c7Q8hf3b44K45KqJCG/R
 vN96UwrgFVd2bOAihZQ==
X-Proofpoint-ORIG-GUID: lo6fdDqmfu94tFCKqA5tpuZ5oKfqyfc6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX62iyrOVL0oAn
 gqE+XTpiVphTpDBqnuPnXunrqqreiScG7eS7srijG49OuUDHjVfdhdh827W09fOaXOt6WqYCchP
 dQUp6SBSI+qW81rZw68rFfhAHyY0nvE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130070

On Wed, Oct 21, 2026 at 10:05=E2=80=AFAM Oleg Keri <okerixx@gmail.com> wrot=
e:
>
> Until rpmhpd's sync_state every vote is clamped to the highest corner,
> so that hardware the bootloader left running keeps the rail level it
> needs until its driver takes over.  Nothing the bootloader leaves behind
> runs on the GPU rails, but the clamp hits them anyway: the GPU clock
> controller's probe runtime-resumes and suspends its GFX and GMXC
> domains, and from then on both rails are pinned at their highest corner
> until sync_state.
>
> On Glymur gfx.lvl has 14 levels and the clamp holds the rail at the top
> one, 0x1d0, while the GMU's own performance table ends at level 11,
> 0x1c4.  With the GPU driver and firmware built in, the GMU boots long
> before sync_state, and its CLX DCVS calibration does not survive a gfx
> rail held that high: the firmware gives up with HFI_F2H_MSG_ERROR
> 0x007306c7 (ResMgrCalibrateDcvsLvl), the first HFI_H2F_MSG_GX_BW_PERF_VOT=
E
> times out and the first GPU init fails.  On the Lenovo Yoga Slim 7x
> Gen 11 this means the compositor cannot start at first login.  Pinning
> gfx at level 11 or 12 instead fails the same way, level 10 and below
> boot fine, and pinning gmxc alone has no effect.
>
> Leave gfx and gmxc out of the clamp: they have no bootloader-configured
> consumer to protect, and the GMU votes them through its own RSC.
>
> Fixes: 93b6c8d10fad ("drm/msm/a8xx: Enable CLX feature on Adreno X2-85")
> Link: https://lore.kernel.org/r/179248663855.32151.9955864156939592299@gm=
ail.com
> Acked-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Oleg Keri <okerixx@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

@Konrad, can you please confirm this makes sense, at least short term wise?

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhp=
d.c
> index fa8fed5bd3e5..2c9d4beeffbe 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -1006,7 +1006,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *p=
d, unsigned int corner)
>         unsigned int peer_active_corner =3D 0, peer_sleep_corner =3D 0;
>         unsigned int peer_enabled_corner;
>
> -       if (pd->state_synced) {
> +       if (pd->state_synced || pd =3D=3D &gfx || pd =3D=3D &gmxc) {
>                 to_active_sleep(pd, corner, &this_active_corner, &this_sl=
eep_corner);
>         } else {
>                 /* Clamp to highest corner if sync_state hasn't happened =
*/
>
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
> --
> 2.55.0
>
