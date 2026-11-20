Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185195;
	b=5s0AL6gIbjNmgAiNOrPKrtTgbUXZM3FqRHX/TYdp4xZEA3kpNCSjKG9v+Egv7NMC4bIN
	 eiGuLd7Jxmn2U/490kDEdT5wARQ7j/fVNqo0W8GDLpDHzkvsupP/nrgux59QPQFsSBjUJ
	 4LAyJB1ErtuEQqSTE8XHnWeFLf8w4QhWkQVcS+MrqjSIdnxqC91YrLEWJ1JTz+4VA6VPX
	 uLzpKLHtJS84HwHpUFY1fO/2QGufSJaKImCNiopyIz4mY3owApIRnvsXPq3hogZJotD5g
	 8XJ3fekYWZhJgsEW35NZ+OD5+NUlaVZftFapk17E+QNSHZDzavpG/z/EffbkBe2wBXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=92f6NRETdzojaigU8EyzxjI/4N0lXsB5qD5xAdIQvbI=;
	b=U3bFL6hfhT8YOarYlfJF2XpqNwzxQDyiVAbittxeMN7T0xBdYphz7GcCBHX0Kp9xifIe
	 1msB1R8dmEyzjAh0aAg1Dmuu9XjE/m/+OZ/sLH4GAErVfrC7553SMlb6LWrHwE/obvSHh
	 9Zh4WalztBLMmCR6yqA69hIwXCSbYrJyyJo2P+NKzO3+SNAyCbpEl64HBwBJWNX6aXZAo
	 TkyxWgUh8d+bkNniodx7913rttD21y7crcu5escgCAtfeqOQMvuhFSuS9pkv8TdfkA8NM
	 V2j2BB2hrC7IoFj4U0TH3eak3IZF0czZBmZC2Rwy/+TVhx0XBD/18kPjrjL+P52NT9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="fVLeH/NA";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A7F606A325
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 14:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53A7F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fVLeH/NA
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e47347279so544966f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 06:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795185193; x=1795789993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92f6NRETdzojaigU8EyzxjI/4N0lXsB5qD5xAdIQvbI=;
        b=fVLeH/NA1t57W3/bCEZIZWhbOFBjWy0sHlhrpoG4Izfr9IGJew9nG3j42Rw6alippY
         BT0vIYEC5b2uFta9Ajxyvq4HLZxEk6248gD6bsXwocEB04kMqZ4iVDN+XhjDx7wYj2f6
         uRvILwXA3WGpDt+jghB/balcWGgm/XhfllCE5NU7WQYSOgIR2D7ZhZUwKnFGGT6d0eig
         b/JzF7ykNyFPqess44kwGAbKuEIt95T+yu/epovAsfSDyGaR6R7UBvrFEfadI+1dBacK
         vz3mktPikbpyKm7zBsyaRloECJHvgHavA5eOStrOxSwbRpMvHMV7WonZA+z5qaQHN/Vp
         Ae2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185193; x=1795789993;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92f6NRETdzojaigU8EyzxjI/4N0lXsB5qD5xAdIQvbI=;
        b=OgbBREOcWN1PkUhqRfNpURFDgpQHYzDv/E/S0iO9JkoIWEBDNdY+E6FfWdGXpL0woL
         3kJbfSM81wSzLnb7TDgzID01ewytFGcUpEqp12/GkYmcktHZQvDszvcPgqqCXguRYKLN
         csyjaYUYh2R99Op0mb4vNgQ9QQk98C2uGzA3edx2NN5FlqUFm6KNVN8EdV0DSEiHDF8M
         iMpvFHdpErFLXdv1/FXfymy+td2IZRGwC+nViECb+9niTcpyjJ9MUAeY1nILKx9S7MmD
         aw29nleb91JrY+Go2klvXaxOPjIPpfzX73Hvb+Q1zHsYFwN/3YfpTmhc33Y1djh6oAOQ
         r4UQ==
X-Forwarded-Encrypted: i=1; AL+hErFG5NsZBXoTfOxPzu0VbMXza05xvB3J2O7FL4RefFbPa7TbTCSR+/9GmD0iCE3HamFVRnOBvnrA2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/UzJr8zmITMwTsLzSKu0G6gXI1ylZsQEMqBs4+U7TBoOkuZLhw
	KG6umiIGHKoaiLBDKKIA+Jc+xqJuG3dRSRM5pWqfExrpj9iXlZqiL1USDf0c9/q00Wk=
X-Gm-Gg: AZFdTZeKqi1rL/Pk+pVsnbhRzEPgXmHOmKirFMwRJhDMTVRSI41g0vCYdyCq/BBbvR2
	1hEQlkzO0V/IK3kckN3ahiQ30UhuJifZZHjS7yBySYkQLZIdP20gKvSDCpmyNRuOdn92sXmVNej
	QxzJV3b+W+CLbzRtLJeyJwu8c6QVrSpiw9Hv2l81Vw/bXMrIsR0wiEze9d8Qaf1cl3JudajIl4L
	9Ut52DHwf7Gye2u5yPzUH9lJ3wKpG03Q85uoUbigtg3ID+uNRbHFlBiqvS8e7B+6HMIqoQJBTS6
	rUM+D5TIE8APr1mlKna7LWDsHjoKV10mCMNkFAtFkszxaJMnsYskeOxEJD4rvRHShuzmKaIK9sE
	RFyLyWQvkMhveF4/yc/WnY3J0jcbYpD2cWkBda9kI2hgMMGNdxYUIdc7Kij5IndIW8NmLzc6F9p
	m6kayxjtHjipifQinUg2SGyR2AIQbZ4fFwFmnUuhzqv1TEhpTpb6qbC/WyAPJvCoIyPnps6Cibh
	+2XQzrBGzOjvlHBWlVNGPXC0XYwM8CvSxwzZSp2EYSnMafORLGJhJKF+H1NV6+mdGZ8gilFbA7S
	eIZoYD3qTfAedeHf9N5l83cC+PaG9ziXuz6dg8p4jmRdfWrQr0Gp0HSb6A==
X-Received: by 2002:a05:6000:400b:b0:4a8:dbbd:69ab with SMTP id ffacd0b85a97d-4abb4f58c75mr6786554f8f.27.1795185192603;
        Fri, 20 Nov 2026 06:33:12 -0800 (PST)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm5978154f8f.40.2026.11.20.06.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 06:33:12 -0800 (PST)
Message-ID: <d94ad9ca-afdd-4301-a69c-0bbad5b334fa@baylibre.com>
Date: Fri, 20 Nov 2026 15:33:11 +0100
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
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
In-Reply-To: <awAqqg6F2Z1t55x2@ninjato>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Wolfram,

Thank you for the rewording, it is clear

On 11/20/26 12:10 PM, Wolfram Sang wrote:
> In the past, we wanted to support all kinds of firmware. Sadly, each new
> firmware introduced different IDs here and there. So, we came up with
> some stable IDs ourselves and mapped them to the IDs per firmware. This
> is a n:1-mapping of firmware IDs to our stable IDs.

Sure, that is part of firmware development.
I know several SDK versions exist, and supporting several of them is work for a vendor tree.
As Geert's cover says, "While upstream Linux must only support sufficiently mature firmware versions, vendor trees (e.g. renesas-lts) may still want to support development firmware versions".
Each SDK version can then have its own DT there.

> The support for <n> firmware versions got serious opposition from
> upstream. We concluded that supporting only the latest firmware will
> make most controversial discussion points vanish. So, we now have a
> 1:1-mapping of (the latest) firmware IDs to our stable IDs.

Agreed, supporting several numbering upstream for the same chip only brings confusion.
But then, why can't that one mapping be one DT?

> I guess this is what Geert means with IDs becoming "stable". <n>
> firmware versions might return <n> IDs, but supporting only one firmware
> we get the same "stable" ID from it.
> 
> Sadly, of course, with the next firmware update, we still might get a
> different ID all the time. So, not stable in that regard and we still
> need the mapping :(

When the firmware can be updated, I think an id change should be fixed there first.
That is what I would do in the open-source SCMI server firmware I am writing for this chip.

> Yes, this means the driver is then tied to a specific firmware version
> because it only has this mapping. Not nice for a user. But we didn't see
> another way moving things forward for now.
I think the DT is that other way.
With the SCMI ids in DT, only the DT is tied to a firmware version, not the drivers.
If a release that changes ids is already out, it needs a new DT, or a quirk for that one release when the DT cannot be updated.

The hardware stays described
The CPG and MDLC belong to the SCMI server, so the DT should mark them status = "reserved", and the consumers use the SCMI clock, power domain and reset providers.

The Devicetree Specification v0.4 define "reserved" for this case (section 2.3.4, Table 2.4):
"Typically this is used for devices that are controlled by another software component, such as platform firmware."

Zephyr also uses SCMI on this chip, and it already keeps the SCMI ids in its X5H DT
Juno and STM32MP15 handle their firmware differences the same way, with separate -scmi DT variants that simply include the board DT and an SCMI .dtsi.
If the number of variants grows, tools such as Lopper, which I mentioned before, can help manage them.

Best regards,
Clément
