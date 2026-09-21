Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EF41F342
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001191; cv=pass; b=VpgYn69ED7Aq9ngWXoFxw+ymsb9N5UtbjTy4eiJtBj/OXk0c0CBpaVukLUNNJfcNf3OZbWy6wcASUxADwxefI7JwNSkuIW3H/Scmn7O8aubR9SZRG8+Y/vakVyRI52R+1BYi97eShCsC+M6b1aUJE9HWVDHYPseSdsuQimgXKds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001191; c=relaxed/simple;
	bh=r7lm+CiC9wEa6BgamTUuhlEQwcuYZjSsoJngwi1iaKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0pc/A3U9bMmETn43ZQVk8I6CK3oaptkVZfMP07XbrqcGkbBG4S+ktziCL49YDmfzwONRTrHF87FJ/um68HhkNYkmGl/G+BeNAR6AC6NUIidPGjYt9fZOs5NgfJdywEvVj/R5FZL2wcPPMBERopBKPrz3sccmCCl9/iQyno0+Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PLjFj746; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iovYwHsb; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PLjFj746";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iovYwHsb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEGNcx1553091
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QGpMDXbC7yeJzKIVYaJ+2yrvGf7V4gzLzdPmK9D7H4=; b=PLjFj746DwgTYYE6
	F8bg6eKr3tc7fjVnCufAGwWSW6nQHnZFdphyiMUDaJ7Re7G1kv1cmBaC6KV+pHL7
	Q7mcAejuGclMvGvBA9DgSDpomiaB6RetrcIQLVd4P4GnCH60Sj0ycVyapOVBKylp
	8nIH77l40LqoNpMmTj9GhEZMZQbTKtPtYRnNqbENC8cowz3OQ5ZWcyLzj+Ih5Rrq
	Y4Mga/LHN9ltTgvPfJWUOngovFq1Ii6mRjdMrsvcBEoSktA6aCyuc89q3fzxXEAU
	P+0EF0l3m6MbIN5fJT/+Aplej+jfB1YgK0X/ie7LUULZAS0rQKaAOjxWIEJw/VN7
	j2F5IA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3csgts5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so2430385a12.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790001186; cv=none;
        d=google.com; s=arc-20260327;
        b=cgH8JHX0vj96+I7i+wisxqQdt/4yTFgnKYwCjEEPCshf3tAg7eEgXVt28tR8Ya7MPQ
         Oz+P6NtWGt/1tKib6aOYZe6iG8nnIGrCctWY/a45yhIsgw5t8yYQHwInwANu98ILHo+B
         Z8o0WULhWTvqAZ13sXCIAyHKgGwWlz7BZoYQGMx8h6+0noY+tmxtXVy5DrXZ98ujic2c
         XF6BhMivloQ8RsCZ0bjKJnKrsr4qNW18QXGi5YdRnkehMScE3oDEP7MIKUC2y+BozMmd
         sHd+2QOQmE26qCP4rPoJAiGFcQSUxSZ8pXkG+sisoabc7oban4dkOQGEdr6kbhsLsNBn
         4/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+QGpMDXbC7yeJzKIVYaJ+2yrvGf7V4gzLzdPmK9D7H4=;
        fh=48KI40MMQ0yG4sWIRQh5PNc1Wd4FDta97Um6utGmmuQ=;
        b=GSJqm+6B1NMiHNLitsfTu7TDY5jaXLGdGax4ZZB4CUpbFu6DPpqvEODWmQj6lZE0uh
         HRiqjcra41bpeuoT6b1Fi+vkYT8pGVZFv7255Nrn8b/y4qLaA3//ij6nIO1SAwWp91Xz
         qu25maLX+foe8ze6txtouI5hFOUgvN3a5CIUqG1H94aSF8zQbOw943ZN6jroc6DLBMMA
         1c8CkVR56jan/PnPUZ6eUyY1d/DmImyk5xFRgihQNGbhD/tO37Xgc4ELzjUTDWu8Evda
         fnVeenIn3JzsEsPm/6vknD5ljAPnjWdw2Y2FFKdXKQE9La8BSOZlzjpGoR7A0ZKNyDaN
         MFeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790001186; x=1790605986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+QGpMDXbC7yeJzKIVYaJ+2yrvGf7V4gzLzdPmK9D7H4=;
        b=iovYwHsbjChrOOHxhX6gz3yd4sRntriM8Q59Uwr9Us633zI1KdjQ5AEzkG8vDrX2OA
         clpvdycSOTv17JabfkxBbWuPd7XagYWAdmQrxZuR4cfYflymaSqPSHHvSfz79uqVT2Mx
         73gG60gdEkMZmaN5s0Mv5i/VmlS8eh/TczvQc/bOPQGQk0mnHqovm2qzgZHpIWZ6niXl
         X3WHvR6b0VjCXA96RoG4qeZ010cHr/9AAeOuALdDTat9YymVEvM5hl+L6dD2yM47jcK2
         HEDsFV6vCwMBSlddmfKv2YKXwwlTFBrnDjYn0B8f8HvPnbbWAC34DTyThcKso1KXnitb
         sJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001186; x=1790605986;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QGpMDXbC7yeJzKIVYaJ+2yrvGf7V4gzLzdPmK9D7H4=;
        b=Vc0WgDP8ev9pHyfecx4Y2LWiZ+T2q9G8bQ9cMqP9ji0vRLKRfHam8WLK5+5E5FRZKg
         pOq7lkkUuQdrziqvx8CuJqinvk3iZ1KTmi1wAlL6pmzuku4QgWfc2g85uPFrakJxHzCS
         AyWSe9XHfKnkN+xF6YbuR40N2BD6N11NG2bgvQ62frKB84xztdG6eL4Yb28DX8gqPwzV
         dBoXpSMi5Ehv4UQq4e5R5V4D1J+FJ5pE0dcxHNoa8uioZKzFPEBX4clHkgIJh4E7E60R
         jD8+g0sPWNtu5YcBOD2cubztpFGIvpvwT+Fkt48DIYBXCzjZibkBs+VU54Gxg7HLTX32
         rJjw==
X-Forwarded-Encrypted: i=1; AKwUvByQVjfcDHanYoh5mV9co3XVP4Ig7fa8EtbHeSdy88vYPvHGB4cqLhC24OE5kj4VbVozIyuWLlsL2g==@vger.kernel.org
X-Gm-Message-State: AFuF++nWel6Omdc2IZLWtXO8BtpTSVfvuoCQYlumWe5hxL7onWsLTtZU
	IZT1J4/zXpGa6mVHM1fPZo7aPAH2q8W1RvYzF9SUgSDbMl9PjRzXqa88ne36qTFoWqFFADdyVw6
	wJuK2welH36hqMvnj3BNW2WT25qanomBcyLWBY19cJWOHFO5muIgDD0HTz1eEWLT7kouWKwibYl
	FCop3iuYIbp07PfE/eU/kdHNBmK5HQi2E3XEYU
X-Gm-Gg: AYBFou09YYlkEy96Mg2qS6vf3airfYYzkWkYsng2F8vTF+IvpXS3xnfhxUQROgZdU1a
	cInrJxwQmgIyLG+hTvBW7RAjx4wikkQWaXHCnqufRIwA7jGUbwF0hBPWyla+KUySapSOjpHJk2T
	58ay6U5lWUNiOsATiRCPYuaBU5ZI8GY+MGfDZIhKeJZYhrV7jJ2oAMDAOrbA==
X-Received: by 2002:a05:6a20:6f90:b0:3dd:a195:dd5b with SMTP id adf61e73a8af0-3dda195e52dmr11030333637.61.1790001186033;
        Mon, 21 Sep 2026 07:33:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f90:b0:3dd:a195:dd5b with SMTP id
 adf61e73a8af0-3dda195e52dmr11030295637.61.1790001185527; Mon, 21 Sep 2026
 07:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fbe8b4a4d90f0b555285cfb4ed18b6a2afc38b74.1788436280.git.geert+renesas@glider.be>
In-Reply-To: <fbe8b4a4d90f0b555285cfb4ed18b6a2afc38b74.1788436280.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:32:53 +0200
X-Gm-Features: AcwNN1Wm7QptWrQP64KBLoWANiDzhteUPebkkzrS5dFRZNkLVpmRMtVpNjJdPcc
Message-ID: <CAPx+jO_N5oTL4CvU3NokCRK9QgKbxsEwHfz=JLUTi-rRGhStwA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: rcar: Make area arrays const
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX6Yzj4T2MZjHP
 4arjWXKzSmN9AjfWXmAofZ1ufq0uUF/6JDKBTmWYi7gPlKKG5ejs12lM8/RPDvVk+FDEX/OM/tf
 1HuBgB1rJo3aQUC/dq2aeN7Wt+d/nY0=
X-Proofpoint-GUID: yZe-y3C4yTrXPDfj7uUZ41m8pAaIHT7p
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab14025 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=H6JtXQTsj1a3jlPKj3wA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX8w5rvQARYhLg
 /NcgZej6cc+8rpI6varbrm5Wa/VW2KbO5+CmfB2vZK7Z6tN1gj1oHT8p5glv44XaPtEeXiINOj3
 MGglx0y8F++0bX0X3RYsc21CBdKpoKh8onmojwnhAzQ5sFWxXtsOH4MpYXKZDok40AyI4IIDLEt
 1X8lN4Bl8HmUeo0R0lv6r/SbfISgvIg8sD/jw0aYK3XClbp+jJxfKF1ZCU0K4/4SZmx6ptq+WnF
 5K8BtK25UDvTGIhPEx4iTuiGQnLaRwjh58DC5Jfhj37q+Fj54YpXytj6ip/umdQZSf3pT4V3LKN
 GHJQWQ3LCME8xjSuDt9hLTqd7GhtJjK2+exu37Ir0H/xzmHRYEwfnj20SjACKV419N91ykC40hB
 L4b6B9nBKiUCULqlYLd0rB2WIOUQPM2eI5thRUC6T7E8l1mgpkydMC0qJyCgXi2FXvyJJsV4CEu
 sMgGEyBLrl9itTZNI2Q==
X-Proofpoint-ORIG-GUID: yZe-y3C4yTrXPDfj7uUZ41m8pAaIHT7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210211

On Thu, Sep 3, 2026 at 1:57=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Arrays of rcar_sysc_area and rcar_gen4_sysc_area items can be const,
> unless they are modified by quirk handling.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/renesas/r8a7795-sysc.c  | 2 +-
>  drivers/pmdomain/renesas/r8a779a0-sysc.c | 2 +-
>  drivers/pmdomain/renesas/r8a779f0-sysc.c | 2 +-
>  drivers/pmdomain/renesas/r8a779g0-sysc.c | 2 +-
>  drivers/pmdomain/renesas/r8a779h0-sysc.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/renesas/r8a7795-sysc.c b/drivers/pmdomain/r=
enesas/r8a7795-sysc.c
> index cbe1ff0fc58393e4..2ed377b58846628d 100644
> --- a/drivers/pmdomain/renesas/r8a7795-sysc.c
> +++ b/drivers/pmdomain/renesas/r8a7795-sysc.c
> @@ -13,7 +13,7 @@
>
>  #include "rcar-sysc.h"
>
> -static struct rcar_sysc_area r8a7795_areas[] __initdata =3D {
> +static const struct rcar_sysc_area r8a7795_areas[] __initconst =3D {
>         { "always-on",      0, 0, R8A7795_PD_ALWAYS_ON, -1, PD_ALWAYS_ON =
},
>         { "ca57-scu",   0x1c0, 0, R8A7795_PD_CA57_SCU,  R8A7795_PD_ALWAYS=
_ON,
>           PD_SCU },
> diff --git a/drivers/pmdomain/renesas/r8a779a0-sysc.c b/drivers/pmdomain/=
renesas/r8a779a0-sysc.c
> index 54cdf250f7c2d143..5f84b8d56a3282a7 100644
> --- a/drivers/pmdomain/renesas/r8a779a0-sysc.c
> +++ b/drivers/pmdomain/renesas/r8a779a0-sysc.c
> @@ -11,7 +11,7 @@
>
>  #include "rcar-gen4-sysc.h"
>
> -static struct rcar_gen4_sysc_area r8a779a0_areas[] __initdata =3D {
> +static const struct rcar_gen4_sysc_area r8a779a0_areas[] __initconst =3D=
 {
>         { "always-on",  R8A779A0_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
>         { "a3e0",       R8A779A0_PD_A3E0, R8A779A0_PD_ALWAYS_ON, PD_SCU }=
,
>         { "a3e1",       R8A779A0_PD_A3E1, R8A779A0_PD_ALWAYS_ON, PD_SCU }=
,
> diff --git a/drivers/pmdomain/renesas/r8a779f0-sysc.c b/drivers/pmdomain/=
renesas/r8a779f0-sysc.c
> index 6ed13cd1cb249df5..d22cbc33a6048c9d 100644
> --- a/drivers/pmdomain/renesas/r8a779f0-sysc.c
> +++ b/drivers/pmdomain/renesas/r8a779f0-sysc.c
> @@ -11,7 +11,7 @@
>
>  #include "rcar-gen4-sysc.h"
>
> -static struct rcar_gen4_sysc_area r8a779f0_areas[] __initdata =3D {
> +static const struct rcar_gen4_sysc_area r8a779f0_areas[] __initconst =3D=
 {
>         { "always-on",  R8A779F0_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
>         { "a3e0",       R8A779F0_PD_A3E0, R8A779F0_PD_ALWAYS_ON, PD_SCU }=
,
>         { "a3e1",       R8A779F0_PD_A3E1, R8A779F0_PD_ALWAYS_ON, PD_SCU }=
,
> diff --git a/drivers/pmdomain/renesas/r8a779g0-sysc.c b/drivers/pmdomain/=
renesas/r8a779g0-sysc.c
> index 249cf43af45b6445..96d39a3ac46056af 100644
> --- a/drivers/pmdomain/renesas/r8a779g0-sysc.c
> +++ b/drivers/pmdomain/renesas/r8a779g0-sysc.c
> @@ -11,7 +11,7 @@
>
>  #include "rcar-gen4-sysc.h"
>
> -static struct rcar_gen4_sysc_area r8a779g0_areas[] __initdata =3D {
> +static const struct rcar_gen4_sysc_area r8a779g0_areas[] __initconst =3D=
 {
>         { "always-on",  R8A779G0_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
>         { "a3e0",       R8A779G0_PD_A3E0, R8A779G0_PD_ALWAYS_ON, PD_SCU }=
,
>         { "a2e0d0",     R8A779G0_PD_A2E0D0, R8A779G0_PD_A3E0, PD_SCU },
> diff --git a/drivers/pmdomain/renesas/r8a779h0-sysc.c b/drivers/pmdomain/=
renesas/r8a779h0-sysc.c
> index e13372cb80eea857..3775735854f29fab 100644
> --- a/drivers/pmdomain/renesas/r8a779h0-sysc.c
> +++ b/drivers/pmdomain/renesas/r8a779h0-sysc.c
> @@ -11,7 +11,7 @@
>
>  #include "rcar-gen4-sysc.h"
>
> -static struct rcar_gen4_sysc_area r8a779h0_areas[] __initdata =3D {
> +static const struct rcar_gen4_sysc_area r8a779h0_areas[] __initconst =3D=
 {
>         { "always-on",  R8A779H0_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
>         { "c4",         R8A779H0_PD_C4, R8A779H0_PD_ALWAYS_ON },
>         { "a2e0d0",     R8A779H0_PD_A2E0D0, R8A779H0_PD_C4, PD_SCU },
> --
> 2.43.0
>
