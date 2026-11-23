Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460949;
	b=Mi9B99eQj+/qtkPmdTVivCiKDPH6lDWpJhXjORubYvA4pYR1UYmyIX8ldqa2HvgfBGU3
	 GKXjNr6EwYiI3gB+DPia+r/dJvuIJ2hJHDzAeRVKo1W/lwp4nEbXFK7v93TsWoM23bts5
	 JTjjzrwo9YzxtiyePqWLdaox/be/D8hrXT8fi1AXnIUCNLbHoxQ9SrOxYQ9z3YxWNjIpd
	 xIapGLimXpBXm5c0vc2GcLZUwowwoBgDAcT1/r2jKO/NdLh6nTLgcxeFf6VFMmosfdpf4
	 b7j153d5HFCD32T7L7kqTIsUesb73MC10SPmEyQ2ybJSJjk3YTe74YeMq78qRnY/usA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hXmxFeoTBX/tQ++ntzQj/is3shY2/2htZh6VSebwwAc=;
	b=kHFF7SH6YDVdHzFfhez/0V1a9R739quv6zJCafLByW1eVRKa7gkgo/UQSGtwZB6UdWbD
	 1w+clxm7f52CqjE7fAAX6W+RLyOjQiy4xU1lNozrKLjZeAdpY8DEqbGUW9O2VSfAQRAu4
	 itb+Dw685wE/Nzl+Lq67vRYYoeH1qtLKPnH6CvOchhRxEuV2y9Xcs9JJjHse8sjjnNTTb
	 pobllbF5HOI7D+wjimzAohxDYtvZJl5FBE2q98rl3KV1MTM2lW8uOP6O1Q8doeLMSzHdz
	 J9e2K1A8DkZH9em+hbQpLX0zn4pHNvKxW0ZdhQ/nWYc63PFKQ1Ou/A0whlETcroGeOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bvzvFjpx;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D5606A31A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 19:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 086D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bvzvFjpx
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so32566695e9.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795460946; x=1796065746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXmxFeoTBX/tQ++ntzQj/is3shY2/2htZh6VSebwwAc=;
        b=bvzvFjpx075sG+8K5J2gMyO/voucUrNRFEDa5aga5/eRAnJrFMNDEHtmtxhq6Es/Vf
         Va3ETZB02Tk+HUDIDJL4wHTugoTbHv9LhbfA8qJ+FltMF+6rxnoXlKREnf1XnHEscMHl
         4E2U+tE2vJJWY69UqWY5h5XssZSKEqbBuyzI2GvHjPVmufkUG+tFZQNNQqvLcZmFV9HA
         rzorDz8pNbd9EN9nUfRRAA/K8MHECzaVgQIl2EajITYjyvlYh//ZSYV081SXgvyeBF51
         3REd/KLvhzSchHA1VZZvKwUVvO7+1PWJdaWjPxIklFfQn+lDVy8U3xgvTVpggqZq5/G2
         YS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460946; x=1796065746;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXmxFeoTBX/tQ++ntzQj/is3shY2/2htZh6VSebwwAc=;
        b=JcA18DmnBsmY0Qlj98mH3jUUKCct8ybxUIP7mSVpOGlRqya9+SBwE598RSsViIItGC
         Wd8gtedmj1sGQNNPadno9yABcGxKewzssxwOkdBuDu+hZZuvaxtk90lo1fxOsa0TZx3I
         Augn8w965npTO88R/hrHeQwafWVR+JuZeDJLojIWGdkqBm8Pz5ZuPlLdc1Ruu3kmnew+
         dY8O0tJbp8/0Gw46SeP93uf/SVQMNhlzLbejDjjb5A45dyK3vtOhmA6EO3zXC54W0mse
         eGzanMJhh9BXpU4IdAHZ/iHvF8J9u9el110gzrDXZNoRyZYDjJIYxEPPoAxWzdHuufvp
         GUxg==
X-Forwarded-Encrypted: i=1; AL+hErG1hOpYsHN3UiaoL3JXm7gRtou3oTXtJVTP3G5IHyGSqiO7BeXmkvKUXt/TrRKRqqJGvNhzC70H0g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/d1aFztfLHotXM6Exd8ZWX+BoeBxHpqp5JS4fhJbs6N25hKsgv
	g+wnZGbYtywjvxGDuhtzuQY6IzirdUGS60HWgZ+QSWy/YfTO9vj4RtC4QZJCr4K+VPk=
X-Gm-Gg: AZFdTZf1K/JuskAddnf7etww2dZ6g+KFMCo9cGbzmwGfSJhJGLU+VlRocudG4wa6oZu
	WfDUAWaCET+6JgBz+BZ1vvK/eYmi1HkG1Pr/e7e/4um1Rri2qFzdpriX17vjIrWci04+sTdBKJl
	bWoKr7rRlt8wbynhLyz1G1SM+5fDtHQ9GMfqNt9s8wJVBhdWkBGLYE5nEUP/ZTMNiY+R/4kdSsi
	ycNli83of4/4viNegHgT/yDl2c2lHF4tXNWwq9ZVr92gCLMxT8U3CKvNpkxEjTPlN68a5jkigEJ
	K1HP4CIH0scoK56BF3IcM0BBqL6DBa/FTjKIT+Dx6vc6+BLtqT3smj7xrNCgn2vUClMtYjrsiWR
	Mh3JJ5IainYf+RCaayo+DqTdTdLjahqwyJPXKOQhR/cFckYHFnePSkwSryHt/96L8K8MvIWhCW3
	jA3Ia0segd0YdSoDJQyX6NR/RW/7YwGka5w2ohM2wfwcr8NViISXCQpeMPhRwFTUh3zjggJeGVA
	tPx8usw9B0ZwcaWC1Bgeo6RRrWVuavUu2vTFZx7qm1UhYXs7Bpi9DJYMqr+aU9RP3E4JMqhqJ82
	XMOKCWIzfZBBRMo/GqGk0tduniEDFsYh15bDD301eWCNSb4uUb22vP3JsA==
X-Received: by 2002:a05:600c:3e1a:b0:4bb:6814:7391 with SMTP id 5b1f17b1804b1-4bb8881921cmr248187205e9.25.1795460946295;
        Mon, 23 Nov 2026 11:09:06 -0800 (PST)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b9add26sm24014155f8f.44.2026.11.23.11.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 11:09:05 -0800 (PST)
Message-ID: <27796cff-eef5-46ce-8079-93a0a8d40db5@baylibre.com>
Date: Mon, 23 Nov 2026 20:09:05 +0100
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
Subject: Re: [PATCH v5 00/15] R-Car X5H Ironhide CPG/MDLC SCMI remapping
 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Paul Elder <paul.elder+renesas@ideasonboard.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1795029012.git.geert+renesas@glider.be>
 <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com>
 <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
 <awAqqg6F2Z1t55x2@ninjato>
 <d94ad9ca-afdd-4301-a69c-0bbad5b334fa@baylibre.com>
 <20261123103633.GB2959742@killaraus.ideasonboard.com>
 <fc13a7a8-b825-400c-9ea0-ceb2670dc478@baylibre.com>
 <20261123160550.GA3050935@killaraus.ideasonboard.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Autocrypt: addr=clegoffic@baylibre.com; keydata=
 xjMEafx9bxYJKwYBBAHaRw8BAQdAtc85GIwDXLz0rh9thWXC80Lji0otVDVncXT4qaS4j1fN
 K0Nsw6ltZW50IExlIEdvZmZpYyA8Y2xlZ29mZmljQGJheWxpYnJlLmNvbT7ClgQTFgoAPhYh
 BJjMiHuM4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEH6EW4KtCh6Tt+sA/jVC35rY1npFlOy7YnncTdrID8Qf855JA78IzXgvzpGp
 AP9FkuuT80m66PP3DvgYX9kVnG17mSDKO0+v2W18v6ZgCM44BGn8fW8SCisGAQQBl1UBBQEB
 B0DMwF4u//aQyzsFlO8rPJ/cqsAuPH80IeIA3HOEo5mlVgMBCAfCfgQYFgoAJhYhBJjMiHuM
 4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsMBQkJZgGAAAoJEH6EW4KtCh6TdSgBAMDS0MiWCivt
 LjzZc9bs+P/xdXywUjDKq3lpQGJ6vZ0GAP9vI6DnN7vwVK6jt6/+0aBGkog5Ura9+WwRFEdM
 vLfPDQ==
In-Reply-To: <20261123160550.GA3050935@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/23/26 5:05 PM, Laurent Pinchart wrote:
> v5 supports one firmware version at the moment, and the driver would get
> support for new firmware versions when/if needed.

This is where I disagree: I don't think a SoC driver should follow the SDK versions.

> I have yet to see any vendor who can provide 100% stability guarantees
> for SCMI firmware interfaces. In theory, sure. In real life, I just
> don't buy it.

I agree that while an SCMI firmware is in development, its ids can change between versions.
To keep the ids of a released firmware stable, I see three rules:
- an id always names the same resource, ids are never swapped,
- an id is never dropped: when a resource goes away, the firmware keeps its id reserved and denies access to it, as SCMI 4.0 section 3.2.1 describes,
- new ids are only added at the end

I think upstream should only support a firmware that follows these rules, with its ids in the DT.

For firmware still in development, I agree with what Cristian wrote on the RFC[1]: "fix your firmwares AND/OR apply quirks in the meantime".

Any other view on this is welcome.

> We can agree to disagree on this, no issue.

Sure, I think we both already know we disagree on this :-)
Thanks for taking the time to discuss it

[1] https://lore.kernel.org/r/aekXUvIPb8nkhdKu@pluto

Best regards,
Clément
