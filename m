Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792926599;
	b=Cp19ZmtagDAOQDUbRuqYIof/nGMqvFwdnhRhHwuBrLZl2CmsIY8iDLt54BCxZyw9Og8W
	 AnD6RzHNvYW39bZcwkCTLueE5hKorC7pKMMiLsiJh7ZdZ/Nz2M/aznQOHJI3y8V/zBSi2
	 0z6VFiTIZorGyPSDoWTocbAGkovAACtzsxfRsw8cqKWzviijcWbrVxy/WPzZb//+E/wYr
	 OkuNxHuWhX7UVThPuH0i94dFA1pN8YYEVmqg14QXq20+Owz1jr9guhowkJ7q8BdM/gVLa
	 pI+XXU+CCKqO/W7sgkjJxZG5cjDctI8vP2Hgwzhby56hUUOGg5I4kW2JibWWsjhJQsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792926599;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=GjtDmUDJ7P9a7dCWsPAQRfLzfmaw50jjj96MMkbrG+o=;
	b=dXRyKbPbKwR3vVoQ718nRVxXrcKl7zH6vugLn5jZDLHwiY2d1K9flCObQU0GUE4Cp6wH
	 xy2ISNG7sO60I5ZH+pzd5TC+w5bRtroaR9KCQqSzwzUnP/DDgN00MCffJulrw3OwzRhU+
	 SeXeyFNB6HMdgoz4d8hR5rSof1y2UApLUhrgZLwpfCqPUFd0ZN6N9cMKtOla/fKU0tb+l
	 6nw5Vl9Hoi3oZcEP9igc+6i5D784FbdtTu++o27N4zZDeLgl4rBi9w5/69X61sVil7snH
	 EglXJTBv4vRLpedr0Fcd4eHnQV5smF3kBedOEJvSiIsHw+Xz1H6mMoVIU5CidRy3F9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7255606A31A
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 11:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7255606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-70059e4dab6so1546519eaf.3
        for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 04:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792926597; x=1793531397;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GjtDmUDJ7P9a7dCWsPAQRfLzfmaw50jjj96MMkbrG+o=;
        b=syg8w0wNih4FkrWz4UVJjIt8WNcDABDapcCJsTSrJg+TLrbkLZkPExrc8WBam0/oHN
         L5h758H7rCr0t7RGUcKPy2MmoBIfF6TWT6qg7sRGyEOdutDKa98+nyEsGrv9a2uCLgIM
         lDRUiaj2eh7vAJwTUDbTop2IlsR1E27lWM96DK5A++WFAoHoQnEmjEOaBhUBQKM6FdBF
         ao2Rlyz0AXvPHLxocdXg+0OKFSwuc8gE9eLbLWTC2lJv7IbRWlA1FIvs0QOL1unAKT27
         3tbId7/7Cp9b13gOrgUDndvYKdlizfkPWBZ97ggN/e3pfTejR2CJn+DOG6YiZ/nx3oA4
         ty9w==
X-Forwarded-Encrypted: i=1; AKwUvBx5n1zuNiXcKKoJ6EGb3IHjHu26UBJAtiS+6vur37xGsv6DK47Fgk7xuyEG2bSMABKxhAwCLi/PFg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLJYcOWdIxikcvD3ZmIkUr/DiIuAkmMl2os6gjjpuk+Bq1PZo6T
	7D0DGmg0ZFpBfkLmtV8WJnZyNbvNaFEfA3RSjfGyO9AazbEeytIXATapnLmI5Fkp
X-Gm-Gg: AYBFou0D8RvrPR/vlAznkFundcwdNjiHw42aOmbuom6q2CHq9swfTz4BbJoJ/KC0BdM
	yFeK/Y0sI4pA/uATrrpRTYlc79WINZdus1EyW5ldF9bqt9rV656u0bN63r/dBzS1/hVUy3r6p0G
	X4IaiZr/r5W5ll1Z8L7wEtLZz/PJsoc4u9zE+uSkN5zaskkzVcFGb6Yb3ylxfearHOUAgvjTpbL
	kz49GBpGi0EP50PYPX1jwnRu12fzRSMmO7qwhLB3o+15N217kKygZsfZSz7QrASc0PvPQoPce3F
	BkDrvBXApxn7MuSo7bipgEv82f0OEj2mwHq+oviC896dA+QzufhJ9K85N78uZCHJUp0G5ZokLBb
	qauciJrPmlg6/DgAeHxd4DEsttlo3n1Io/YKSz67lckYP4LayiO4GR6jAuUcFs5+xkuERHTxChz
	bYfl1mCxT6S8ZQYD2IJtC7gR+ILl1LJM9ugIB4XKGlEcxIG7SYHi5hsEDA/7E9TJ0q8rxqKM0gz
	iacxZ8Ocy2U5Mwu50ikGAfREmiEI9/TxTzQfD49rUpKQGzSKRPwmd08/+Vjs/dT4OIedP7iYhQR
	n6vA4P9pfF6aPLJgMQ==
X-Received: by 2002:a05:6820:1381:b0:6c9:80d9:5f0 with SMTP id 006d021491bc7-70ba0e54fcbmr2084396eaf.49.1792926597634;
        Sun, 25 Oct 2026 04:09:57 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a843225d69sm2538389fac.15.2026.10.25.04.09.56
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 04:09:56 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-844a8bf7e25so1558036a34.1
        for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 04:09:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw7lDMcSid3H7pmy/wUQe5KAHP4DNOdoa+Cl7qQa1UL1kPLCMQG/RGrHWmIed/NT9fNlJnXb6C17g==@vger.kernel.org
X-Received: by 2002:a05:6102:4423:b0:7cc:776:6c54 with SMTP id
 ada2fe7eead31-7ce5cd246a2mr1349167137.21.1792926141152; Sun, 25 Oct 2026
 04:02:21 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792776697.git.geert+renesas@glider.be> <f9de8214043ad4c8748fadce7fd2cc2fa95b1291.1792776697.git.geert+renesas@glider.be>
 <d870c163-8d90-48c0-bae0-5f6e0e38c5bc@mailbox.org>
In-Reply-To: <d870c163-8d90-48c0-bae0-5f6e0e38c5bc@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 25 Oct 2026 12:02:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcxDY2q7MK6Zj5MFi-4UVJe=i8L=gWSTCmLE4NMjdh4Q@mail.gmail.com>
X-Gm-Features: AclHuK8CaW_17mlyRa4Y7XpLgXIYuKk4YmAF6_as85fetPG-fOFZ1fPRmRtKgD8
Message-ID: <CAMuHMdVcxDY2q7MK6Zj5MFi-4UVJe=i8L=gWSTCmLE4NMjdh4Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] arm64: dts: renesas: r8a78000: Add GPIO controller nodes
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Sat, 24 Oct 2026 at 07:35, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 10/23/26 7:50 PM, Geert Uytterhoeven wrote:
> > From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >
> > Add device nodes for the General-Purpose Input/Output Ports (GPIO) on
> > the Renesas R-Car X5H (R8A78000) SoC.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Co-developed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Changes compared to Marek's original:
> >    - Use hardware clocks/power-domains/resets instead of direct SCMI
> >      references,
> >    - Drop gpio-ranges properties for now, as upstream lacks Pin Function
> >      Controller (PFC) support.
>
> Is that ^ OK ? If so, good, TIL.

Yes, it works without PFC, as long as the pins are kept at their reset
state or configured for GPIO before Linux boots, which is the case
for the pins on the PWM connector.

> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks!

BTW, looks like I used a wrong base for submitting, as the context does
include the pfc node, which is not present in upstream ;-)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
