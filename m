Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878643149D
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277579; cv=pass; b=G73oEYAe1qiynRcq6w8pcZiCR373iH7z3msvS3FUeRYX2Vy3o6llrF4aZEta/SuUDo5Vel/yp3YWeOLfVHZRWsbUFPkSNXQPM3kcOBR5aEvqzXZpa2PDfB/AAIz/q1KSvWSqXDccYnPbkY2hJMEHrd4Jqar3gXc4RNxY+C6YQ4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277579; c=relaxed/simple;
	bh=kBO/AzoZx1ofZasrbnMAMlpidRtyOjDHcD5P0zRr+dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePWcHx0YVrcZCR92GUx/JUo9q+UFI6bC1/xz46A3Mrn+90q0OmL0n8BplBdEyeI292kp8i6V668ucR0ksomZkfSBxrt5UL1iuHcyy0H2L0Z7leg8lK/aebS/pS5HLp/w83y1LpEaMb7DzzuLPBhFU3Dx+IIXk+uRPyfNjIBIj7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n8d7mRg2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aXz/ab7L; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n8d7mRg2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aXz/ab7L"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8XHW2145824
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 15:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DXMurLz1uw6v5dbnfD45z53kR9FFKD293CZNB/HTMoE=; b=n8d7mRg28ll7i78w
	GqCzjFy0bizbLYoxqeGEpp6HFGBcrpvYeGy0TgT44jO0MzXaTLOz5lSZQRx/cifK
	Qp53mkNeloVnt9XCz8Wkl2Z2UjvxruvtLNSWce8M5UCfS2XYre+q28svzAdUAN1a
	oO0WPu+sbLecb5I3Yl/150I4ELsWPMH2+2EEJF9sywBuK4Le/v37rX2UlYJrXRFV
	whYQjE1yZFKS/Lona50Jy1d5URXP5IqnzVgObOGpy6OmC5WelxY9gdSww8RbVmeJ
	mko9TaWKwNKqgfguXDScgTLVfJUpaSjTAq5CaDMajq5yWdPM1KFYXyfoaMDJAld6
	XRrawg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdnk8uh4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 15:46:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso1527063b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 08:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277576; cv=none;
        d=google.com; s=arc-20260327;
        b=VTr6ygGnIWc9QNqIpvYk9pjkLahjS9q2Zka+Eqwk0ry7X2TBXzIaVAkVmnBbbLWPCf
         57L9Ng+sy/POlTJUDT7l1ytlF4RQHSLCJPoOk3XKDpnxEJIpKfXA+xVyo0wMw4CJKidy
         MWGQrk7XP2+YdAfXMmjs1ZeDBAiFVsUffrzDLb1LD96cW8ii4BVS9gSebgEPJ4cugLOR
         KoaaaKsVwXJh7oiDCRZwUes1WGEpOTPQ/IEktJ6fZ9GOag87HFj92XsP9G5DjGWd6BjC
         Km6h5QGBA0w+8DIRb7xz0eP48jIj2ue9uLj2NZ8nSSm/pJ4nNH4W5eFPIH3KQZ3HaCHd
         3+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DXMurLz1uw6v5dbnfD45z53kR9FFKD293CZNB/HTMoE=;
        fh=6RnPSUbRZoBSmqAAFYA5vx/nNtiz9vwhDqYTVCKc9ww=;
        b=o30IgeD5HbrO8NJD5+ss23WUh1kv931udy9ntP+kEXcpmYsujlH28xlH9/QHB88IKX
         adcqLcBBzRTUt7A+7SThvmaNe4GVbtSfmUsBhGvMrWVyvas1ajuH9/qlWcGaxyXlaRET
         L+gEDvoXNe9OpwTz106F8rIckTepcz5E2rmdUZB6HzBuO5kUUn+SgweYVFuiUvYl8A3G
         OH7+TAlkipgmRsJolTfC2HJS1iO+5JosrEsl9lQdngFULGLgsrW96KaKQWWGPMQqj5MH
         Oe2/91wkZEbyODevOeevb16IYIi86ZKncd9fGH3Y28vwe5KM393KH7WPGvkMxZ2KqqZx
         ycvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788277576; x=1788882376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DXMurLz1uw6v5dbnfD45z53kR9FFKD293CZNB/HTMoE=;
        b=aXz/ab7LQl9y63RellizNIOD0WjddTGovZcxQhYNNMJ95HWsOXIgbbHfla3sHhexE9
         BLTIvmt6tIh4Jem5KJ7xQ7hypnZbtlssFTgdX/2xLLaZl0nWd8nJNQz79dRaQLXnnfZA
         CQU38jXVEx3x3fPC5f99WHkR9iHdyZTpBwSwwl9JuGCncNYZa9AIVwWwjQNHPLGLi/xU
         pHuCNWHDL3xPEkMek7cGnnJzHfRNTLAMmvXB/TSb212/h6Dm+zbm87X0uDoz/yMy7fVa
         8Dx8MigqsAp0nG8S1DIxeTeVbm0OcTJde7IY82jXeykkf2l8+rsGMQQM4gso5ISsQkyH
         Yfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277576; x=1788882376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DXMurLz1uw6v5dbnfD45z53kR9FFKD293CZNB/HTMoE=;
        b=fpduYLV2coCj6FyLlJpk3QNaiEHs3rpKwYQmAvA7kjweAPxlA4eQd61/bJArGHqSOw
         XPFQ/5KT2kG8iZGyT3mueh3jUbh6PLIP1zma4L6u6wqb6en/0AShM4d7+499aOrwmr8W
         NaFBxYcurDKiV+MVZG6w6cGk4EoNjXj6xgOPIYscaEFWvWSX9pRHE0A/Dw7J8hzgLjqg
         PaNv5SlCPI+lRCBSMRq01IdgizCdAAE+wlpJ71E6RbTtuKlpVuHVhsu3sYfB9s9Xcv56
         dJfCOdAHp9o4sV/SYauTFKM+G/C+srVmJm8ze0A5Xn4+fgJ0Kh5jcHvmlYlYwlUsipYJ
         NrEw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7VvWuFWiJKHmx7QuNDobTbj+AKMb6nDW3N0G4XvPMb1MG9cHP07I4/KWlX87dqCC439G3Fn2A2w==@vger.kernel.org
X-Gm-Message-State: AFuF++k8tKCWrjmbwEGksmzzjT9FOD/ay1ZyIP84zaIl+o4mGf5OdYgx
	hJwUINCueVUZa057POTj7NuVg2k10CRRn4c5PuVhTXhyhBuVqyn1cTJUIvCTx/Fs37DG2boQwc7
	8f4ZmymRCOeNv5uQb74sSxeWSKN0JpPZ/3IpCVAkCjGYr6V66efWNIb5QxReplwz1UTX8tdiIO2
	T+jP9figGi2U1dfiXbv/V3q1VvZd/csm1LoYRE
X-Gm-Gg: AR+sD10W61MZbPPRmQ8XQXbiiZ+1Gu5LHdW3mK8M+AVOxchG4M4oqaeMlhuVEem063o
	aF5VDT61NtmIv21mIXe3mvpWODeOODkKC2K2JW2nusLmm/ze06NddSD87FOCdBGSDboe/PSXVBT
	gtlcJcK1j5fPwhd53wRbUNWhOyJ1rxxnGijigzulmfDnTaro9GP1hLTmbM9A==
X-Received: by 2002:a05:6a00:4191:b0:853:430e:6b60 with SMTP id d2e1a72fcca58-85bcbd8ad6fmr5717506b3a.14.1788277576168;
        Tue, 01 Sep 2026 08:46:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:4191:b0:853:430e:6b60 with SMTP id
 d2e1a72fcca58-85bcbd8ad6fmr5717449b3a.14.1788277575650; Tue, 01 Sep 2026
 08:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826101316.22193-1-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260826101316.22193-1-ayman.chaudhry.kc@renesas.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:46:01 +0200
X-Gm-Features: AcwNN1Wk6oa8z3X-T1jHCneIimH6M9AciAx9hJy1lSv_z1qxgSpmHgEf1Fp22kk
Message-ID: <CAPx+jO8eNBgcWf8d8xUhS6n=a4ztLV1ZSytTyMMqj79f0SFLeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pmdomain: renesas: rcar-sysc: Update description
 of chan_offs, chan_bit, isr_bit
To: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=f6p4wuyM c=1 sm=1 tr=0 ts=6a96f348 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=yC-0_ovQAAAA:8 a=ftZ7uTllurLVGgvAASsA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzOSBTYWx0ZWRfX1UsvInPqlaVE
 T5LwzVfy6IenfvjX5E//K/H9FrLUknq8dAkoR2SgtBBuloGqL1oVRWmsoHYvYtlg8w9YEyWcBTT
 RMdjM3BRJTYZwe7s13jhPay14SnuUvDDArML36zaeXxPkuOGceWMkY+0wDwah4tk5teQ+Y9a9gh
 T+CUb4cKR5Nw4ketsl8EZl3n34Dlf/BBOidld/kndrzjFL4vhCz8S70azhOBwmtVcL0vfk+YXUW
 P+xFmQOlLcssS/J3FUldRtXUgLfRtZOwojCfH39WoPgYi3DoCivTSSFOlntWy1NHsjFMN5aNh4F
 can9Je6wjISAJzIyT0JDhtOB6oYrZeSPpSly0yttoEm1gNFTnevNEjgDNC4w0WGWou/MD+fh+iU
 I+tYfBW1d4PfZZMmwcIdDqSyy3RTmuUlnTFxjLTGDy/iyiP/36KxpBY8lFOS43d9oPK0niRgl1p
 y+fYMYjZi9nV4qQczxA==
X-Proofpoint-ORIG-GUID: xuMoa242yjgklgh2QpxikyTjE54oFAUr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzOSBTYWx0ZWRfX7GuEV4+AHZeb
 Rqa4Oe6Toqwoew6+APA1wsSVa7seJKtJrYg9/W1xigq14Of/27NSrBMoICiJuJkZn7u0Nc3QLWD
 mhxz2vEAIGwq22Fsq8IQxM5elK/GnFY=
X-Proofpoint-GUID: xuMoa242yjgklgh2QpxikyTjE54oFAUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010139

On Wed, Aug 26, 2026 at 12:13=E2=80=AFPM Ayman Chaudhry
<ayman.chaudhry.kc@renesas.com> wrote:
>
> The descriptions of `rcar_sysc_area.chan_offs`,
> `rcar_sysc_area.chan_bits`, and `rcar_sysc_area.isr_bit` do not clearly
> document how these fields are used.
>
> When `rcar_sysc_area.flags` is set to `PD_ALWAYS_ON` (i.e. `PD_NO_CR`),
> these fields are ignored, therefore improve the description of
> `rcar_sysc_area.chan_offs`, `rcar_sysc_area.chan_bit`, and
> `rcar_sysc_area.isr_bit` to make it clear that the field is set to 0 if
> power is always on.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1->v2:
> - Updated commit title and message
> - Changed the description of `rcar_sysc_area.chan_bit` and
>   `rcar_sysc_area.isr_bit`
>
>  drivers/pmdomain/renesas/rcar-sysc.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/renesas/rcar-sysc.h b/drivers/pmdomain/rene=
sas/rcar-sysc.h
> index 9e93a1f98f68..b264e727883b 100644
> --- a/drivers/pmdomain/renesas/rcar-sysc.h
> +++ b/drivers/pmdomain/renesas/rcar-sysc.h
> @@ -29,9 +29,15 @@
>
>  struct rcar_sysc_area {
>         const char *name;
> -       u16 chan_offs;          /* Offset of PWRSR register for this area=
 */
> -       u8 chan_bit;            /* Bit in PWR* (except for PWRUP in PWRSR=
) */
> -       u8 isr_bit;             /* Bit in SYSCI*R */
> +       u16 chan_offs;          /*
> +                                * PWRSR register offset; or 0 if area is
> +                                * always on
> +                                */
> +       u8 chan_bit;            /*
> +                                * Bit in PWR* (except for PWRUP in PWRSR=
);
> +                                * 0 if area is always on
> +                                */
> +       u8 isr_bit;             /* Bit in SYSCI*R; 0 if area is always on=
 */
>         s8 parent;              /* -1 if none */
>         u8 flags;               /* See PD_* */
>  };
> --
> 2.34.1
>
