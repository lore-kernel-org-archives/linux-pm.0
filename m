Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B393F8ECD
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221464; cv=pass; b=uyx8EkuJ1YYIsur7Xk66MVjOk/fJu7tDc/OQFXLvVdhvUzJ/afBC14pIlhBjIaZSuD9itb+lpwUI51CsbdViQEWOaBH0z67w9xMF47nEXJaH5zrGjjJX1x0Q/Z0+CW9AL8gR77oXkmuRl3B0+JackQ7krGPgobr65RtakkDUr0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221464; c=relaxed/simple;
	bh=p2QMU3DTYzx0hJvixVYCYPw8OSsNqcb3xQFG1Mg3X18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPIN+PZu0uiBjdp+F7aYfWhtbFmjlUcI9ee2g/a7iydTqmjx3j9idL3/FwRMeK0DhlV55UlqkuymdPYvyHkZlyzfB35hqHXI9OHcd2UUxlakNAOzmvxU4XK6lqxpTQV1kqBQCwGLh1q3f4e3bzBwKCThsaZ2OMzKCrbAKEpUtBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NlB8zap4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JkvYKJ95; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NlB8zap4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JkvYKJ95"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6eeLZ2161287
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 10:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ty5/YlOK6jhAeQysmUgT83beKPjDWgvudsEIa05/S58=; b=NlB8zap4bl1dTpi/
	b77sQXntHv1GfNurcpg1EXnyTgwpZQ+R78j2BoglrlZvcovg72q6QAhNZfrYzcqr
	GCwMe36xIWlsMUYFJg8JYGU7TK6ZgYfMV+pc0lL6XogJV6HWr0LEOLcfyjLsqv1m
	ZNq4SlEiH17wGWg3jha9yW8w706I3uJe4rCwJjbfD5Am7ydlP/iNJjbivrLwrwS+
	x9zOhcGIvabtlfi89CueWIKKke4cwPHsg46q73d9VcaLPyY/MSWxNOaUT6WI97fp
	1du9a25vtOEz36lozAdQyY+2xlVha4vci5E+Etk7h5hFpMtrrVUJvTbcfOsZ8jJD
	DQkAog==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7rub6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 10:24:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e01a62d99so2523323b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 03:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787221461; cv=none;
        d=google.com; s=arc-20260327;
        b=BcZjmlmSlvVY+ghBRPTFWM+x5mISsqrxuI6HUJwEmk5jLjhLRsHqAxHI0nE9uSy9kc
         oBoI17e09oazHhG3SCUrl3xK86x6T35Yf7JtwKPZWJMad1s/27d28GUgVd/K7aUTj5Kj
         1JOSao+JNgrrjFWP9MEOyEftd4BjKn+2ruTR4vZNvYROgPB7N9YrzpHFXRIXJgI37JEh
         tWzkpah3CU1y/+gUIabCZ4KLzDYcWMQ9UKkz0yWrqO53/oltWYFRw6mvuF3RpiRB5j2w
         MV9wIZOAedllpJKNxuOSqRENDp0tz7hLuM4nIW2cFS3V8emksJo+rv5esBpHA5XeC2Az
         Pa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ty5/YlOK6jhAeQysmUgT83beKPjDWgvudsEIa05/S58=;
        fh=VEhasRdn0SvcUqzRxLo9RK8hvVKnb1QTF8y9LVBXz/Q=;
        b=mzjuB6zErYYctP9LjLMg5+hpGj0vv79z/uEd+S4UmDL116JJSb7wG223yvstzHwPyq
         6PFbawt8O5FCPrZzuMD6IRq9o8X+Q5Wyd5NmeDs3J0o+CHUey6RTCgqqeFW2gwVjS9uc
         hUsRBjtDQU24+7nPbDpiQKnvs0idTXYhSFTLtjBzq6JUHJmVmV/gOVyPd0gWzb5doGjH
         fDEpI8tO4OIR7JJa+1WWJtbnjBUOGKlaEzjEwwvl8l+3q7TkqJYwI2E95hf792fCxK5o
         NpWPSZUWHkEtE7fMDrBRfCdN5vAyi+wuGUsJ0Cqu8F8OWkOIDnqjDzJ/f6IRSGTmXVTk
         rciA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787221461; x=1787826261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ty5/YlOK6jhAeQysmUgT83beKPjDWgvudsEIa05/S58=;
        b=JkvYKJ95KgONw6owUNOPlCJ1ysho2lfe5m6A4jWVsagl46uw+6WzJZUh60g6+VAX01
         pYlw9zXWFPy7Ff+CG8J6d4J5Aogh16GJ4F7lLFEanZcQ5tDQkiKOm41vNmFLohNekoeN
         TozYf8tvbaneWa0wyv9PWZ4oeRqtAJYoVDeG0buNdfLBFvoGNnJjXcSFiHtKHu9bUdcm
         k120Xset93TcdG34p2XM37EewzqkcQX1GZIMnPLNJTvUAB5A7QN1/JE/2kMCLsBTNj59
         AaoqoJI3Qsw2qr5r6h79X1RK97Fg605gAbWwXn+a78nGP6+UL4alM54mrutuNJTmw7fB
         287Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221461; x=1787826261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ty5/YlOK6jhAeQysmUgT83beKPjDWgvudsEIa05/S58=;
        b=bkD5WCT+6ZoPMwKXKhBR6pKCazw8inmrY+KkOCtqjrBKv53O6VhlmzViXUYcWsFnf7
         lDlBZlZpHxUQDD7IZ/J0qbL5xf0ZqAaYWZ/SF7kBscDARleWW58r3vmeS/iBNDMrTO6c
         B4l4Vo6Du4GDjd3CD0SzN4K+Oq7A6CLE84ajlMqmwO5vZ+X2t34iDvqmk6PTtWABCi3b
         08DG3YHCnaYyVbhUud6X1pgjDPDpfMgf8t6B39JzX43AE9l/GtQyEGG4iPGgoh2gfYvZ
         Wkn8ARsqhZiYNc5cYnR26FsGx/TBqojTYbZrWWe1ashcIUGSsQY15zf8bYHp8I1kXUJv
         98Nw==
X-Forwarded-Encrypted: i=1; AHgh+RqGslQWieUxJsDf0uYtQe7paOobJseACm27SKyb8rkdmKF9fpq700n+vcWQPtWy4ewhpBIey9hJ7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzol9SHMA0p0ZzE+JTTOtWAgI9BC/SgIBe5H8365wI8H8iSmaXN
	peTt53R7X0FSPOvKPXelepA40ouyu9NirwaQWw+FIu2q8IhdwwiK6RdjuhiLxBYHD6F2ytKIOoA
	mzV9kLVvPesJF112PeBjAy/5gwdJTUAm22pMzYlEXVi0IFD3T3EQi32NRXuBE8iwplzU5f3oqTa
	dmph3BRlNCR1XDpWqJzszqoi6RpvcLydFqLPB4
X-Gm-Gg: AR+sD11kdaezWaI2j8sutzEzpyBD4C1pHxlwM8FDYiBpFkjntpq8LkhU74G10cHLCBs
	cgeoRkREjGGINhSQ284eipDJwmeNz/KqHKmBowev0atoape5r4qknpfsk4OSaby4YqlCOsi1UjM
	knAprswlwGYnPC7e2IOAaCht0Lj6eVma997sFHSKG+WMTl2W7YqAdLbt0pAg==
X-Received: by 2002:a05:6a00:2301:b0:847:7ffd:ce35 with SMTP id d2e1a72fcca58-851d382e720mr19263267b3a.8.1787221461185;
        Thu, 20 Aug 2026 03:24:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:2301:b0:847:7ffd:ce35 with SMTP id
 d2e1a72fcca58-851d382e720mr19263163b3a.8.1787221460718; Thu, 20 Aug 2026
 03:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
 <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com> <CAD++jLnzDmxW_SoJ9H1tS2_r+jd7A7FpLVp37nK=dOEPj=GExA@mail.gmail.com>
In-Reply-To: <CAD++jLnzDmxW_SoJ9H1tS2_r+jd7A7FpLVp37nK=dOEPj=GExA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:24:09 +0200
X-Gm-Features: AcwNN1XagjqLsUfXCAJXyqu2taAnOsy7gMxOrYs8oiiblP73dGEaPVwCq6ztGis
Message-ID: <CAPx+jO-+hLsAdDC9Ep16cO52cA2c=xKeXvngkGqzoC0FyxXj+A@mail.gmail.com>
Subject: Re: [PATCH 10/11] regulator: db8500: Add power domain regulators
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NiBTYWx0ZWRfXwcXps5zWmCyV
 al6nj/T5Z5Vuhe/V9HFLsW7/SxlbLMq43C3ldd9pEVsmUkKfs7sPop+jk9xgVBC1dfBkqw4e17H
 Tlpfqadfmru9lBcciQRfhANjhu8852Je7mL1iX4ylx/vKWRNzd2xFmMIsV8GGi1pjNWlA/Ts8Ti
 NcY47sMmKrLsPhNqUWnh0GYdohHq59nd3kHLrboWBHJuf2jHsz/3XNEjaAL4VI71eOD182/0ULx
 9KmBIS0KDPlmWL0GmF8sDUoobxBdVSVcSKlkbA2wNNGZ8Uy8ODGzU+W6w3/Rp0cUqACGFDjnOqq
 fribjqbyXbeyDdYUFw5ClctZ/vZNNTg09zQlcGcEorUregzIzXaIKR92tJXqpRAdTOCMVxDu2T2
 9aML+TlxQ52i0czzA1uVLTrCswl9WJr9Masr//xfwV7vQVeiRB6IK4UzEz1d5xFB1b0121oeQeg
 tejvtR5DQVa5F7J+8gw==
X-Proofpoint-ORIG-GUID: r4G3ICEf1aeQz7izjTOYf2bPwKaBikFa
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a86d5d5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=-_xB5rzH_TN0feDXJEkA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NiBTYWx0ZWRfX42jQ7h89/jaz
 acaT8QEohkWVW+jwmEZrSEhI7pQf/+0pgJRPwQ2/ZL2/yLdfOm47iVLE30mv6dfztcW9xjf76Ej
 4YbdTmv6guhkWtLZVZTeCgJowf6fT0c=
X-Proofpoint-GUID: r4G3ICEf1aeQz7izjTOYf2bPwKaBikFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200076

On Wed, Aug 19, 2026 at 3:30=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> On Wed, Jul 8, 2026 at 5:53=E2=80=AFPM Ulf Hansson <ulf.hansson@oss.qualc=
omm.com> wrote:
>
> > On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.or=
g> wrote:
> > >
> > > Add a DB8500 regulator driver for the VAPE and VSMPS2 compatibility n=
odes.
> > >
> > > Back the regulator enable state with the corresponding power domains.
> > >
> > > This is done for off-chip consumers: the corresponding voltage rails =
are
> > > routed out so they are used for powering different peripherals using
> > > these voltages as supplies.
> > >
> > > Assisted-by: Codex:gpt-5-5
> > > Signed-off-by: Linus Walleij <linusw@kernel.org>
> (...)
> > > @@ -673,6 +673,7 @@ db8500-prcmu-regulators {
> > >                                 // DB8500_REGULATOR_VAPE
> > >                                 db8500_vape_reg: db8500_vape {
> > >                                         regulator-always-on;
> > > +                                       power-domains =3D <&pm_domain=
s DOMAIN_VAPE>;
> >
> > Hmm, isn't this the other way around? The power-domains node should
> > have a regulator supply?
>
> They probably have that, but that is not what this is about,
> it's the other way around.
>
> > We may even consider to skip to model the regulator altogether and
> > make the power domain operate directly on the prcmu instead.
>
> That is what the series tries to do, as a whole. Sorry if that was unclea=
r...
>
> What we do in this patch is to deal with the fact that two of the power
> domains, when enabled, also turn on two external power rails outside
> of the SoC.
>
> Since external components such as I2C devices cannot really be
> claimed as "being inside a power domain" they take a regulator.

So with I2C devices you are not referring to the I2C controllers, right?

Are you saying that these external I2C devices consume the same
regulator as the power-domain DOMAIN_VAPE uses?

I thought these types of external devices in general use a different
voltage range. Moreover, do note that DOMAIN_VAPE also has
corresponding OPPs (performance states) that change the voltage level
based on the requested OPP. I am not sure an external I2C would be
able to cope with that.

>
> This is based on my understanding that power domains is an
> SoC-internal concept only, so there is a clear boundary if something
> outside of the SoC starts to use such an externalized power rail.
>
> All this regulator does is to make sure the corresponding power domain
> is enabled when the regulator is enabled.
>
> I will repost all the patches once v7.3-rc1 is out.
>
> Yours,
> Linus Walleij

Great! I really appreciate that you move this forward!

Kind regards
Uffe
