Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5149DB90
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540245; cv=pass; b=BhuZZVxtwLbaZtvF2eyOrDka+HHNgnjsl1x1FYB68mUI6T8X8+mGn9y9EgeQf6nzgrPElRhhigAa/WfcMX2KofntfoH3+YCOIrwepY6ErBQqG17V9Dwmy4eLs0HlCz2wLLkfQ9LglI6OrPnZbZN81ChApzzcj1WmoBpncwtI0IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540245; c=relaxed/simple;
	bh=PiIEJBacYP8RPpVhrEdxj6N1ZBrQAEJntz0xmldB7uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COJe818scryf8G7GFrqSyQp0wIQqdDmG0cqU90ndQpPXWebxneYLZg5FAA9WpsjQyuFKtaKfasKPascdLg3/3eVANN5HZ1Tn74/1g5/096OtKHGMJ21Jl2/2VxR3acd4Ljz+zKeRFY7nTuSUZV2hdLJuYqtkKz4aA9JX+UHePpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WEXjmYKV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cn+iYpeF; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WEXjmYKV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cn+iYpeF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KH7i230902
	for <linux-pm@vger.kernel.org>; Fri, 9 Oct 2026 10:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RGFAbqayoGzkNoR9L5GgWnoZmVxL7JzSyp3JwWFjq1k=; b=WEXjmYKVBun7yiWt
	YcX80+2wv35fcTXvK0ES0ZsZU2i6UqtGQUdqQ4VwyEeUF/DSdreHDgunke9Bt6Zb
	uScCI2vzXkW/VEx2NnFgsweM1StFeweU8GOg82xUFPbMEEMB5NkDKsgUgKSkizv4
	zY5MHEbeGsyttEzp9ebcb3RpBQXkvjgKnoSv8ArUfBs/s5/Y6GOMqcgILZDcv/pS
	pEcgCWyXzVgPO46tMgTDwL6Q3MsUFTZ0c2FA0U+PYKGZBGvML8OXH3wDKGQHqrkL
	9HJuqxwi9YNtGh4mdyRvz/KF+F+jklfT+CQgBQ8hU22qEI+ihK0+Ax9tR3OQTFbk
	B8hibg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu30v0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 10:04:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88c76888646so4610045b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 03:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791540240; cv=none;
        d=google.com; s=arc-20260327;
        b=fjzBT91NAwsGX2w+EUE67aRYz3LWv/FbLqTERXHBZs4ET9Li+tu5c560ZWTlAyFZAY
         C06suYGHwJsRfwoZJxQZ1geklTz1exJutt07gBhEJPjAFK6GSdoNzXX0Aa0zMyz7NMON
         8plh9qZWU2dtRfxSssECPgbh7MnQ2vd4Napz14g+CrjLtfm+yGlJdxoQ80nPkyA/1yXC
         qo2qQtLaAVLy5e8g/McO5ObqoIqboaLY9MhelRpo2hF6/67mbOlODniKXkpl6hrC0+5d
         3JOfXPao/lhjjp/JYsP4K93HIIOD2dOx05IQsRP0B9p0HKo3RhcZBbZhPQJHjmLmkQep
         Mhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RGFAbqayoGzkNoR9L5GgWnoZmVxL7JzSyp3JwWFjq1k=;
        fh=Pb0POMgyoRqQG7FT3LIXtk4hhBBgxaytzXj2RFQHuWs=;
        b=CNXcXZc9CPbTHH1A0w+fHiFRzIyHaLIR5Qiet/1uXwm3twY+HmgRED+zV8j7YVUJ5q
         a2S0q4GfQn1AL3xUA+z9YrsanLsw/CdB6yo0sI4A+2DMMXYADlIZPm3MK95U4gmzOUXt
         E7Ube1EpMBkMx2Ox7sKSaTKwaSjpsYgOaBoH/S9pg+Ynl5fx0tLi1Gy2KbuVkDM+t8NG
         kjWcW63uMnhPmKN+3KvaULgq6Antw/9ZcBe7nwNGN+gzGeCoUgsk3vCDHmwXtHglHLn7
         vWzSqo+BvYHpJaRqY7PwRpK6kD7Dpi4Zj1ZZV7IV07xlQ4sxIwyKXd2kgObW/euSnLDf
         wpIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791540240; x=1792145040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RGFAbqayoGzkNoR9L5GgWnoZmVxL7JzSyp3JwWFjq1k=;
        b=Cn+iYpeF1wxWB/Q0vk9Za/mHwuHK06nHpCGozYkDbM+vXFQ2g4q0UNeXahm2KN4uhd
         xn8E8Uiv36mBANv4zZCfb5JDWjLgoZW8tmpoVeGCybcd814vGxq2fkgC197ze+aYUdwt
         DE0dlz0yo75hLo2f1L4qo0/pps+aZjyrWNzbJYzdL+laGVvpYpqe2ktVDXyK4FgvUpdq
         0QbCge1F2m17mHp0zcAJl1vjmwFSZw5fPtTwQ26hUBqCcPdrnfP3mOmhz8RpEZW1PanJ
         807dOGN9P65bL4qSNy8RXKJrembzW2Hs2XYShaSfTmdG6O4/UKAqlh0zGGUUd0GMcBsJ
         KBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791540240; x=1792145040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGFAbqayoGzkNoR9L5GgWnoZmVxL7JzSyp3JwWFjq1k=;
        b=rLRoAKxohNOKk0k+ayteZH7qSUxzWJl1hj84T1rhGtYFOyNYijh7bDUFzyjwetTuIr
         VCNzWdGO46V4mhR6PA6BxQHf1rycoz5gaolkjVpiVVddYPELW9i+3oQ8d1ueNqtZkouA
         Zj7BdOED5DY4WYLpDcF2xVVFpCbg15MB79xEd2cUIIb6cqdoQ7OrxMabdvFu6h2ywOpU
         5Vqg28Gjcd1G9sLP9l+jLCVT7BAo1GUohC8RNlf8Cy7wrFnS4ax0kF2U8JbtofbgHeDw
         PKg9q+0I1bjJBXFaNjF59f2alcujwBQnQNMC59swssh/s1p0hbWJmEAyOKGNR05gOWv3
         zRGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbnL69jrZaNJpqbGbV8qLTfo0au8/YQi72do7uwVdLIzE3AHW6kZtBjlipXEwC9dVHXV3X/IQ4YA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJPJsSk9UlC+gfWJKMsporuGz7esa6gZm16nATI3tgivv87+fhe
	s+zP4E2sGq0XFdpijLtRfMNrsONBm/prtIVvXwDG+7QiCz8SNWQgw+JmRY11dbqCSW2XkmTm0Ub
	1BgT6Tnvoa0nIYrwfCYAAuJqX7EFnVGHnRKvGSGsTq+yPTLtmepB6LhQIb2IyLSVmn4tjyn1FRI
	2Lx+6pNwcnm2sl2k33RGAzwMrMhLKv3x2rg/4R
X-Gm-Gg: AYBFou1y2PtbB/4jvynwLpAv/EDoCTO+3wPDujH28qbm5OjDbll4PGKYcRwFlVmPABG
	lTr9K/M2+vZGZyHYN5K8AstgJkWxRq/XBS9gvu6Q7d/LbfFXa998OsSA/fEoSx05h9S+TGGDGGv
	3MgzY9bCAqUXOL2LV6tLCR1/jpsE77CgGjqmqE8gpfcggKvGYO2FczaEeCsw==
X-Received: by 2002:a05:6a00:4f87:b0:881:1fb6:a81 with SMTP id d2e1a72fcca58-897c3ff538amr1154981b3a.3.1791540239793;
        Fri, 09 Oct 2026 03:03:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f87:b0:881:1fb6:a81 with SMTP id
 d2e1a72fcca58-897c3ff538amr1154954b3a.3.1791540239339; Fri, 09 Oct 2026
 03:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org> <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com>
In-Reply-To: <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 12:03:46 +0200
X-Gm-Features: AclHuK9hQAW8ziR1wvAdOw0nLveraf3a0x0LG_1OOR8LPyJDyZu5bXvxmgGRPSA
Message-ID: <CAPx+jO-wb6NLYjnn_k7xu=Wqq61+vop9o7UM=5Y47U-WiGFXBg@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] pmdomain: st: ux500: Implement ux500 power domains
To: Linus Walleij <linusw@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.li@oss.nxp.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzOSBTYWx0ZWRfX/KVct4Oz9aXS
 1nYViK+Cz5CHOuod7C2VlHCGWwnrt/fZFSTldksr1Vl7mQJEGPSdY+ZtMn3eK6cZ2IJwd6gu/Ci
 M8E5PYpmePw05jJxKRUDbd9S+VxrkgjLGt9NZZOtoI2p7Ly5a+BDPwbnvRpSRJN5CI7JEx7QqJw
 tGLueV/ux4oQL9Z6x9/7H60sJLFYxE4edamAD4kZnF4FMm6QrzwMgMwsDicXcJjWotiPnGd7+TB
 kPrFHzf4XArFls2YtLsmipRmcph/ELm40X0xkk6cYV6t4o++9l3Oz7vBQlFvbIwlWJFXke3iRoG
 xUg5rTmBPb+mBvK7ndeilKJiwrUz51OXIyd8lyGWyDD1FhzDPP4f+sCJqCha7rlidt9K4JZAHs3
 BTAGp6McmENUbiczvOivx9GsnsEDhrIgORMpb6PqrIHoyppjDRo7m2TUW8lthxQ4Brgpj6kGaWa
 ThTrchMSjKWFD6SdTrA==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac8bc10 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=MPZ65LRjT8IzFkvHGtsA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: NNQR2Semjg67UlbTTjBKmryN5lk6e0tk
X-Proofpoint-ORIG-GUID: NNQR2Semjg67UlbTTjBKmryN5lk6e0tk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzOSBTYWx0ZWRfX3zipjmNBm3A3
 czSRXqV/SmimGqqCl2FtxXeOlOhXyTwz+oI/J+2F1hNelzUpBwAEhlJsQxNAjJHWanQyggGu6UL
 0HNfk4JOKT7emf+KgL6sz8L/Kq6dzWE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090039

On Tue, Oct 6, 2026 at 12:30=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Hi Ulf,
>
> On Mon, Sep 21, 2026 at 12:48=E2=80=AFAM Linus Walleij <linusw@kernel.org=
> wrote:
>
> > This series pays off technical debt from the beginning of the device
> > tree for ARM initiative in the early 2010s.
>
> I have so many fixes series that need to land for v7.4 that this is
> mostly targeted at v7.4 at this point.
>
> However:
>
> > Linus Walleij (18):
> >       dt-bindings: power: Convert Ux500 PM domains to schema
> >       dt-bindings: arm: ux500: Drop NR_DOMAINS
> >       dt-bindings: arm: Add the actual power domains on U8500
>
> What do you think about applying these three patches to the
> PM domain tree as a starter for v7.4 if it's not too late?

Assuming we get an rc7 on Monday, it's still okay for me.

Although, please re-submit these three separately in a v4 to address
the comment on patch1 from Krzysztof, then I can apply them.

>
> They are reviewed by binding maintainers and should be
> uncontroversial and will make it possible to avoid trouble when
> merging more stuff later.

See above, I think you missed the comment from Krzysztof.

>
> Yours,
> Linus Walleij

Kind regards
Uffe
