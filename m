Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492903;
	b=oAoG2U6wGamA7fmJau1KQ+yMsOIwwpR0EQYiWY9zIi4qV3pNCyaUJc1yNcoTltmkrcGy
	 rtkFv1RbLKY1tvNgLck1dbXlTbjAFq//wFObLt80HR4ROSlZPEMrPXbXEnuLsNqYCKoCf
	 0TYRf5DjNmKyhq+N6+HAbyOThGq8mTCoFZPCSUdy5Bb1KG+zXs2cQb1T8NkUH9Eu9CkXl
	 d41FPxhYi5QUunIJa0rdG7uhN9+hIjgLvov0sXgTPanC7G/Ly98vg0viWsGtJIojDFqga
	 jvCrAnvF2Q1xsFP+HTknV2kg9bIoVBj4aeubpRQhB+VD2q9KaYSpD3IyCAoyMkUVDoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492903;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=p9x4nyKp58U6HRLjvUMttJNHFZj1/ft861x7cFqIKgw=;
	b=WnXc9GhsE4oVX518ua8VYihisnVRq7ze7AKpELt9NCPzfPbmbpr6TLg+VVLTFYjMbDVf
	 EmYKhCDFZpXH1HaJhVfvYoG24ncQXVyr9C90GmakJtOjDqq5eYb0EBhIC74k443t+k3b6
	 0uYMpMzxLvYpdj7fDWqp5y1E5EZC0+QYGtg63Hluhst5VSZT+BW2spioe8EqMDeDHJ2rt
	 cvDpoNxTYigy0/TQE97oUPC6NwbMubLLnkwj7HXaAgLgW3VTdDQjCbXT3XQjpU0c6cT3k
	 zDkpwv6pIX2QPBBO87CVrlgK+GAv5wHna6N7HEF8m/kXCSbuRN6XV7MdLKrZz2RB6kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2234460A3816
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2234460A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so1421824137.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492902; x=1795097702;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p9x4nyKp58U6HRLjvUMttJNHFZj1/ft861x7cFqIKgw=;
        b=tz0TnfwA74ejgYaEjvGCJq0kqglT7NRIlzqoWT98O0ny35ylV+a9zTnxtKY7ihjNBX
         HCowEa3256BF5AzSSo2wnxcmgzU/3hdX7BOnv5ePqpASJmFESn9WHS2roO7QpMLVxLOX
         ANRMhXa6d9KHcYKkgaSMb5u54+xzQE6EgqgPlLoYHz5vUfBrpYy31Ezq2i7199Ohgrd1
         o40t1DYB/cM0v6cMfz9Bxp7XOslEq151DYkaiddIIwo8lgwQjRpjLEjmCYgyxhH1F9qP
         0doZZYb69uocl2oW7/DILv3d2LHE03aYMzxK/OBFwmDMA9CFxUN4LKmonwUD5OJqvwDH
         f+tQ==
X-Forwarded-Encrypted: i=1; AL+hErFOwIee/j0oXvRFyUphGs9WYM52b8DCBB9Zi2klKuvz1MCzY0StY0stAR2vpb4oERV9ixfyCMe4HQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z//fiEtwTuYZ639iUQkbTbqnbvXm8Rff8zw3JM+BPWJr2B1Kt3L
	umatDCqxy7yyO7EUIOxTcm25Q3sfUppWrI+gBLUea50h2gLTvB2RGt27dGbDD+o3c5g=
X-Gm-Gg: AYBFou19Bp7RYzmrzK/ifdF7PhrzDj5w1gxbAzfdGfIy0o/0fsB/EfrI+6cS8gPU0Ap
	qll1SMWNqBqfnbExGhKkIOux8703P5fMPVFDsNJbflLndW4z0KjYq7dvZw1D7dPxTucGDy9J9LB
	EUdtVQxJ2D2aiKnfe94WpzUV3WqtKKpTq1b7xtyD7LlbU01JDy21vAlm4sXFFzD2oD7GojMTrIW
	J46QbEo5pNNvh3cqxMIaxRto59n5nn4EKSS8YB/h0VMnjUzv5IxEZKlCen7FZFKIADyqY+mtnSK
	n0BWf0uYkqsyKF74pxXiqw2UBxYa+Dwtdi/uYjklBhzTAsm4pgYIUvhvStyKZZN0Lc+w3r4wLm0
	p1C03UKMboBe/XLZBVlhoCtuIjyNwXqUVZS2/nS7/hhL/1/ny9d7C2YFCFrMLsmEeyCkk/hLBvv
	FcoHv+QgsgVkAjsrYspxuq+pH4wKRM/ktitCGsKTYfWfXVH8oF5sPpnDNwhyzQQ+nGWF/Kq1cAd
	bJXQzUlMrmDv1U/a+Hzmwu5GtVPaN90Lplou6qiOKGH3cJootlZWG3YggRQvuCRxgKDG4VggKnp
	OTlIMvF6uCTzrqpKXkN+/Fi4HtBPHGrYegtpAs5UF+o55Po+pLLM2DLv3SSrLO395qI=
X-Received: by 2002:a05:6102:508e:b0:7d2:b199:6712 with SMTP id ada2fe7eead31-7d50618ccdcmr2078612137.30.1794492902016;
        Thu, 12 Nov 2026 06:15:02 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c2003b37csm5626319241.6.2026.11.12.06.15.00
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:15:00 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99be509f943so997013241.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:15:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFil4c2Tiw9b1H00PvLwdi68oyGA//WND/+LbznEw1dRt5GWjag5K0SPG0qSTX4MzwxD90l8S0yQw==@vger.kernel.org
X-Received: by 2002:a05:6102:5798:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7d5060e293emr2040092137.21.1794492899954; Thu, 12 Nov 2026
 06:14:59 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
 <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-2-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-2-1b2072e8c37e@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 15:14:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVBBySyLE=5gG5HvQV95811asBZ7LKwsQXAVPdUPjjTTw@mail.gmail.com>
X-Gm-Features: AclHuK_i81THT_hnDNfFBzoyAYqo67SKua85inNQRuBh9I9Xk4b1lG_6SVOc53s
Message-ID: <CAMuHMdVBBySyLE=5gG5HvQV95811asBZ7LKwsQXAVPdUPjjTTw@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] pmdomain: renesas: r8a78000: Add SCMI maps for VIO
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 14:34, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> Add SCMI maps for the VIO domain to map the VSP and FCPV power domains
> and module controls.
>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
