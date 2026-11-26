Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691119;
	b=zY/9S9fqMaeh7nNHqQlaMkgJHKoFFuwsb3ligIzZOUu0Hs7rDvfJOeJ5RD+xAxyyuJxp
	 okxAr/U7Y+f+38grF+QgbcUvKlH6KQdbU1whB7HON4Ax6Io6nnXhPra8Cz+uNGJ861rFO
	 lyCwADBqQ+WxLooiBhBBvFQVWj2F/fFBMVbOxTsLJbTt+Pw38wf30/t5Etzuffv4vEf+X
	 osA2ayxAMhVoCdA03I7pwkkrheIzsswcjRfNFFBzgb2zjABw1o0xgF24DMa77uBP+Z2FT
	 4C4mp3qKVFNWpWAE06T6js6T++1jsMeltRRqiXL9d6bG06fV40uuIX5f3T14IY5ahTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691119;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
	b=ye2RFu7OU4T+MX9mcIU8FSAkqMFzmIekMeUHCbbXXhh72tJzUL+mlOqBG3RphHipjr6N
	 sZppiXfFiQdITBKdRYTzapFSfCrySEmIFbMEkIarVadMYkeIufuyZskfR0qzj1WiGBVTS
	 co8PDxyRuhMzpu2+PKauoK52GhSfyQk956/6r5YJsRKt9N76NJ1pPoAKxj1lmCf79fL1b
	 Qg507+D4ULWJbBadc/s4Cz/ELTagTxmwwe4Fd5UyOGue0uVm7RP2SDMsA0N1GvNul9Zc0
	 0uzXUuEDjGjs9MWwF8R0O8S2rIV5BiW5wSkZR/7sMXIUPLI1s3N1hoeyqIKRN9S6zBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1LCYAuM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T9QlZ98F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B4606A323
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B8B4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1LCYAuM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T9QlZ98F
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQAXgFm2631206
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=; b=P1LCYAuMr/D5qPTC
	qvoMVcOhInukkngJQPbRRoVLIxCrm3Cbfltg0ixbMdjOrOCz28lnsbK/FQbX9Kxo
	BkB6bDX3zRnt8Lih15T2VcTNv3NsYAZmdBNcGIxrJ9waXYUlSRR2c5ItayhUE+Lj
	UIJqi1GcDJuTJV8n5mrLlU/qf/cOXHqVrbFPCDN4b0Cqz9iwZUQbDA+S+IHfUpR7
	ZaGPJrzmcNTomoKTKw6DtX4u+/Ex32UNVMKqo5Hvrp3sL161tdjQ+yWKRBUIzIeB
	VPjhRhXeaJs2curePdUvH8qZN14pakXXbheUUye90cMh2duVMtLEbyyacpM8Tti8
	AevJyw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahv4q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:05:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b49dd1e77cso3637521a91.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:05:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795691117; cv=none;
        d=google.com; s=arc-20260327;
        b=G4F0ZSJ1W4RjOMS/DxNVOIk8/0UUWRKJjj2hS77mHzc5jWdvtWisaqmJPe4p18tIdr
         r4oueIvoxmkjVybFZzsvVruz0NwBnIR65vgqZty66hzaEByRTYYW2A4scfW3H8/c353S
         BvgZzCdnPMq3etpqP0HglsRU4AKtMvCG/bOIU3twbyFCqucI4Ad9/0uKezBvXQPTkza0
         +wpqUZqbzVyb8u6LkgAOM8bu3E5zygINjRhKu8tdoLvftp1S2Xpz62oIOW2amB9C8Lx9
         jbcmu5IKSeUNQD7zxgIz9TFfkbiFn1tdJ16/0hcBB1E8l+BO1KF30GKLL6y6Zy0NDhDz
         EqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
        fh=pdAYs6QZfFp7L/OTXMOYDXLc9JKuJ6vF+JvSvc8G06U=;
        b=faA3qwWt7hGO54zm8/NV9yQL0Vb9OIPiyaT32sYRuT/tU3ojSbtL5ohBemTACzxzQi
         UtZuo2vuY629y8XErbHeAcA0dVloyWH1yjIg1RDxOkypqIxHzAeAHqvyOTjlqsLVC0l5
         hDHbXp6ZEMCZ/Lg6/zS1C9rKY4tzMR925PxoFwWRnn/mxg0wh9UzrLPBSqzwyLS7XRbE
         lYSvAoZ4Ua6a6WmeA4+ESWEKvJfkpNZb9v1omWGlK3t3ntVWVDkapJ8roNKwUhvIqHab
         s4ZZcuA/sk0z0JduyBP7mLewf4IgKnK2WQ5uYcfkZ/UkVmmDVO5GnoUVM+1SyXkv8UyC
         OGPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795691117; x=1796295917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
        b=T9QlZ98FlUOKJoGOkwA2EmoSZp91xoItC6lmy50A6/C/YWZKpQHaYs8p5Fs7vizDEY
         K0mdys1xpB+bZXOP9g8X5mYnykswFE+F7UEk0uAFHDjFBFP8wFnTSulnnTKkw9YbtU6W
         qtMtAkbOA6Xzld+b91sTSKart4MhLnZpnGVRsxAftUGbbpufCinBseTFTKhEz9Tf9cse
         KnsaBu+kpsulkt5yeLC9D39ShIR+mSBGm6RcUBtdgDHC5tDFE4bB3gn3WHxmX/96UgVn
         nPIHgmaV1WtsFCTtb9LLk1jhp68gSd4CcR/xzg2g72J2DFu83fFtRLkBvjh1Zh14R53f
         Ovhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795691117; x=1796295917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
        b=uBSHxKrCkNOhV+364DuddfRlj/NjOWQ/wtPMrBV2dR1lt3YzdG9lTTrlkYOAdxQejf
         dzNtyJSurTAw407aSGqt7M5s+V0JVXsaJyaxxLYQ2Swjjcc3UShU5AU71UvL8mS1n4xJ
         XOlKwC1LyJs8ZXnYo9SjBfCjvCe8YfdR9J9sCNpt4kgXLU7TGuqiRqj2dgKG4AGYeW+5
         wOXyUdp8kBQ6wAF5zl4jKs+N9atrzVnGg6d7Y/uKyyZ6lbySgFTdgFjyv9fcrpcntN0b
         nsHihrMeC5Wej4SieAskzavbfowmk9FaMsBasK8trKVkQ4Jr0u5oIASy0+XMVwXLDmga
         X9Rg==
X-Forwarded-Encrypted: i=1; AL+hErGsrcHDoO/QdwvcvA14HffjDjdxabfj51pxbXPcQG/XASoVumF0RswlaBDhQ3PzyCXTX+ok5bUo3A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2CxTXM6llJ2j4wJps9gvLCuEpLf9aN4NVbsmrgwqJ7L/9sBQS
	kpzXm5DiaaM5GwQOxpQNdjX52+k7ruf8jKOrFdMa63LyitSfZFHtkdacIG09cl2S4FihMJ7JB8P
	64PBLIRmfegni3yegYUUpXE5MYx5wPw7jr/Qk/fiVkyepi7RxGDgWBjFSGbqtNOqg9cmiP4vp2h
	MCcClBm2DUzFAXL+1xLrnfUfANx7LkOW+p/Wz2pLJLJ6r+ElRqOQ==
X-Gm-Gg: AZFdTZc2Knvur3AxSFckq6lrOo1bXdHF2mj/LHuYewCVtfug+vqykEbWsDYz/4zvZ7I
	WNraWP1NURYRhSdIhhOdvzEltT/lW2nv/JC5LDhlGcZuJhBmlRDprru8KBCNbPb3e4x19VQbCdc
	RMbyT2SR6r7juw0yEiN9TifIP8euca6H7DacTP5WD2XbDCJyh2Km1o9/mqBg==
X-Received: by 2002:a17:90a:d2cf:b0:3b3:b595:2473 with SMTP id 98e67ed59e1d1-3b41c906b61mr18544068a91.24.1795691116532;
        Thu, 26 Nov 2026 03:05:16 -0800 (PST)
X-Received: by 2002:a17:90a:d2cf:b0:3b3:b595:2473 with SMTP id
 98e67ed59e1d1-3b41c906b61mr18544043a91.24.1795691115988; Thu, 26 Nov 2026
 03:05:15 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
 <20261117173738.1073856-2-Frank.Li@oss.nxp.com> <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
 <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 12:05:02 +0100
X-Gm-Features: Aa3M54r_rMhLGHc1vqQ3FXriLYRwoLb-Xyx7xbWcsA8f-DpP_bkxDUBWaFpBhbQ
Message-ID: <CAPx+jO9JYTygL7F4nc9zb=iOmeKfdpa6-_QBOvAmMN9fp6HfwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Frank.Li@oss.nxp.com, Matthias Brugger <matthias.bgg@gmail.com>,
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
X-Proofpoint-GUID: W2kwgf1o6QptXwrKViB24NF0xHGxjq7F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfXzkefn6sJHAAv
 WUzrfygM6b8px+6Kx01MAHrpe3vWD4/K6BwNb1HCN26O4fQFMTZuY8Ac3PYZfq9QhZMuHY1gkvZ
 xEPqV63c4tCMm6cDuL2d+Fsd3N+BNy0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX3tz/ikffzc8E
 FFccInm+0RYi1AYedaDLLGbPCy+H0yyWuCiymFSmYixryr7YVBzh/v6P3OZkr55IjYep7I3964k
 HO+ZvdWCuobol7SrIbzHoKgK1EVP9O4ubusveBnB3GDVsPPgFTQSnXIK013cUwCCIcwhynxlTrC
 QjmjPs9/D0FfV4IcUbHQl826dS4XoEgjrbguyXP1SqHF1gUkXjK3EO7as3WV2apKAF5yp4bUD69
 p1HWSNdTgm7wlMfuAAq3BMkA5ws2J28ydqLDSrPXjgfWd0kZETW5kIvdJ0JHg5JH+30manrMF5/
 irNLC2JxaJi4IHjtQdpDtCOLXcnrxaxInJTU0mkjqiyxiRZw1hieG018zTYi8/HuXBJ1/YLsusz
 WsiPosNKR7Jdb3rM8OGXG9H9MvNwDDO8DYiSyPYp6GzO8Qi1P6xrse8kYiyz3hDVOxBpUBlD25U
 AKDE77CTtjod4APaoeQ==
X-Proofpoint-ORIG-GUID: W2kwgf1o6QptXwrKViB24NF0xHGxjq7F
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b08126d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8
 a=QyXUC8HyAAAA:8 a=GFqr32JmAAAA:8 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8
 a=iox4zFpeAAAA:8 a=7CQSdrXTAAAA:8 a=mpaa-ttXAAAA:8 a=QX4gbG5DAAAA:8
 a=ZLGELXoPAAAA:8 a=P1BnusSwAAAA:8 a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8
 a=JfrnYn6hAAAA:8 a=foHCeV_ZAAAA:8 a=x6yKa4QoHz4R4KwlW4MA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=ST-jHhOKWsTCqRlWije3:22 a=f02Ha7HRcztGgdyUxOxW:22
 a=t8nPyN_e6usw4ciXM-Pk:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=CFiPc5v16LZhaT-MVE1c:22 a=D0XLA9XvdZm18NrgonBM:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=h8a9FgHX5U4dIE3jaWyr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260042

On Wed, Nov 25, 2026 at 4:53=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Nov 25, 2026 at 4:07=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > On Tue, Nov 17, 2026 at 6:38=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
> > >
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> > > returns -EINVAL.  The real implementation returns:
> > >   1  - device is active and its usage counter is non-zero (bumped)
> > >   0  - device is not in use or not active (counter not bumped)
> > >  -EINVAL - runtime PM disabled for this device
> > >
> > > When CONFIG_PM is not set every device is permanently "active" and
> > > always considered "in use", so the stub must return 1, mirroring
> > > __pm_runtime_resume() which already returns 1 in the same build.
> > >
> > > Returning -EINVAL breaks callers that test the return value with
> > > comparisons other than "!=3D 0 / =3D=3D 0":
> > >
> > > drivers/gpu/drm/i915/intel_runtime_pm.c:
> > >   if (intel_runtime_pm_get_if_in_use(rpm))
> > >   which wraps to: ret =3D pm_runtime_get_if_in_use(); return ret > 0;
> > >   With -EINVAL the wrapper returns false, causing an incorrect error
> > >   path in the GT fence revocation code.
> > >
> > > drivers/gpu/drm/xe/xe_pm.c:
> > >   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
> > >   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
> > >   returns false, so callers believe the device is not usable.
> > >
> > > drivers/gpu/drm/gma500/power.c:
> > >   return pm_runtime_get_if_in_use(dev) =3D=3D 1;
> > >   -EINVAL !=3D 1, so the helper always returns false when !CONFIG_PM.
> > >
> > > drivers/gpu/drm/imagination/pvr_power.c:
> > >   if (pm_runtime_get_if_in_use(...) <=3D 0)
> > >   -EINVAL <=3D 0 is true, so the driver always takes the "requeue" er=
ror
> > >   path instead of proceeding with the active device.
> > >
> > > sound/soc/sof/debug.c:
> > >   if (pm_runtime_get_if_in_use(sdev->dev) =3D=3D 1)
> > >   -EINVAL !=3D 1, so d3_prevented is never set, corrupting exception
> > >   debug accounting.
> > >
> > > drivers/iommu/mtk_iommu.c:
> > >   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <=3D 0)
> > >   -EINVAL <=3D 0 skips the TLB flush, leaving stale IOMMU mappings.
> > >
> > > drivers/iommu/rockchip-iommu.c:
> > >   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
> > >   -EINVAL < 0 triggers a spurious WARNING on every call.
> > >
> > > drivers/media/i2c/isl7998x.c:
> > >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> > >   -EINVAL <=3D 0 causes the driver to always skip register programmin=
g
> > >   when !CONFIG_PM.
> > >
> > > drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
> > >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> > >   -EINVAL <=3D 0 prevents any debug statistics from being collected.
> > >
> > > Fixes: a436b6a19f57 ("PM / runtime: Add new helper for conditional us=
age count incrementation")
> > > Fixes: 3b85b7bcccf4 ("drm/xe: Fix display runtime_pm handling")
> > > Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> > > Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance=
 after fw exception")
> > > Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> > > Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil I=
SL7998x")
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change in v3
> > > - drop tag: cbb819c363c5 ("media: rkisp1: debug: Collect input status=
 by sampling ISP_FLAGS_SHD")
> > > selected PM at arch config
> > > - drop tag: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> > > selected PM at arch config
> > > - drop tag: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runt=
ime PM logic")
> > > guard by CONFIG_PM
> > > - drop tag 727538a4bbff ("drm/imagination: Implement power management=
")
> > > depend on PM
> > > `
> > > Change in v2
> > > - new patches.
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > > Cc: Alessio Belle <alessio.belle@imgtec.com>
> > > Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Jaroslav Kysela <perex@perex.cz>
> > > Cc: Takashi Iwai <tiwai@suse.com>
> > > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Yong Wu <yong.wu@mediatek.com>
> > > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.c=
om>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: Dafna Hirschfeld <dafna@fastmail.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Michael Tretter <m.tretter@pengutronix.de>
> > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: imagination@lists.freedesktop.org
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Cc: intel-xe@lists.freedesktop.org
> > > Cc: iommu@lists.linux.dev
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-mediatek@lists.infradead.org
> > > Cc: linux-media@vger.kernel.org
> > > Cc: linux-rockchip@lists.infradead.org
> > > Cc: linux-sound@vger.kernel.org
> > > Cc: sound-open-firmware@alsa-project.org
> > > Cc: imx@lists.linux.dev
> > > ---
> > >  include/linux/pm_runtime.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > > index de9e7518ecef2..1d983fe55a16a 100644
> > > --- a/include/linux/pm_runtime.h
> > > +++ b/include/linux/pm_runtime.h
> > > @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct devi=
ce *dev, unsigned int delay)
> > >  }
> > >  static inline int pm_runtime_get_if_in_use(struct device *dev)
> > >  {
> > > -       return -EINVAL;
> > > +       return 1;
> >
> > This should be return 0, as we did not bump the usage count.
>
> This is kind of moot because there is no usage counter.
>
> However, the caller may always take the opportunistic "in use" path
> because there are no potential costs related to it.

Of course, for the !CONFIG_PM case that makes sense.

Please add:

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe
