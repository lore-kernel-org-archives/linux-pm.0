Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6643BCD14
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525094; cv=pass; b=o4urOzeM1ctz/+Td7FAKdH+bBLo/biLtFoURUNMm5Ubzkc13DqZiaVWZEfhnsTlWIJtxf/JdedTaDC+Q1dkoIZqWOF/GEy6YFfC+7R5uCjk3c3SloqDB8EP1EY1qiMKRZMNkcuYPOQHk63YUwaJL3yFU503BdLnPEfydaYKhvU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525094; c=relaxed/simple;
	bh=J0DBJDhPyKi4K64Ojy6y17lBqGHCMu6qO5alVMzFIw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELKzkMWl145TFnPKWJG99ZmGC2P2d8KAT2jBoVysY376UwETdZw1E9C0eVbAiq7O4PlaBCZSA58WVghZIou7mjv8SIPLNlP7yDz8vf3rWwvMkFU9qqhZycgRMlukgD6nx3IUEWR/BNsXoqlOx53lLcTr88Yo9kIc8QWMqnkXVgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLN4Thzw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=grKDoszE; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLN4Thzw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="grKDoszE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8YKQX2527581
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=; b=GLN4Thzw5ppeE/wd
	AoM/dI436IbDimGs9DiOG5iPm7qlx7v6S7ZCsWR5VkX6AqY1pmkxpxFieue1OfwE
	uP6toMsp9mFWD4H8oo74JxFN9Uy2fTTcpLx3+PPSNqpAoRyV8on7fVC/V9hGkHEU
	jNl3i7/7rzkLABjCcbrgPjKcje0Byp9mHuIMQ21dnkMxYoMpUj6/sCSoshoJ0mGv
	sEebEGKjtdgAeNtkyZD6m5oYasD9OiE0K57Zn4jMExI5k71q7lRgP8Sfv0tp4RZA
	GkKGzEYPkJUm+7KevEH3JBqjtx7o6eEWMvOhpmg7vQWgQw50tIJngXLdC7yGIGsn
	jqnT/g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd8909-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:58:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso2190258b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 01:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786525091; cv=none;
        d=google.com; s=arc-20260327;
        b=JC5S+r1pfNeupHuhd4NAzCpwqfElBEC6jsRVWOqz8VqBQJRv0cl63CExpgq7zJUgsL
         32q+MQf+XZAqMOlPC3Rntoun+RgHYZK/Cp92HCPadfvAqaK6stz9iJy0L1HPlHnwpPk5
         6aOzYGYFrTysmN49EH37li+KWLVbPHaNnQblTYbWjIwisdbN37Ii9sIja5eeFLU8WC4A
         n5Or4sqqsZ/rJ/Ss73fjOEZvVBCdbiGHbt3hkiIq8Gbr2UgK+34wF9Av4bXgUoFQy9YS
         U7CAvcoXDkEQZCVDOyTrLnAS/kwuftMcom+3e2xjBNPY+NCTB9OVb98Se3QId1OotYMg
         AAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        fh=qEIeGSEN5F0PFDG87qxFZvUaxV+c5A9727JLn3rDE1g=;
        b=IaN37zaIFfnysTBsRh+7yRdkwRH+WTe8QhF9Atn7b6wIBIQi0DzSXNYfkv1Mw6gx2e
         q+f1fK9XvwCpV0AeGwaD/76hI+cfYi6n09SMA9hgt29E2XN1x4i3lOLlbCHVQmQ8CC0o
         KRuLmlY6MBJZXbT7HBPI8AiXVjb7WEcxwXJuPAQlYcO12U2U5WQafDBnMCgKetuD4zgO
         bIZ9J4aGDwWSz+5meXC7n/KK5dtWDzojyJo8atYkawZHY/+sSSN14fgnWMqpKDvsR2B+
         wzI8hTcPFKjPEIjgBSzBf3bPcFreoMmXCV3mYaEOeucQ8jtCiimVQ7VRZHSXr82ptyO6
         KXfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786525091; x=1787129891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        b=grKDoszE4bHmiPL64Y6bp+0dIoBtk18FS4gYbk2RaWfNjKoQgbD5gN7YTKEdfUJSOL
         thFuj6H/U8RRHtEi8X8Pp39QgOo9tilaU3Ejw2VGlOvC+YKU4lMAWtzepYjXupybn620
         b4462p3hpwAZw/KIu8iNAPDX5qZBYARjnvMp4EVp4qrgMX4/ScMr5VtkBNaZYndxMOJq
         +Ur1Eo/EJdUc/Q1NjW6VewWS+iqW3T3sflf6w8MEnziw0h4adAK2q3bfTBCgu5+rwf6Z
         sqRvJYWUNIEF8e/h0D6dQUQJfvbR1A1wSNpP/hI3MJMb+0DzxKcgIQIqAmDi2ZCPRKwd
         tezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525091; x=1787129891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        b=X2jcqYgSDX2qn8niEnXtCxWLy6r89yokvamYNmtsbhDxASq0tcA6JCNj7sDG8AWnqq
         AlR3g6JwdIKL0shdGgsmtcmIOFVa1l2Q3dq5o1C1SPVv0EoN5J4XMUW7bCLqeSg2cXna
         cfivj0OzHMM5JpH4peLeGSfTqtD1ATXyqAv/uDC2tAadJsBGuq+gdbcUwe2yICUPQQ2c
         /Vu2c7fdcoo3u7S7z3h8nGMFOvspBGSX1cfoaGF5wehWxy6ZETik9bmSuDfQAr3SI+8d
         Z+7O/z3gLP715Kk2ey5+yaFTt2tLTs5XhJNCfgsZlc2yQobdt8bsRQsbMIUlpRkt7mlv
         B6HQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIi8jpmq7ser7mzfsPrJGY7U//XqO6oc+7Y0BPhHGi5ZZYlGonlG0mMN+jdpHcEJGyCFugf9dROg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx21u0ZB8st6yPsfSlZhmmvaW1Y9nxez8SqZzX5R8wAShSXcQC
	gi68kSw296wH+Rxckfx/0+WZbHpK0f4aI6zkN1pJUhob6Y07Xfs6TIFa67TFKnZEfOI1xyuVTEF
	caF6BTv6Za9kmFL3RE5dsMhG9HwdnlWFjkLP2D/5VT247hh3h4lQ3Q0HEXSCZFgW8CNlHNsPPva
	ObWrhWczKTJ+6Tcbs+TwQ4D6YW+I8E/MNmpGL+
X-Gm-Gg: AR+sD125YpU2MjXWyBtmgotR3ycPcnxZs1dyt1iPHiCW2k1FGvLvvdQq+TRWXECOUy9
	uuC6qCkbDeiqZfpETVsgWPY4StAWN0LmDqIfxXL0xdzSXvwB9XRA4L1y1ASkTLESY7s4YUT8vEO
	WYA0n3cJDXZ1l3s4p8kWotOeN+iX1mWXzWiwzYQRrQOe1rOW9dAjYD9fa/6/yCtDlo2aNKwP7/y
	6qJO5+Arkuz0sp/Hg==
X-Received: by 2002:a05:6a20:3d1c:b0:3c4:1916:9d44 with SMTP id adf61e73a8af0-3cc3f913cbfmr3419281637.16.1786525091143;
        Wed, 12 Aug 2026 01:58:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:3c4:1916:9d44 with SMTP id
 adf61e73a8af0-3cc3f913cbfmr3419211637.16.1786525090708; Wed, 12 Aug 2026
 01:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
 <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
In-Reply-To: <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 10:57:59 +0200
X-Gm-Features: AUfX_myh6JDkLkJD-gnKUbWgAMFmmHbyR3eCYV8kAAVu1iWiCFaF1Y5_s5Z16ro
Message-ID: <CAPx+jO_-1tZfZcjae9shyWcKPsj0fM1SvRzC9_JVOvJr--EeuA@mail.gmail.com>
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state()
 on state 0
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfX+KetQztwFtMs
 fgoi1jDfqFbjyEXoikmemJNYeTSot8EFr5C4mxy8CNMCATDWQHFDy0Xux0E/it2ThTrnzrjlbMb
 ltcRspOHSpFj0VkB3oawEwUMVSf6OrQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfXxQ+yIJ/SLhtF
 fwEQWXnimNFavCz9YRM0XMLVlAWpzPQcMJ8VvXIgah1+lVPc0Wx3ZsV1QSM6QGlqS6AIEopRjWn
 ypbpi5mxB7sLO3SEAbKx300cKD7JrsXAUtV7Ixrn9m7XXg/0X8bhR/firNU22LZ/wgLyUbbq/9N
 8FkNIv4iggcc0D5j4lgqU0Rps6znYAsEPksFEaC+u2pZn+RDio4t/1AOi5tePmqKGiFbkBejGmp
 7seXi/+ggqGQGAakptx8PUkXNp0ViR1fYS3lY1Cu3YePoO4RzYLO/cfa4Vnp5DqNPNIdbUrTdOF
 Z2D+bMp1xGOprtNevyQ+/ebH2VGVrs21psBC9na8DUdZYCGnBW3usdRCVVhx/J7oDFc1udgsA+U
 rWrBdJHC07VsqemGbvRSlq3Xl0+kZfuhKB2BeoMXM8u3OD72g1Iz7jxb5kUAKWM3m+02HB/en1v
 3+OMHA8uDCK6+M9e2kA==
X-Proofpoint-GUID: AjKZO07Nz7YpCHIBtN8W6Q2YeqdFiNIP
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c35a3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=4tH4gHCIEoDemCCG4kIA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: AjKZO07Nz7YpCHIBtN8W6Q2YeqdFiNIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120071

On Wed, Aug 12, 2026 at 9:24=E2=80=AFAM Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
>
>
> On 8/5/2026 1:27 AM, Praveen Talari wrote:
> [...]
>
> > ---
> >   drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain=
/arm/scmi_perf_domain.c
> > index 3693423459c9..e390f902a444 100644
> > --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> > +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> > @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genp=
d, unsigned int state)
> >               return 0;
> >
> >       if (!state)
> > -             return -EINVAL;
> > +             return 0;
>
> Won't this cause an issue to other drivers ? how are they going to take
> action based on changed return value ?

I think it's rather the opposite. With the current returned value
(-EINVAL) the driver doesn't really know what to do. It tried to drop
its vote, but that failed - so what can it do?

Moreover, from genpd point of view, this fixes a real bug as the
aggregation for the performance state becomes incorrect during runtime
suspend/resume.

>
> Remove Acked-by due to this till i give back.
> >
> >       ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, fal=
se);
> >       if (ret)
> >
>

Kind regards
Uffe
