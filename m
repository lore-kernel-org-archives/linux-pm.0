Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399549AA2E
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994785; cv=pass; b=PNNLGfGzvyUE6MG90FJovzdBD83cPvVKp4mxAWIIAb7l+7+ccza9p5tztWB/VIXQO9GIjGFgRYUKUOT9K/4krgOaRcw0eeOSeGSpHJwoDhh7H9qNojIH/34LDzOggTY0qar4P3PyDc6UF0UC6pE/5hcDWSmP8ag2VPG3fxlWlZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994785; c=relaxed/simple;
	bh=zhes51yOam9nrMY50t2XhGSjaWOq58zdOVkwQ6/JTTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcwFbFT9OCM6uyAqZCJmcrlNzNcvoSsemXvX9+D2g72mjqHaLcwHL/5ctz4+VVbz4pybtUgnEhTdk+DQK4YqBuuOJeVv9WYYBM6xErNN57xwydUUI0Ez7mwE9p3PCV/8jcSFGvn2/Iaff1rmasYWsoXBK56ju9KSLJE4S8+88xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDV/uRKt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GOEseVby; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDV/uRKt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GOEseVby"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdwDw1413940
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=; b=FDV/uRKtPIY5Te0O
	/bQLtP7WCvqplyZdNh/yoW+2tP/GxJRj2pu/B6Bsl0tycX9TtwpAkZ2N0+iOYQKl
	JoIpLSfJsY+e7FBiFpYhQMo6g3XgQhIwE1nJh3JJb9MfQWsyWEC67O1f35xHuyZX
	z9qj1VvujtNw6wroAqLSizpGFKgzMfc5UYFj9zFzgjqJMMEnIgx1EYa5V6PwjB2a
	eidrXvUd6D9+bsRQYXBngget4ljibpHdqFk+dqh8Azy7g4c/vHo0NXQIrO3go1Ax
	kN0Go5GB7uylS/SACc7SzmeISBCOdGJhbq82oCS0UvZ4gOSftSsIEswUdfChrIa7
	CyqGeQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d18hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:46:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso11207a12.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 05:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789994781; cv=none;
        d=google.com; s=arc-20260327;
        b=SEWGQQ59zK0uw9tjJBUx4tkRGDxtDc2W1aHsUYFQSChCCnJGKd2MiUuqOTeVuKSR/3
         l7GCsixP3ENlXtuE7oE68r6A+EtAC3jd/MncWBf7ocsEOomk55B70dWN+J3xmAT8Uo0a
         e7uLXG4uco78ybxGuvUBhj2i5zdP+JAUVi746c+r7T0rDBAXWDe5qWnXk3mQSg+g7nFI
         MfDNrG9bJWm3IpoUuDru7+jADchzlEnKUrJEB5ft5cuYO7SPCOysGhfbXwqLYch8ybeo
         2Y+EtOJ2COHKf/pdNIa/bc6peEbEjmVgN1R+b9yu3nSKAFnG9BYUYi0xA3/Iu4i0WDlq
         j4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=;
        fh=5LoNIjmxJzuK0StZqb9qxMC+uhgslV3LrRQl7FXb6Nw=;
        b=ih3FgnaiIZTDM3iaHT11ODIhtk9xN1C60TRXERDAe3Hb+JLHexfaw+2weqSF7Tpgwo
         nyE29C2UAYSzoWXivY33pJ0+fHXgmCe273s5rlwPYFgKbvEuuWaME8VtfTVckvNaPK9H
         TjTreehadDUIFtCxT/OWPoYBaxw8sQQfENE+mof7+CUP0o3dlphFbpVIdaLLYADr9ZJO
         x2VLyqzkNJWSj26CElc5pQLnPnkBNlEWhZlSAKolamE55bL+uM60nPf4mXlgZmH3QzlT
         gaMqrxYkl/eqzZ8s9ylubBT818WLMHalQe9+J6tppwDBpDy+E2mWQGKZb6wARx6dAqAo
         mLAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789994781; x=1790599581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=;
        b=GOEseVbyfZNt7wUgeRrqbxA/hDoOilk0zGgdb4pVahg5gGMpTFbVBkQ6JnWUH5UWu1
         VNZlH/kN/7KlOGMuMYeXHyt5RtR8eCUIPeiH/ddXTJuDxLFp7HIwzvXIdh8limPRjw/O
         njsFnBsRrSuW8CdY0UFknGapmraoPh3gDSuwtf25yY64LUzAxFNMz13V5ENSmpMOSTjh
         HFaXqeEBR3DMtwSJFvhT1Qh+k+kvQREycV3d4YcqmWEohMitjkZ+eMpLUiezdbK0sN+y
         +85YR0UTnfdkbW2N82ZeyA/QysuwSlbh9defJMIRL1ebAngAcwJDjar4r1HeWKtPFRlN
         OEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789994781; x=1790599581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGEBVkSl804Lbjet5Iqv9xkjaomkmKa7knvOOohRepM=;
        b=RUfUdQN3ERbsUUAtHPmNGOHi1Tu31YoYZ+oMgHV/UXRuVkDkTHFEWmNTQV8ceYqUqA
         Y5oqxA7MGy6OEWT9c/eUdmG7h9Dchd5OB3vk+aIOpJBLtbYMvyR1n4yE7tkSrqiGThbn
         RLObQQ4jmJUZNBtlcyETGy4/hplQjoTXJZeMmCyKkhVAHtYqk4S15yIAQFi6HSDcTZiw
         cuUQIsHyepIX1YQFUXrd4MiFI4AJIRPR/E1oxTkUAxvJ4YAOcW650U9/x8zR26PmKrVl
         y7+dMTP+RlI4fYyZJDtlOVHeI7bd6H5ZtPbIe7ZrpzcGPB0ZJNhtIry0AM+8FVPhPZjm
         6iFw==
X-Forwarded-Encrypted: i=1; AKwUvBzhl42KN5vXw5KTpTXMjpIRBIbmQgVnwK5FWf1mCMBnFEa9ZP+B9tWzVJ1yjSxILEu5rZiJGzdpvA==@vger.kernel.org
X-Gm-Message-State: AFuF++mkmuR7sn9XiR5NSatiNzZVptotXpC3fets1fmVPscJEuSZh9Dy
	HoNAY6HCJlVXnY3UEoLfiqYuLdAXNObL5sJOPKgC9SMvI+8VS8/0yyA2gI9vV/thfJSvYmYlxyD
	er0gPFK8FLaTLs3/0WDhabcd5RE4qunp3zJM/Sn/30cSLJ8QB1udxHw8T1+QGE6oSVNkh7U7SyN
	UF6LNJuAzljKzvt+iTSg5c9I8/8K83IPp3mXEJ
X-Gm-Gg: AYBFou2jr3xWf7PckBcvtZ+AuHndxDKfrl63PVL5QoOM6HCZXFXcCJVx27YlSgv4T7t
	RNfJU1PgMfVkAU0W11jCzyQzJPRj6iuAA/DQYpAralw+naTIj8l03njZhgrocF88N0f7NqaEYWV
	KI178YguM4pjMsqlFii9vpLXrTHhRGjM79y2pNdyJzFtU2ET5rkXWaekzkPg==
X-Received: by 2002:a05:6a21:6f87:b0:3dd:a197:edea with SMTP id adf61e73a8af0-3dda197f85emr11235060637.57.1789994780987;
        Mon, 21 Sep 2026 05:46:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f87:b0:3dd:a197:edea with SMTP id
 adf61e73a8af0-3dda197f85emr11235017637.57.1789994780421; Mon, 21 Sep 2026
 05:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com>
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:46:07 +0200
X-Gm-Features: AcwNN1X9mUUfG00OJyVIt6nOyuDWy2ZSHbWKT6BOlwyDwHXMMZbGC4tmToAM-O4
Message-ID: <CAPx+jO8EixqfXmrD8zkMkJe_B+2AATo=YNFJraAdE_O9X4KM-w@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
        p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
        royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
        sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
        u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
        diederik@cknow-tech.com, alchark@flipper.net,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: RCO33kGUvFK6mnEPuHcNVWnEBY6va2mN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NSBTYWx0ZWRfXy8+f4dkY05n7
 4N1iqXVJuunJc8dhD8IzaqnW1jZ3eCwBTK7/+kgK3Jh0cBxQMDXMBGPQKstFFncF0GaMD5vvc7w
 gWQT+mD79Yr0WyPinKwrsGeosszkK6U=
X-Proofpoint-GUID: RCO33kGUvFK6mnEPuHcNVWnEBY6va2mN
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab1271d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=9GNsruGHAAAA:8 a=uuLM8HNXhctW1a4qv2gA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NSBTYWx0ZWRfX344kIJHEPeC9
 JgjA3Qd8wM0gW155gWlYHB45TZI/LYC5LWukViDwjby/5eIacsMruYJFyK0jcAh+x1l9zLx2gf+
 vhG04BCrCz5fcCHT2Mswx+L5SL6Hc7iCKy+CfvovnATdg3GeGHEWJgjDcMzjehsuw0wRS67rdn1
 yMHDlxyEoGXJt2iiPgLnpp18rkcSbGVvDYG8b+yyxSkdkMhjwN0WmT4y9d4eGH37K9V2qgxVscE
 /H2c/gegOulNd3WwZGJ/OWxVGFlMPRu+dxrzT5OWgCQ2FX+LebA27msbC7DQHxtSL/YNIwtCcbb
 FGTl0fiM4w6o3onnFL9WLf8eGHsLLjmfHVpE1ahwLTkgcPDv3xpBKMVesq685EA5ulUX/5LXpH/
 sUwEZ3c7Si/5mQrmH3lGjQprSs2mQW8vxdZyd+XngArSHwlsMEQQUw2l92oAlAa+WLOuYCjUvJ3
 yHBCW7xq/dhw/NS1v5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210185

On Tue, Sep 15, 2026 at 12:43=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> =
wrote:
>
> This adds the RK3576 NPU to accel/rocket, which today supports RK3588
> only. The RK3576 carries two cores of the same RKNN block, wired up
> differently. Two extra convolution buffer clocks, two power domains per
> core, one reset where the RK3588 has two, no NPU SRAM rail, and a
> PC_TASK_CON that packs the task number into sixteen bits, not twelve.
>

[...]

> Igor Paunovic (1):
>   accel/rocket: request the core clocks by name
>
> Jiaxing Hu (13):
>   accel/rocket: take the completion register writes under job_lock
>   accel/rocket: wait for a running IRQ handler before resetting a core
>   accel/rocket: let the core suspend after a reset
>   accel/rocket: factor the completion tail out of the IRQ handler
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
>   pmdomain: rockchip: add optional per-domain power-on settle delay
>   pmdomain: rockchip: cycle optional power-domain resets on power-on
>   accel/rocket: select the per-core clock and reset counts from match
>     data
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
>   arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
>
>  .../bindings/iommu/rockchip,iommu.yaml        |  28 ++++
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  47 +++++-
>  .../power/rockchip,power-controller.yaml      |   8 +
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      |  22 +++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  86 +++++++++-
>  drivers/accel/rocket/rocket_core.c            |  32 +++-
>  drivers/accel/rocket/rocket_core.h            |  11 +-
>  drivers/accel/rocket/rocket_device.c          |   7 +-
>  drivers/accel/rocket/rocket_drv.c             |  42 ++++-
>  drivers/accel/rocket/rocket_drv.h             |   2 +
>  drivers/accel/rocket/rocket_job.c             | 151 +++++++++++++++---
>  drivers/pmdomain/rockchip/pm-domains.c        |  83 +++++++---
>  12 files changed, 456 insertions(+), 63 deletions(-)
>
>
> base-commit: 1a1de54f7369cd2b5bac0f265910e60ad3a6b4c3
> --
> 2.43.0
>

I assume it's fine for me to pick up patch7, 9 and 10 from this series
and funnel them via my pmdomain tree. If not, please let me know!

Kind regards
Uffe
