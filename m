Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45033D45E6
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087507; cv=none; b=HSi86YxnZl9Ioja3OEtR2WIKip/kTj55AtnCMBhu7MJoTQqEvcfg+VS4INT0WLUfTYgks74z++ZMdo8z7UuDL0XZH7m9ocCGkUWZKS+vyrvu3JA7XUc66fJnMLYEm55jIE9HucbBsFxQodntPP+Z0QU/OGm8m5grVjnqU7jb5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087507; c=relaxed/simple;
	bh=4yB2Y5u8aFXapmD6u+a/gLWVA/skpYwbSVTikTd58WE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gy1l5kVAhlyFnLjwIFQEnxTjkhPlQc2/g/EjL+Oxon/AHZAcbOAUJLv1T3GY6Fg21rK7ru6jIobuROnhQA7fWAKoa2k09XYj96RNbOy00wjS58utAmTxPHw4D3lKwKMfjL0iI0VFMOnAtxTdLQsXTu/c3TAa5Q0UHVa2cIcSqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=nOz3+1D3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uqR8JExy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="nOz3+1D3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uqR8JExy"
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1FC497A0127
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 14:05:00 -0400 (EDT)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 14:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1792087499;
	 x=1792173899; bh=4yB2Y5u8aFXapmD6u+a/gLWVA/skpYwbSVTikTd58WE=; b=
	nOz3+1D3B7kmETDqfhoc4wGO9LkMBq1XrhBM2/+O4BRxAkXMoTAF5GBIn6trNkmq
	wYMLv/FZ3+NgLwNlPKtS8bNMH935QS7pIslaRr1cMk9e/xFGr9Cg7oTJqW2hpJi/
	GdR79o7IKJO1pY0FjKPa+CK4PXQUJ+vcDTrIv8qkZMggeku2gVTi5N8+to/3dO1J
	4tVS8RaV6nUtktHj74Yx0ebyehIXzD3AsvHDcqaFA0j1r9IuOeQyJ8Qko3YJZBPF
	m29euqAGuanknDfH81eCAcjLw7aPDzAl0IZJHKt0wXMIN6Sm2wRLxtO0Whyj1w3A
	4UqF/Q6Z5aQW7jyzz68qjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792087499; x=
	1792173899; bh=4yB2Y5u8aFXapmD6u+a/gLWVA/skpYwbSVTikTd58WE=; b=u
	qR8JExyt99pvtLQjlc74UCl9CezdGswi2vqeJmQ6AdSVFVdDk1b9NabZjZl/Ouk3
	BiQWGdE2/koO6CkzN2fMb53uX2clWJFOSrKhNrwqcKDe1aLzdL2inURYnMI/ku0w
	vf+2sxro7TTzJWCw2j/7vKNLEeAYDU4c9kw3+1xqLPiqJ6iQThpVlfButfJ4uCy7
	nqn2fxpjAXTaIlv61/KlYWV5fZlQO14XeNIRsC4UWacffsSmvO70NnoILqD2zGCX
	v0woIoBDtcAhRHdBNLfiFv2wrUhN15PDw3gEje/QbbWrymB59bH7Pzb2x1hbU6Wi
	ftjq+vOyE1auGaIt6zViA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792087499; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:QY3eHIQJDc86aTCv7P0yOnQDSYjcCqfSuMVBUVqwLIxLKrK
	22rx9SOBiPqRArEz9Y0hHtakmbUzkvven7+4YRx8dZrLvvCk5bSdCE/WaWUjB1x7
	Ybf4WSjvyhKCjrR0PL2E9ulu9oCsYV+spijzZgBcxLOR892Z3HLElqGrLLP5c4Xi
	GD+qhp1kReK7Me+/aTCZ4F2RKrLYc+aI0cpdg0xV1V0NoTm1e0qysJe+CyBgi9WA
	GDGOF0VuNnO0EVXzggH3subxi4/KJMbWw5N+PQYvmiQefsQEwWVh4NSVY4GBlR8b
	EQvu4P3xm51AuHNVumPgAzlyssMWl6IzZCufARw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yyqQTI0aMpJ4JKDe6Q1dI9JFftws1lzFENsS2EhJTuY=:4yB2Y5u8aFXapmD6u+a/gLWVA/skpYwbSVTikTd58WE=;
X-ME-Sender: <xms:yhXRatjSwADLJShPvaI_fpvcawV4RsAgPuHQJRbN44PWZLhWzwqL4A>
    <xme:yhXRas2pNhqOUki0C9AA1Hk2wdOQ5cN9XOmYq-NJZl8wSqFmbQO606Ienda6dHj4x
    AmCqnq-qjEbauxEdzpP-kt3_-36FLMmWVVnAuPb9FAAogWU6Z3lpoG0>
X-ME-Proxy-Cause: dmFkZTGK8zdX4ZQ1sZzKIFuSMxNbjxQ/R06Lb1pbAAXv19stb0UBuhJD0X+/7UZSTWpED+
    VibnngELO1eljGnxafpmOCCHVDuBfgVnyg7mo5UsNrSPiBPLeurtfVwfvEJT97p3W3CaEi
    azgiTF3JWvrj+1o76Y8oiMlMFh/8ypUdkUYgj8R/lhyMryDSeF23wVnp0Sm/iusqt0qM5n
    mKLbNgMZuxaPnpsplVC0vBkouL8Hz8pQQPGRSEV2XoTJjIFvQwiRnOsCwJcAnf5bl+IXl+
    Vhw6uwLw5rUSA2kbpDeQQTDryEYgZWWfkZjEr5uzcCl5vSurmMAjafqHOkVwzZwnTFlTbp
    xv3h6fGniz8ZepQGKV6CvyPFPx1Y5Fmvm5xHgBpnjrNC1NpZ2UjOtjABpHIrW45yIAAPqQ
    KK7O+uFRpt/6s5UssCW/SqxOYsN48Iljg7BOZCET5dEKHJ5eG03OlIS3ndan+g7bIJvkox
    Hs9AxSZ0+OiNGh3fEmAhy4ECyVkOiBZWjF0H3XRyDuxYQEXfh3A6OYi0YcnJBRuTHSkCKt
    P/BE++RPnd5fdlfkpWc6R1Purenkk7dp62Ng3p71krZMMY2QrgNPpEOt4SJXTu+BjBk9u8
    47tjhUA/ijr2bhp5ORzMPbdCqwPnP2jS0UUv7xcgkOEULOwuWi34uTqFctSA
X-ME-Proxy: <xmx:yhXRagRDsLQ0ZGHoTD07qU8GI-ahKEEgAtMYp7aGd6R0_At1m9-RnQ>
    <xmx:yhXRave7Th43vCEdAG29pxvmhLjuXZ6ogG8_1d4PKXLb_PPrXRv9Ng>
    <xmx:yhXRahSjGBvEMmB1hM-jC9MTYpx44Psx1P62W1n9ygJ5YS7eS-6R0w>
    <xmx:yhXRaj1d4LOTmqctiAtbVOHgPUNj7PbiU4egbHj-ndDxEi2lnVlX6w>
    <xmx:yxXRahOTUvFK5HGx47QocYlJKHqVequ9b5Qb7hQ-Hcp8Z2KNsFQ2p_-e>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 5F0FE2C0007C; Thu, 15 Oct 2026 14:04:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ao5-L1TSHHD-
Date: Thu, 15 Oct 2026 14:04:38 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Armin Wolf" <W_Armin@gmx.de>,
 "Daniel Lezcano" <daniel.lezcano@oss.qualcomm.com>,
 "Hans de Goede" <hansg@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Maximilian Luz" <luzmaximilian@gmail.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Jai Luthra" <jai.luthra@ideasonboard.com>,
 "Greg KH" <gregkh@linuxfoundation.org>, "Jack Wu" <jackbb_wu@compal.com>,
 "Mario Limonciello" <superm1@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Kurt Borja" <kuurtb@gmail.com>
Message-Id: <1cba0f2a-38cd-42b2-a773-9dca5d7519e5@app.fastmail.com>
In-Reply-To: 
 <CAJZ5v0jQQsXP4v7dymuHZhy2oVjPwV9eXhqV4bGPUgMyGyUsUQ@mail.gmail.com>
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
 <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com>
 <c751e18d-57e9-4ce6-95dc-1bf53a7a4808@gmx.de>
 <CAJZ5v0jQQsXP4v7dymuHZhy2oVjPwV9eXhqV4bGPUgMyGyUsUQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] platform profile: Add firmware-neutral aggregate sysfs
 interface
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thu, Oct 15, 2026, at 7:30 AM, Rafael J. Wysocki (Intel) wrote:
> On Wed, Oct 14, 2026 at 11:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
>>
>> Am 14.10.26 um 15:24 schrieb Daniel Lezcano:
>>
>> > The per-provider class interface is firmware-independent, but syste=
m-
>> > wide profile selection is only exposed under /sys/firmware/acpi.
>> >
>> > Add /sys/kernel/platform_profile/{choices,profile}, sharing the exi=
sting
>> > aggregate callbacks and semantics with the legacy interface. Keep
>> > attributes hidden until a provider is registered and remove them af=
ter
>> > the last provider.
>> >
>> > Notify both aggregate frontends on profile changes. Also notify the
>> > provider class device on a direct profile write, matching its docum=
ented
>> > POLLPRI ABI. Restore aggregate visibility after a failed registrati=
on.
>>
>> IMHO the aggregate sysfs interface only exists for backwards-compatib=
ility,
>> so i would be very happy if you could just make the associated code o=
ptional
>> and instead teach platform-profiles-daemon to use the individual clas=
s devices
>> instead.
>
> It is not just a matter of opinion AFAICS, the aggregate interface has
> been regarded as legacy for quite a while (see commit 778b94d7ac17
> "ACPI: platform_profile: Add support for hidden choices" for example)
> and it was retained exactly for backwards compatibility reasons IIRC.
>
> I'm with Armin on this.
>
> Thanks!

I don't think we can get rid of the legacy aggregate interface - which I=
 think is what you and Armin are asking for? What does making it optiona=
l mean?

Reading through the patch series it seemed quite reasonable to me to mov=
e it out from under ACPI but still have the old interface working. What =
are the alternatives?

User space (and users) are still using the aggregate interface in my exp=
erience

Mark
