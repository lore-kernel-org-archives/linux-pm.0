Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F793D567E;
	Sun, 18 Oct 2026 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364910; cv=none; b=aVfGc5Ee6+6WvSPbZMMocZbDJzv913XXtCRFDjdBxVoIZrpmJt+JqvNiAf4VKP3AyP22/WWlPnwOz3XBYqe/Zpu/Z9M9gJ3K5kVciaBkg3Q4LyFjHbC1JjmTCm/9l+B0zOpCvIIGXFHXUk4RTTkGIjWzurF8NEhKi1XCEdefeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364910; c=relaxed/simple;
	bh=7mXkF1gQ9X0dgexyk2NiLVbwLgkj6RIkSopmYeA2QkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOPNWNwOptcFv3ub2u9qW36zTBsvlRoc43e9MS4Spu2xLygui8Af0gWG+OxJM+QQ74/8R3Kj0lVwnOppnYJp9y29xOTp5AK2S5mo2LlS7t/EFvGm3spxsY879jMmX6sOrcQQJtD6U6PLIisceLNY0GL39dELNzGpmMtOmX+10+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oT5cH/at; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oT5cH/at"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j7Dqk1l4TzKnP9;
	Mon, 19 Oct 2026 01:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792364898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7lgpJVBTsYDOKCZp9reWWs+AKWsfF0gEALW6fOkYM0=;
	b=oT5cH/atrp9ovqdpuQIP7DfVGJ6SEhc4NYdWaebnlGknP6Lj0h/aCCi8/iTnwX5OQ9OZFb
	3Q8h8LA/Dd8FervajaX1FzI80HpA4eYtTrsyyDzQzEP+PopebzWl5rYCY+0NTVany7lwK0
	Lg6Xz1z9G3ULlVdx4CEvtumT8U0nV3yhIQlLM/v5cStHSL+hLtRxK//XUeYEu4U0Kg3B7F
	RmNYQdpmFnCPXq1qg4OkqtAD3f3cJCH2j1sI/HN8bpaJLdxg98cSez1ROMcSvgSuLVxdMu
	KhMZR869qV+ADdRnRqrTxtsCvYTZVusYgW5fKMu1tpR8Xc8QuwtSH/VzG3r5Aw==
Message-ID: <63af69a1-3372-4986-90a8-395f0c0334db@mailbox.org>
Date: Sun, 18 Oct 2026 16:04:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] clk: renesas: r8a78000: Add clk_hw to clk_map
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1792163045.git.geert+renesas@glider.be>
 <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>
 <51d8ba05-76e5-45ab-91da-3c6cb02505d7@mailbox.org>
 <CAMuHMdVzX8fd4NDQi8ow0m+48g8p-LBHMysFi+fOqp1oDtT8LQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdVzX8fd4NDQi8ow0m+48g8p-LBHMysFi+fOqp1oDtT8LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e818b94e08cabca6903
X-MBO-RS-META: mmgr5c94npbzb9imi9iunexn55pa6xbh

On 10/18/26 3:51 PM, Geert Uytterhoeven wrote:

Hello Geert,

> On Sat, 17 Oct 2026 at 19:34, Marek Vasut <marek.vasut@mailbox.org> wrote:
>> On 10/16/26 5:55 PM, Geert Uytterhoeven wrote:
>>
>> [...]
>>
>>>    static int r8a78000_cpg_probe(struct platform_device *pdev)
>>>    {
>>>        struct device *dev = &pdev->dev;
>>>        struct r8a78000_cpg_priv *priv;
>>> -     const struct clk_map *map;
>>> -     int ret;
>>> +     const struct clk_map_in *map;
>>
>> Super-nitpick, use reverse xmas tree ordering here if there will be V5.
> 
> I believe that's already the case. What am I missing?
It is , sorry for the noise.
