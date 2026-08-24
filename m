Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6B367F59
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571078; cv=none; b=XD2Ry+wAk9pHjk+AD2PkL4nS5X9xR4PhDZfPjl1fRzleuqXvZQQkpB481U50xdTuipnqRg+0rdKDr19ATxxjvVniJRBaa6D2J+zTPb9X9sLhxq5PEfTQvW4RjRTLbEEiFNzMd1OX0ct4PX0S2YKsvXCHUPvGaerPSo9PaJ+JJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571078; c=relaxed/simple;
	bh=9o18Ss1HSCezKpijdpsSmTTtjPaVfKlkqkGQKrki1c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du4proK+89NhG29qcLZN3oHBFcFHmDjavINMA7M6k0BzvpO8jc1sT305lNCTpWGNJ75AC1nGXC0p6AKgbqD7ogqee7n8U7GaAPH5j4jhR6fwJ0SQX6+UqZRTq193/ykhmbgm4jxC3d+8+OV2Egbb9tiIjY/KL1Uq9og94y/ZQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gklqmwlf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WXK7O2YG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gklqmwlf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WXK7O2YG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMfmA2864672
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uhZFMUq0G82N6cZ0jr/Dp8Ye
	4zJGl9JW5FIR7tFFlKM=; b=Gklqmwlfj9AzCkg/arOvToonrhf0bYY/rB+R88JX
	3w6WMi/u3Bi+iyuC5Z/s1CKgJvg9H3owZXmIpgfVN2qfyWO/yTvkxz9y8/Qja3ym
	liXTh6B+i0GkURoYSqt1egIKbsIjuYTVA4S2GymUThJ8m5yB4V4SuJAyhCNKzcrk
	cKoJk6hOpg/1VjmtI3TJ5U8NRRZ/Lbjalee64MB+/jjtG4LUjwHDfXUTHqZcCyEF
	+6hdoRjcq2ZOLtDL/ZaxPCFkoeon0XzTv36UH2wNqls/gmvgz5j0gGi5ukR/L8Xw
	N0xB4JnHmryBkKdZPwEGkkxIvj2IL7soNYf8wZSDCl+4Ug==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr275h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:31:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52d33c89a29so45230281cf.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787571075; x=1788175875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uhZFMUq0G82N6cZ0jr/Dp8Ye4zJGl9JW5FIR7tFFlKM=;
        b=WXK7O2YGXeiMqLDsKbdbeAvkohzS32JwzUmfi3kCwWb/vpNMHkH3KP2JaHVnLjO7Sn
         h0qE0sU4eZBCi85E1M0gRmTQQrQT0nFlpoWA9YK38FuWt6UI4ve2k92oyi9P7B3fUrfm
         dIRDSIgP8I3BU+iKI2FdDXWzvFdzdzgBcmK1d/GD3I+65oGsum3sDfccvYxUvW0OTAf6
         T7CeYUAcrxp9fCfnuiXfuR5kv3FhDh0UHIQvAZ3pSVCkEAz7obp8fiOv8Snuqx7ZkA4+
         zEkQdA9yxm8MOnpTXwBmUOjLV2vPvMY3ra53DC8fqBu5hPOdzPGJwyJ7AUnMs6IxBczy
         VA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571075; x=1788175875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uhZFMUq0G82N6cZ0jr/Dp8Ye4zJGl9JW5FIR7tFFlKM=;
        b=ERUL6CcBHvVPYpleeND6hybgLIoMY+/z/Q5PrjWm4Of19xGdgSOcmmFz2mZRxcTpEE
         MHmKhDTIJhxvXNOPvG90wGFYOCI/ZOpd3s7BpLY/zk9GlXqoqHE1XbThTwKZcGSQ26jd
         9rJ+q3X8hlWAb1Apiq4V3vN41SmcV0bPDjLye/qOk3a6Lej2WPL7ppOsYv3j7WtvxxTJ
         tt62fUbXXt2mx6lKzgk0zOw46LlPFL+O0N5d/V6nQva9nFEUxKVJFuhQVgOr7aBuqDKf
         ty5PZopQJWn5lvW/OxvctZop+x37YDS6swECt6naklghscCQblIPrEEm3afaOaSnd/Ds
         FVUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdArAO+Oo97ZrFJjYNo7OD+J09s8UMSfHrFZ42NQ9dlBT5580xmmuG8PMOXsWyYVK4R81DoX/izw==@vger.kernel.org
X-Gm-Message-State: AFuF++mYTBfDhQmSwkZAgYFEnenCD34cn5RlWRlcEfhQr1gvEAS4ZZol
	sUuYp/J6nVSZphDII1/UPQIIZeElyO8cgG3T8QhHknWPGrflQ7xwnMZ/khN6zG27XMqo0hjGFrP
	e/k4dCdAcpbVGdfOCvKNXwGxbfcqnStEaIZWZJkBe/5L7qPmG0WFOFKpZF3w5pg==
X-Gm-Gg: AR+sD10bfbkZXrzSxqmrHrOcUvq7mzmtQtatjcUWiNdY87BbYsXXNtPmvq51c+sFQ53
	UF6poK38EIQ0yAdC8+FPgTsgIgEUtII3eTGJRWJ6+BDhGEgtn8yh3y4XheLMyFCnw9viuJVW6RE
	Ab+7EwO/glfXEaza+pufiIabW1p6YOpk4YwXour8FSKWzsV2YKELNgD8ZnnfmINDPERZYkdqsP4
	XTtaNIeK6omC5T3ybv3y9ZB2JHkCN87Ov5hkmucTxvr4u4OrtcYLm+3Miwrg74sV01rkk7IkYm9
	Dz9rXOexYnoz19knej2oZqAVc93nq3UDmDw3KiLTYvtGPkZdRN3uSfj1OWQt38znGwM4lm5wWe5
	JqlOH89J8kVz1slo=
X-Received: by 2002:a05:622a:4cc3:b0:51c:ae7:fa1d with SMTP id d75a77b69052e-52df56e10f9mr245520821cf.5.1787571075012;
        Mon, 24 Aug 2026 04:31:15 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc3:b0:51c:ae7:fa1d with SMTP id d75a77b69052e-52df56e10f9mr245519981cf.5.1787571074499;
        Mon, 24 Aug 2026 04:31:14 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm1342927066b.46.2026.08.24.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:31:13 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:31:10 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
        p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
        royalnet026@gmail.com, u.kleine-koenig@baylibre.com,
        chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
        alchark@flipper.net, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 08/13] pmdomain/rockchip: add optional per-domain
 power-on settle delay
Message-ID: <dn5vlrxg2vr64d56mqibriz5y7ebeqezkv6f2aqf5qd2gti6y2@ohdxvj5dnscc>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <1b89eceeca92f7857d26c5d2097bea2bce10eb93.1787568944.git.gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b89eceeca92f7857d26c5d2097bea2bce10eb93.1787568944.git.gahing@gahingwoo.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfXyZZGeJxEGVwr
 H0xJvqwCIA3P0rVDQqfe3BjCYx3FuuD5qDV8448yIaXDrekrC0R+KFHETxjtwMB4AgrF5+25UbV
 PGaws4xd9GnJ58HB78SaF4eE49JJ6+ijYmaHyG0SaGHCKPbutoOEt567nhT/2+4le7fB0xhgc9M
 4Co0rsQPyil7THChaV7sEC9Uls0+wCELePUDvB3mPsiveqLfeQlrUriQNFGK8zrw8ecXHYhNjAn
 UKLB5rdK/JSMsKNgibYzBXgLSZJ+fEv4nWWTV8Yq8GblDLq3w1D+R8WOE0WidhHYWnyxJpXUvg4
 F5Odq8YiZTVCeHA8nKZgsY5xbPB8f+APYABChjxinOjPJJp/tjWbfFu8kG67v2Ba2Tl5FD9Iyni
 rDoFftjdHjt/82bV6iZ9TLi8WvMVXb7YEua2JqXVGMhrZ+JcwPlLzqB7YAARhIJB7VoAe+o0OSX
 t5szt6dOZyUMPKwUMRA==
X-Proofpoint-GUID: o-6_zzXmsMTmJZkY1sdxf59h3Cc83Pj6
X-Proofpoint-ORIG-GUID: o-6_zzXmsMTmJZkY1sdxf59h3Cc83Pj6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfXxhxt69QoshdT
 qoTCiYn7l30haa//1lzjIyiOQtVW7nk8VS5b+74K1cTxoeIL5MRPMbR3jOs/fpZvhVRMOVxflZP
 BDnyESQhK0u0h52yYbGEkdUpTWo5sdg=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8c2b83 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8 a=lG5QNMjPvMxfgh1q_X8A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240096

On 26-08-24 23:08:57, Jiaxing Hu wrote:
> The RK3576 NPU domains need a short settle time after the idle request
> is released before the registers behind the domain answer. Without it
> the QoS writes that rockchip_pmu_restore_qos() issues land while the
> domain is still coming up, and the NPU throws an async SError on the
> first cold power-on.
> 
> Give rockchip_domain_info an optional delay_us and wait for it between
> releasing idle and restoring QoS. Rename DOMAIN_M_O_R_G to
> DOMAIN_M_O_R_G_W, since the suffixes name the fields the macro sets and
> this one now also carries a wakeup delay; RK3576 is its only user, so
> the old spelling is not kept around.
> 
> While the macro is being rewritten, give it the regulator argument that
> DOMAIN_M_O_R and DOMAIN_M_R already take. Without .need_regulator set,
> rockchip_pd_regulator_enable() returns early for every RK3576 domain, so
> a domain-supply in the device tree is never looked up and never enabled.
> Add a DOMAIN_RK3576_R spelling that passes true and use it for
> RK3576_PD_NPU, which is the one RK3576 domain with a rail of its own;
> every other domain passes false and is unchanged.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
