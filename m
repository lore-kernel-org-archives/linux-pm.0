Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610465;
	b=ccRQbre0h76T0p38wgTAnNCnXh5dyuIiXQBZWmZ+uM2OHKSvuIxGIH5Im+KjjL+eNfOV
	 EbK2BLH+KeNFrtyEK5oag+2KtDNVtdReF/7iYk5q0kMwrLmE56rXxhsrM8x2qsdc93Imj
	 TMiLFR757yv13Yp1Fx2vxG14Pb4ea/baRWy19+LN6HbebLSTN/wLu45PDV0ON9587TB1q
	 GXvvHEKDpwJTet/GA9vy8fAOh14Mp8wYqY/lGPrUST8ZIlCUehx1RfHbWUwJGkatMJ4DE
	 41/8Y3l8L3B8JjG/8tQpRO/1T/GJloSBwA/p57hy3OR4M3U/FaYS5AZ5BYHpE55k4ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610465;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ac+xpJrvd6zfAE97WIurl+pYtHzF00Lzr1WG7VTrgAw=;
	b=LNI8NetERe/VaTyLcvRJ/7K92ZoOvgvLGjbQVs2yT+jEXYEmsR4cOofMJbpFpxbqryUl
	 Bk/zeXvW3W3kBMMn8Ynrv2OheEJZ7ArMkTbV1223d41qw9A8d7DGpmoe9dp1vREklkLI+
	 cptaqLK6iUSKGSq/8fCw9QF5LcA4IUPpbjofgR5Aoc3GpUtYmqGlz29LVvTzn5/qIegop
	 wjQfEH/FDIIvEOFO0aJdnEG53yrun2Q6nP4xXspOe0Dor9RNR5PS4jTf9datnJX9OTojH
	 yiRRkXBKHAiYNn+PNac87KRaUBhtQ4SwBM6/7hbj6jllYiKEtCJW136rA68JV6uKCbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C5606A32C
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 09:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 959C5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc013095d4so802382137.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 01:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793610464; x=1794215264;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ac+xpJrvd6zfAE97WIurl+pYtHzF00Lzr1WG7VTrgAw=;
        b=IC+CwYXMFCCQC+vPb5vdQoLhO0V9JlPpPxtKn5eZMlfqfyCgLEdgnXKACmty6kISu7
         iFKpIGFeL2ZT5/LO2CmTZIvXrZt7kYGCx8Q69WFxDPTQw7JOKvnNs/h8zuG5ty5WPhrn
         B+Qtbv3b+4AOqOVNL2zCYLZgmr5NBOeF6YKfqjIyNDRQ58ckFRjsg3Qv4RmQyWQFwaEb
         4EP2AJX5FmniXvWC11TZW6Kkuz4sjq/pCW6PIhajcy3hhRNR1cs6EiJbTEWTtBlbZAZR
         jkfvXfE2UxPA/rkOEwEs3fJZWFKT7EnJOwO+mCurM5XOE+SJEmC956Lzuvj3NtRPucsr
         DX4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwnpcxsQpTLMT8mTAu8qw0xYfc69Nh58NKWe/iFyqt8lIOtKA8ahWBnVDEl76NCqCIkKa7YuPso9Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8howqQ4Ts+m0uZff8QMIswwkehjwZ18tPlXCRILsBEy/XgSy58
	L1FfqFz37eu5t855ytX71dJzAOct3VZCxchVze3ALIlCh/zEYvf7rDZXUbJQjOJx
X-Gm-Gg: AYBFou3LIEwcocuz7hj6EQ4wqbaHWW640xhxGMztml9awimNNg0jGt9Zgtb1uSV9tQv
	eBodTry40QTuybFcEIBO1rYhisH/gR0+K/6dygSl/cTDP/MSmFm3+Qr8VMeBuKptHgF5xb4xzA/
	RGQdWwIkJfAF1JXPf/HrKFZCH2vPMENZ99LDIIBMC0lKMMjWaOVlL7rnfbkAoneAEFEF5P8ZCdV
	C6ih/ZZAtPhUakMub8Pl0dQpgQDu1jR4ta45R1Ia9aTSpDq0JoPcQVOyjRhrWewD3Yf8uas0x2T
	d4KzAzfuSRnC9uxXFvCJypAvOluz5rXfWVfMieU2LM39d9O45Gr9NPzW1z9Yy43qPRBAL0n8kUF
	27hLrD+m6aHzJf4YvNC4zESnhgFPzbZYsqoEVLtepyYKrv7NNO6ByeYHDewPTvKpFctZ7Xu4xBc
	mV8WGHOvChg2JFFQBtF8eqPmSOIaWom40mszhValHnVq1F+1Y37RHHQ/1WrCnyNhbbT0y/M2OqP
	e2mapvAMvXapiae90S1ss/OBqhC0CeDnv2V8LXPSW7XmU8PmwmIQbj1ytkiHiwNw1kpG/hB9Th4
	RzxDssdrzDY7PwRrGplyVgWzT8Gde19yq5TAfuFGiIibnrpxt6wIZMf8BdlGLXBNLg==
X-Received: by 2002:a05:6102:3707:b0:7c2:799c:9031 with SMTP id ada2fe7eead31-7d072d11c63mr3073884137.30.1793610464495;
        Mon, 02 Nov 2026 01:07:44 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee3a066esm10945921241.5.2026.11.02.01.07.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 01:07:43 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so706042137.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 01:07:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzvQQqdf/yXl47KEc0XSQOMKA7W1fNBdfIHT+F4cj57CahcbBWEeMteHJNrSfdBLmR1/Ppb6oiGuQ==@vger.kernel.org
X-Received: by 2002:a67:f403:0:b0:7d0:9587:1b90 with SMTP id
 ada2fe7eead31-7d0958732b2mr1205111137.13.1793610463593; Mon, 02 Nov 2026
 01:07:43 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-3-e052903a3832@ideasonboard.com> <20261030220549.GH3178046@killaraus.ideasonboard.com>
In-Reply-To: <20261030220549.GH3178046@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Nov 2026 10:07:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX1czCW_KTW8Z+_jb3egLxqBu7bOUmqyXy3PqYhmUfLNg@mail.gmail.com>
X-Gm-Features: AclHuK-1v1dRSgyK1HeeK29l-3g4aKIGNPop6k2nHA1eLryORdmauRDpRhHjRsM
Message-ID: <CAMuHMdX1czCW_KTW8Z+_jb3egLxqBu7bOUmqyXy3PqYhmUfLNg@mail.gmail.com>
Subject: Re: [PATCH DNI v3 03/15] pmdomain: renesas: r8a78000: Add maps for
 VIO for SCP FW SDKv4.36
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Paul Elder <paul.elder+renesas@ideasonboard.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Oct 2026 at 23:05, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thu, Oct 15, 2026 at 04:51:43PM +0900, Paul Elder wrote:
> > Add maps for VIO for the VSP and FCP power domains and reset domains.
>
> s/reset domains/module control/ as its not just reset (and there's no
> "reset domain") but also module control clock ?

FTR, SCMI calls it "reset domain", but I agree "module controle" fits
better here.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
