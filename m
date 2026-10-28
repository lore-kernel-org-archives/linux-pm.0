Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793185218;
	b=B/hOH3PIbPYamVFN/2k1ak/w3C1vRCcHJFXHEIabiMPGLR5yaUwm2AMeqCsKCz2hfndN
	 l4peCxf8esYGGKsqWV4TQWpLRewt0ARG22h2j8qmIfB40ciIhdg8T7HOixmM3Ym/R/WOC
	 rlYmXKp6TJMRM6J33nRbZpHuxtokMP7hqGZgnrmbNQg0RvhY8j+xSwqabrJ2W73CnJ6aE
	 DJea3M9X34tOeOUVnXF+4YTFpeeMP7fVzyHeIXy+UeyTi4TlNqQpwLbuQkwZhueDdh1QR
	 TCoBnkWdH2IjwVjWMjAvs8uYKy6qx+nlIYm5Fn21pvNrgwS3nY10fYSbDcrLCqhhOPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185218;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1wa+/owR94gXnrAcOckNHscnr8fLSqcbseBqLJMCJV8=;
	b=R5enxv9lw+W7FIOar9+WXfEE82vqFKwDdSghuHRBDs17bdqnRkZh1qTm4J8z8+qufQ9Z
	 tF18zW+fRDNmpcCW7+b2S7eCBUlXcQJDkcmojFUu5BVpnxQ37LX0J1p8KSxu+nhmZiigH
	 KV9VKhhsCkC0UQCc3JlcsJr4lQyTgLb+HK2nccqmZtagPhYX//1x33nA4x7Uz4x6wrCYP
	 NBNna/+fG8xoqno0a90ohU3QRtmQc8MhYJ1tmCOFHi8k7CQIVRbLtFBIUPMKp33LZ9u0g
	 KSWF8fYLNpZXjIIm7A8jg4XvpBSogDcUikxGaTARRXb7W7WJOvRuhvgF+Q1739rH3yA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YLZUaHMv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TwwPPUDa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D2606A31C
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 11:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 821D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YLZUaHMv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TwwPPUDa
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8Kqgu1101742
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 11:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1wa+/owR94gXnrAcOckNHscnr8fLSqcbseBqLJMCJV8=; b=YLZUaHMvORb5+JOm
	pG6DIHFWDZCgl6lavcglKsmKSBHvYojRNB2UznE7BHNJKjVtjehpaXBSngpbtnCk
	OCsMb6xLFLL3Jh43HIREbPjEargv4QqJED5H3FeXVbxaZZq4l2oKrdsKuJYSw+L3
	hQ78YRw5ihdKxJhXhM6aPpnwoZa3jIod3pDbSwgb03x7caVeMeOfyClpTss+NY4R
	5W5yXsZZSkpoN829u+IQ13XhSJr3O/Z1iSKu8weAgT/rYrQsz2dArQgUcPf/35hf
	PpGI1UXTWE3PDnkkbsMwa2L6nA31G8p6B3vQreWi9edsjsOrUuoq4Ge+uwnY//sI
	XZbljw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdf7rjhx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 11:00:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e93f266d20so11519405ad.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 04:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793185210; cv=none;
        d=google.com; s=arc-20260327;
        b=VfUd/EeXEVeDoGvU3KC8M/Qb6O20qNVZ39OwFEA672SUINLC11QXX0DCPW13zBYtr4
         ATEToaoJJhlQWDfmCuBl81zvUVcRoqIL08cD9THeWCRXrC9Qa8bPt2Y5X309Qzl4YlFZ
         Fcwug09U7DS1nnb4ND/RMMhVTKukulv3PPSHRwtMwB1y6ixB68it2geoNc36SjZwXqnQ
         Q+QFdDaF9U7vxKd4XFnXD0eI569Jx33Fs5xBTqRWy9ALkIT4sDBzTuKX+0L3ZRp3FJSy
         mHtZo0ILA6KR1+2oS4k1CVsj9DoBhpc4AwK2dl4l6Oed2CLZvvVff7e7yRm0jZAz/ckV
         RewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1wa+/owR94gXnrAcOckNHscnr8fLSqcbseBqLJMCJV8=;
        fh=NCnQpBeinYtWTcs47UMV4JAmv33XXwXJzlAyXQ/ZpZM=;
        b=shkBDDLuS6SkNnuKBv0XzrL05KfZkxj6DIAgIgP2H5yiea/gwqWQmVPiwVu8tbkhVD
         qbxHftNehAfuP89XuIn5UqTjT2SvM8NX1WYU1qO6waRqdLtpdwNoS4VJa/hRnmJizfxy
         ZPX8x2lqNIOzkVfATfHtFCDUrRjVPw8D53KazeemyIyS/xRjuLJwJQ0MUOYIYndgAUOV
         KpiYuilVexfxtw63M1DQj+v5MwRV8/bKv7PeRID4/iVLuzrhDT1QYuyX9WscNyzSAtGk
         0iHfGCvYQ9YbqE9Sh4PqsWriKMgmLPe41aUYvh+HEuumRD0fsD1+xelNltRzY5pTS7x+
         4WYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793185210; x=1793790010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1wa+/owR94gXnrAcOckNHscnr8fLSqcbseBqLJMCJV8=;
        b=TwwPPUDa0jtCCNmldKxmcrc9NtQgN0xgFHn7Z65f01ViRnrPtkmqFpIKItmIqyk3Sv
         B5L6lhtFgmcE/LDKLBvSaB+shejfHhYyr0TZYe0J/CQqWLk/GX1xQ+lF8YbGiBy3J2id
         9QfnFej/IrD53IvxcpVc4Em0c+JTLe6Ma5F++UJz2X0tsVboaadbm8yjbnmOXAQ9/zA8
         n/va1fQpbSC6DAoYdnUAas0RzlUFKnoPpwnwyzEUwq9/vYRxhywLTmGHYVlr1GxtVi5J
         zkLFeLqcg+Zpyv876RkTkm5tEcPB5tBp6Fl7hENjfj442AfOsan7ZSCrnnUvj7tPn2dN
         xBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793185210; x=1793790010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wa+/owR94gXnrAcOckNHscnr8fLSqcbseBqLJMCJV8=;
        b=nqO2IyXHLEY95WGuKW5u6Znmxk7jQ92iXOifdp1FOLIw/eFrv8XbnmZVCNAUkXEtS1
         ofS0ZyacTaPorHZdpAyAllAm7p+hBpfkyY9rTf6A9jUH/c5JgQ/UjQu5hGUhTZ0vx1OG
         +LDE9IeAFyAf8EKczesosOQEYicTQpJaf7cYrmjc2tJ/NMPTvlJwr2gcW/BPZxjEP2My
         NcEHNjTxAOm5EE0tlrDfrYBbnQPsxyfrX+Hl1NbbUiA6gyaJkSWVG0G7EhWujM7T6/wH
         MdRKoot9j4t0oTm2nXRiLMVaR6z0PG28qMKIoGYQ97LoR6MdLIcV3OCLeId/AByHgCaj
         Njyw==
X-Forwarded-Encrypted: i=1; AKwUvBwIE8v2/QinhR990JFEAWky+8JydXNE8d0900g+GRGi2ETCyh4W3sg80YbSwCnlt4X16joIYU3zmg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKh0MyDw8an8+6X5uR4SJLbc/B2/dtnGKZG9puEXQ0s/vx5BzB3
	SGKk8R9xbAvnOZC6nu+dTvqDZmIdLcrdCcRMe0PHvIdpdSUosbxhr8Qj//tBExOd5UI/6dNqkoK
	yV8FmxZ+lruiKOwRIdKWwEm6IwTCnqt+m+oyMd0hPsOcNMapCjZCaX0XDGUpDP1nCZB5HKq9f5i
	5WLr7IIluFuH9IADuSMZCkNYLgqW6j20WVGKhw
X-Gm-Gg: AYBFou2csuNf1+N8vbKX0Ep42S/A+fl0HO2FJslVkIlv+zReq/LhN5AVGmfuG0UlcDz
	PrQ7ZafozlTGTGYW7a8jum3NiQDyATaUQezaGCDgZ439O+z1y4ibU/XX6b/tSYvFR2QHRubby2/
	cMJ4Zv0TApkbL0ca1+Q5EKuhjK1h38VJvf//uiKNi4grSGZlrBEw3ijuSu8Xu5+DeLrSgN9e5x1
	MypobVVOmOSsvbDDA==
X-Received: by 2002:a17:903:244c:b0:2e9:7dda:bfd1 with SMTP id d9443c01a7336-2eb003cdd36mr19355735ad.30.1793185209838;
        Wed, 28 Oct 2026 04:00:09 -0700 (PDT)
X-Received: by 2002:a17:903:244c:b0:2e9:7dda:bfd1 with SMTP id
 d9443c01a7336-2eb003cdd36mr19355325ad.30.1793185209362; Wed, 28 Oct 2026
 04:00:09 -0700 (PDT)
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
 <20261014-prudent-mini-duck-377cb6@sudeepholla>
In-Reply-To: <20261014-prudent-mini-duck-377cb6@sudeepholla>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 11:59:58 +0100
X-Gm-Features: AclHuK-LQgnIpxOBv6YIR41I8lr76Fns1lvAAUTxZNI-80rsX3bNmiwX8o5xW2c
Message-ID: <CAPx+jO_BOwbKeRytBezm+piLhb8Z5N2eQO=LRwBQoSZ3kXOpwQ@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=M4bYuCws c=1 sm=1 tr=0 ts=6ae1d5ba cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=Fkqsunai0WhB3pQShDEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: LQQ4zjrkVA3-SbcXxVyduCmCDzPYlVTY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MyBTYWx0ZWRfXyNzrWO735Scw
 6YzuPsVhOoSRIXvT2DQYIYL9MLZqHL0lf4ogUrX/RiMKa+TXxnJ4jiCiMctBJPJF5RbstWyKdG9
 xXKuw6GlPasVqA7yjsatYUgKvEgJI8k=
X-Proofpoint-ORIG-GUID: LQQ4zjrkVA3-SbcXxVyduCmCDzPYlVTY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MyBTYWx0ZWRfX6b8bUEgm0yj5
 FDPWne5u+2oovPRmWuqyo0qVaQhoF1u9zBZ8CMQUv1U0olIZx/NidhzHPjq47XHtwDwnXOPiq7+
 LOhSa6JwMkxUCY4TEhxZpIx6zqLxwZXHv/S9yQmZppzSx3cQs/YmmCQSsUYrczx5SFDGIZil5ht
 13ECaAV5sVd14X5Amn+dlPEenGibpXKMn0LR7jx6/kk8a8WwNQpD6icVJAGzD8Ku6yfRNZ6674z
 MoQnTyu9ls9PfOwRNpfO2MvvJaXRPIscoYXhYHd1RyRAR0/4pgGzuRs9iS+lln+hOCatu+yG7rh
 7met7wCZp91/pAsTG2oalgMXm3YC5+l5YMj2xYJWmA/zaYvSeKyutJiqWMVPcu1cMSDrHJm/zxj
 XjAbqV8u2Jz/yeXv+jtJ1ANDkimMgYiygweVPsnGUvt8Ngg4avEWZCCTf3dnGwMURXCR27QLtvU
 fZaBDWwskZXIkiBX/Xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280043

On Wed, Oct 14, 2026 at 9:12=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Tue, Oct 13, 2026 at 12:11:36PM +0200, Ulf Hansson wrote:
> > On Fri, Oct 9, 2026 at 5:27=E2=80=AFPM Sudeep Holla <sudeep.holla@kerne=
l.org> wrote:
> > >
> > > On Fri, Oct 09, 2026 at 04:26:38PM +0200, Ulf Hansson wrote:
>
> [...]
>
> > > > If that's the case, besides that the cluster PM domain topology mus=
t
> > > > be modelled accordingly, the display device should be hooked up to =
the
> > > > cluster PM domain it belongs to.
> > > >
> > >
> > > Ah, I thought that's the way the whole domain-idle was modelled as we
> > > started this OSI discussion a decade ago with an example of CPU clust=
ers
> > > sharing power domains with some other devices. I am surprised if that=
 is
> > > not the case already =F0=9F=99=81.
> >
> > It works fine today, I was just trying to explain how it works,
> > considering the use case that you brought up.
> >
>
> Ah OK, good to hear. For once, it sounded like that's not the case. My ba=
d.
>
> > >
> > > > Beyond that, it's the corresponding display driver that becomes
> > > > responsible for what should happen during system suspend. If the
> > > > screen needs to stay on it may need to call device_set_awake_path()
> > > > for the display device - unless it's a decision for user space that
> > > > can control the behaviour for the display device via its sysfs node=
.
> > > > If things are managed accordingly, genpd_finish_suspend() may decid=
e
> > > > to keep the corresponding PM domain powered on during system suspen=
d.
> > > >
> > >
> > > But the s2idle and s2ram anyways suspends all the devices, so they ne=
ed
> > > to vote in for the power domains to be turned off. If they are suppos=
ed
> > > to stay on, the system enters the state it can based on the other vot=
es.
> > >
> > > > The above said, $subject patch doesn't change any of this. It only
> > > > allows us to use more states (deeper), which are limited to system
> > > > suspend (s2idle).
> > > >
> > >
> > > Still not convinced, if all devices are plugged in to the power domai=
n
> > > hierarchy correctly and the domain-idle states represent or carries
> > > the entire system power domain topology, we shouldn't need this extra
> > > information. Having it make cause issues when it conflicts with the
> > > topology information IMO.
> >
> > No, it's still not sufficient to model the power domain hierarchy corre=
ctly.
> >
> > These "system states" are special since they require additional
> > coordination in FW/HW, to take into account votes not directly
> > controlled by Linux.
> >
>
> But if Linux doesn't control, some other entity would vote and until then
> the system shouldn't enter that state. Without knowing that it is system
> state, will the kernel be unable to choose that state as it hidden vote
> is invisible/not tracked ? I trying to understand why if Linux chooses
> that system level state as part of idle loop, the platform can't downgrad=
e
> if all the voting requirements are not met. I am struggling with that
> and want to make sure we are not working around a broken firmware.

For OSI, all the FW would be able to do is to return an error. But
that doesn't prevent Linux from trying the same idle state again and
again.

For PC mode, the FW should be able to downgrade the vote. Although,
from the cpuidle governor point of view that would be suboptimal as it
means that we will try to use an idle state that isn't really possible
to enter.

>
> Sorry for being pedantic, but some real example would help to understand
> it IMO.

I will coordinate with Maulik to try to share some examples.

>
> > I realize that the description in patch1 should be extended a bit to
> > explain this better. In principle, we can compare this with the PSCI
> > SYSTEM_SUSPEND support. The difference would be that PSCI
> > SYSTEM_SUSPEND is limited to support only one state, while the
> > $subject series would allow us to support multiple.
> >
>
> I understand that part. SYSTEM_SUSPEND is sort of platform co-ordinated
> once the requirement for entering is met.

Right! And I think that kind of explains the problem we are looking at
quite well.

These "system-states" are similar to how PSCI SYSTEM_SUSPEND works.
There is additional coordination needed in the FW to be able to enter
these states.

>
> > In regards to ACPI. I think this is as simple as comparing it with the
> > list of ACPI S-states.
> >
>
> I need to check if we use ACPI S-states via S2Idle which is the case with
> this patch set I assume.

Yes, this series enables the "system-states" to be used for S2Idle -
and prevents them from being used for the regular CPUIdle path.

Kind regards
Uffe
