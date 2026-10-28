Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224835;
	b=2Jqvb9tx6XcHqo376YM2dI4GKC1ux7Z36Ix9eKNiB9lfycDB9KODhv/giSa6WzO/4uHi
	 HG18+k8NUVvdhRW1JLtZ9iZQ7R5Q3LSrI8hHicCWII3btOqlpJnxqJuGqim11ftvc4r97
	 KwvZnljxQxYrBzUL29bm9NQ9tOiOaE8xhEnPUIVatKOQ7pBub+3VnOkO1FuC/VEIa5qkN
	 QyVMZS4atmQMZLOyMn0yI6UX3dJmDP3e4rI4bVXQ+KT6H6NR3arsm3SvF7bVDHDG4WDjo
	 1enYceZNWUnHsazmYAY8G5gL0i0DmfMHmPGIlP8bTJhrqCerBUodXMy65jixubwb6Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224835;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UpYH4m8C5Z7i/g34ppN64WV+4cVy2YgoQt8bN0alaQg=;
	b=MnzQV+Qy9IhfghkIGh+zu1ArBO+uTbcwOc3EOK/WcxdNQNhTzXMur7Io+SS9Q5nbtyYj
	 Dm44pmB4MFkZ0/wtFvw986QFGgrpoGibrOOfbA0VB06YIvIJfeVQN2X92i87cqimKmol0
	 TVROQi/S9Bp4EpO0F+dTUy5jKdw6oZdm8/OaGd6BmWGASwdra1shIqiozFL10qF42zMjt
	 RSRNuuK6kp1og6/92KfdyjfoT26U+cGAyINAgCXiPxyAllT0uCM0SXta0x+Y8HY73LrZR
	 B7M/VGROHRtMcKUJCpPhT0JJioNsxQo9Sc4MQmXu7mlFCyEdV7rWL0obcpH8cgL66vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0y79WAJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D023606A31A;
	Wed, 28 Oct 2026 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0y79WAJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFAF1F01825;
	Wed, 28 Oct 2026 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793224834;
	bh=UpYH4m8C5Z7i/g34ppN64WV+4cVy2YgoQt8bN0alaQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a0y79WAJCKiwjXicOsE9qoCh0K0q0ni1VmiXiyukuYsn8OS8JgWmqM9hsDiyACrmy
	 DFOjdJ4ivHcA25PK3n6e+JrOM29pFxCcuvfLIJ3uuVJyeXQtUQLeN2EucohIsjrdof
	 QlBa4dTuRL+zQbkeYoLwUE/TA398W+TG5ZM903rT6Kg/GKuVZiu1mRlyRWAoO+fd9C
	 expmcH1pjHcbgRUF5/Jrmd7xM2uo00dyaw83IyHvCed6oKwm+c0O/SMpaPyNW74Fmq
	 4aL32lT4KJ69X+fNLJNYbrl57MguJ6ODnBPSfVz7m1XKDycvoG+Bnd/iMqHi1450XI
	 752/JtFga9nOA==
Message-ID: <f0618a27-cee2-4f39-a578-fcbf3c51607a@kernel.org>
Date: Wed, 28 Oct 2026 23:00:29 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: qcom,camcc-sm8250: add
 interconnect provider
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Jonathan Marek <jonathan@marek.ca>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-2-atanas.filipov@oss.qualcomm.com>
 <20261020-bloodhound-of-remarkable-debate-11afe3@quoll>
 <7ca815b3-4712-42e4-996d-4a1e53cad492@oss.qualcomm.com>
 <Sm-FvdxaOiXpzzGo30wECHdQF_-LtUaJCO3mGpBUxXfnVCYjOLE5DhNWdNmOMhYdkR1RMXhPzWuHhsZJkJ_Vzw==@protonmail.internalid>
 <20261028181040.3515955-1-atanas.filipov@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <20261028181040.3515955-1-atanas.filipov@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2026 19:10, Atanas Filipov wrote:
> What clock votes cannot express is why I think the camera NoC is an
> interconnect:
> 
>   - The camera NoC is a bus with several independent masters: the VFE
>     write ports, JPEG and OPE. They share it on the way to the MMSS NoC,
>     and the camnoc AXI clock sets its throughput.

I've always conceptually viewed the CamNoc as just another NoC that 
happens to live inside of the TITAN_TOP_GDSC power-island.

I think the trouble here is the CAMNOC_AXI_CLK is just one clock, it's 
not interconnecting any two things at all.

Noc entries in DT usually look like

interconnects = <&gem_noc MASTER_AMPSS_M0 0
		 &config_noc SLAVE_VENUS_CFG 0>,
		<&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI_CH0 0>;
		interconnect-names = "cpu-cfg", "video-mem";

In the second case we're connecting an MMSS port to a DRAM port i.e. two 
completely separate producers/consumers and we have specific ports that 
RPM/RPMh is involved in managing.

Which is not the case for CamNoc - here really we have some shared 
clocks which we need to calculate across components within the Camera 
power-island.

In downstream the CPAs code does that.

- icc-clk would I think over-provision clocks
- CCF would as you've observed under-provision

- But a CPA's analog in upstream which components set/consume ?

That would work.

After all what we are doing here _is_ specific to how camera works. We 
don't really have many - any ? other examples in Qcom SoCs where we lump 
a number of different semi-independent components into one area - ICP, 
CDM, VFE, JPEG and ask them to share aggregated clocks - in a way that 
is specific to - guessing but - specific to how these components get 
modeled in silicon test benches.

My vote is to replicate CPAs in upstream with a CPA's icc provider driver.

The bandwidth calculations are already proven out in downstream and if 
we get it right - potentially its something downstream could switch to.

We could even use the interconnect API inside of the CPA's driver but, I 
think just doing votes via interconnect and icc_set_bw() into icc-clk in 
the drivers directly won't produce the same bandwidth calculations we 
have in downstream - which you may loathe downstream code but the clock 
calculations we'd assume are ~ a pretty good starting point.

So; make the CPAs driver an icc provider.

cpas_icc_set() could/should absorb the downstream cam_cpas_hw.c 
heuristic for calculating the aggregate clocks.

Its not represented in generic icc-clk right now and as we add in more 
clocks/SoCs this disparity will grow.

---
bod
