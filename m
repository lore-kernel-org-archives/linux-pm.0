Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C993BD64D
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556423; cv=pass; b=urN+xInF8I7BN9jnlzVA8k44beA1jCXA7Cr/7cZxMmUMsqdkVtytZmJ6qi5MV3SdMznLauRpPSZf4KVckb26u4MyxlRuphRel232GorvHqDww/0fXyb9CwdlX8MlUlHI9jzuzWgdxRlDl5H5cZZVHhdM8YXGU4JgfGakglfKSf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556423; c=relaxed/simple;
	bh=NZeBJC9QSEBrvBodfj4dor8expShVcP7Yt9IwugqSeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cICngEPPOTVAQ3YmnH+phaJ2YKJa4R2oArHi9DLYEZDQ+Ldg9xSDZKwqcZYogEOvzv50ZYtJwO7rG7RghTsHL31Wd7eIqgKd6aFty/1j5zYxXRIeWTRJlwWNVCAr1MiBwY3D223wWe4h2rhFvk0Q+ACiVx5NkhCKmHF8AyZ3Zu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ahi9aH3/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jNTK//UV; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ahi9aH3/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jNTK//UV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DKcq82408328
	for <linux-pm@vger.kernel.org>; Fri, 9 Oct 2026 14:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vp36po/cz04TMtA4qWYnSTEK6SQr6l93s1NVoQTANc4=; b=ahi9aH3/VFaXEAr5
	8I2va2ktkJ+UNgIhUkf332tEbBGJGMS3n3T9vHBLzRGvj47hq5PjQO8vWDr4n54u
	qbe711kjDwiLaPSdYyO2MYgQteioYq6WvMvHAvra/xOV+P7e1mua5dqaz9Hf1nNi
	oGx3Ej5UtMdt6+R9RbBcHGEjY+157e4ozXPU2lznlMFpRyVaeOTOKgYTxWmn8dvS
	dmqkK/Ds7+63M8r+JHAhUtMjWGvx1JH7lTj0SiPeV+e0Qx+S1abEE17qoBBnVUcx
	92vY68O56UVYbPAQHDSbiRirux34GWUoJ3SKQI+tCe2188ovFRyVEA20IzPA4G6g
	8sQK4w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvc9et-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 14:33:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e61a8eb087so39147805ad.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791556420; cv=none;
        d=google.com; s=arc-20260327;
        b=SjliUUDWIaLbii3LhH19ojarZ689jWcxwbIAR5R1CILq166b2uWpOks5DQfTQkH8vS
         ZDf//OGs61i0HXwbPxWNyaPPuUXjF+QlmtaRxGtPpTRFyHSKXI4+LhtHkJC+z2Bs7pZ0
         KVDnH5cUkTI5/vovCbmID7N11rEXcs76CoBSUlosJMqZWid35JoWJEpOoKdU/cfNd6Ez
         f1I2I0fEUnssKiJcJBnpgGYjgNtN1D9z4TVWNX5kyACgp1DrOSUrEjGstuP+NCA3dtpR
         1Q8v18y7IixQ7CjBMblEOKm0mR0e7tabnrWLji9olHbajOhTUdiYybCMmaUcG4W10DGc
         FOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vp36po/cz04TMtA4qWYnSTEK6SQr6l93s1NVoQTANc4=;
        fh=30+88CPh8gDJ/XUJISR1ytU9WT1kHTPexjbFzX5hoT4=;
        b=HlBMQifZvF3AM42f7ryURym189WQbONemZCdvOZUyfJNWTKKHjfv/426m5Ai5kb4n+
         k/mhW5YeOX4S+U/Le6wcsUlZd76t8GTpjHmFQzovPRNHu9w84lSe25E8CobB8UQsU7Ei
         fm8ufUf4xxj2bCVCbxmALOu0UESJvLqW6dg/dmRwlZ21HaSXaBC6IHYQO8UPFIKjc+4d
         K61LhfAZdkYr/a6ootnLLEmsARWqnoGyg2Xhs+/qw92s+pVVcukhc231u5lbkjCWQsB/
         WL9Tmtet1EKd4CEwzPXpShY8b4Vo82SArb0BkWjgwNVk+0qr2eDyEtreSlXqD/aMxQbg
         HfgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791556420; x=1792161220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vp36po/cz04TMtA4qWYnSTEK6SQr6l93s1NVoQTANc4=;
        b=jNTK//UVVpZ/DQt63VOJOQ8lFgOLzRYVpXK07yflZ3yhKQURtpBVXTUS9oO0bLoz1V
         GwNQITh9qVwqgK7oJaXwnP8KV3wjmp5f5oR5+Sc78hK3HLnUhv3FVWjW//irY1Dln7yz
         nymE6aHc3jjogZqJ3ddpesHtLplF65hYs1GF0/KVGda02couMBJKxDi2midYtNKapKLx
         owEgVr319bhI1T/4toaIEKVnpi8wiZ4WO393BSdOpDGRd+iFK2Nk6awmkSAJkDsSJgpg
         GDXW204IEcwiYQaK44vK0yLXLSa+Jb+1ADnw8CpB4acvRNrCrR0urREmZhZU8g+8IzJc
         PzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556420; x=1792161220;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vp36po/cz04TMtA4qWYnSTEK6SQr6l93s1NVoQTANc4=;
        b=1BrG+LOOL0sc8gPoS1y41Kb30HNt0C8+MpetMxhWYypYDeAuxg+7BYlN4FvITp/7qD
         fDjLzQHLHyeELFtluNZcPclytjXa/iVUvSVXq/3mk1sNk2LyOJLueaNqnY2+FtCsFHjP
         ZCj+vKUcnOuoj8sR3gvY6TOAwaeNpA491UySjsFwGFRn1zSxuIIFJ9pVTfcEJRzUz9PT
         TIXScbqnGYUFScJ44WB07v+PGPZ7CoT0jTayjaEtOKWYRmZdXg9bbQF2SRmsOvTFfbmo
         oFItwpROk692Lm7aH60DkA8FzgqpjYTLAj7E8dSM+vaCSCau9mfsY6XGYmW38Gw1q//T
         dayQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWHhUrcqev0XB3gbUxdo9K6KdxHLB39AXBNH7jxEtk32I6NYBy1c2aya0kpoIeb54gESXC147b0g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJiqsidFOci8tpR2qzfuAMVAhhzKtOLpsEJYGJglZ+V2CN+mCNn
	CelA7RnJbo3kFiVcNI3IT4GymfQSwuKbJSRAzjDDp6Va4oZQ5Z24ShfH9tndbINXyN3sctvCgGR
	3EXRlGCwOsv/x1PsZcSV3MqcCfDQ9fFSWHZbECIpd/6HikrEgKI11k57bYKAEJxMHOHLfkeP2iU
	MxAASX62M40nu7NH2aZHHZKED6NoLKwFrgsmrO
X-Gm-Gg: AYBFou1KWb7f6adDAOMVdWa714z0PLnzj84cL/cTESh84rlShzhRmA/6+djQFGk0+ul
	THoAkByQm4TSa198CsoiB3Fx57qyHnOtGBL9U5KWdgjSTo+3yQU4UgVALWPyrRXwSJsl2Eo+I9T
	EOJGtR/fzewEFNdlwEk87NbbosZIENy888/+nyummNRUIqHU7azOV6++iTLw==
X-Received: by 2002:a17:903:2f92:b0:2e5:98d7:8202 with SMTP id d9443c01a7336-2e842cd44b8mr19505915ad.13.1791556419671;
        Fri, 09 Oct 2026 07:33:39 -0700 (PDT)
X-Received: by 2002:a17:903:2f92:b0:2e5:98d7:8202 with SMTP id
 d9443c01a7336-2e842cd44b8mr19505565ad.13.1791556419166; Fri, 09 Oct 2026
 07:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-0-5eb1b90bc35e@kernel.org>
In-Reply-To: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-0-5eb1b90bc35e@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 16:33:28 +0200
X-Gm-Features: AclHuK8BLLsnCLnhdwop9PNp8hP17bfQmxcAxbY57H8p7JbbxjDD7-48aE_iQho
Message-ID: <CAPx+jO9BiY=v=BQ20qjgmq6SJ99NK7krTHTMdGcTfR_dshodJA@mail.gmail.com>
Subject: Re: [PATCH 0/3] pmdomain: Basic DT defines for ux500 power domains
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 2LdxRR1PHqa5dtwaKq1Ii5NuTMKfeJqx
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8fb44 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=XH1a5p_xQohBom4lpSYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NyBTYWx0ZWRfX8DM26SKwjKFH
 fsjwZ0EmHwPDZt+0tP/+QbIB9wVdGNl8+GCSXaH4Zl9DwUsCDouEo6iHOk8LfGCgeeM3K/txOyj
 wki1fAGo4DuFvcMBuHJS2FJ12LPPrK5DhysdMmWmrz5aFD5YWnkijbAsEOG0G07vEfxLEYxcNIC
 tyXIZiu5VYeD6GKUhyRq4peWYH6Jr2hPC2BAPeUOR+7k9nfzBPsavctskLG5i3C/dsRAHxbJ+XI
 91sBbit/t9pjDFfy9GRPwzZRRefYKUWticke7OR5A9s/nZcQLi8mK/uKx1FDrPe+ym5ByqqfF7+
 pkW6dZIYuNFts1EFzd+7oYIpbdU/36PdRjRmGpgrioSdjmhI0nUtF8I4vbrwpMZSInXc5U3hKSX
 cKKJgVDVVB/6z37Ies4/6qHVkeLdgJ6qxz0YDr768jOWKVact3WztV5LT+mzJ+vn2B4ednJB1P5
 2tUweq5N57z83Gqwx3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NyBTYWx0ZWRfX/xNPaSwFzbJ0
 uOFV3O1/L15h2z5Xrb+FzKpQyxDSBUVFvjymppLytwK2xqehS2WdtiwrB32VnDhglCSHv/N1bcc
 WEky4Uz6Y4oFmDD62PNjhXIM2FUrllc=
X-Proofpoint-GUID: 2LdxRR1PHqa5dtwaKq1Ii5NuTMKfeJqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090057

On Fri, Oct 9, 2026 at 2:15=E2=80=AFPM Linus Walleij <linusw@kernel.org> wr=
ote:
>
> This is three preparatory patches for v7.4.
>
> These three are an excerpt from the earlier sent series,
> updated according to comments and collecting ACKs.
>
> It also fixes an urgent dependency (my bad).
>
> The main ux500 power domain rework is targeted for v7.5.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Linus Walleij (3):
>       dt-bindings: power: Convert Ux500 PM domains to schema
>       dt-bindings: arm: ux500: Drop NR_DOMAINS
>       dt-bindings: arm: Add the actual power domains on U8500
>
>  .../devicetree/bindings/arm/ux500/power_domain.txt | 35 ----------------=
--
>  .../power/stericsson,ux500-pm-domains.yaml         | 41 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  drivers/pmdomain/st/ste-ux500-pm-domain.c          |  2 ++
>  include/dt-bindings/arm/ux500_pm_domains.h         | 17 +++++++--
>  5 files changed, 59 insertions(+), 37 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20261009-ux500-power-domains-v7-3-rc1-redux-acdf755a5efc
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>

Applied for next, thanks!

Note that these changes are also available on the immutable "dt" branch.

Kind regards
Uffe
