Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE3545D910
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556701; cv=pass; b=fPSqlQD4lo06BOlCkk/53V+3oIRChIWheLcyfPqBO4BqU42N8giAgYOTH+kmHlXU6G0qPF7ivTS5oK9VaUCggAMMipaFbQJ+4QiNwUexGbJIOzs1IrlVkJpmNUR5yW9kbc0Q4twmgopFmJ4a19bCekgkcnDbEDYRexwAlSJplvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556701; c=relaxed/simple;
	bh=hiUOs3lVj64YP+qgdg+X3u1xuQjJYN6lKLOGoKrayZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwYlBgOmW7WtDjENc/Z7X+15ZcWM3I3tBrFLPu/6iPYZ50UuuT3rWNlXNZtg6PKAimbsN5IZ0aX3/SET808VqYniK34abG4sKTgUF4d2/CuLDwQdVJayfvUOKGdOCyEYjPdJ6dow3ODA2U4bG7Rr1z4kGbIJ9qW7grjACyHhARg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VbYUQwuJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jfBdYLlm; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VbYUQwuJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jfBdYLlm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DKHuX3024092
	for <linux-pm@vger.kernel.org>; Fri, 9 Oct 2026 14:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UMVpMFCHtMG0Xn67lqGB8w67sz48UmLUXf0QKHiAu9Y=; b=VbYUQwuJPCbtoeVX
	m7otJFYOvB2nJ/0eD5rMovP6i9TEsL9EsY+aAjWGwu4BLzi+Cow5JCrCB0CpVwpc
	KCqXEBJThkepkP4ptknCDiKzHIua9stKQaMJCjZ2OedHblO1CwJtlYJe5tyV9rpu
	zuH+iDR3Gu/xBamKr5oMgVhPrcqdRvt9a6NZNcjuUgHnC/Nzg262hRdLYGi+Lh06
	YBh4CgVsDbBkT7VgKX38+3M/mXE1SkgvkmZY007Urf4ET0KiRlXMmeMGuIl3ut8G
	4IeuA77qbU7JY5aafiRsZCu/gCck2jBsIXIWm8E1ufCYrq96pI5kCmefSMsxzfrZ
	bOVO0Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxwc0hy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 14:38:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so6975468a12.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791556699; cv=none;
        d=google.com; s=arc-20260327;
        b=cNXqC9B61rX27NJ7nxbShyRqDjIFPckY0NB9LVco22Jmpz2QF9mbSeMv4CCRODh3AG
         nVEwl9BmvUC3+SzvIpV75UuMA0WYkHH3QGR1ARwGn5u8ZXMJuCD2gZv/y7g7z1i3Iub2
         mUruszdJEm4CApJwqanU2VEjnHBXNRNNgkAMpjadED/lmb63vhDrBeHdvPaoKhWkZKfz
         nel5Sm+JFVKKM0s7UtkzRe8BnFftvK8rAS1/1sHgztLh8T5u6ugJZmWH1bV6PBzM2wgQ
         W+M+ohBY1h7gTa/qk+/Cqx+pd5YnurigOLJPo7/5qJ5eU5PuK0g3o9tev21OQ/UQ/ay4
         ocZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UMVpMFCHtMG0Xn67lqGB8w67sz48UmLUXf0QKHiAu9Y=;
        fh=as0ifp+vbp1FcGes/mAzm7YuM4O8xOmPF+Ujie45lTI=;
        b=bVsgBYZcOQVpmauCv/SAiN+wxr4s890dVYUnFF2UaAGe05KueGQtvaxftHprxiQPxe
         Fq/c3AkOLhfPqZS3BwHCiy6IKEHMrDvd/MwEn0I/mFVqcGkw1nFUOnGsEl4pRbd9tc0R
         mDTBkkj/fhIy/7AENx9m+S5GOCAgXpOY+Wl05UgdkHBWMx4ND1sbulsr1NHXGZRpS16S
         qW9N9RD8j7qb1M/OCpi1CIztY2h1QI1uTpbbG/KlFgNFxGITqf9EWn/p8oqCJU0w/AaB
         VW60JgiyA1+2B9ZJH1Q3bKihQsAA8p5/RfmuBn541bhR9AyP95cSTEIKCfIqvJF8qQUS
         PSwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791556699; x=1792161499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UMVpMFCHtMG0Xn67lqGB8w67sz48UmLUXf0QKHiAu9Y=;
        b=jfBdYLlmsp2GwguhZG4Tf4ObietOqsFbQa/Ha49lREJVZQyO5Nta17XKc0qDq/bTQU
         hARvyQZDMclT41VWKRkIfHAUUxVJEv55SPrME0avRyS1CdxeRHwZu2yBwgtj07Ka22rj
         eyDE/NsLyAT6jS19tSZYTcp6Lv7wmNL/QDxM74JOawbJucm/4tjH4gEiAvZ6VEOvR/ZU
         yDzPjRSDKdGfMauz5/83cuoPgIF88pgUZj1e5fwBF2kI99pgrtNLRZxbRpTr7U04SY0/
         Gsp7hLVHVEGJhNT2BZlx9HawvKTIAcYhEIrp9dHLEKluYEskqfc5vitt9Uq8X4DGaR9n
         2a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556699; x=1792161499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UMVpMFCHtMG0Xn67lqGB8w67sz48UmLUXf0QKHiAu9Y=;
        b=zBJZPerqr4fWIQkJUgf04x/eIIoOWKBMj8zlGYMm+zCmIoNeLquDHUrgCC1tNA8GNY
         6mnFvY0O/PmMTfQG2128Pk+Rod1YbfVCFSZ2vT/iuACUDQQfj8CC3pqPRCfBXCXictM0
         GNZYaSYKDpHBKtszSzbFkgEs8GR/AvwRAL/cFB7yuOBmHtqtaHOMelzSpWRpUQMthKK7
         I+rq9P8Nn0o6QIkxXiI0Xz6EZrk3bM7GaoNAF4nVvhndwkYREGH682LKv0KMVuLOi9JM
         wFs5G8s+tbVl9WCoSUWlS0ldi02MAAP9uNsbgt7CBftBYzZ6ENPbb5pZQF+PsiO0gfH5
         RPNQ==
X-Forwarded-Encrypted: i=1; AKwUvByHZKEakKzTKZ+78S2hVZLYUtCzO70qKmqfNGQ61RY92KFZVwXQk6lGa9donEIDdkxW3AX7tkfJKw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIUEgxQ2QCV90rTDi2UI7BZYqWh0vV0f7hYdkTz7bgKSugu4trM
	6+q6Kbfwm21ZmT5Nu1fisx3po74rD/+mI0pmVhQOBbVVAVbFrhgHcrEtMs7LvmgXUZV2ZJJG6n5
	H2k3/OWSOHH6bvv2MbuCxcNsN8OqW46CWlxVG6yIcq5HFG9RkLsSQGmdp1vK/Q/4F/D/FVu4Ful
	NRkiCINW5CBM21FkGvBVj7EGHji15Oo2Yaq/9W
X-Gm-Gg: AYBFou2z+RdphAO0jTpKrQY7tqFLjhPE7U/ybFuhjIdA26ayEu6iF81lvrd+otrZes8
	YAiHac/qKIYeG/SulvwdWFGDxLVMTyNCcALdHpSzjwgPz4mIklawlYVIITis64+2uDY21TDa5D/
	6ceQ6Ggw4vE+RA3Z+4UTi2RdVV9YKyWbJwiXwzzDcJOsD19jWexr1jvwDfPg==
X-Received: by 2002:a17:90b:1e41:b0:3a8:9b79:e6ea with SMTP id 98e67ed59e1d1-3ab3a96ffd7mr2186069a91.59.1791556699221;
        Fri, 09 Oct 2026 07:38:19 -0700 (PDT)
X-Received: by 2002:a17:90b:1e41:b0:3a8:9b79:e6ea with SMTP id
 98e67ed59e1d1-3ab3a96ffd7mr2185985a91.59.1791556697914; Fri, 09 Oct 2026
 07:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
 <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
 <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com> <20261009131902.GA1195061-robh@kernel.org>
In-Reply-To: <20261009131902.GA1195061-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 16:38:06 +0200
X-Gm-Features: AclHuK-dvh3nBN-NbcFTG0ZbDjXuEqk09evXIZaWdeTMn5nwqDOFCebwqJJJ9Ag
Message-ID: <CAPx+jO9F6wUG9M_cV-xiF-KAKD5kJ02n+yE6L9vocs=KWaKFTw@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] dt-bindings: display: ste,mcde: Allow power domains
To: Rob Herring <robh@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfX3IG+Tg+xZBcE
 Cr4hq3uMAxjcHkT36SwIghKgeRAq+R3/JBq7/OxyejYNwjxXztTD1SeX5wDQU69O7YyJANsGpvx
 EsJLm6B0Ovd88XTfDL4hEuTHHE5HSYS0FwslmtyUU502xo7tFyOGSiOWrbwutlDWGRtH4+dY3fD
 SpBYAF2FwPHBc/80X3gI1CuPpjwjSPwckBcI7w3IpfV9mNuQfXX+pgraxgcfPzcyB1q1QxECFMw
 ajH1tuP4028cNBD6feGvYPPrnWE+Nb7hUTA4QpX8DdAwadazafxA8YIs6u5+SQsaYP/1tjrzbG2
 p3+PjiK839doNhAQIdmNSZM7NHKPWnfdNtb+Ic8PArhB+Z/WhHcQGP0cJrJ78t7mpTDlXdDdOE3
 I/sj3RuuVpOh/h55EfRLecpQ7GS2f56f6TYCKJE0lk/c899VUyh2qNioVJpfalvhl6jh4x8WLol
 8Iq3cN57isy2qUQs77w==
X-Proofpoint-GUID: EY5rI7-yQ3O1v_batzvcuW7piAvvs2rb
X-Authority-Analysis: v=2.4 cv=cMB1IVeN c=1 sm=1 tr=0 ts=6ac8fc5b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=sRttis5sQqJQ8Uet4gEA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfX+m6gdndh8fHG
 B7J2e8sydhPhGB+Bxp47JjO6NYl8R9jDXqWDL0T7tyJlZ8ALkPggy5jzQFxspZusyRMu2PmDXo/
 5dg7ydwAgZV7sysKkMKe8sZySr3KXuE=
X-Proofpoint-ORIG-GUID: EY5rI7-yQ3O1v_batzvcuW7piAvvs2rb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090058

On Fri, Oct 9, 2026 at 3:19=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 09, 2026 at 07:05:46AM +0200, Linus Walleij wrote:
> > On Thu, Oct 8, 2026 at 7:41=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> >
> > > > +      power-domains =3D <&pm_domains DOMAIN_B2R2_MCDE>;
> > >
> > > This patch is in next, but the define is not breaking dt_binding_chec=
k.
> >
> > I screwed up, I forgot the dependency on the new define :(
> >
> > I asked Ulf to merge the prerequisite which would resolve it:
> > https://lore.kernel.org/linux-pm/CAD++jL=3DgFt9kKZH9T-m8B_pbwRvzc35tTrM=
n5V238d3528DpUg@mail.gmail.com/
> >
> > Is it very urgent so I should just revert it? I could also just merge
> > the single patch adding the defines into the drm-misc tree if
> > Ulf is OK with that.
>
> 'make dt_binding_check' errors out. That kills my bot for anything based
> on next which is most patches.
>
> You could also just remove the define from the example.
>
> (Note that drm folks require a revert be posted and acked or they will
> revert your revert. I learned the hard way.)
>
> Rob

I have queued up three patches [1] for next from Linus via my pmdomain
tree. The patches are also available for you to pull via my immutable
dt branch. I assume that should resolve this problem?

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20261009-ux500-power-domains-v7-3-rc1-redux-v1-=
0-5eb1b90bc35e@kernel.org/
