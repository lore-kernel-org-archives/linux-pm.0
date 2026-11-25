Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795611072;
	b=hrXNxYRSzGbTpbKim+3kuIzDHn3MryXmJUzAvCRvw6h12wiRmx1GEa7gWIOfru0Bt6z2
	 GkTkfT7fwqK8nogJfw9I94uVDa22D7VbwmrN73zjEMznGOu+ZMSG4hIX8k9/pbjlWTpY2
	 8OE0Gdb5A36MgySDWZnoWhFNg+g0SY9lJGq1GgvxasWCUIbzRoYs8+MubccqfYIdk/art
	 DCRXu7fnXjiqBTC6QC0CFXT0X98LN4kAy70S92z9ur31hKHdUptNVlDcP7YyARmFyTu9Y
	 P0OSDVGVunUUdw2mjyca+nPFqUda8ndG7zhUkwj4+q+bg4+zPItKx7/KUATEm9CmPog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wwgE5NxSVgc2t8KsjjDCtOGzZc3dNj9wJ/WoGnzRYb0=;
	b=t641rYBuEfkBO+cJR+cDUMzjMQRrOaevGSROE6S80bpk/cTIz/sK8s0wgINLB00u+z7Q
	 d3UHBm4ykkC1Th5g9Se73i9wPy7IhBizPplxmJb+eiTXt5JMqZPLTey2WWklYgKiha5B5
	 GLMmmCH1vd+RzR1UcR+UHr7iAgLYZpsDMMiYBYKVQcWBc7wyqGynIlt7KHaj+QNaSaQ82
	 yOPZxLnFwAk+76elx3ET4zyNFqCfVub9q3o6oB/zb96emgvrsUqAhi+8TkZ8z1saSU4hF
	 yKo8T0qZ8k3YpfQ9vgpB4U5jxuHYDhq6fqobOKUyS2UbF+W9/2/Ek7ERLNjnqr59z9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m8fhfeow;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cwVqb0TO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16027606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16027606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m8fhfeow;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cwVqb0TO
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nkFa1505215
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wwgE5NxSVgc2t8KsjjDCtOGzZc3dNj9wJ/WoGnzRYb0=; b=m8fhfeowqm1VRive
	6iqLBc3fp0UEL3CNDc5RPFXmdka52wMUKFc/3OSA0g5KRUiufW0tSnlQHLfmD5/y
	8YxO0fG7xTh4jsEfs4Bc6jRm5b4tzITYWtahBLLD7Sy4mC4/i2Wu0SQIjc/P3RAX
	J9lwCmi/BDEy3+FrWhjX8SBAbRSn7P97h4R+WgGcYQ7gH3irnFer95RPE5r87n3m
	TG/gXydKAWol1NbCUQ+qDH2RixWId/M77EDrmnElWELPuz1lfvIdiUo0InjbTT1s
	/OKpCOIOKV6u3CW4DnXNCb/gxnVryCtHORw760pt0UtOhvLjdl8R8jTiWB7A/pd8
	2EGlDA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5qa2a8qr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:51:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso4386448a91.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 04:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795611069; cv=none;
        d=google.com; s=arc-20260327;
        b=e1fGmAQwVqiZI9xdz+5iu1IvZF9yiqr4/2XgbO3e9/wUfIzuvFLg7VAicUrzK+LzB8
         Rq1u1mOzSn/e4PqxweiuPDaI/RD16D9Yhh4OUf9qE8pA8gpE1JXdnqqSMgMz+wQuNJjJ
         1NVSqHtPqafEoj8b89YPjei618V4v0VXaLtpxJ+x9Vj/k6ehDIe7AFqO81RFdbl+DEvl
         WWyN6rtCS25O4lKjZebKw+rFSawy7uQtRHAWfy+usQQxBVboomr9fgP37qLXTTWpgZMg
         vUtMCEaNPdQhej0yCCCRGiiK7C2UlKrXC26CEjL6EjhjKj2e1QoBuHSmeEF/fM9Yuy+G
         kHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wwgE5NxSVgc2t8KsjjDCtOGzZc3dNj9wJ/WoGnzRYb0=;
        fh=n7rRUOAkw5owWTelJXxUI8y1fywXF2lw0x8U8f2Y9AY=;
        b=VkTowoFigiJgHfGn1W/RvRbVhsmOwr6/wPIZYCJHULDcbDnHarvcHYyff+hMshILfu
         bIxbf12euf1RLdg/zxVHSOuJ4scH/ta/via4HFMtlGcaodknVHr9AjvmTuiN4lZUaZXs
         OXO3y/PbXnhy8vh05z2aKJRm6c4L8+xkIs7+dp+cX4ynF4aM9B1wMmtSDTf6DLcjFLRV
         mdPMjFMko20ZczqWFf1T981RzxeBep/5u2cHkEEiR8zmZof9/UUbJ4Ma8ZpnNksT+1UX
         pZIX+2Lr5C/enXlceUfLRtI2lFACNxRXReS2MPO2+mRFpgkeaQ6W6hTKz2J/+3atjLz6
         8RDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795611069; x=1796215869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wwgE5NxSVgc2t8KsjjDCtOGzZc3dNj9wJ/WoGnzRYb0=;
        b=cwVqb0TOimnVRbAPj8UW5b9gHmhZkGbKSy8R/UevUdqPxZhXj9aYir3kW7ZI+ymve+
         jHaKRdiYtlkT4MJzyItNV67TCJBCBj2FlpCUmDoWPXL/i2siQ5ttNCZSHhCL3fwvX4G+
         wriYp10P00tFjKjMnsyeXQS3bcOt+JXX11agRVf+qfUb6ShBT+RWAVDNlh5rhiyGc/zD
         CaNUjYg3+Al/6NQN4tkOH1x8K0w02D/U6FrMtnuEvJlfPyvW2ozkeeShTSTa13OwqEqP
         c1Jsfbh2y1fp2Gf0uoFxZw7UYilzdqieW4d/pQ6osVdXUoH6JaLno2SL1XRGn/73CHl6
         P6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611069; x=1796215869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wwgE5NxSVgc2t8KsjjDCtOGzZc3dNj9wJ/WoGnzRYb0=;
        b=xeWif+jdq9JncTC4Q7zDAO1Tn/P+ZKyvhz2/j1TsNxxpE5UancAO7/RNfrVHs3m4Mj
         at2f9BfW+LQD+eIoTUJn7d3n/H4VLZQTueCJouQJNmvK/4G7XKQjOYigj6osS/3pbwNK
         W77OPCmi0Ce9s0ZhwPPIlg6f+SGIfHXxMo5cobJXVmuic7txbXlDaictJbV/7byAC9Bq
         j7F1h4gz/76F1RcagUktrMTWc3nsMpEd0ix8esNp+Eae0ua/n5x7E4QsSv0W1yGEI/xH
         x1suCpIybzMzhgPvpnLnhwdKpLCY78Wz2gRpQRl4+V883eSAYLdLvXur0KxJSXA35NV8
         f3Tw==
X-Forwarded-Encrypted: i=1; AL+hErFb7ODKnZ6GNWe0UYNkD8rwbjXavfV8nUrqj2IuRxUvYjRvmkFyXXuTP0fNtDCPMqDGwUDN3cB6DA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QaXw5KT+/qyW8X/QQPLOPNS0s7mg5fb0QX3vonYy9gLshl6Ec
	OQkBDM4v0YWuVja1LVk6aF62QNF2IMXvjCRO3JsJESOYmwB49sZ2BFlrLhZgH0nlDwBohP3ylD4
	NXt04pS3CUVhOXe+qj2yvzCiGDWtwZejX0CLCrztx7jSC0BcIs1G3D4mzEhDNYGamK3GANhZKJ3
	FegjZWgDHDmqquKggJm+liBgyWs/60u+y6HVqT
X-Gm-Gg: AZFdTZczMiYXkEu+gvZx7QdkDmroAO8gWlehicPBm00XkfUI+n7QkR3tNOR0OUAJesN
	UOJrcN0c4bU6Hbwh1ERgRslUEusagdUOibfkWFyVd1OQ4707nXqRyGB1I3TQueKtCcHTJgGS7gn
	fPkaK76bDFPVlAiwRpsjNeriNLW2WuMjkSWflb0ALJvAeqRd3Uonpck0M1rA==
X-Received: by 2002:a17:90a:e705:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3b41c97ca8fmr15296805a91.52.1795611069044;
        Wed, 25 Nov 2026 04:51:09 -0800 (PST)
X-Received: by 2002:a17:90a:e705:b0:3a7:f4d:b23d with SMTP id
 98e67ed59e1d1-3b41c97ca8fmr15296773a91.52.1795611068408; Wed, 25 Nov 2026
 04:51:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-pm_attach_by_node-v1-1-4dbaccdf8b0e@ideasonboard.com>
In-Reply-To: <20261023-pm_attach_by_node-v1-1-4dbaccdf8b0e@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 13:50:56 +0100
X-Gm-Features: Aa3M54qcaVRFS_Ygi-rigReNxXenz2S9UHifcqrT7vrh9jD8bEBnZ2j2WNEsy2E
Message-ID: <CAPx+jO_FC1t_UaDfQDPOCy+V-Zdc1b5h5krrppGvYiW-LsD3LQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Add genpd_dev_pm_attach_by_node()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Devarsh Thakkar <devarsht@ti.com>, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: gBKWazku2swgAWyunSGkKIMPN3Sxr6OM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MSBTYWx0ZWRfX5c0X2lx8Xm3D
 WJwcLvefTZ55q+yHRf239T3qMj/S6GSojMDrgshjvaEEhb+2FVDYikDEsydeiBl6KOWVPIYo1RC
 y4OWIPlYD2lJVXqtQfk4SZ3XRDKmMHs=
X-Proofpoint-GUID: gBKWazku2swgAWyunSGkKIMPN3Sxr6OM
X-Authority-Analysis: v=2.4 cv=CKu/zhrD c=1 sm=1 tr=0 ts=6b06d9be cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8
 a=Ha9stk7DY33kt1UNLSAA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MSBTYWx0ZWRfX2T+MEy+WBqUB
 DMWCHyAXZ2SXchUW6UJ1tmQ7qYjOe2TvW7TYr9d5Z67ffdNmKUyuArUPCmUstV2tSIG3709q15s
 mdAe4n6Wzy2ffcvrim+fvKBBTqpCQhfyo0RCvyVy8JoRwjq0/hEmYj7GxlbSnusmIftNQjupD5x
 TMbpLYGfZK3JUypzg1lFkni0S1fY+20Mlm6xNieqMjLlqR/mK+ojp3TV5uKC6YwkMbeEqRQVvHO
 gW1pSGx+gJLiZtbHeWtxoeECrF3Xef2H8wL+LTWQuQmCiA52cJuBJOSlEgomOgweSCKsDoYc94t
 30vGy3dMlMF4kAza15d8j/m2N8nAg1Krn4ZOdy4zhNj3YKwKIR7C768lrAErBlY6kxaoOp7DokN
 P028UhuXMoUQgaOvwiF6mtrW8N61n8fN9/YZzDmNlR1FVuiJkznHN85jDDA4t1xMCniAxjTWsNd
 IgVsUB4yKIMnN5Nj1Uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250051

On Fri, Oct 23, 2026 at 8:17=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> genpd_dev_pm_attach_by_id() and genpd_dev_pm_attach_by_name() attach a
> virtual device to a PM domain listed in the OF node of the passed
> device.
>
> Some hardware blocks are described in a child node of a main device.
> They have no device of their own, but they do have a PM domain of their
> own. Neither function can attach that domain, as both parse only the OF
> node of the device.
>
> An example case is TI's display subsystem and its OLDI (LVDS)
> transmitters:
>
> dss@30200000 {
>     power-domains =3D <...>;
>
>     oldi-transmitters {
>         oldi@0 {
>             power-domains =3D <...>;
>         };
>
>         oldi@1 {
>             power-domains =3D <...>;
>         };
>     };
> };
>
> The OLDI TX blocks are not part of the DSS IP, but they are not quite
> real devices either as they don't have registers of their own, and are
> instead controlled via DSS registers.
>
> Add genpd_dev_pm_attach_by_node(), which is similar to
> genpd_dev_pm_attach_by_id() but instead of looking for the power-domains
> from the passed device's DT node, the DT node is passed explicitly. Also
> add a matching wrapper function dev_pm_domain_attach_by_node().
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> This is a new try for managing the OLDI power domains. Previously I
> tried using auxiliary device/driver for OLDIs, and handling the PDs the
> normal way:
>
> https://lore.kernel.org/all/20260529-beagley-ai-display-v3-12-7fefdc5d1ad=
f%40ideasonboard.com/
>
> Then I realized an issue, mentioned in
> Documentation/driver-api/driver-model/driver.rst: "-EPROBE_DEFER must
> not be returned if probe() has already created child devices".

I don't follow. How is this a problem? Why not create the child
devices at a later point?

>
> The PD virtual devices used in this patch's approach do not hit the
> issue as they don't get a driver, so they are not probed. The tidss
> driver's OLDI part can then use normal pm_runtime_get/put functions to
> manage the OLDI PDs.

Sorry, but this makes no sense to me. Considering the above statement
about -EPROBE_DEFER and child devices, it sounds like we need to
manage some kind of cleanup in both solutions, right?

Perhaps if you provide a user of dev_pm_domain_attach_by_node() this
becomes more clear.

Kind regards
Uffe

> ---
>  drivers/base/power/common.c | 27 +++++++++++++
>  drivers/pmdomain/core.c     | 97 +++++++++++++++++++++++++++++++++------=
------
>  include/linux/pm_domain.h   | 19 +++++++++
>  3 files changed, 117 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 9bef9248a705..a873541f9350 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -171,6 +171,33 @@ struct device *dev_pm_domain_attach_by_name(struct d=
evice *dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
>
> +/**
> + * dev_pm_domain_attach_by_node - Associate a device with a PM domain of=
 a DT
> + *                               node.
> + * @dev: The device that uses the PM domain.
> + * @np: The DT node with the PM domain.
> + * @index: The index of the PM domain in @np.
> + *
> + * Like dev_pm_domain_attach_by_id(), but the PM domain is looked up
> + * in @np instead of the OF node of @dev.
> + *
> + * Unlike dev_pm_domain_attach_by_id(), @dev may already be attached to =
a PM
> + * domain of its own. The driver controls the power to the PM domain thr=
ough
> + * runtime PM of the returned virtual device, or through a device link t=
o it.
> + *
> + * Returns the virtual created device when successfully attached to its =
PM
> + * domain, NULL in case @np has no PM domain at @index, else an ERR_PTR(=
).
> + * Note that, to detach the returned virtual device, the driver shall ca=
ll
> + * dev_pm_domain_detach() on it, typically during the remove phase.
> + */
> +struct device *dev_pm_domain_attach_by_node(struct device *dev,
> +                                           struct device_node *np,
> +                                           unsigned int index)
> +{
> +       return genpd_dev_pm_attach_by_node(dev, np, index);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_node);
> +
>  /**
>   * dev_pm_domain_attach_list - Associate a device with its PM domains.
>   * @dev: The device used to lookup the PM domains for.
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 052ec478dfcc..327fbd40c854 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3462,34 +3462,16 @@ int genpd_dev_pm_attach(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>
> -/**
> - * genpd_dev_pm_attach_by_id - Associate a device with one of its PM dom=
ains.
> - * @dev: The device used to lookup the PM domain.
> - * @index: The index of the PM domain.
> - *
> - * Parse device's OF node to find a PM domain specifier at the provided =
@index.
> - * If such is found, creates a virtual device and attaches it to the ret=
rieved
> - * pm_domain ops. To deal with detaching of the virtual device, the ->de=
tach()
> - * callback in the struct dev_pm_domain are assigned to genpd_dev_pm_det=
ach().
> - *
> - * Returns the created virtual device if successfully attached PM domain=
, NULL
> - * when the device don't need a PM domain, else an ERR_PTR() in case of
> - * failures. If a power-domain exists for the device, but cannot be foun=
d or
> - * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that the=
 device
> - * is not probed and to re-try again later.
> - */
> -struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> -                                        unsigned int index)
> +static struct device *genpd_dev_pm_attach_virt(struct device *dev,
> +                                              struct device_node *np,
> +                                              unsigned int index)
>  {
>         struct device *virt_dev;
>         int num_domains;
>         int ret;
>
> -       if (!dev->of_node)
> -               return NULL;
> -
>         /* Verify that the index is within a valid range. */
> -       num_domains =3D of_count_phandle_with_args(dev->of_node, "power-d=
omains",
> +       num_domains =3D of_count_phandle_with_args(np, "power-domains",
>                                                  "#power-domain-cells");
>         if (num_domains < 0 || index >=3D num_domains)
>                 return NULL;
> @@ -3502,10 +3484,14 @@ struct device *genpd_dev_pm_attach_by_id(struct d=
evice *dev,
>         if (!virt_dev)
>                 return ERR_PTR(-ENOMEM);
>
> -       dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
> +       if (np =3D=3D dev->of_node)
> +               dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev=
));
> +       else
> +               dev_set_name(virt_dev, "genpd:%u:%s:%pOFP", index,
> +                            dev_name(dev), np);
>         virt_dev->bus =3D &genpd_bus_type;
>         virt_dev->release =3D genpd_release_dev;
> -       virt_dev->of_node =3D of_node_get(dev->of_node);
> +       virt_dev->of_node =3D of_node_get(np);
>
>         ret =3D device_register(virt_dev);
>         if (ret) {
> @@ -3513,8 +3499,13 @@ struct device *genpd_dev_pm_attach_by_id(struct de=
vice *dev,
>                 return ERR_PTR(ret);
>         }
>
> -       /* Try to attach the device to the PM domain at the specified ind=
ex. */
> -       ret =3D __genpd_dev_pm_attach(virt_dev, dev, index, num_domains, =
false);
> +       /*
> +        * Try to attach the device to the PM domain at the specified ind=
ex.
> +        * Pass 0 as the num_domains when np !=3D dev->of_node, so that t=
he dev's
> +        * required OPPs are not used for the PD.
> +        */
> +       ret =3D __genpd_dev_pm_attach(virt_dev, dev, index,
> +                                   np =3D=3D dev->of_node ? num_domains =
: 0, false);
>         if (ret < 1) {
>                 device_unregister(virt_dev);
>                 return ret ? ERR_PTR(ret) : NULL;
> @@ -3525,8 +3516,62 @@ struct device *genpd_dev_pm_attach_by_id(struct de=
vice *dev,
>
>         return virt_dev;
>  }
> +
> +/**
> + * genpd_dev_pm_attach_by_id - Associate a device with one of its PM dom=
ains.
> + * @dev: The device used to lookup the PM domain.
> + * @index: The index of the PM domain.
> + *
> + * Parse device's OF node to find a PM domain specifier at the provided =
@index.
> + * If such is found, creates a virtual device and attaches it to the ret=
rieved
> + * pm_domain ops. To deal with detaching of the virtual device, the ->de=
tach()
> + * callback in the struct dev_pm_domain are assigned to genpd_dev_pm_det=
ach().
> + *
> + * Returns the created virtual device if successfully attached PM domain=
, NULL
> + * when the device don't need a PM domain, else an ERR_PTR() in case of
> + * failures. If a power-domain exists for the device, but cannot be foun=
d or
> + * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that the=
 device
> + * is not probed and to re-try again later.
> + */
> +struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> +                                        unsigned int index)
> +{
> +       if (!dev->of_node)
> +               return NULL;
> +
> +       return genpd_dev_pm_attach_virt(dev, dev->of_node, index);
> +}
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>
> +/**
> + * genpd_dev_pm_attach_by_node - Associate a device with a PM domain of =
a DT
> + *                              node.
> + * @dev: The device that uses the PM domain.
> + * @np: The DT node with the PM domain.
> + * @index: The index of the PM domain in @np.
> + *
> + * Like genpd_dev_pm_attach_by_id(), but the PM domain is looked up in
> + * @np instead of the OF node of @dev.
> + *
> + * The virtual device is named after @dev and @np. The required OPPs of =
@dev are
> + * not linked to the PM domain.
> + *
> + * Returns the created virtual device if successfully attached PM domain=
, NULL
> + * when @np has no PM domain at @index, else an ERR_PTR() in case of fai=
lures.
> + * If the PM domain exists, but cannot be found or turned on, then
> + * ERR_PTR(-EPROBE_DEFER) is returned.
> + */
> +struct device *genpd_dev_pm_attach_by_node(struct device *dev,
> +                                          struct device_node *np,
> +                                          unsigned int index)
> +{
> +       if (!np)
> +               return NULL;
> +
> +       return genpd_dev_pm_attach_virt(dev, np, index);
> +}
> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_node);
> +
>  /**
>   * genpd_dev_pm_attach_by_name - Associate a device with one of its PM d=
omains.
>   * @dev: The device used to lookup the PM domain.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f925614aebdb..c38c90d63c02 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -477,6 +477,9 @@ struct device *genpd_dev_pm_attach_by_id(struct devic=
e *dev,
>                                          unsigned int index);
>  struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>                                            const char *name);
> +struct device *genpd_dev_pm_attach_by_node(struct device *dev,
> +                                          struct device_node *np,
> +                                          unsigned int index);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>                                         struct generic_pm_domain *genpd)
> @@ -535,6 +538,13 @@ static inline struct device *genpd_dev_pm_attach_by_=
name(struct device *dev,
>         return NULL;
>  }
>
> +static inline struct device *genpd_dev_pm_attach_by_node(struct device *=
dev,
> +                                                        struct device_no=
de *np,
> +                                                        unsigned int ind=
ex)
> +{
> +       return NULL;
> +}
> +
>  static inline
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
> @@ -560,6 +570,9 @@ struct device *dev_pm_domain_attach_by_id(struct devi=
ce *dev,
>                                           unsigned int index);
>  struct device *dev_pm_domain_attach_by_name(struct device *dev,
>                                             const char *name);
> +struct device *dev_pm_domain_attach_by_node(struct device *dev,
> +                                           struct device_node *np,
> +                                           unsigned int index);
>  int dev_pm_domain_attach_list(struct device *dev,
>                               const struct dev_pm_domain_attach_data *dat=
a,
>                               struct dev_pm_domain_list **list);
> @@ -586,6 +599,12 @@ static inline struct device *dev_pm_domain_attach_by=
_name(struct device *dev,
>  {
>         return NULL;
>  }
> +static inline struct device *dev_pm_domain_attach_by_node(struct device =
*dev,
> +                                                         struct device_n=
ode *np,
> +                                                         unsigned int in=
dex)
> +{
> +       return NULL;
> +}
>  static inline int dev_pm_domain_attach_list(struct device *dev,
>                                 const struct dev_pm_domain_attach_data *d=
ata,
>                                 struct dev_pm_domain_list **list)
>
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261023-pm_attach_by_node-13788662f3a1
>
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>
