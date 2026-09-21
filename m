Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7B310779
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001217; cv=pass; b=fye/ClTavMxMrxRuTUWEj3Yv8Pcd5gjq6OX2NZfQezjh9oDZ2zWG6NebiTXkitGCi8mn8I0sYK4/YCD8SGYPRMCrJb8q9vpc1HW7/RZ5DY+Fj/Gs0SQaYd4NIMpfufO8sZN4TLT7tsI18QTX9mtYhIDjS46GUN8zdEIk6vflSE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001217; c=relaxed/simple;
	bh=DOLUHzyNbgypNt2Cb2gBz6juJ39hx7bJkNuPsJ+uwUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuGJie8zBF9eZvqOnXIpezNtA5eNzO6+rNbQHzQjLhax8RgkW1JGym2nQb0kqcO1VB4/b/oF8/ikrYqg9dWA0gWm+asqynUK4lAa0v/S6cVSEb+ytz84ShbS9J2kw+JWIs/b3eMrN/VXGG0HvEOvnN9b6b2C+RUYPVKp77aUs0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fz87+HYF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MQDJX3Zz; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fz87+HYF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MQDJX3Zz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEGgQJ2404379
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RN49HaPQGdrm1yb0dZkAMriqXQ6TCvsapV0/mYAPYOs=; b=Fz87+HYFeYV12a3m
	f+pMsxZZO/xAP7mGdkNmLg9WRgreu4SKgYlWEUyW1olZMk8HDHvixkPBy69Goewc
	SmTzNAm+yCwwXhxaFAD2ihOBXHTNFtfyPLpQMaRCbeOaAlRRusH1X5Nf9rf1RwXI
	Bl+YwLDLPPtw1e6wUWkCMPID4zX/jmT+bbKcVEAq6ktXjwOZHvCQ1hasqgUJy3bH
	EFAhd6vc/qo8ryuk++Iu8sJKR7wKR29WCcjsDK6QdqSC/Tmg/bsz2WRRQlzT/fUW
	JiqJLh7BqkVtrCIVES12YpVeTq+M+PFwGN//muv/Kcn2gBRMOEWbWZxvQ+/Y1A7a
	B7tCgg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3vav09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:33:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so2430733a12.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790001214; cv=none;
        d=google.com; s=arc-20260327;
        b=ay8VDC6NFursuSI6F3d12+HL1gXJFSCT8t60p0PP8MqXZZg9R8isQfdyFur+IqHCvb
         /5PlMV5Ot78RwV+ZIfE3iREkdA2fDjThklj2g8NGd88abem/ye8Yzf16vuXLs3aeRbjn
         oeinpsNJ94SKD5qOug5RTSEaNH0+kHi6ldm0NQ83v7tu9MceBMPKmHotflwo+UmTqvoC
         44Km9vuY1NX33CwtM69Sw2XaZoLrynSfPd3dqoElWNLPvG1tXXQM9lZh7qLwZn5F0T2y
         p/zngfxq+OoW425LG3yDZerDg1yLSwLieBZx97SRMHcb1xXxqXdcdKY9lkyTldU79qIQ
         iBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RN49HaPQGdrm1yb0dZkAMriqXQ6TCvsapV0/mYAPYOs=;
        fh=bDRmCPq28sLxdrVHdHk9+/ZBXC/1PXaQPRGysRGKLjc=;
        b=H0XABE2n/yBdksJEYCGKrpa3Mw0iF6KzKoU0TqJ3m++WwU3pmJcISGtDfo5Mk1ssCC
         EfIgSBP0AC6IJt/ZxI7r+GXzlqx5Bjtcg0IgNNZ4fcwNOwPcJOie1w0LY8yVcbAZLYxM
         PbwRdI+wTGBhmDi+SL4r7hkrmDz3WNAU14sZl/dAnX0+FL7+DZOWgeHqqCE/+pkxm1VS
         8T38nsZUtSR1iQs8SMxK2ygq63cHYKdqD+zOojqBK8RSrd3msiNX5UjbSpUUjLC73DGv
         nP9i1vUuJ7YPGVf3dFgFZqi9p8zuRHOcYTj5yYKBpImtKd/uuVX8Ep5ZED2XsCu2OIta
         S0XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790001214; x=1790606014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RN49HaPQGdrm1yb0dZkAMriqXQ6TCvsapV0/mYAPYOs=;
        b=MQDJX3Zz412DN6SA4vlD3OMTRXSoKpf+UQaACchxKl9nZKMCqV24AvBiEbkr6NAXYz
         2Z1L9I0DR6D2FEGAt4toK4AVURVj9n6yEMpZnUaUeTcMTTAm90iZyQvrFcIiHbLFtHQR
         vpoIjnIA25PWb31+b+On36rAmcXWl6wtvS5S59ZMKb4hPCDjPS6/yQFelTejW/mAF8US
         sozu6Kb+EZ79DKk3N5iEmv+I51Nk34doUvgFue5w9oMLwdYVXt3FJ3/pF1XI4ljWMvfj
         mh/1dato9bVjJtdLpTOgy3prN/OQj4CRY5Hqb7ql8G7cY3hFURaYpxY7r4waG7/RyAV8
         AouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001214; x=1790606014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RN49HaPQGdrm1yb0dZkAMriqXQ6TCvsapV0/mYAPYOs=;
        b=PlBZRP6beXD3G1R7G4qUQUdtUV4vca32yiDeFXFNX1nlEA3Vt0W4xjNDYswnuoHPQO
         0HmphUsCRPgk7r85mpd1Y9LPg7QkH6SZVBWNxCXVverq/KwSoWrmEjzmLLh2oI6GB+/j
         0pcIB7l0NAatnOjAKXPyQ8ntyhwQ0tCf1p6zb8Tu8UGKp4gAK3x5tVmgZyQtfUyNkHsl
         JQ2kSpINptc28LcPWHlnPr4k5yj1ca7Zjf4+pYgOGxGuQBu7GgG04GjdyhmAyPfREGb5
         M5NfZEVOPZMJA5c+okaxoL9eDggKwTa7qR7zBAYJpvXuxnHOFPXKyW5qTtPuDQhhEy71
         NLvQ==
X-Forwarded-Encrypted: i=1; AKwUvByr+JxkyTZ1DwFundqmon1yolIYpGHEB7lH8yHBdO3NfxOLg6KdxJWDpPQonnp37TTdzDoNqOkVOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kVkI8nhPP5HT7BoDEEqg+UvjQkfJ+sOqQtLBXSKEW52NBZBwzC
	op7PkyxQxgoGLTUff/CVS4szM55/tADQmk8Y7q8BipUrwEFg/HGrgGW7Yljfzm/XmqtnbxNZ618
	T/nRIDjdFmcbGFNef/6ySiKlYDnYeXfTCrsJmKzet8WekPBFrPSbO4RT4c6RXh9LtZ7aTKEqmtw
	UWiLsvCS7nAZonDURvzoCi6kP7SR53PMMVN3UI
X-Gm-Gg: AYBFou362+nXjkFQfigUHeFA7cnfO3/FBBf0M27qg8eD1d7Qq2XIjV8wSkrSejRuC1a
	5M/4boGEpBSCDO1KiYTvUERpkXDJlWYlb9s2EoiRT9XkEpjbkxLu5ltbIZ7SFQzbtijkqELNhk+
	pqRvbbmC2/jNFw5AcC08gE89ZYm2JLqTTA/24lNkurUDUzP3eDXy7xYYFfOg==
X-Received: by 2002:a05:6a20:6f91:b0:3dd:659e:5db2 with SMTP id adf61e73a8af0-3dd8c4413a7mr18266806637.16.1790001214388;
        Mon, 21 Sep 2026 07:33:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f91:b0:3dd:659e:5db2 with SMTP id
 adf61e73a8af0-3dd8c4413a7mr18266769637.16.1790001213920; Mon, 21 Sep 2026
 07:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86da16a61c58eb08419f7528237c124e519f0a72.1788791506.git.geert+renesas@glider.be>
In-Reply-To: <86da16a61c58eb08419f7528237c124e519f0a72.1788791506.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:33:22 +0200
X-Gm-Features: AcwNN1Wd_6jxzpMXptAMEPqNJszFTSpjB9lLwhY1vA5MxxJu1fMZtdoj5lA9YJg
Message-ID: <CAPx+jO8y2Yk1KwAey2nRsjjduGbvfy=rHqsToDHhvf9sfMMNag@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: r8a78000: Fix lockdep false positive
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Ytia1IYX c=1 sm=1 tr=0 ts=6ab1403f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ZwIrdqM33KZ6HQH4p9wA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: GEWy3c7pEiDUSde4ix79Fp_mR8b045Ei
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX+ZYKmahyVBDt
 h5KzmKOWxmTJrKA2aYvntoqMXUDwH+FPDX959mVXVABXEj2NXMowpz5C8kpgmxUJSBpzAyfnXHB
 NoofFqBjhxs1BXD22nKNOxw38QapLcc=
X-Proofpoint-GUID: GEWy3c7pEiDUSde4ix79Fp_mR8b045Ei
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX3ECizesbbL/+
 +XebdlIsbMhmkBNWQ5uSC4a1SMhyNe0WqiOnrDL/jTT+mQT2G9VjtE19obn92WnIx/9xFahxEMD
 0bf2ZqvwzJ1J5IAet3BKOvmye7bcI77IDcWdJbeTjSU5VQcVraASbFmThPF/kGbxEZlpHNdkMbM
 G9albILTv2lIeWFELk/VF2bGTTFZmBmdakiv30rQ3X1KMrDC5TIgy8bXsiwSFtn1eqamvwkoV0V
 XP+Z0zA+/CKkjhhJrTMjJDDTMMmkha2Jy9xiskrCuARDbvMppo3lHewQQ749ZvNXQOXtLUSuwgH
 ifpydCump5orFA9l6GAmfienpPE7KBHj7C7tUF6hRgqh4EPjzmmfy+/pT3yiHA0ZHpGJ6sph6Ol
 GJN8t/E9TzZxBEWVo71WI/GZn/AVyDJNvAM+P0wLaXXHlrK4frkfpStzpkVFqrIXR6CC43kJ/OK
 yNNE4RIr4S/xIa76Y5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210211

On Mon, Sep 7, 2026 at 4:32=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Lockdep reports a possible circular locking dependency when attaching
> devices to an MDLC PM domain:
>
>   - During creation of the singleton PM domain:
>       A. r8a78000_genpd_always_on_singleton() takes r8a78000_mdlc_lock,
>       B. pm_genpd_init() takes gpd_list_lock.
>
>   - During attachment of devices to PM domains:
>       A. pm_genpd_add_device() takes gpd_list_lock,
>       B. r8a78000_mdlc_attach_dev() takes r8a78000_mdlc_lock.
>
> As the former is done only once, before any devices are attached, such a
> AB-BA deadlock cannot really happen.  Fix this false positive by
> introducing a separate lock to protect the creation of the singleton
> domain.
>
> Fixes: 89e6a71b35703f10 ("pmdomain: renesas: Add R-Car X5H MDLC driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/renesas/r8a78000-mdlc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/=
renesas/r8a78000-mdlc.c
> index 2668fc2ac9cbd388..1fd71bb3da776eb1 100644
> --- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
> +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> @@ -45,8 +45,9 @@ struct r8a78000_mdlc_priv {
>  };
>
>  static struct generic_pm_domain *r8a78000_genpd_always_on;
> +
>  static HLIST_HEAD(r8a78000_mdlc_list);
> -static DEFINE_MUTEX(r8a78000_mdlc_lock);       /* protects the two above=
 */
> +static DEFINE_MUTEX(r8a78000_mdlc_lock);       /* protects the list abov=
e */
>
>  static struct generic_pm_domain *r8a78000_genpd_xlate(
>                         const struct of_phandle_args *spec, void *data)
> @@ -191,10 +192,11 @@ static void r8a78000_genpd_del_provider(void *data)
>
>  static int r8a78000_genpd_always_on_singleton(struct device *dev)
>  {
> +       static DEFINE_MUTEX(singleton_lock);
>         struct generic_pm_domain *genpd;
>         int ret;
>
> -       guard(mutex)(&r8a78000_mdlc_lock);
> +       guard(mutex)(&singleton_lock);
>
>         if (r8a78000_genpd_always_on)
>                 return 0;
> --
> 2.43.0
>
