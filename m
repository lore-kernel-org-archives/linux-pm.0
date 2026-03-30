Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D837F749
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856366; cv=pass; b=WuIiQC+thurs49YnW+W/ziKktq3xysBmNuZyeMxpbF0zwpTqd/KrdJ3QT00EKt10PWKE+B4NdLdwBlQOSkMm1nBqng4Q+NfxwOkkr5ofLPU9BgeeIr0BV3Beidilq1mU47ewQ1fjnaNkBA34IzQUrDN/PlijYuvTxTph/y75xKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856366; c=relaxed/simple;
	bh=zYnQOFZ4bGFIeTmozNqeJkBObILJLvK0jBuil+gfMNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkI0Z6KhQXNYLXdKI+Iz5sWbb5jbkwMJtydkaGsTCi9BiwHy/sPwLBDWlZ/EIkBj67hCos/r1Z8JvX8SOq9nq0J6FpwgngpyC5LtgkL/gJhbiKVBGgknQSv4SYoZZpPFH/rbydabK+uWBpsbsdM7Zco7PE3hnTQ8kVVCzbsWR1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltGT/++V; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltGT/++V"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66c05fb27e4so286836a12.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 00:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774856363; cv=none;
        d=google.com; s=arc-20240605;
        b=SUyRBOWzMrS7lqdLI6iFdn3BK62NyLxU3HFqiJSizza2LQAg7Qpv339tUUZYTH40+p
         TVlibHQj5zlvKIXWG4+kWbNspWO+Qn4/P845+B3byNEVkfp1dQxymZyDp6RUBZaqmmCS
         UiKYlGAD6gYYQbeEGur237dl2RmwGmAzTLb2EKbzrlGecwvFdtMEQYZg6FqO8xF6JvM9
         UL2KqFlwO9h52A6z2QFfr/zTTUBOaJ/LddkeW0ywca8WdssZejTbTSGgiVNKV3YraBXD
         uSQA4XVTE4hfTG3NvjRYUoU0Q1Qq263L+gJrQPUiOaOSPl+oDsFngu+fbVNjsI19Yif2
         8YIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zYnQOFZ4bGFIeTmozNqeJkBObILJLvK0jBuil+gfMNk=;
        fh=Xn0ZSzfPq/3LMAUPVScKv0LGKBlBcxED8XRlsF0GBuQ=;
        b=Wjloy0kOW1epKhbX59MOfLgzL5/s8EeJkDyDIufgzXPvDzH+lfSFWBfc0E83wmFugK
         8Hd6aBkXWzZKK7sIEfRIbW/bwCNpiGzcDWhieSI6upcGgcd51ceLQBasWWQ2u8jjuM78
         +LAgo3ixb75KafBd+JPc1T0wft/YyL7T6G8R/5rBVVtAl+MPstD7ngwMlsnkNqCoZJj1
         Mtv8mH52L4rtDL2sqlEo7GE9wHiOlsBd3FsiUsbkC7wQ75J5CwvIg4ntGW4fr52k8hM4
         tEIyqvVqfrWOw+wrLNsdy4NYR6N+sOvB9QOIlWFfTKjotgWVpVgenbT+I2Kk60NgwptM
         VEow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774856363; x=1775461163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYnQOFZ4bGFIeTmozNqeJkBObILJLvK0jBuil+gfMNk=;
        b=ltGT/++Vw0wLROzvE0ZJl7pTg3Cu8NEOafpbs0pE8r3RpE8q0sJpAfXfzjUWl2eKao
         CwibCxdmVAMROEpagKD2P2BeipXDsZxOnJFg4r0p1SI3Yxt3GNT45BOnZwwLk95Eo4Ur
         bic/mmzzsS430V9YyHZrF1oEuD07CcJd9k5Xpfei4bC7LfoMpiFCPtea52XCLajH1NFL
         w0y8A5r8REZkulM0KoCdY+PSvUpt12E0BymdQDrtioO5gbl3BEQKOToNLoa4Q24RP4EU
         migiCy+shBWDS5wRco4kXyBXokQ/DvrpRXnXp/N/8qO1ZGQyZXYdOlwrIUfNsxc9mpWJ
         iQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856363; x=1775461163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYnQOFZ4bGFIeTmozNqeJkBObILJLvK0jBuil+gfMNk=;
        b=Yd3hb1BBrYFohEhrWGkyFc/ZCh32f3Rg0vjFvvT3ZGkQcJknWP4K2tgLc5lN+e69vQ
         LLF8rU4qNEfUye25ndFZlrG1PriIKABqjQMnTLzq9JwXLBYh07f8iJl86kbui48YcDyl
         /adZQVMj/7cgpeCXeOfJYOIyz9VtrJVJP3E/1A/Vr6Dkz9EB9a9ipUCqZ7rzG6FSWZdF
         ttM9RPCSGCrYCX4KOAuebU5iVSi8CTjPvcbVuRjZinmNbbQTBWW6XoDLikTwviAxYO/G
         sWMeJj6oZxqILiS3bR5mdsSGTOpgNiKjZus93DaXPFJwH4irUE1nosKC+2hWCJFGylJR
         Yesw==
X-Forwarded-Encrypted: i=1; AJvYcCVCH3xNS4+76Ah58Hr1ETMaZz04YJiuES3pkVuCQR4ktnZMhVNU/hmT72gbFRz2jtcI140DxSwdSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KqSscPIKDd2+a8IZdh3RPy8I5mYpwCyew1Q/cudFNzHcXCrS
	bKJ2uX7GR9OX8TpfZckij+ploD8ZGhPQeW/B5WuqTVz9nCvon7IzBjgU5zpYAKKxbN7TeKaAESV
	psiPiMlc58vbjWuPzM4mPYEwk0sfPPT8=
X-Gm-Gg: ATEYQzwfw9+XT+ruMu7estbJgDao1yH5JLBmYqdu3I9H1p4Z7cMrjcSKz/xpdCjmQjn
	Bw/yyWH8edyivyrST2W8mbVb07u+IpVuUzXFGSMqyEE9ACBxlG0lyRwWBk/djQl3ul2VzZnmQei
	nehGgT4o+sbDmKIeVgwAAPG0m521KkP4mJ6kxj/PrPeTwrp4XM586wZc+sGCCJJFu1agfTbCfCW
	oy1geekJJT1s/zlzJUVR+ltnViGCAMNJyA5Kxw27Eq19er7MG5kxi4METRKq9hcc2YNDt6SmgN6
	TQ2kTA==
X-Received: by 2002:a17:907:9621:b0:b98:13a:c92e with SMTP id
 a640c23a62f3a-b9b502b5aa6mr732407066b.2.1774856362950; Mon, 30 Mar 2026
 00:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-8-l.scorcia@gmail.com>
 <CAGXv+5GmDtrtFHJXs+fDyF+dZ5YW-TSEqXnPs2xCH8cu-Xcn9w@mail.gmail.com>
In-Reply-To: <CAGXv+5GmDtrtFHJXs+fDyF+dZ5YW-TSEqXnPs2xCH8cu-Xcn9w@mail.gmail.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Mon, 30 Mar 2026 09:39:11 +0200
X-Gm-Features: AQROBzCKAAw0QfB5IMl3n57JlPRQDr7IJq4vT7zpNh4df3HsPMVBkVCKdEdIBnw
Message-ID: <CAORyz2J355NZH=7iQ9sTDBhAmtjP7xTpXe21_3Z9J_R5YvdXAQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] regulator: mt6392: Add support for MT6392 regulator
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Gary Bisson <bisson.gary@gmail.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 19 mar 2026 alle ore 06:04 Chen-Yu Tsai
<wenst@chromium.org> ha scritto:

> If this PMIC is anything like the MT6358, then it has 0.01V fine
> tuning for most if not all the LDOs. It is sometimes needed as
> a rail may have a 0.04V boost that would otherwise be invisible
> to the system. And then if you have something like 3.04V set in
> the DT constraints, you end up with something the regulator driver
> doesn't support, but the hardware does.
>
> Please see how it's done in the MT6358 driver. I spent a lot of
> time on that driver to make it actually support the full range
> of voltages, and describing the supplies.
>

I had a good look at the datasheet (MT6392 PMIC Datasheet v1.0 08 Dec.
2016) and unfortunately I did not see any fine tuning option in there.
I'm sure this data sheet is not perfect as it's missing some regulator
registers that are clearly used in the Android sources, but there's no
mention of fine tuning in that code either. I guess it does not have
that capability.

I will shortly submit v4 that hopefully addresses the rest of the comments.

Thanks for your help!
--
Luca Leonardo Scorcia
l.scorcia@gmail.com
