Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA853499F0D
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994486; cv=pass; b=kMN+r+HhZpsdcR6jyRoeLRtUbXVsv8XWrC5k3qHEMHVw06TioSeWD3l3nv4F6Jt7o3UH3zsBKXYUg7maTFkqRvrcHMSDE2ng6L6g/7TvE71FP0VE5T/SEg97rUg68wuLtCSzWRIoxiwEeFhzOTIfzmfD+dNz4MaWT5Fl1cxRagc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994486; c=relaxed/simple;
	bh=yQsBat8wrAi5mNmhyb+O3UWeqryDYjYvqsGCKicdWo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIt9WZkZVVA0PCWdAk58Cpf5MBC/hItOND+Kmsc6eqy38x+AUCbKlWN+FqAE5baN42SYEwsD6UaL/kOl9MHZonrXElmFXuXc2OjlFMoIy70fMWy0B1RfSlSyE3hhgkLM9RKJFTMWJCxWj9OxkOdp/zKAde8PtGzMICQrAcWJXz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ElvYsXrW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SWHwWue8; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ElvYsXrW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SWHwWue8"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdtxS2091243
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MCkUtZMQ71ULc4B874+EyT+6Pil1L5OznKSmBdpWeOQ=; b=ElvYsXrWBfG26UY6
	V2FjiXMbFsn2iyvAOqIpcKtWlHbfEpYrsN6TuG8RGba9ur7ykT+VMqKDB6YY5Rdu
	1RgTFl1vWgXfnbVkwWcxf8tyuw1JV8PUXYsoMkDE/AyYgLpnPTelKF9tb1jP4BXd
	mL0V9Es9ZkHSHoco2uWla/d3HWZV2M56jQLiizIyJhzsYWg772rzH4yYChe/lw0k
	iCNPyj3ISyHBL5ZKAB1+VNxtGfqh3bZeevfKNbdl9eYwXswY08YbDJK4NQlUzx7e
	JRgjm81AofSvqE3tFcngODmLTOTYmlzusB8VknB9JCHVqBUGByOZc18OzTDYHpF8
	08b3gQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3wtc99-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:41:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb48f41343aso3509893a12.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 05:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789994483; cv=none;
        d=google.com; s=arc-20260327;
        b=TvQrYmqqCVQ5DXQHwpAWgGQa1HSmdWMzAMpccwHnjvVY3AfuteHj/rZhOIQ2ZqItu8
         /6ncaeT7SYEwzapji2dKtFT1FicxTHZoz5GxHlHwvEw6i5RM+4khp9oT+RhLu2uWKkCV
         kkg8ZmuvTJTOLKbnNe3XMBMR+sBzWOmu6ZvrR9uKkdwINe/4YjtSEqqS8RNs6Hs0AZqd
         hFcxGiRXWGj5gPKYEUJhHe1oyeSb7n8e1GnjCwQyparl51lc2C9fm7pt8UkwecEefZ/E
         d4yUZGKZt05GdNW1ke7AULW5nO1t9zk9aVzbYhybUAV6P1KCDP2T4mxb4GK6nyrldzOa
         JxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MCkUtZMQ71ULc4B874+EyT+6Pil1L5OznKSmBdpWeOQ=;
        fh=ZpjLNx7uzHM7QWhm21Py9DF2KUYL39kyXyObJDE53BY=;
        b=FLXSgiQA+/H/r5xSt2dDGBQ/KigPyhp2I/HZBtRUb7CwIwvOemdsIU+eUBVFnWG4oA
         63aevsthyhVhVThbYPIbbzPG5rKmwMwjNE2vD1wYSkk1fTCY39oD/OZpZUii9gpvYcKu
         LOQcz15W49nt4SZh5ncR0n/c7ZPHtlw9tQ4D6FYQtZC7pH0yJYgCvXZq7yqNCBw+nLvj
         tEN6Lu88/dwLXR7sB9Avsn8toFcxgFuEizOPj80LrtOhDRzeQh9v4XhAD19i8ESbkbrN
         WPzvaOTnkng76iegULo2sfIy/2WeTMRExMOOmAGV9YzfhWH5repDZHA0sIwsRvHONt9z
         PXsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789994483; x=1790599283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MCkUtZMQ71ULc4B874+EyT+6Pil1L5OznKSmBdpWeOQ=;
        b=SWHwWue8QVL/zgtgUN57MuVHRVsugTmCh0OJqXgSQvQMUOE/3GOq0nTjN4fd0L8uQk
         ND18aweFvKcBe95BMd8p7AtBiqf2bK4oZBlnVFTBsiY2VfrN2fYPsikoI62LqSIsDLVR
         0uzmwCZsKj8KB6S9vTUEXUWEALqizxyEJrR5ozWcQGL5E0Ns6jI09Z+k1a6xMXCf4Nma
         vUBMJqC+IuZuaiz69Hhkbmf0CPW22JNOCZGd+eA2fCylMjR+U0pnToT49nUHPEAwnj7h
         CFPGZdfDfA8JkGSqDPiYQfjQLDogo4Zdog3ga0YqenjZOnaYy0CsmwnmpjrRCysppARC
         T7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789994483; x=1790599283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCkUtZMQ71ULc4B874+EyT+6Pil1L5OznKSmBdpWeOQ=;
        b=H74pCBa/V2/g7bipbTX+qesOtIibb9XRtdxICMzMKd+LXlTAOz99Rxvx1XEyrIaKFL
         VNC+RGvxHIpcudKE4+DevWg1LUuyqDs1Sa9aQVJU+x51qx2ZVcC0a9zlmfFgdc3vUzNw
         3ydkoSQRvgFSjk8rWhd5xgxNLLgwYFdH25o8Ewl1reG3IsH0XmaYCCMK0tvw/HiTJIv6
         g25lAKFP6SbJPF9BwCTY62tYCzdYITAvlM2gFRetzD34S94wQOwUjiNa20FWbsvJ4MAL
         s5qymlAyLswp1ganuLJ9rAlI4tN3/P6vyMFfVlomKGQFW2KjljlXO/aQq5DTTbsdyPAM
         SAcg==
X-Forwarded-Encrypted: i=1; AKwUvBwXJmJzgdEUrUa6QjGzidYHlZtMO4vR7oPtVrbf9nhbqeNgEs/Ig5RMgJ3XxyR8XLXcQqC7Qx8Oew==@vger.kernel.org
X-Gm-Message-State: AFuF++mbK5m9Lhrgnmbn/nusU5hx9vgxdwujg4JV069OxSe1qCi8P9ci
	yUrpncMEf28F8Ibmki6X1Gdnb9iD53qi9Bm1CVFSWaKMH22lCtLY8fYsR0ZnY7WEZ9ypPNnutmR
	/97QeEE26CXOjOikwSgm0xLBzipkWWz79N7f6f7/dDIHkzSGASao6GHQ1rHT4+/B360keRXMLnd
	InT2VbSc0QbO1kNPjgNxE+nE0F2GATmWhpa5YI
X-Gm-Gg: AYBFou24kfiRThXpF8yppZS+f7D2GwBDsfXXMhPIljrZrbH5v5iHy4eGofiZQ0BXLQ+
	64D/Ht6q92l26flb04I8coIidKbnb0Y3QTFlIdqY3ESM7rCT37vV5Ot7vCHxIdA8WMTmpjnjNMW
	pe9s6kzy8gq5w/C9ChFUew43w3IjJA3gEzscmHg9GelKwoPBDA4Rnkh4fZcw==
X-Received: by 2002:a05:6a20:728e:b0:3db:b3b:5343 with SMTP id adf61e73a8af0-3dd72553e40mr19632628637.12.1789994482618;
        Mon, 21 Sep 2026 05:41:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:728e:b0:3db:b3b:5343 with SMTP id
 adf61e73a8af0-3dd72553e40mr19632577637.12.1789994482080; Mon, 21 Sep 2026
 05:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com> <20260915104328.45901-10-gahing@gahingwoo.com>
In-Reply-To: <20260915104328.45901-10-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:41:09 +0200
X-Gm-Features: AcwNN1U_m4mjOUzjWYeAqWZntQVfxzbTcYRMim6iZjC6YeWC6g3-sc-ZIdGx-1E
Message-ID: <CAPx+jO--v8dHGCTMQrooxm7dLPDYbUHt4euWTud-GKK7efOuZA@mail.gmail.com>
Subject: Re: [PATCH v13 09/14] pmdomain: rockchip: add optional per-domain
 power-on settle delay
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfX/x/kd/Y7/0NS
 GpF6eQ/sfPUms0Ka5dHz0olsaTbwsLhoMMhSD8PbuyWf8dsBl9HGXikshTja4p8b/oOfladjelg
 sora8QFC5nX2et3rMqwGe/aveFXc+1GDKiZJVjGDsd7aBocEbdZmyzjDvtLKfW4X0YlIMA91vU8
 TbW13diAYaKrNF4zUvTfELwTaJ1EH78EpvAxtc/MLk4gS1I9kNxV53cmZPd1y0sy/5HcwG25jOq
 zXjsQl0anUV9FWHv0yXdJKOBAQg8zpFLDHg+pgBzHT5hGwNdTRhky19ccjrMZ7IoTIAYl8X7z52
 BaDTwps6LS5OC1QZLLI7tkhudMxweYIMICuW97k5ImDWIkUZ+V60mwlIp6D/2LixEB1JbfBzfHv
 ejSdDJcNK49+lpNJ52OiGJzyJyro7n3rX8otcYOQsbkWnFfvUvchdrrx4CdfMzPygOF0ioAJPVx
 wWa0YdHFYm/Ih7eyHjQ==
X-Proofpoint-ORIG-GUID: Q3l6ntKB8katoprgMaTzQTUsON_BbwpV
X-Proofpoint-GUID: Q3l6ntKB8katoprgMaTzQTUsON_BbwpV
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6ab125f3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8
 a=TQVB6zonJKZT9JHDKKgA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfX2XhjBgn+i3WY
 WK3ANa7Y+jVy0y+GC6nrSSOarfLPy5z33Xft965GvSd1uQBQ54vKgWZtKGXUbyroETnNw3Ocecm
 UgPhAKFN5V+9h39FISPe7HU83cybWzc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210182

On Tue, Sep 15, 2026 at 12:45=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> =
wrote:
>
> The RK3576 NPU domains need a short settle time after the idle request is
> released before the registers behind the domain answer. Without it the Qo=
S
> writes that rockchip_pmu_restore_qos() issues land while the domain is
> still coming up, and the NPU throws an async SError on the first cold
> power-on.
>
> Give rockchip_domain_info an optional delay_us and wait for it between
> releasing idle and restoring QoS. Rename DOMAIN_M_O_R_G to
> DOMAIN_M_O_R_G_W for the settle delay it now carries; RK3576 is its only
> user, so the old spelling is not kept around.

To me, everything below in the commit message can just be dropped. The
above is clear enough.

>
> The suffix scheme does not survive this cleanly and it is worth saying so
> rather than leaving it for review. The letters name fields, but R already
> means two things in this family: DOMAIN_M_O_R takes r_status and r_offset
> AND a regulator under one R, while DOMAIN_M_R has no repair fields and it=
s
> R is the regulator. DOMAIN_M_O_R_G's R was the repair pair -- it did not
> set need_regulator at all -- so the paragraph below, which gives it one,
> adds a field the name does not mention. Naming it _W_R or _RG would be
> inventing a convention rather than following one. Say which you would
> rather have.
>
> While the macro is being rewritten, give it the regulator argument that
> DOMAIN_M_O_R and DOMAIN_M_R already take. Without .need_regulator set,
> rockchip_pd_regulator_enable() returns early for every RK3576 domain, so =
a
> domain-supply in the device tree is never looked up and never enabled. Ad=
d
> a DOMAIN_RK3576_R spelling that passes true and use it for RK3576_PD_NPU,
> which is the one RK3576 domain with a rail of its own; every other domain
> passes false and is unchanged.
>
> Two things beyond the delay, both worth saying out loud because neither i=
s
> what the subject describes.
>
> RK3576_PD_NPU also gets need_regulator here, which makes
> rockchip_pm_add_one_domain() call rockchip_pd_power(pd, false) at probe o=
n
> all thirteen in-tree rk3576 boards. Only rock-4d enables an NPU core, and
> it is the one that declares the supply, so on the other twelve ->power_on
> never runs and the regulator is never looked up at all. It is deliberate,
> and it is what the delay is for:
> without the domain being forced off at probe, a bootloader that leaves th=
e
> NPU powered means ->power_on is never called and neither the delay nor
> 10/14's reset pulse ever runs.
>
> This is not new behaviour in this driver. RK3588_PD_NPU has carried
> need_regulator since it was added and its req_mask is 0 exactly as this
> one's is, so rockchip_pd_power(pd, false) has been running at probe on ev=
ery
> rk3588 board, with rockchip_pmu_set_idle_request() returning immediately
> because there is no request to make. Of the forty-nine in-tree rk3588 boa=
rd
> files, twenty-one enable an NPU core and declare the supply, twenty-six d=
o
> not enable one at all so ->power_on never runs for them, and two enable i=
t
> with no supply: quartzpro64 and youyeetoo-yy3588 take the dummy regulator
> and the one line dev_warn from the regulator core today. The idle
> handshake lives in the child domains and on both SoCs they keep it:
> NPUTOP, NPU0 and NPU1 carry req and idle masks of their own.
>
> If that is too much for one patch, say so and it splits.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Other than the nitpick above, this looks good to me!

Kind regards
Uffe

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 56 ++++++++++++++++----------
>  1 file changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index ba66ae719..39988efd8 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_clk.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/mfd/syscon.h>
> @@ -59,6 +60,7 @@ struct rockchip_domain_info {
>         u32 pwr_offset;
>         u32 mem_offset;
>         u32 req_offset;
> +       u32 delay_us;
>  };
>
>  struct rockchip_pmu_info {
> @@ -185,7 +187,7 @@ struct rockchip_pmu {
>         .need_regulator =3D regulator,                    \
>  }
>
> -#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status,=
 r_status, r_offset, req, idle, ack, g_mask, wakeup)   \
> +#define DOMAIN_M_O_R_G_W(_name, p_offset, pwr, status, m_offset, m_statu=
s, r_status, r_offset, req, idle, ack, g_mask, delay, wakeup, regulator)   =
    \
>  {                                                      \
>         .name =3D _name,                                  \
>         .pwr_offset =3D p_offset,                         \
> @@ -200,8 +202,10 @@ struct rockchip_pmu {
>         .req_mask =3D (req),                              \
>         .idle_mask =3D (idle),                            \
>         .clk_ungate_mask =3D (g_mask),                    \
> +       .delay_us =3D (delay),                            \
>         .ack_mask =3D (ack),                              \
>         .active_wakeup =3D wakeup,                        \
> +       .need_regulator =3D regulator,                    \
>  }
>
>  #define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator=
)      \
> @@ -258,8 +262,11 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)               \
>         DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
>
> -#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, wakeup)      \
> -       DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status=
, r_offset, req, idle, idle, g_mask, wakeup)
> +#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, delay, wakeup)       \
> +       DOMAIN_M_O_R_G_W(name, p_offset, pwr, status, 0, r_status, r_stat=
us, r_offset, req, idle, idle, g_mask, delay, wakeup, false)
> +
> +#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset,=
 req, idle, g_mask, delay, wakeup)     \
> +       DOMAIN_M_O_R_G_W(name, p_offset, pwr, status, 0, r_status, r_stat=
us, r_offset, req, idle, idle, g_mask, delay, wakeup, true)
>
>  /*
>   * Dynamic Memory Controller may need to coordinate with us -- see
> @@ -681,6 +688,10 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>                 if (ret < 0)
>                         goto out;
>
> +               /* Some domains need to settle before the QoS registers a=
nswer. */
> +               if (pd->info->delay_us)
> +                       udelay(pd->info->delay_us);
> +
>                 rockchip_pmu_restore_qos(pd);
>         }
>
> @@ -1300,25 +1311,26 @@ static const struct rockchip_domain_info rk3568_p=
m_domains[] =3D {
>  };
>
>  static const struct rockchip_domain_info rk3576_pm_domains[] =3D {
> -       [RK3576_PD_NPU]         =3D DOMAIN_RK3576("npu",    0x0, BIT(0), =
 BIT(0), 0,       0x0, 0,       0,       0,       false),
> -       [RK3576_PD_NVM]         =3D DOMAIN_RK3576("nvm",    0x0, BIT(6), =
 0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  false),
> -       [RK3576_PD_SDGMAC]      =3D DOMAIN_RK3576("sdgmac", 0x0, BIT(7), =
 0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     false),
> -       [RK3576_PD_AUDIO]       =3D DOMAIN_RK3576("audio",  0x0, BIT(8), =
 0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  false),
> -       [RK3576_PD_PHP]         =3D DOMAIN_RK3576("php",    0x0, BIT(9), =
 0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), false),
> -       [RK3576_PD_SUBPHP]      =3D DOMAIN_RK3576("subphp", 0x0, BIT(10),=
 0,      BIT(10), 0x0, 0,       0,       0,       false),
> -       [RK3576_PD_VOP]         =3D DOMAIN_RK3576("vop",    0x0, BIT(11),=
 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
> -       [RK3576_PD_VO1]         =3D DOMAIN_RK3576("vo1",    0x0, BIT(14),=
 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
> -       [RK3576_PD_VO0]         =3D DOMAIN_RK3576("vo0",    0x0, BIT(15),=
 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
> -       [RK3576_PD_USB]         =3D DOMAIN_RK3576("usb",    0x4, BIT(0), =
 0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
> -       [RK3576_PD_VI]          =3D DOMAIN_RK3576("vi",     0x4, BIT(1), =
 0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
> -       [RK3576_PD_VEPU0]       =3D DOMAIN_RK3576("vepu0",  0x4, BIT(2), =
 0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
> -       [RK3576_PD_VEPU1]       =3D DOMAIN_RK3576("vepu1",  0x4, BIT(3), =
 0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
> -       [RK3576_PD_VDEC]        =3D DOMAIN_RK3576("vdec",   0x4, BIT(4), =
 0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
> -       [RK3576_PD_VPU]         =3D DOMAIN_RK3576("vpu",    0x4, BIT(5), =
 0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
> -       [RK3576_PD_NPUTOP]      =3D DOMAIN_RK3576("nputop", 0x4, BIT(6), =
 0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
> -       [RK3576_PD_NPU0]        =3D DOMAIN_RK3576("npu0",   0x4, BIT(7), =
 0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
> -       [RK3576_PD_NPU1]        =3D DOMAIN_RK3576("npu1",   0x4, BIT(8), =
 0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
> -       [RK3576_PD_GPU]         =3D DOMAIN_RK3576("gpu",    0x4, BIT(9), =
 0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
> +       /*                                            name    p_offset pw=
r      status  r_status r_offset req      idle     g_mask   delay wakeup */
> +       [RK3576_PD_NPU]         =3D DOMAIN_RK3576_R("npu",  0x0, BIT(0), =
 BIT(0), 0,       0x0, 0,       0,       0,       0,    false),
> +       [RK3576_PD_NVM]         =3D DOMAIN_RK3576("nvm",    0x0, BIT(6), =
 0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  0,    false),
> +       [RK3576_PD_SDGMAC]      =3D DOMAIN_RK3576("sdgmac", 0x0, BIT(7), =
 0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     0,    false),
> +       [RK3576_PD_AUDIO]       =3D DOMAIN_RK3576("audio",  0x0, BIT(8), =
 0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  0,    false),
> +       [RK3576_PD_PHP]         =3D DOMAIN_RK3576("php",    0x0, BIT(9), =
 0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), 0,    false),
> +       [RK3576_PD_SUBPHP]      =3D DOMAIN_RK3576("subphp", 0x0, BIT(10),=
 0,      BIT(10), 0x0, 0,       0,       0,       0,    false),
> +       [RK3576_PD_VOP]         =3D DOMAIN_RK3576("vop",    0x0, BIT(11),=
 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  0,    false),
> +       [RK3576_PD_VO1]         =3D DOMAIN_RK3576("vo1",    0x0, BIT(14),=
 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  0,    false),
> +       [RK3576_PD_VO0]         =3D DOMAIN_RK3576("vo0",    0x0, BIT(15),=
 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  0,    false),
> +       [RK3576_PD_USB]         =3D DOMAIN_RK3576("usb",    0x4, BIT(0), =
 0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  0,    true),
> +       [RK3576_PD_VI]          =3D DOMAIN_RK3576("vi",     0x4, BIT(1), =
 0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  0,    false),
> +       [RK3576_PD_VEPU0]       =3D DOMAIN_RK3576("vepu0",  0x4, BIT(2), =
 0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   0,    false),
> +       [RK3576_PD_VEPU1]       =3D DOMAIN_RK3576("vepu1",  0x4, BIT(3), =
 0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  0,    false),
> +       [RK3576_PD_VDEC]        =3D DOMAIN_RK3576("vdec",   0x4, BIT(4), =
 0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  0,    false),
> +       [RK3576_PD_VPU]         =3D DOMAIN_RK3576("vpu",    0x4, BIT(5), =
 0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  0,    false),
> +       [RK3576_PD_NPUTOP]      =3D DOMAIN_RK3576("nputop", 0x4, BIT(6), =
 0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    15,   false),
> +       [RK3576_PD_NPU0]        =3D DOMAIN_RK3576("npu0",   0x4, BIT(7), =
 0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    15,   false),
> +       [RK3576_PD_NPU1]        =3D DOMAIN_RK3576("npu1",   0x4, BIT(8), =
 0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    15,   false),
> +       [RK3576_PD_GPU]         =3D DOMAIN_RK3576("gpu",    0x4, BIT(9), =
 0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  0,    false),
>  };
>
>  static const struct rockchip_domain_info rk3588_pm_domains[] =3D {
> --
> 2.43.0
>
