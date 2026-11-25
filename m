Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619254;
	b=YdUq7mBph2EQErVzbUBNzewJECFM8ojEb/nxAtGzYnofjb11Ui2Oe+UusRD6laJXZBA4
	 wvuZCeYfB7fv/Z8juJGcjumejkWrkaef5tUBArfPBp+lFGs6WVA8mUxSZeXLvcAn/6cIf
	 h30KrpqsCQlm5fHVwR43JQ5nN0mcxPycK8Xne7LQo5YHaZy9a5GEGwidAo/za/Xp2Nbcy
	 T2hwEJAiP++OCmcd5KqWKnNWf1XQwf+RYkz5JCYzAshIdf7WM5sCGpZVMlYSXh8VLs5qh
	 hsxv3LVbqvEtyzBebi2S02ZHiude2wezmOTbgqUUoD0V48r/QE+etrYEs0S9m1oj1IA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=db+Ha9wyQwvqpCYlhHffmTpkau51LqeWzqMbVXiyKQ4=;
	b=1EJnYu8D1u+buCRfP7n/eN2GOTJfNIj6OLHALQQoYitiiXSHNPvd3XJ8K8HUHyyy+WCy
	 SDUhcJIEuU7pYRj9EGrghU7i/xCxbNbzNAjgn2R6NkepzJoUk6eulsPWFfJP6ohzb8oFv
	 pW9i2qYpIxrDTVi8HcShV+ElrLidPC7R+VtOmZDqje5kE1zgnNe9xtLsvJB00WpbKYU/M
	 3fLXq6emuVfJ4Cz8X7CeJ3Hx0V4Lf0syjWtf9nAvVQyQY6J88eFIyzKlxtzWBDWGug2wI
	 DohymHGt6qw+JMs0SvIcmmqKXYKPDWj38M1fCQzqfKlqwr+VBJPLFMtMpmueHYJTPRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g1iGMU5+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f2gFOVpc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10F606A32A
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF10F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g1iGMU5+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f2gFOVpc
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEMCk2048157
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	db+Ha9wyQwvqpCYlhHffmTpkau51LqeWzqMbVXiyKQ4=; b=g1iGMU5+iI+taWPx
	yLKnXluxP0uaMQZ6O5vPH2iEJkzvOVHnbjFOxlUKSgN9I0PnTwKk9RPx0tz5phAE
	cWXakaxrTlDBuo7Ig0ayxg17cVaHRUvakyzifrARLhcIgTZpCsEH6XS8Zm9/J4wZ
	RXv0fAKx89tE2ZoK/4K+jz6tuSEyQjzpKoEat/afA6amSKDrjYvpqTeB9cRZsJbX
	pRXFEREHLj3Q0aKAwidv2GoSEMoP/vmxEhm0axosUN/os6TTs9KZmu04624uM7Nr
	ASb1nzQhhyAYBm/r0M49GHRkHxqW+wg42e+m20IdMGvKqw2YgnMNycX1SM6phLCC
	sLz5Lg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc2bemj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:07:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b0a13ae043so6277667a91.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:07:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619252; cv=none;
        d=google.com; s=arc-20260327;
        b=EMFJqeex57pflPLozFgTFNm2GKWkjpyhHk4tOACrCUZ/gCfpYtZLizwKT1OFuTjg0W
         aOmDgoDhgd3Sl790egLrMVgaDnP0cgvkd9hRkLpbGFLU6wY9PUJfQGTxHdiTkyavEGoT
         IiyeCDKogsIUcjvRnlVWbdxJ3VEY5b+VqcUnkYr+O/p+24+yF9s/S27R3mRLwyHdKYyE
         DV/f1n4yiKS7SFX1958kO/r6wj8sl6wwLVBY9R3Qcow8SB8ubLC2BuHRu3liLAfr6QtF
         lte2Iy30D9552cGY2iT7RZPpkzdzRDo1CNYiKsm/JqOLK5qruIwUTU8vizk+vGP6AuI6
         pZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=db+Ha9wyQwvqpCYlhHffmTpkau51LqeWzqMbVXiyKQ4=;
        fh=gWFTrGKWcVKVGKGc8TTc1DEAm3JxBfDyjvoGufufPAg=;
        b=iUeUbpwSjdh1h2bgTQ+pzDPRlE2j/UnUrNp3Br7aAEurjkJT4I8zD9ebOf0sg1HAI9
         LZTRWCLCJ+ghS5B8DCQLM0yb6lSTDgeFmVWonGuoh4BmZgfXzFjxaIDZi/1O1RULviEs
         yLma74OwQrwzzCIEKj2v68w6MS0RikB0U0dI1XOJfIANyrOnYYGP6wlB4hPFz45awhnx
         5tDthrhdPghAmyYMeCll465lt/tIlVRNgrmwcpPEp8D2btPReicTui+IdTOAVZbdxKmt
         DcCvQjo3RtsGBSfkf7oar+a/5HIOEYBQsTCM3cBUJn6o/40kHuJCFXg49aUjZe9Los0A
         WpVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795619252; x=1796224052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=db+Ha9wyQwvqpCYlhHffmTpkau51LqeWzqMbVXiyKQ4=;
        b=f2gFOVpcbCOJ9yOFdfJGpHBsYXJZMz2NDVhtSnnMTPrHds3LU7u/YvvkyRZGa0LSVv
         R7DdyC143HQvXgIkiLVGwnCNorseDG1DJtAYA5KzBqjmvGKYJicR67M6Go00IETewbuK
         pAsEsAv6UCJ8L05g6eovbM+/d63ZUw+/UFYqIG2qovwneMZIyRG5/DSQcHnM7GLKekLM
         SgxDoQ4qiKuXhseZDoB+hOLxVQlzZTRgCVNh3C+G32RRHBR/kUbkEdQUaNcpPG10KkHH
         l/XBa3wj4z1eqvoDU/7sfgyVCn9S9MjcqtE8n+GbX1f5zvz+MuuKFMwk+xgh8J6mt9wX
         B8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619252; x=1796224052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=db+Ha9wyQwvqpCYlhHffmTpkau51LqeWzqMbVXiyKQ4=;
        b=sZXjbggeasEgj1vIfntWKnedAecT3Mn7ktrTxHso0Wsj3AQfhatCZDUAjUTeTxqucQ
         fIY11CkGy5J6m/1GgLB4tYr89/3sbS/mUUB9hFcOfuR59L6dF/kj7MvRTs8kO3CroGsq
         CKgE1eRDwCsnOLGJx1loVNNbImm8p9Po38Tv47b6UbIH0qD+X7UYzNEL7wfNnpUTpkrV
         vvlhkMGtTpvQj6xivfOKv+Mjs00cPja/0D6z6ISLkfVdx6U8A1EQSOKp60VXM/wL4MnI
         yxyjhi8q87P5JRbc3tkoII6/UEIk67RLZxDnZlNxIfaQ9+oWeJvfi1gpniu4TuD64TDe
         OB6g==
X-Forwarded-Encrypted: i=1; AL+hErF5nH/RvYO5tA7WGlnN3VpyxBvJBdCcHnc4Suel+c2aX4PQTHA4Q6/j9KND7HMleNzKJXO350N83w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9D1ynK8WJwKnQfBzPtjbpQ8YTqfwgEAd9Yyz0Sj6rGIHy1qd32
	G4L9ez7G0EZsWFNLotksimsy4Y55wwfEI0W5fXB7ZC5gd8cnJnl03Q83LCZWt5xqI9/ycJ9x07C
	xpkg2Uc6LUeaxTyTa8xF8HWVYNZMEAG2j5a1VR7oczyyXksxMlIaQDbB5qc5Iiz3rjQek31yBQC
	Ts1KjRF6xpINkSF2qRVRN9l5l2Lz91SSBQAYqW
X-Gm-Gg: AZFdTZfMkoI7F7pKfolinyMLhcAd7IXnphOCLbL2NKDB6d7H4qKc8vh4X3RdlEBsX5s
	H0yGEFEHhoXqXFZfYlsVRhyTK7zzXINAjNQuwMWkDo1H5c+0opkkU8e/KWNJtVxLMK8GGERtdXq
	djkt2JyAouuDy88rsxI1udDwyWQu4mpDZSBBrwYsQusVDB3J4rYN25djgvWQ==
X-Received: by 2002:a17:90b:4983:b0:3b0:97b8:d6b7 with SMTP id 98e67ed59e1d1-3b41c931d29mr17812817a91.42.1795619251745;
        Wed, 25 Nov 2026 07:07:31 -0800 (PST)
X-Received: by 2002:a17:90b:4983:b0:3b0:97b8:d6b7 with SMTP id
 98e67ed59e1d1-3b41c931d29mr17812748a91.42.1795619251127; Wed, 25 Nov 2026
 07:07:31 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com> <20261117173738.1073856-2-Frank.Li@oss.nxp.com>
In-Reply-To: <20261117173738.1073856-2-Frank.Li@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:07:19 +0100
X-Gm-Features: Aa3M54qdNdgAc_JRldH76LdEJD_mei5kpsUzvFW9k6ee3hswc_FKGO5qrF_F3iw
Message-ID: <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulfh@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Hans de Goede <hansg@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, Marek Vasut <marex@denx.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support:Keyword:b[Rr]ock[Cc]hipb" <linux-rockchip@lists.infradead.org>,
        imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti <luigi.santivetti@imgtec.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        dri-devel@lists.freedesktop.org, imagination@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b06f9b4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=GFqr32JmAAAA:8 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8 a=iox4zFpeAAAA:8
 a=7CQSdrXTAAAA:8 a=mpaa-ttXAAAA:8 a=QX4gbG5DAAAA:8 a=ZLGELXoPAAAA:8
 a=P1BnusSwAAAA:8 a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8
 a=foHCeV_ZAAAA:8 a=Idd5WaZmN1QeKTrTtQEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=ST-jHhOKWsTCqRlWije3:22 a=f02Ha7HRcztGgdyUxOxW:22
 a=t8nPyN_e6usw4ciXM-Pk:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=CFiPc5v16LZhaT-MVE1c:22 a=D0XLA9XvdZm18NrgonBM:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=h8a9FgHX5U4dIE3jaWyr:22
X-Proofpoint-GUID: 3e8CgX44GdUFALJ2rT2645jXmdXDMgYQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX6fBiW2WrE9cI
 r+hZjjVAy0TtnRPJAq4kjENQHViMYvBYspWHDKynj7Eurq2/hCl14oYje0u3Z/eeBCJT7ZsgiON
 T9mx053AhMoN76pDuM+jmvkdqlsjhFcEqSVm/pSFpT4Vrs+Y6UkATTLWs1Fwey7sNtC6QORQSKZ
 VHztqqyuECDyBUfjn/9WxWzw6hjO9ZXL1YLpAbfXVp8F8+PcsUwXQ3Pv2i30oG8KH6ss+91eCcD
 xgZyzNHG3aJfTAPD4Zf5o96DyZATpHzj+mlmD6V3lnNHuET6uwlJ7GIyTWCOW8QYEmJBtWHtb8O
 /sFE6sqn3u8Tba/e3GcJ4GoR2RSxaihlvkABR0KKtrA/SSB6lT+/gZZ03lTMa6FUOAUQXExtE41
 Gxs3Hsp4mW500X2egmqXFz1GvFVryLwuOKnBll0uDk0ppZEA/uQNvXnjQa6jqlQZnMLOP+v9ewx
 Uc7DFxWycG+Wc0RFz4w==
X-Proofpoint-ORIG-GUID: 3e8CgX44GdUFALJ2rT2645jXmdXDMgYQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX69X8OzRIhg+f
 o5oUbDctynQ1ZZl91z9qf7jUF5Pbil2dfEuDVupUoB1kfLno7zHs4zxiMdMVHIHel3D/Mpu3m74
 SuQHQN7/puWsf3vPCflKCHP5wcFAea0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250060

On Tue, Nov 17, 2026 at 6:38=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> returns -EINVAL.  The real implementation returns:
>   1  - device is active and its usage counter is non-zero (bumped)
>   0  - device is not in use or not active (counter not bumped)
>  -EINVAL - runtime PM disabled for this device
>
> When CONFIG_PM is not set every device is permanently "active" and
> always considered "in use", so the stub must return 1, mirroring
> __pm_runtime_resume() which already returns 1 in the same build.
>
> Returning -EINVAL breaks callers that test the return value with
> comparisons other than "!=3D 0 / =3D=3D 0":
>
> drivers/gpu/drm/i915/intel_runtime_pm.c:
>   if (intel_runtime_pm_get_if_in_use(rpm))
>   which wraps to: ret =3D pm_runtime_get_if_in_use(); return ret > 0;
>   With -EINVAL the wrapper returns false, causing an incorrect error
>   path in the GT fence revocation code.
>
> drivers/gpu/drm/xe/xe_pm.c:
>   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
>   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
>   returns false, so callers believe the device is not usable.
>
> drivers/gpu/drm/gma500/power.c:
>   return pm_runtime_get_if_in_use(dev) =3D=3D 1;
>   -EINVAL !=3D 1, so the helper always returns false when !CONFIG_PM.
>
> drivers/gpu/drm/imagination/pvr_power.c:
>   if (pm_runtime_get_if_in_use(...) <=3D 0)
>   -EINVAL <=3D 0 is true, so the driver always takes the "requeue" error
>   path instead of proceeding with the active device.
>
> sound/soc/sof/debug.c:
>   if (pm_runtime_get_if_in_use(sdev->dev) =3D=3D 1)
>   -EINVAL !=3D 1, so d3_prevented is never set, corrupting exception
>   debug accounting.
>
> drivers/iommu/mtk_iommu.c:
>   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <=3D 0)
>   -EINVAL <=3D 0 skips the TLB flush, leaving stale IOMMU mappings.
>
> drivers/iommu/rockchip-iommu.c:
>   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
>   -EINVAL < 0 triggers a spurious WARNING on every call.
>
> drivers/media/i2c/isl7998x.c:
>   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
>   -EINVAL <=3D 0 causes the driver to always skip register programming
>   when !CONFIG_PM.
>
> drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
>   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
>   -EINVAL <=3D 0 prevents any debug statistics from being collected.
>
> Fixes: a436b6a19f57 ("PM / runtime: Add new helper for conditional usage =
count incrementation")
> Fixes: 3b85b7bcccf4 ("drm/xe: Fix display runtime_pm handling")
> Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance aft=
er fw exception")
> Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL79=
98x")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change in v3
> - drop tag: cbb819c363c5 ("media: rkisp1: debug: Collect input status by =
sampling ISP_FLAGS_SHD")
> selected PM at arch config
> - drop tag: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> selected PM at arch config
> - drop tag: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtime =
PM logic")
> guard by CONFIG_PM
> - drop tag 727538a4bbff ("drm/imagination: Implement power management")
> depend on PM
> `
> Change in v2
> - new patches.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Alessio Belle <alessio.belle@imgtec.com>
> Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Dafna Hirschfeld <dafna@fastmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Michael Tretter <m.tretter@pengutronix.de>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: imagination@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: iommu@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-sound@vger.kernel.org
> Cc: sound-open-firmware@alsa-project.org
> Cc: imx@lists.linux.dev
> ---
>  include/linux/pm_runtime.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index de9e7518ecef2..1d983fe55a16a 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct device *=
dev, unsigned int delay)
>  }
>  static inline int pm_runtime_get_if_in_use(struct device *dev)
>  {
> -       return -EINVAL;
> +       return 1;

This should be return 0, as we did not bump the usage count.

>  }
>  static inline int pm_runtime_get_if_active(struct device *dev)
>  {
> --
> 2.43.0
>

Kind regards
Uffe
