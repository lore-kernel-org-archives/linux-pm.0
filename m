Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794496812;
	b=EZbr7+otAkp/WnhwD1rzlgQ5M5fP/XThob+FNMt3pqmgl4dQ3uri/KI+fsQnZMGw1ILm
	 +GZeVQd/el7kuTOQhbHjbxGMvM0VYWVjShm2kO8Us0Hq3uUW+daDZDqJbsZpfyNUSarVT
	 HVRqzxxT0tGKFIEJZuD0N/6NglBbpjjemLuTweEDlSNjUGRhf6qLCQzphTDQ3gP14FLyR
	 ZkWYSXg5w4of8p4TzxhjOey/wgJi6bl8ohna5rfw1gErHrRnUhoyYCBr7T25QubBO3DNt
	 9k5tVgmBnbZXE6s72s3JWk5CBgBG7omiZiwln8pmARZNam/4w5duRuGKeOSvmqJr31A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496812;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+fIl7t38r6YFHA9TzOGRmGrOug9wzJn5bgunm8JUJBI=;
	b=zJeI8eoEkqTlqZnlwktIe1GoeZ81oY8VdtuE0TlIF2pWmRTuv+v0j3tZS62Ysqo+ffBz
	 38yc2uDxZhbFrcJJJtQxDYl6xguCSudKO+cdMhnzogyET3g7ry7m7uSaUOd6nh51VHHkx
	 Jby5/SRKBFvR60hePktnYwYq72PKS+EEz/EWZ3sSXJvkfMHcirRzoK3bq8ObC33o1NrQj
	 lCF9cOLVBaApnipkJpjicLHVFIO5pZMRgBjuYtugOcYJalcIWD+dPvLgzPNK+H8UDNt/z
	 ytp5XBbPYKW/Gl8tO/3u0z7nZXNSqEnQer0Zar6MUg6tTyCfeovHImcAgy0+utB7Qsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=isZAzEjw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HEBIKdIX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F060A382B
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 15:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618F060A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=isZAzEjw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HEBIKdIX
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9EW1J4092470
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 15:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+fIl7t38r6YFHA9TzOGRmGrOug9wzJn5bgunm8JUJBI=; b=isZAzEjwKumlixI0
	DrwYp7TSLWkN+oTpA9eciLdB3BssYhOhb9HwJJUnPhBVY01KxJ3eKN4hX2twziJZ
	x8P9jVovz/sKgkPv0rV1wlHtnkNplB7rO4NcSlV3LMffdwvPjNwzm6MV8LZP7gfh
	YfS8REewWUI44q74Z70Ezm03vlQj+dGd7hN/pjkyULkNAaONC0hAvr+6Oa0gLXaO
	S9RkwJaZxFyL8XF+0NPJW6/cvjbijKcxZd0kHVjRSFrE1RRLX58xv9aSUXkwbRPQ
	CdA61J0XbkRSTZGgDa1U7j7yN/6QmkunQwYPuk8FDnrETXWCYUstOLf2E6/YuDKS
	tivIWw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8ke8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 15:20:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b32efd7ec4so3955144b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794496811; cv=none;
        d=google.com; s=arc-20260327;
        b=eAcYZToW4PBgRy4IrjNB2U6JjFneVoWb5tvMf70PcRYnJ9HwYVxsTOdU4RVjZMRSCE
         iHmYLwGDkse0WYf+mAAJhNKafp6qWluYBelq26bzb64+8dcHPgsw5XJLdAsrs3shaULG
         8F3saK9aYor3qz+RK3GeiH6+uSgyh530GzFqYjA3ZFmfGIUKFhf8DY7hVONvKjNZM06J
         G3M//70uHaIm6vQnS6isqA2UyC9YP2NKisMmlQgaloVZCSVID0Q1YjOvViCqdzh7H1gB
         9jITG8VJaNlQvzqG4j2IJtaH4YCzQaEOCjPl2QP9WLlXnjM27DZ6G16bhCmMCa+doOcB
         5IiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+fIl7t38r6YFHA9TzOGRmGrOug9wzJn5bgunm8JUJBI=;
        fh=nad2CQs3z71dVYAEetWukNF289WLwaYDM5Ykga1XAeY=;
        b=RcKyMxw2tSUKqLD52cD87Mx/ZYis3mVq5esWHAjshZD+uZEKuSE64S4c5RwqYiExUm
         SvYDXTJVKIGB/9/OdovUhdcfXLLjjD75agTGYGMIuOCy4x6j8ojoBza7P8AOAoEIK8nk
         CmRvkNJOTrHdMlzf0rfjcKe+HTstwpa3o14Dl31/qfMCn/bT1eLLnFPe1oN0O7wQikQe
         YaVtgS6BDbgj+ZM3vAv/eJl0SHgncSfLRpig024nQMkXDoe/sKtPjT7iFT3m+sGO0pPW
         cqw1G6ENIJ/bdqNbJCuOmXJHjhUFj63w3yvIiyaxVILi7sXodivGMAYkuX/oqkPpDy9f
         6YJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794496811; x=1795101611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+fIl7t38r6YFHA9TzOGRmGrOug9wzJn5bgunm8JUJBI=;
        b=HEBIKdIX8KX3bAilyFQuoCxRjw1icH4H7U7tWESHcpuSiyPOMS6d3PLyXi5pXAVfxu
         /jQQGQpXj2k0/OZ23fMuei9a7yvXFjOsW8K2kD1xEIw6fI7M0GSdFk1mAbh/D5Emq9AW
         3eJapuxx8hvxjrVNTIfJEwf1zeK+sFv5sE7YOYVSSo8AefXo908dlYgLH2WRxXDo19oO
         DpXnQtfA4sC/qZUHWfw/bYIrU++0rUwwwGCtdN8ZK4yrU/UcxG7gbKzRrwrd0Sj2UsQw
         z1OPyXwMFrV2iEO6dwXPD9yLzISrROYCZn+owsKXnmc8MaKnhazZ7t6W7FhgebinJD3Z
         mhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496811; x=1795101611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+fIl7t38r6YFHA9TzOGRmGrOug9wzJn5bgunm8JUJBI=;
        b=JdswfJXyL1PMN6CgmwIE3N8YE9UJnPr4UPXNn6QiedXBjR1wuZ+E4sE2e60+1PocNE
         Rrqd3J2dlcDWHna0edXd/aThRaNgAO3p5mdPJfAQqs8rGkOOptnZTJx0eTF9yIQTwjEP
         4F1u1+m3nzGCRlpA9YiKN/M5FTm3Ka5ruQlBqqJmN9sJgUCUdGlyIcg2NGN1g3nsJ+Ub
         MhdkZvx27NX8Ku0XdKpmAMoopWxvm19SWWGRE8bFal7ZEvb8CNdoO6WzO5Th3cPNjS12
         KSN1NhnV310OpAsDt/gEIV0Se9Ri0kBocC9+HyhUokiAkALfmAFip9GPJPrj+O7E2+ZQ
         1pEw==
X-Forwarded-Encrypted: i=1; AL+hErHDeWx2f1QeaqmRYkvkJ/Uy+z19C1D0XTGpZCzXAMWNFLQRwRpljHDcCpU+P6VVGytdrsrFzZ6JIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+5dNbuiC/6ciqERiRcL2P3SEtmgjAmzi0bGEoacN7yVbx42/vX
	JNf6g91SDXNMoobwgFUBW0m3Ot1g74KeMbqvQadBKdDEQwlrVua9NhKTLO8ytA/lYempvVHWzLG
	Ea4lQRWUxoVei1vgtlKmnbLgwCWOCn+E/0UCVm5lYydvpyHYCz25hrK8RS0OhE7trILwGGxRRDC
	l0O7E3ETb5P7s931/YjRmc7UWDbf3pKnPxSUk/
X-Gm-Gg: AYBFou1NBc4Q5pDzeahVBvzs+Eow5yjbc3L6QfP3G/nnZ7frmLbw3Q9kyEXIzk7sMVY
	X0F4CUMVP9zhVzppQ8Fo11H4LIopmZQrMyO8xrOuI9sCPwFFhxURCXzUutYAXbkTctdG3SotbBn
	30sEPpl4Ly6pC7oUG4F9n3B/d8sqeYmjPSdWOgOLGfvB1HebnhqgDGwxH/oA==
X-Received: by 2002:a05:6a00:f8d:b0:886:3a6c:a9da with SMTP id d2e1a72fcca58-8bc1bcd60d1mr5466779b3a.26.1794496810692;
        Thu, 12 Nov 2026 07:20:10 -0800 (PST)
X-Received: by 2002:a05:6a00:f8d:b0:886:3a6c:a9da with SMTP id
 d2e1a72fcca58-8bc1bcd60d1mr5466739b3a.26.1794496810109; Thu, 12 Nov 2026
 07:20:10 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019092417.391522-1-leonard@lausen.nl> <20261019092417.391522-2-leonard@lausen.nl>
In-Reply-To: <20261019092417.391522-2-leonard@lausen.nl>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 16:19:58 +0100
X-Gm-Features: AclHuK9honMV6OwgXNyYrNEkyUm1bD_efoW1xKgxLOXh4P3goN8MpuuCosIlMxs
Message-ID: <CAPx+jO-9BqNgA1Nx2TiHX=BS6cJMmETepYsiujBCeeb3wPt1bQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: rockchip: Manage the RK3576 GPU domain supply
To: Leonard Lausen <leonard@lausen.nl>
Cc: ulfh@kernel.org, heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, detlev.casanova@collabora.com,
        finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
        inindev@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gahing@gahingwoo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2MSBTYWx0ZWRfX4XXTI0IwQvkG
 wBiquWMKB32df93Rp4BnrhgCe5nkkWtFo1E1qUxRivZEN1zPyWJ0103ymc8Uxi2iG3+XiNqZj+u
 p2Q8wNrwpwY6WMRr1TmxtojM4zSG6m0=
X-Proofpoint-GUID: tycS4pEfvZWH4Picb55gxlhk4QniLdfM
X-Proofpoint-ORIG-GUID: tycS4pEfvZWH4Picb55gxlhk4QniLdfM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2MSBTYWx0ZWRfX1g0TT8X+7ccF
 YBVS9DzfO+15io9iDm8ycDPxvmrdHuPUtsjbH+CYTRD8AEJM37J+gC7DkLwbceLygRbKQrUm33E
 NEIn6UdFWVK/CisEUN5q1yJDfW3cQBVqnECr5KrIu6PAtlqWRznwwEDWjEA+plUWtt5+MBwszGO
 ry9cIDYyymnUle1FomXGWMGgXz+GaTYQTAA5I+tPdC3K9Zi6y3P5C6JopMh0VXRdn6OeLgqOTGw
 ycXN6jB7j7Ubks6tcl4yliTlUV0V7e7RL1JmHUltv5WW4amqEuF6ZGqPS/rDQllIaV+0ytkNiof
 eH3KFTWfnqPp8wLZ18Z6yWyc8NVPOEA01+nbBQ0wWlhA8atztZfoBUemsX6ldMZgxNnTP/Xh4tI
 hXQIDu4zJmWMncWQiHh3nGCO23iwzyq7LD6pU6F1dfFeVDDR/8bNnVOBcAKx07PKV7RRJaXqelg
 6achzswHrdw/Cs6r85w==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af5d92b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=9GNsruGHAAAA:8 a=TNRU4YkNAAAA:8
 a=9z9mmZE1JoB7TLlessoA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=gf-oSkQAjqHFJRp-GQfY:22 a=T6RL-YpNOstmnv1gjOTq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120061

On Mon, Oct 19, 2026 at 11:24=E2=80=AFAM Leonard Lausen <leonard@lausen.nl>=
 wrote:
>
> On the NanoPi M5, boot hangs during Panfrost initialization. Before this
> fix, booting required blacklisting Panfrost on the kernel command line.
> Loading Panfrost after boot reports a GPU power-domain acknowledgment
> timeout:
>
>   failed to get ack on domain 'gpu', val=3D0x113ff
>
> Add regulator support to the RK3576 domain descriptors and mark the GPU
> domain as regulator-dependent. This lets the existing Rockchip
> power-domain regulator handling manage the GPU domain supply.
>
> A corresponding domain-supply property is needed in the board DT.
>
> The regulator-capable descriptors are based on the regulator support in
> Jiaxing Hu's pending RK3576 NPU enablement series, without its NPU settle
> delay changes.
>
> Link: https://lore.kernel.org/all/20260924102135.92217-10-gahing@gahingwo=
o.com/
> Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")
> Signed-off-by: Leonard Lausen <leonard@lausen.nl>

So this should be applied as a fix and tagged for stable kernels, right?

Kind regards
Uffe

>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index e193f978d5f35..b41f9fcb62bfe 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -176,41 +176,42 @@ struct rockchip_pmu {
>         .mem_offset =3D m_offset,                         \
>         .mem_status_mask =3D (m_status),                  \
>         .repair_status_mask =3D (r_status),               \
>         .req_offset =3D r_offset,                         \
>         .req_w_mask =3D (req) << 16,                      \
>         .req_mask =3D (req),                              \
>         .idle_mask =3D (idle),                            \
>         .ack_mask =3D (ack),                              \
>         .active_wakeup =3D wakeup,                        \
>         .need_regulator =3D regulator,                    \
>  }
>
> -#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status,=
 r_status, r_offset, req, idle, ack, g_mask, wakeup)   \
> +#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status,=
 r_status, r_offset, req, idle, ack, g_mask, wakeup, regulator)        \
>  {                                                      \
>         .name =3D _name,                                  \
>         .pwr_offset =3D p_offset,                         \
>         .pwr_w_mask =3D (pwr) << 16,                      \
>         .pwr_mask =3D (pwr),                              \
>         .status_mask =3D (status),                        \
>         .mem_offset =3D m_offset,                         \
>         .mem_status_mask =3D (m_status),                  \
>         .repair_status_mask =3D (r_status),               \
>         .req_offset =3D r_offset,                         \
>         .req_w_mask =3D (req) << 16,                      \
>         .req_mask =3D (req),                              \
>         .idle_mask =3D (idle),                            \
>         .clk_ungate_mask =3D (g_mask),                    \
>         .ack_mask =3D (ack),                              \
>         .active_wakeup =3D wakeup,                        \
> +       .need_regulator =3D regulator,                    \
>  }
>
>  #define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator=
)      \
>  {                                                      \
>         .name =3D _name,                          \
>         .pwr_w_mask =3D (pwr) << 16,                      \
>         .pwr_mask =3D (pwr),                              \
>         .status_mask =3D (status),                        \
>         .req_w_mask =3D (req) << 16,                      \
>         .req_mask =3D (req),                              \
>         .idle_mask =3D (idle),                            \
>         .ack_mask =3D (ack),                              \
> @@ -250,25 +251,28 @@ struct rockchip_pmu {
>         DOMAIN(name, pwr, status, req, req, req, wakeup)
>
>  #define DOMAIN_RK3528(name, pwr, req)          \
>         DOMAIN_M(name, pwr, pwr, req, req, req, false)
>
>  #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)             \
>         DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup,=
 false)
>
>  #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)               \
>         DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
>
>  #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, wakeup)      \
> -       DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status=
, r_offset, req, idle, idle, g_mask, wakeup)
> +       DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status=
, r_offset, req, idle, idle, g_mask, wakeup, false)
> +
> +#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset,=
 req, idle, g_mask, wakeup)    \
> +       DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status=
, r_offset, req, idle, idle, g_mask, wakeup, true)
>
>  /*
>   * Dynamic Memory Controller may need to coordinate with us -- see
>   * rockchip_pmu_block().
>   *
>   * dmc_pmu_mutex protects registration-time races, so DMC driver doesn't=
 try to
>   * block() while we're initializing the PMU.
>   */
>  static DEFINE_MUTEX(dmc_pmu_mutex);
>  static struct rockchip_pmu *dmc_pmu;
>
>  /*
> @@ -1323,25 +1327,25 @@ static const struct rockchip_domain_info rk3576_p=
m_domains[] =3D {
>         [RK3576_PD_VOP]         =3D DOMAIN_RK3576("vop",    0x0, BIT(11),=
 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
>         [RK3576_PD_VO1]         =3D DOMAIN_RK3576("vo1",    0x0, BIT(14),=
 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
>         [RK3576_PD_VO0]         =3D DOMAIN_RK3576("vo0",    0x0, BIT(15),=
 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
>         [RK3576_PD_USB]         =3D DOMAIN_RK3576("usb",    0x4, BIT(0), =
 0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
>         [RK3576_PD_VI]          =3D DOMAIN_RK3576("vi",     0x4, BIT(1), =
 0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
>         [RK3576_PD_VEPU0]       =3D DOMAIN_RK3576("vepu0",  0x4, BIT(2), =
 0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
>         [RK3576_PD_VEPU1]       =3D DOMAIN_RK3576("vepu1",  0x4, BIT(3), =
 0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
>         [RK3576_PD_VDEC]        =3D DOMAIN_RK3576("vdec",   0x4, BIT(4), =
 0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
>         [RK3576_PD_VPU]         =3D DOMAIN_RK3576("vpu",    0x4, BIT(5), =
 0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
>         [RK3576_PD_NPUTOP]      =3D DOMAIN_RK3576("nputop", 0x4, BIT(6), =
 0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
>         [RK3576_PD_NPU0]        =3D DOMAIN_RK3576("npu0",   0x4, BIT(7), =
 0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
>         [RK3576_PD_NPU1]        =3D DOMAIN_RK3576("npu1",   0x4, BIT(8), =
 0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
> -       [RK3576_PD_GPU]         =3D DOMAIN_RK3576("gpu",    0x4, BIT(9), =
 0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
> +       [RK3576_PD_GPU]         =3D DOMAIN_RK3576_R("gpu",  0x4, BIT(9), =
 0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
>  };
>
>  static const struct rockchip_domain_info rk3588_pm_domains[] =3D {
>         [RK3588_PD_GPU]         =3D DOMAIN_RK3588("gpu",     0x0, BIT(0),=
  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
>         [RK3588_PD_NPU]         =3D DOMAIN_RK3588("npu",     0x0, BIT(1),=
  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false, true),
>         [RK3588_PD_VCODEC]      =3D DOMAIN_RK3588("vcodec",  0x0, BIT(2),=
  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, true),
>         [RK3588_PD_NPUTOP]      =3D DOMAIN_RK3588("nputop",  0x0, BIT(3),=
  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>         [RK3588_PD_NPU1]        =3D DOMAIN_RK3588("npu1",    0x0, BIT(4),=
  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>         [RK3588_PD_NPU2]        =3D DOMAIN_RK3588("npu2",    0x0, BIT(5),=
  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
>         [RK3588_PD_VENC0]       =3D DOMAIN_RK3588("venc0",   0x0, BIT(6),=
  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
>         [RK3588_PD_VENC1]       =3D DOMAIN_RK3588("venc1",   0x0, BIT(7),=
  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
>         [RK3588_PD_RKVDEC0]     =3D DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),=
  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),
> --
> 2.47.3
>
