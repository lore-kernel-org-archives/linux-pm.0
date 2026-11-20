Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170593;
	b=iQEsINw1ijCCVKhyUtbdPOjLEeS5BeiHf3DF3l1JIpPY5HrqxF0+Ew2JoFNC7bNuFJgU
	 0KfI9VyD/KFCvZnN1irA3g5Jhd73UgvRhM17XX1KUvaFhD6qGLpPNqbIQJyT+/ieGgHOr
	 f/UK9B3fvPz1FLBReJUY7Le7BcjuK0b3R+bfvH1QXVagB6OOOo1BwUJFn8kxTZKmBAz0q
	 sF+prHBuGCy5d+HgV91C45+EAxPdP1kgnYKJS5GpfnuwrGrGKNS8/JsL10HtNYKHyt014
	 IgA0LV7UwecqHa2oMs0xVGSRZOGuFocbZjykG+WfZNMtQMH0/UQ7DNrLzlCvT/NW8Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YECa1p9LzdYXA7zGnIWZNUD0xhZVO826hfzpFJvQccs=;
	b=ItXeHpvSxx6DXMYe+SVibY9lrPmRzyrxo/6wfKqUU32fgKhVpmtpp6VQuLMTSLwS+SJ5
	 4fKN1Y0+4gkwRytMy1Fgzrn+AeD+VIDep2jayZGgPjAxyo3E5KPZjtrVCqZHQSECu64uh
	 Ued7ajKQZ3ohV0Y5cuKP7BF0Fh5mGHGDwgTTPy83MPQGEADe3v0cZm7mXpuok3dRzVE0g
	 YbeEN9AxKXe3mPdqgixuYpjjEej/yk/8+vQANSh0BDNCG9zss6lIPNTQzKSNh7OqolvnV
	 Lc6iCEMtEQPunop3JzhkKwqSZT+1TidrVj5+q86TGx0daA6DLEq0K5WskygB7tsQAwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=emnnzxhh;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3139606A330
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3139606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=emnnzxhh
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so8450245e9.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 02:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795170591; x=1795775391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YECa1p9LzdYXA7zGnIWZNUD0xhZVO826hfzpFJvQccs=;
        b=emnnzxhhSXC7pOKVR4XJxY37JOLjOZChOAK8ys6839gghkzDP+P+c5pUqMAdfQBI8u
         AEHGxP6PrOmX6taHKNBIJJC5V/mEyzoX0UK2Ne9gWuY3HPn53Zb/5ETmtXitq0LlHZA6
         PLcBn6cQcLYaOEiRvWhqaGoNM/bMkhIPn/xxaF+NV2e++aJJiQ/yqseiqE3UmEx3eK1+
         ij775jpfZ1RUph0D6QJHxszrkgPkYhm4N+7mWb2I3KzT6yBo9OKyQVgSglqI1Q93UQ3B
         LA0EMG/ZrARNzVVucMAgbJCyu4tY5crfyGbBhh0vFBEgPBa/v+rKxcsxsaJAIj7/cE8w
         cBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170591; x=1795775391;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YECa1p9LzdYXA7zGnIWZNUD0xhZVO826hfzpFJvQccs=;
        b=kFjG3mVZymobxpWZ2Kb8nmuUVGiFBdtdHVJgpPCauhMASKocuFlHVMw/F+YqEmalgW
         OVlgZGKxri0NQsCzsiNdlPPykWaFI5DjgRxAlNUSSz8+HhKQTr0w/W/hkarg9hVsupN9
         KIqoA9irlkIdlUevMZUa2eXuvMfzmjNnDjPQhmj9GJTye8mk0d+gfWocabk7bafrF4eC
         rEneGGQjUxYzN1/wQKywUJcRRwH+QJDHjPqVhKQis064zfYs1Ey1z8IrEbdUO7kybkqR
         hDxRwE/yE1mYpW9jzF9iJ3yCBSXXIfqF0o45fp5MNrpa1EY6LG9XVHk6o1I+oAUsP1eZ
         HPuQ==
X-Forwarded-Encrypted: i=1; AL+hErHuOwwGbO98xNVSvkFYA0/j5D8T5DPWV4YIFqYPQ+ca2+rmXQXDK9+D9kr4KOKK2ASPTDy+NjRBFw==@vger.kernel.org
X-Gm-Message-State: APuU4Z84CROjKsDLY19alK1qnnipPhfe4SSL0fwrxqXT8J/eQKiYPOyV
	S/p8jOd3HJgxANplkUH/8ylLJQGDZSBEM2Zh2YqNV2SJejH2eTPdnLYthQDondyeZyM=
X-Gm-Gg: AYBFou25PzmsdJNA4T/+ShEeaD3xSZ5XrxG5bBYEzwQFoZyNy0+/iwC0EH96Vff8tE9
	ALKJ9LPpt9hC7oDQLmFPbqZoVN2tkj3d0eml/9OmRbe+4Ual1xLxutIudB8Y98GYlvOyl6y92eC
	/Tau1BjY59nq88jmkIN4mgb8lh9A6DPhsG4AusKxURTk2lON8Que4lgx38XXc16ZI99qc0ygqD9
	puDkmLb8IIKdIZXqNvVjhZUdCxCwBxSLE6G39tcAACPTnGi621AhdhP/LQ8Y3NJsgUEOEN4sVCu
	UkJF7qaH1TFVj0pZUbBfyyQj4s9pyUVjL+e8ukRxemIEkEP80Ahd+BCrW8PYb0gN8/yu3sXmGY1
	FluZH0Fam4oSuL0uSc0cDN2QjHiPtvRz22v7QpdtBLOwHPIZnhESmbU0Uzdg4rWzewOhOP/kwwz
	i0pHODa+49vIBI0SBo4d5cIh/eNosnuG528JaSVAyZ4fMxVG/rWjoXfwhACxl8LXFKtOv3QCEuA
	grW4Itjv86c0mnX+THW7NROL6O8BS5sCSRLLZIAMz3qnDjEATDYmR2v8rI0bFX3y6bl4bKSRN74
	mG+m6kzL647nYnVmAXzeo0LZyzOzFexw6DDzdBGmAcfFsnNn5+MAu6C8Qg==
X-Received: by 2002:a05:600c:64c8:b0:4bb:605d:8e92 with SMTP id 5b1f17b1804b1-4bb8881e767mr51613175e9.32.1795170591115;
        Fri, 20 Nov 2026 02:29:51 -0800 (PST)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm65912515e9.10.2026.11.20.02.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 02:29:50 -0800 (PST)
Message-ID: <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
Date: Fri, 20 Nov 2026 11:29:49 +0100
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
 Paul Elder <paul.elder+renesas@ideasonboard.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1795029012.git.geert+renesas@glider.be>
 <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com>
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
In-Reply-To: <20261119234759.GB2324725@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Laurent,

Thanks for your feedback !

On 11/20/26 12:47 AM, Laurent Pinchart wrote:
> As far as I understand, the assumption impacts the mdlc and cpg drivers
> only, not their DT bindings. If (or rather, let's face it, when) a
> firmware revision later breaks the assumption, we will be able to handle
> it in those drivers without affecting DT.
> 
> I don't like this remapping driver much, in the sense that I wish it
> wouldn't be needed, but it seems to me to be the best possible
> compromise given the instability introduced by SCMI.

I don't think SCMI itself introduce instability.
It only defines the protocol, and each firmware choose its ids.
Could you tell me what you mean by instability?

For development firmware, Geert's cover leaves it to vendor trees:

> This list deliberately ignores ID instability and the need for SCMI
> quirks during development of the SCMI firmware.  While upstream Linux
> must only support sufficiently mature firmware versions, vendor trees
> (e.g. renesas-lts) may still want to support development firmware
> versions.

For a resource that hangs the platform when Linux uses it, the SCMI server should deny Linux access to it.
Until the firmware is fixed, a quirk can cover it.

Best regards,
Clément
