Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794236770;
	b=3zWdv2kn2f6ykGLfm7TcNORSeeAFPR8XLB1Q/O7xFXZNOYlhLk51P7uYoLFO3ZojrG9I
	 gwntfs1QOrn9hy2mOe3INPLdPWxor64Vho1XGvIMHMu4e6wqCxDdda+IYU/dYXtdOeV7o
	 qOlHRP3YNZhNUDxPWicmcLx6axAPUH5bW1WCiE25J14c5lCiNhnvXOCJnCBpj28i+uH3j
	 uW47nyuy9Gt2Yo5cJigiRQKBCuJvoOgcJzlSIUsQ/tSqWrZ+WRvRFBxRCQVhUjol2Lefu
	 vip3CqOCNpr1ysBJxx0dOsyQO0JvjP9jh/CnYrQcWZ814u6aYzALGI/QRNGsw6VuaZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236770;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KArGU3dbS/GT7fx8YVHMeJYlc6IFiFJjR49nKEqFMmI=;
	b=kjJ6MAKjTttLs+WXKYRLLu8ng3UrQ61DLdyz03z3wxjOVbfa/BcBU4CLgMXpEp2Js92C
	 gPVWjAXB7QbGZNWXQMW/MCiQbJPYcF2761DIaQ5wpizjW68Whbvg9KnOhdm6t89/BXIpF
	 wKB8HCot53GNC0sIH62HiALJgXPRLhQZImSbZun549+U5q8ZGmX6fWE9l9dnIWEE7ltLn
	 1DkIWe3UMQi5cSCrLylKO3ff0Dt2gv8myWJTxxQmTxu4D5V4M4qyeXK36N0IfQ1Y5T4xs
	 79AT1a2nNjqSVbmzRQwpywcdeB6LEoBLB6fLjj+EFgdusJ0w9tFo8eYnDbuyd9A3Unw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mTuBisDp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MFPP7ujN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F1606A323
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A1F1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mTuBisDp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MFPP7ujN
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFBcl022884
	for <linux-pm@vger.kernel.org>; Mon, 9 Nov 2026 15:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KArGU3dbS/GT7fx8YVHMeJYlc6IFiFJjR49nKEqFMmI=; b=mTuBisDpOzs/Pqni
	WxP8gaoajYwRE8TXaHfk1KU1nwzlAlbBKnoKLKw+p5iynqnJ8O5WCk3eFZzB37pz
	KCl4Gn+XmIcIioE+D2koa6f75VEqliU2VEoSwD7nzxCoWzsAxTZSfmBks65GF6L/
	7mk3N5SO+YWrv2MZch5sWt+/82q1tHCBtsLSrkIA3gjWzsVL0ESBPKgk+Nc5UD8t
	SRmJRnkaQfASQa8mUNX9lvEhKtJpGnosNe4+eDCn6CbVJgi5fk1VOlg9OP2UVh3m
	T5X2KcMG9fYTD1A7FoNheWHcqJNNWt8CJsFVrK9AU+qExEpbNWritCf8R2sLNXS7
	QU5RMg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydgv28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 15:06:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b5e3b5daffso1245989b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794236768; cv=none;
        d=google.com; s=arc-20260327;
        b=TMg476fhDxBxh9pZ0bmmgKD/MpnsMQi/9dixakQhzA/EQUksF8gU/VYrRzjMHFMdU/
         j8vSaO8K2hQFgDrQWBmQVUpyER52neajZE2P/nCmU5KjXFLArct68JtxYljV2vkutB2q
         ver/uYmDDYoaWspbEX3J2gJmO5S3YCPfreYlTZ1/n1PBwK31BmOjpUydtD+EfZGs/iot
         aymzYH5LR5dtB0SgLMbgGG8oWP9iNsDk1qk5+EsETUYqLP/+lk/5dodiKz+Flb/6/IOP
         CxmX37lhNIXoM9niwALuyfhBTkEhhlxDuV/B3Fzt7odVeMJpBKcbx6oY4IuZ2Yb4kY0I
         YOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KArGU3dbS/GT7fx8YVHMeJYlc6IFiFJjR49nKEqFMmI=;
        fh=2PszYjeb1A57k/INF6lTaeTka+einNbgMsoIGFWQXbw=;
        b=T45yFQkmQ++1yFObce1OKTTRbszxCLLj8dBczDnj1ls1yOKKFBGRScd5exOIuI/z6k
         JXZWcIh2RPBbS8c6F4krw4hJ4uuHs3CidpnGXKtnWKeUPuN4aBqvpwWBhaJOWTUxPqx7
         TN3LP0v+Djlb7eHnx5xaKZgi9neS7HbdyR4m03yea7ReShpzZQgZ/Ny1I4DO8QMamPVK
         OnmqsJxzbEAwCOEz2TgQH8p30c/wuyvVwCh9vPWh3BEp1Elkac7zTekTf2Qi4MQGDiZG
         SJe9EpxD4L4/TszFmjos1IjBY6ACBRsTTbyKdqA7FdEIFdyPcj4lQOwZSUwf0uSfFD7f
         G0cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794236768; x=1794841568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KArGU3dbS/GT7fx8YVHMeJYlc6IFiFJjR49nKEqFMmI=;
        b=MFPP7ujNg/vMpIHHh51wPKSs7Nf2d5v3fTZd49lDI3A7uXPRuU7eyga0QO/fEexKlu
         p7PXE3pRqjpoYWGH9TEuKLp5hGShyVT3mi2NuHPDJmbQ7MsQXcsG4urybz4iyN02lfdi
         1Oqz7L5oABFFfVyw3hko3FAIwwL8qH18CsMll9kvP2P9tvW662Xz0ERvhF2asGBot7hH
         bWUztO3eP8EnymbdrIecB9At6aGLejM2d433vUv1Ek10iwRT36XEhha+2+g2oVIbRYjP
         sK8wIAogiBUOrMgrRRP8ggonQNFpXU7lM/JvNP6MouQ7VK5yWdf5az3Q+FbOCuAPcVXh
         DKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236768; x=1794841568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KArGU3dbS/GT7fx8YVHMeJYlc6IFiFJjR49nKEqFMmI=;
        b=EE1pS8wOhi73A0vtTVoosrVDYrFiwsKcy5noVTvDWz2Vi/q/nlYl049YgLOjtfVr0P
         2henHkazAiM+/O02MsHJ8ihyz+7JF2qzxVVYEAnlrfN56jpDmSbVpXBUZUED9seD1Yx7
         QkQWWKggXqmjyTp+w77ACNeHqRwcTBG+4nGgFB44FFx40si8gwRLh5dA/xpWgdcF01+v
         aDcKcm1f+tQzYC+GNmS5Lov5LN48LAgbqi+Mh60haQHlhoP780zSa/Y+23SyQ8VT8PUG
         IyoKB4PtDVJggnLLPFv4R1aPrZnPRb8sL8oiK+kwqPcxxJ1v9YfIauDewqav1rYLmd+L
         3B2A==
X-Forwarded-Encrypted: i=1; AL+hErEBB9KuEWgVZrZyCyZggLYT1Iv3rwRi4HOI5MOmdyOguZPtxbx3/F+dbBFFQ0WUSuTHSDq+L6oROg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/0TvPnf3ccDqSS4K7xzyneLg5lqmN8VigbbmorZweO3jBX81jT
	eb9uVLJtg7ETF52yOtI3Ztf/t1OKJQyjIlMI/2ePpi6UXzpe+91PALPe2j/5t57uEylojzYQvKX
	S3uCw79pbKZpc+r9ikd9D3ysE9+r73UiOYTepJCvKxnRlTOGbvBM0ER4iFjv7a2emDA6VJ4sueE
	uLlKl4gFCpGWaF81H3quIPLTttEJsKVgepbhoz
X-Gm-Gg: AYBFou3cDtNE/sMjyAD10u2RjkWA9XPicG780hQUsgcXtfUhHN8Er2IIQdRtf5sotN6
	7GoblhjFKXycuw66Tv+YrG7vdzkaUgqunXlvogcqdm4O83Tu1eS5N1kpERuPRYIcieBQLKHEn3p
	8JCpLgCcAIj0OFhXMCApzwu3desz5rRchZR6KPE23DbeTOIdAK9tv3YV7h1g==
X-Received: by 2002:a05:6a21:e081:b0:3de:456a:6e07 with SMTP id adf61e73a8af0-3eed36563c1mr4958009637.46.1794236767669;
        Mon, 09 Nov 2026 07:06:07 -0800 (PST)
X-Received: by 2002:a05:6a21:e081:b0:3de:456a:6e07 with SMTP id
 adf61e73a8af0-3eed36563c1mr4957967637.46.1794236767237; Mon, 09 Nov 2026
 07:06:07 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>
 <20261006-romantic-stalwart-seriema-90e71d@sudeepholla> <CAPx+jO-T_0KT3GytYu8w6QvrhXFQNZQzR496RL=McU6rnMtnPA@mail.gmail.com>
 <20261009-frisky-rottweiler-from-avalon-6c409e@sudeepholla>
 <CAPx+jO-_aY5pMnWyy1hAs1WRmfW33vc317jdtBsEXYBoHsPfxA@mail.gmail.com>
 <20261009-skilled-mature-bittern-2206fc@sudeepholla> <CAPx+jO87gkTumF=Tg=UPWpJO6O-CRF4njT2KxQ3f=4nF5m7GiQ@mail.gmail.com>
 <20261014-prudent-mini-duck-377cb6@sudeepholla> <CAPx+jO_BOwbKeRytBezm+piLhb8Z5N2eQO=LRwBQoSZ3kXOpwQ@mail.gmail.com>
 <20261028-imported-pistachio-unicorn-2ecfec@sudeepholla>
In-Reply-To: <20261028-imported-pistachio-unicorn-2ecfec@sudeepholla>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:05:56 +0100
X-Gm-Features: AclHuK8jpxK3ADXusNa2gKWHm_wiTVU05IoTbWbQE5kB1SpSxHfIgN3YPGrgsMc
Message-ID: <CAPx+jO-0Vmah=2mewp-kspV7Nqr+Ay_nnO9fTFB_TMbOoHJp5Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: Add support for system-suspend-only states
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Maulik Shah <maulik.shah@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2MCBTYWx0ZWRfXx6xum+ejEdn4
 VacS7nbaZAp+bR8IASm/wKbdqSmVSd2ybPO0QX0wtL6Vf4ugiMnAwsZb4zVIE4zreWK53Mdpx4A
 m1tydYhnMwWzFwWi7Lb8Wh+m7JtrSzo=
X-Proofpoint-GUID: bO3BRsGqVXI9hfVSjvkZp9L6iaZKZ0AY
X-Proofpoint-ORIG-GUID: bO3BRsGqVXI9hfVSjvkZp9L6iaZKZ0AY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2MCBTYWx0ZWRfX2BPvw52dSeNg
 RUXfZ5Out8qr/jcvnm45cp0fxDjlUpqPK+644re1f1gGff3qfnwELK/wpUu7OZasyCJPjMmeTzb
 d++I8zwB2oOWQ9mS2CwEBl5EfRWySvlHqh5MdBZwDtGxueulEBimkg7Rull6iTNtyedlVtxM3o5
 qWeK5OmsZeqd/ZEkp6nKTxtohii61Lk5OLZGrhEOvAP/pOpZVnk0kGump3agB+cC+ygcMlR3LtJ
 QkNH56EZ+OMumnYH6tE8lkVC9QRIgxcD1W+cax49DtAWPJ+/ujkYlYxOxto3hLe1uDUJTkcmoWG
 03X1k+eDyNMYabzVFjW8OI3W/MFVzuHqwEXKAkRQghfywIZNuGYFleEimsmMr70Z9n5lbdaon2p
 0HpHSbrYuWd7ADQvFmiQuJIo7w/uegu0hKobg1+H4Zaed8VKPBKcydr1DnwtouJpusPuuDov3bF
 lDki0fwMq6X19fF+lpg==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af1e160 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=dNvpDo67dldnF-GfnbgA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090060

On Wed, Oct 28, 2026 at 12:48=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.=
org> wrote:
>
> On Wed, Oct 28, 2026 at 11:59:58AM +0100, Ulf Hansson wrote:
> > On Wed, Oct 14, 2026 at 9:12=E2=80=AFPM Sudeep Holla <sudeep.holla@kern=
el.org> wrote:
> > >
> > > On Tue, Oct 13, 2026 at 12:11:36PM +0200, Ulf Hansson wrote:
> > > > On Fri, Oct 9, 2026 at 5:27=E2=80=AFPM Sudeep Holla <sudeep.holla@k=
ernel.org> wrote:
> > > > >
> > > > > On Fri, Oct 09, 2026 at 04:26:38PM +0200, Ulf Hansson wrote:
> > >
> > > [...]
> > >
> > > > > > If that's the case, besides that the cluster PM domain topology=
 must
> > > > > > be modelled accordingly, the display device should be hooked up=
 to the
> > > > > > cluster PM domain it belongs to.
> > > > > >
> > > > >
> > > > > Ah, I thought that's the way the whole domain-idle was modelled a=
s we
> > > > > started this OSI discussion a decade ago with an example of CPU c=
lusters
> > > > > sharing power domains with some other devices. I am surprised if =
that is
> > > > > not the case already =F0=9F=99=81.
> > > >
> > > > It works fine today, I was just trying to explain how it works,
> > > > considering the use case that you brought up.
> > > >
> > >
> > > Ah OK, good to hear. For once, it sounded like that's not the case. M=
y bad.
> > >
> > > > >
> > > > > > Beyond that, it's the corresponding display driver that becomes
> > > > > > responsible for what should happen during system suspend. If th=
e
> > > > > > screen needs to stay on it may need to call device_set_awake_pa=
th()
> > > > > > for the display device - unless it's a decision for user space =
that
> > > > > > can control the behaviour for the display device via its sysfs =
node.
> > > > > > If things are managed accordingly, genpd_finish_suspend() may d=
ecide
> > > > > > to keep the corresponding PM domain powered on during system su=
spend.
> > > > > >
> > > > >
> > > > > But the s2idle and s2ram anyways suspends all the devices, so the=
y need
> > > > > to vote in for the power domains to be turned off. If they are su=
pposed
> > > > > to stay on, the system enters the state it can based on the other=
 votes.
> > > > >
> > > > > > The above said, $subject patch doesn't change any of this. It o=
nly
> > > > > > allows us to use more states (deeper), which are limited to sys=
tem
> > > > > > suspend (s2idle).
> > > > > >
> > > > >
> > > > > Still not convinced, if all devices are plugged in to the power d=
omain
> > > > > hierarchy correctly and the domain-idle states represent or carri=
es
> > > > > the entire system power domain topology, we shouldn't need this e=
xtra
> > > > > information. Having it make cause issues when it conflicts with t=
he
> > > > > topology information IMO.
> > > >
> > > > No, it's still not sufficient to model the power domain hierarchy c=
orrectly.
> > > >
> > > > These "system states" are special since they require additional
> > > > coordination in FW/HW, to take into account votes not directly
> > > > controlled by Linux.
> > > >
> > >
> > > But if Linux doesn't control, some other entity would vote and until =
then
> > > the system shouldn't enter that state. Without knowing that it is sys=
tem
> > > state, will the kernel be unable to choose that state as it hidden vo=
te
> > > is invisible/not tracked ? I trying to understand why if Linux choose=
s
> > > that system level state as part of idle loop, the platform can't down=
grade
> > > if all the voting requirements are not met. I am struggling with that
> > > and want to make sure we are not working around a broken firmware.
> >
> > For OSI, all the FW would be able to do is to return an error. But
> > that doesn't prevent Linux from trying the same idle state again and
> > again.
> >
>
> Now I understood the requirement much better. The core issue with OSI is
> that it fails unless the platform downgrades special system states to
> non-system states during routine CPUIdle paths.
>
> This leaves us with two directions for OSI:
> 1. Firmware Resolution: Handle state transitions entirely in firmware.
> 2. OS Intervention: Enforce the handling via the OS.
>
> Though I personally prefer (1), I don't have strong arguments against (2)
> now that you made me understand the requirement. Sorry for taking time,
> but mentally I was assuming (1) even for OSI until your above response.
>
> Since PC mode relies on the firmware to manage these states natively, thi=
s
> binding isn't required for it. Therefore, Could we restrict this specific
> binding exclusively to OSI implementations ?

I guess we could, but that seems rather messy. According to earlier
discussions, if I recall correctly, we deliberately avoided OSI
specific DT bindings/properties, since support for OSI mode should be
detected through the FW.

Also note that the domain-idle-state DT bindings
(Documentation/devicetree/bindings/power/domain-idle-state.yaml) are
generic and used by RISC-V SBI as well.

Kind regards
Uffe
