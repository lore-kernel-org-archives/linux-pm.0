Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618643;
	b=z/+97ZeQi091s0VJ2wUMmbn820xWPwy7OB9g4kP0dSzp3ORnBovisiG1H8wdIvaV4hQH
	 QaJrL5f4ieAYGmD5dP1LfWR2rRCpdZq2fNf2W9MmeUdKoNI97h+rmfuIvkOJioNqMuUsD
	 91UG+95S+dkhEJ9qQRlbpiDywgCFj6KY92lz/KdyHSzhQzTsvsZMNmK5Vm87O3Vum5uSD
	 R/eGsqfFP2zEaaDrXUq5JfIwxUFLm0Sb7plPrtvwk70pZT5NcRxMI3M3F/SDfCU/sboE4
	 pHqtxF6IjcFJ+OsyVp9vVafpoDCv0AvfVQYHvI5mA99fjIF22T4F78gQ8ZXabW+yYbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618643;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=iVkP4rDEQ7/EdCZ1IUGDhyjDM8nQB2s5/WPSMzgN9SI=;
	b=JHRxzeb5nCSvQ/GJllfL4uIUm9fM4hnH4t9DoVuAhwG9XxKJKYwi5yq3dryNH7n89qZh
	 JP2hsEo08RkNepNatdWg6qM32anVZukVED8XhoNnusJy0hdIZybv1EgND9zbleIFe09LF
	 GCThN+wnYNyrDYFZQgnrzNMEQjfM8DjdKBSL2lGMadyRb9eqXciAFdHIEg9Imiy9rCO2z
	 RXXC1UrCs9FdcLQUegsgiFyIY6UyVhFRZIP8mwAbbz3UvgoFGo5i4knvY/M0agyFsM7MT
	 Qm2FsOkBkNfwGuhLFbVTAuPFfUpzfxJcaOHSVPcWiekYU8so9s9ARhY/GgegkZTJS5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=YNpyvxop;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Dr7JKgcc;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393A606A32D
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 14:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B393A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=YNpyvxop;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Dr7JKgcc
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id CD29213810B3
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 09:57:21 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Wed, 25 Nov 2026 09:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795618629;
	 x=1795622229; bh=iVkP4rDEQ7/EdCZ1IUGDhyjDM8nQB2s5/WPSMzgN9SI=; b=
	YNpyvxopUJAaFvfcE6BEEuS6jDLRbLCWRmiwpIWshkl/pEPD7bYjCwWthqOkC+uN
	8Hfuh9grjQI58gIZIA06zmI6T0EeQaBpyUoFqarRJ6BvXoChAcprZU0217zpKJEv
	VLSdoJDIeXvsVJ1Y4w+KW1OddwRxddtfPw+D8HjLApDf+WSmMZPIbH686687Xn/p
	uVgd1GW298GSU7unwpz9BO+yr8BHvgY9DGIIajH6uX/UDs6YnKOXPCKrpDWlqgW9
	mGQODFuD9+DMcPrjJIVkuiXPClA3k4W7UDQzQWn/c4L7+t2yRyz3/aqoVF8+gpAz
	WS0HOvWszdxml/I3GLv92Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795618629; x=
	1795622229; bh=iVkP4rDEQ7/EdCZ1IUGDhyjDM8nQB2s5/WPSMzgN9SI=; b=D
	r7JKgccgEDo0gJ9bqhDvIRfWrlwoxkSKR7yDYk43pBG667ZienLl9e74uonEpEng
	aRcxdxoAsQwEp539rpg32cj/onbjoON91pqF2jRUYlk+UnjBs2AeVs+x0TnXEBPh
	bGPk6BrDqRIkqV1ZYuOfxB1zgAjxsS0WOK2UfUAQYQxsi8HWqVGYj1aZ7poxwsIz
	oyRXdSeMHqHm6vhcZlAUUq1k1ANm1BArvHgJxZbIW1mSOmmBQ8qsS4aEgDcsf21+
	Q8j+8q6gHoIlkvso+5ee+lKiCT5Pvz6TmzcNj9n9x7G7EgfRReU56BE+bpdltl9G
	jjv0yox+i2gDl6KOIZLjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795618629; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:lwSp3OfBgQTOi57TSSiBhIIqEJaVnElfXC6vbLXFBrActU+
	PGlJEbrv8+G7wVa+o0kx0iG9uVnxksn+3azwg/RIQ2WqAppJ4PoeMTjYcdDJ9bWh
	O4Ky2as/odoOnbrf/FCgAWnj0KeY5I1EdWeh1t5KQrMCmnhkXPvLCyHRNpIJEayw
	aC/9/Tl17weE8y9lD7fpizoQMDQky8gvbx6aW+NCG1HaaTqRYa2NgRNodVZBn758
	D2rEKVZUrHtUwcYaf4srdAPtWJWeW/HEcRpQ/V7xlTS1v87jc9/GSNiaaTYvhJ1T
	QLRVtdMH9S22yYf2uYKTF7G9ycVRAEN62DaQroA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ay1chTJ85YWyid5Zm9dT3a0OQOaSLwIXzawSdjOdQTI=:B6CPTVA9o5nt1bPkZey1vU+8Dht/LmmRYtHTp5hQjO0=;
X-ME-Sender: <xms:PvcGa_VV0j6E4kmmVtQX_w_ub25Bp3sSSJRwHa2PZc83v7sBrvRtSQ>
    <xme:PvcGayaLM0jBM2tCCMfeYqnWY5uW9_PfxOiu5-dCtXa6dRnhn6Dan9n94oUQO1d3J
    V20XnNrziXIr4OAlTzahtVRvy8Tv3vGQwzr0HGhvPzxu3BSzFCrKVSZ5g>
X-ME-Proxy-Cause: dmFkZTGA2Uh0AMBdrBEHqmMMMWz13VchEc7pGA+gzkINl2ErebF02siO1gHL6d+lGmKk1P
    rNXAHunhQDy6ErfvBXm4tmlhmz+xRl/lVRfy1K5sAwh7A1K/7AWARHWutEt7sdOYZLv2nZ
    ENBgjuoe0X7WtYFtbYYPiEDEvQGgXfj0ni7KzAnb9lXishaqrRlq+GJugQfFV6PEVmBSOR
    I8DVN+hTwb/FHDvfXXRBvtpkQW6iB46Hs0B7z11PqSL26qdCiu57vmDcgMe5MB+4chseeC
    kcBfxAI6/Wh571fn6DxCe52Tj56Li7YDxZ1mzMlBp8IVwmCr6yt4vFLYUvggqjIHyZ8HCC
    xEnNtTZIQhcszT8xCBxPYjrcWTzlRF4FqZMDv01P2Im5iNYICWgK/pzHOsgEOareOHLySW
    6d/3UAFGSQ8LhZIiobHorxC0wTfs0saYnWcPDzlWXy0rEmRwaNuZ+sc+Ykbm/HreXAm3E/
    JpYnZliIFT1dux+iYtVtRPxHVlNaUT/5GRptfi1Sku0x1Knvr1RU9USfRRFO8npm/es1lh
    rS3njSYjpqLwAsjbJT01qcuY+GL8EcHEG4f0FRwCPGw8NP6kuxLoG3NrpdK4WY7w9zEXit
    DxeTmy4rvkzabFBtMPu1Bcc98YMcHwhZWxpiT8mm7ctJOVtVi1563Emp8wag
X-ME-Proxy: <xmx:QvcGa58pY5UkfYlCCObGu7PpuFKqCCVMBLD2jag1DbFXW3ncQSIHBg>
    <xmx:QvcGa-7lVDCTcH1A-C5t3H1s1lSP_HgsLM3vLScY_Gu_42zaLeaDXw>
    <xmx:QvcGa3ek3BpLGq9BTJHctjdYks9sh8Tgb6M0A8FrhINraigv_SkMyg>
    <xmx:QvcGa210tPeV_9Ac1YJwE6l9QYjo0uYxoVg6eqE_pgDVlHmcsBkLqA>
    <xmx:RfcGa0W3_mF4e-qP3gfPKLEwacAGNEZFNqGcuvQ3xBuMx9YKMLeBoQV8>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 21AA0F8009C; Wed, 25 Nov 2026 09:57:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AwlvDh2-Hwo3
Date: Wed, 25 Nov 2026 15:56:41 +0100
From: "Geert Uytterhoeven" <geert+renesas@glider.be>
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>,
 "Brian Masney" <bmasney+clk@redhat.com>,
 "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Ulf Hansson" <ulfh@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>,
 "Kevin Hilman" <khilman@baylibre.com>, "Vinod Koul" <vkoul@kernel.org>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 "Paul Elder" <paul.elder+renesas@ideasonboard.com>,
 "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Cristian Marussi" <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Message-Id: <511fd100-e3ce-4f47-9d47-22c6532c3ef5@app.fastmail.com>
In-Reply-To: <27796cff-eef5-46ce-8079-93a0a8d40db5@baylibre.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com>
 <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
 <awAqqg6F2Z1t55x2@ninjato>
 <d94ad9ca-afdd-4301-a69c-0bbad5b334fa@baylibre.com>
 <20261123103633.GB2959742@killaraus.ideasonboard.com>
 <fc13a7a8-b825-400c-9ea0-ceb2670dc478@baylibre.com>
 <20261123160550.GA3050935@killaraus.ideasonboard.com>
 <27796cff-eef5-46ce-8079-93a0a8d40db5@baylibre.com>
Subject: Re: [PATCH v5 00/15] R-Car X5H Ironhide CPG/MDLC SCMI remapping support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Cl=C3=A9ment,

On Mon, Nov 23, 2026, at 20:09, Cl=C3=A9ment Le Goffic wrote:
> On 11/23/26 5:05 PM, Laurent Pinchart wrote:
>> I have yet to see any vendor who can provide 100% stability guarantees
>> for SCMI firmware interfaces. In theory, sure. In real life, I just
>> don't buy it.
>
> I agree that while an SCMI firmware is in development, its ids can=20
> change between versions.
> To keep the ids of a released firmware stable, I see three rules:
> - an id always names the same resource, ids are never swapped,
> - an id is never dropped: when a resource goes away, the firmware keep=
s=20
> its id reserved and denies access to it, as SCMI 4.0 section 3.2.1=20
> describes,
> - new ids are only added at the end
>
> I think upstream should only support a firmware that follows these=20
> rules, with its ids in the DT.
>
> For firmware still in development, I agree with what Cristian wrote on=20
> the RFC[1]: "fix your firmwares AND/OR apply quirks in the meantime".

> [1] https://lore.kernel.org/r/aekXUvIPb8nkhdKu@pluto

Oh right, that response also included the mythical selling point for
SCMI:

   "SCMI server is supposed to be that one entity remapping the IDs in
    the background if the same IDs happen to be representing different
    physical resources across a number of distinct platforms"

I understand that can work on servers with N CPU cores, N network
interfaces, and N storage controllers, where you run multiple
virtual instances using the same DTB describing e.g. a single CPU core,
network interface, and storage controller.
But not on an embedded platform with complex I/O...

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m=
68k.org

In personal conversations with technical people, I call myself a hacker.=
 But
when I'm talking to journalists I just say "programmer" or something lik=
e that.
                                                            -- Linus Tor=
valds
