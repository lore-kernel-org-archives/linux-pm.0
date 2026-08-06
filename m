Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F02D7DCF;
	Thu,  6 Aug 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020842; cv=none; b=W7W5Qe49HLg3lGIbkQ4D7aJGGmNyN8+kJHPEv4vSYEdhBALQUWZvyQ9x7BrNvG80+BE209rfS/0x5gGKXo++VJqi2vJUBCNAqWCvvocKWnDW3DN8CMWAtjRt2qLX9NJ81nOJXBFO0qN3OXoMZSi9Hul8hhGxMu7VKJfr1lbbNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020842; c=relaxed/simple;
	bh=4aNJudDXH+RGTN1Q8MDeFjkoURQAlY9fgjB3FjkGJM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+k68Ot2GVqKBJ7YYDzVS1Yip45TVRB/fcG5DwmOWP5HuvoEyu2v0kn9SgZ7hk7B7qCuAtFum6d1plbX+Ovm2J4HUM9boa1Bm6jI1HU0a1/3mx+5j3UVNoPMoqvWhtKWi3F1xXGyg34DjHgak7jSXCaGsSRedC6xvovl/s1LsZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SalejtA8; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SalejtA8"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hG6fQ4wWHzKnSY;
	Thu, 06 Aug 2026 14:53:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786020830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gPYjDd+JPWeY1o74poWekzAi3fnx4Dq4Me1Ix+wXdo=;
	b=SalejtA8AWY6uPEczWcOa/cZXzI/nFLnL5c8pcM7vKPRH0by35LMoHSCPO0bxDVd2UcA6l
	jhYVkOGyDEHUIMiYPVZ7vyz7VrmgANupuMqL5mgUgpXUnpDSMqZDY/i4lXRPFH5yTuj04w
	jFI09TbwjbrT+6Pl6EsquKJ44HK4DvMoTNxddBYGN0daeEJ6d2/nBy1rK7d4sFJ4MXMbRD
	MQN60NJ4i6cAgvb5gbjaFydu+znCZyOX0rbsfRAUZx9bCwphs2rKqd6ijJHI8a3XemtgIJ
	hpw32DVG+NB7Fme0Huxb6DdsBASNua/51sXMDmu7C8gDtcqN79/h8+K1n3bM1A==
Message-ID: <5920e231-a8b4-40eb-8239-23656fef02e3@mailbox.org>
Date: Thu, 6 Aug 2026 14:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/6] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1785941595.git.geert+renesas@glider.be>
 <89e6a71b35703f10e12f520af1f389b5f40f4b35.1785941595.git.geert+renesas@glider.be>
 <0124d3a3-81dc-44ce-88a2-9426c65ac46c@mailbox.org>
 <CAMuHMdXHPjzCidCkfyF0c9fndAmAte1DuhxGZt=WY=_jxpwU+Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdXHPjzCidCkfyF0c9fndAmAte1DuhxGZt=WY=_jxpwU+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9w1txx9bbib55itrouywbtz774kmecwr
X-MBO-RS-ID: 6c5d70869975684d6c0

On 8/6/26 9:49 AM, Geert Uytterhoeven wrote:

Hello Geert,

>>> +     if (!info->base) {
>>> +             dev_dbg(dev, "Unsupported MDLC instance 0x%pa\n", &res->start);
>>
>> return dev_err_probe() might be more appropriate here, even if that
>> would be more chatty until the support for various MDLC nodes lands.
> 
> Indeed, it would be very chatty, and may confuse users, that's why
> I used dev_dbg().  We can revisit that later.

All right.

-- 
Best regards,
Marek Vasut
