Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491118;
	b=5YrZ7Un9alglXshRXEYz4eajZSs0jWLuz7O70nFyaglNTocUzRuqZxIoMgAQHJaO3Ims
	 0Hzwboh06av1wqs9n1d87DomdTD4ViojIVBZRpaK+9GWVN+1ev755gbjJbHwYYM+alcg3
	 JOUdoa8F54S/qq/HUihCpzlnBC8WTDSvlaBG2Yu7il7orGH89LG8nr3mJKe0VGm0WU6/O
	 c3+Ntl7I8oxSR/qwWU5JmjjyV4aMPgHumxffIy3INQ0DSunWwTWzA6a51m20u1ip1AZXr
	 RWYle7JF5HH5dF0S5teQf2MtGfWu5hAV8UCFaiyD7eHbN5nIMpxkcXGtP3bpSnv7okw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491118;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=4m5/EFtVtJMcX32G0Py/nICnHfPv/lKNQS3VJ6V35d0=;
	b=sVK3Gm2axtLf6wwTvzcovf/p1IHXAaICR3zF4SM2lSOqwxKjadhYbsNOpFZ+ou5rtdlu
	 xuJR5eQgUlnfLQO7FI8ueUt7fl5Q4WfruUsCqYyZCrG5vdRbaShrdrGSIZNZaU11hcynH
	 yEKB7V4CHl+A9mxzBszgtyLJcAd9+aoucdCF3uhu+8bvvqDgh1UP9cAvbE/DCzXAiJM1J
	 b+AuARQ0lgWjvxMw34Ce9KOptB3cx4Xkj385FA7haY9rNYHbQHOj7WYORW/4tSVW5/+nq
	 w8x729KpDcAtIxwmrUbHFSSLoF4D3B0r+eoF8qe2aHkTsVzNyJYgeOyPtV+ZwKs/ZMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A17606A323
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A17606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4c9abc1824so606312266b.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 05:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491116; x=1795095916;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4m5/EFtVtJMcX32G0Py/nICnHfPv/lKNQS3VJ6V35d0=;
        b=L40HOTDjko/rhOA/HOLgrBOjIOEEkPxoyh8OI8aM9tZVbsv3SC4TaU8I/7N61BQ6fe
         4qFo2uXoaPe6UxBRz0di02Z5EPb12RcgKIK6QvBRZmboyeMJ5oZxigA8m9nIKOro3Mf0
         7O14GerpjVgnq3ZkIXZHAHbdGo0gQxln5TE4Mz3s9s/r7ILIXZyy+l6pxOR+jtjYiXkF
         KMsdZvGLlFbkeMTKic96z0zxyUqyD9a8W0zNAQJtCpIm7hHZdk62hpvCGjDUt6K8W3vv
         t0sD9L2SIFmqemQcBP71G1OXzuK5TvmVYNCdPmDsbqRgtD13T8H5ofyZi8J2GVUHzCfk
         fDuQ==
X-Forwarded-Encrypted: i=1; AL+hErE2VKTTYfeL1OCPoVNjhIFzCHr6FUhXvoWN88AT/sj8lbPaPw8/7WKIhYVTcA0bG1BAVxRHDgBRrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/n6S/vca4vhwOcz89NgTxNvOVMCvsQ4WcsU+XYHZU3dyB0G/K7
	9H7SgH+Wc5kQc/VilYbUUYKN9mSUswd1OP9WaCleAMVM6URGj3jzqOuI1hoFOuE61Fk=
X-Gm-Gg: AYBFou3KZpqwvOKqSXh1Py6KcKiCMcjEZ4BpVdgwz1sQYlolWsBx4LBp7QlpdTtHbec
	SOEMoiPcVvPTaFwNaYPIaLEJT4QZA/2JOIelgK1W6B1gS7qX2y7O9qoNx8rBm+Ji/xbGgT3CQW1
	HP847zKmZx/GmWBoub9sCNtI2WtTYHQ438wdMTrfwZOppQHHoFah5ShBpTnFp0Ej1ZsM0oZn8S0
	DBsyo+kez2c7d6LcF3vVfmCWC+Hm+mJu29MLM3B/peYBjc8zEDDIpBDoTHAjkqNwpWf2fEUP0nl
	Q/iUiANELDadyZXoaFjPh38x0bLIHDIzzoyRrOuhjnGMMJ7pjwoIQumk7kJ4KybYDzScO3PBnNU
	vBksTFVZrw8MtMZx7dFXQ2HyJDLUvcV93vykUu6SqvbLZBNhCGO5/I60tO96le9dOuvpmG6B//l
	IHCGNB7mLBv9H9ZE8qeFTa0GR2X17BjhvnhNv2j3XxR3ibzUOHTp2GJeb+av4AIoPhHGqIe1AJn
	PAVOTXYVPPx1QpChvKNwHJtB9OP8a0KFx35kpibFTnkcFJQTYH0WtC/2JEfvPxWlrhTXbeZYfWE
	hWx7y5yZEjdnEPSnlaNukuulQ6B/CZ7tfzCLCIT7+jly18xLzlAwevOnTtQZVZVWQ3ptzk/LKA=
	=
X-Received: by 2002:a17:907:2d2c:b0:c46:7ec3:fde7 with SMTP id a640c23a62f3a-c5066b32327mr477340566b.31.1794491116179;
        Thu, 12 Nov 2026 05:45:16 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a683d72sm346070366b.81.2026.11.12.05.45.15
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:45:15 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4cdc606b47so673772166b.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 05:45:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGZCtmrj84jkQBjTuKFVYEK+Jah2iyTlXGjKcKNaVM4QMOeZnXA9+C1izyawjdFhLsgqFC9nU+5rg==@vger.kernel.org
X-Received: by 2002:a05:6402:1bc1:b0:6b4:5a9c:4e44 with SMTP id
 4fb4d7f45d1cf-6b77770644dmr2967919a12.37.1794490681628; Thu, 12 Nov 2026
 05:38:01 -0800 (PST)
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
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 14:37:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeX=6DCLv5GZo1UFU2Nn1Y4zGxCMovxyQGefO+JpuZ8w@mail.gmail.com>
X-Gm-Features: AclHuK8Bvm66uPuRAPPxi-MPPvPl-KdDJtyohfMgnqBqTlOChWJE1Vd3ab7DaZs
Message-ID: <CAMuHMdVeX=6DCLv5GZo1UFU2Nn1Y4zGxCMovxyQGefO+JpuZ8w@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] media: rcar-fcp, vsp1: Enable on R-Car X5H
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
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Phong Hoang <phong.hoang.wz@renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On Mon, 9 Nov 2026 at 14:34, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> This series is based on Geert's
> "topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v4-rebased" branch [0].
> A branch including this series is available here [1].
>
> This series enables the FCPV{B,I,D} and the VSP{B,I,D} blocks on the Renesas
> R-Car X5H SoC.
>
> This has been tested on an Ironhide with the vsp-tests test suite [2].
>
> Full summary:
> /dev/media0 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
> /dev/media1 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
> /dev/media10 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
> /dev/media11 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
> /dev/media12 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
> /dev/media13 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
> /dev/media14 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
> /dev/media15 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
> /dev/media16 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
> /dev/media17 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
> /dev/media18 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
> /dev/media2 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
> /dev/media3 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
> /dev/media4 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
> /dev/media5 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
> /dev/media6 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
> /dev/media7 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
> /dev/media8 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
> /dev/media9 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
>
> The last patch checks the device revision and prints it, which is useful
> for debugging but is unnecessary processing for driver operation so it
> is marked as DNI as well.
>
> In v3, most of the patches have become DNI because they depend on wip
> cpg and mdlc driver work. The non-DNI patches are targets for immediate
> upstreaming though.
>
> In v4, thanks to Geert's new rebased branch, all the clocks and power
> domains that were in DNI limbo have now graduated from DNI status.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v4-rebased
> [1] https://git.ideasonboard.com/epaul/linux/src/branch/epaul/v7.4-rc1/x5h/vsp/fcp
> [2] https://git.ideasonboard.com/renesas/vsp-tests/src/branch/epaul/fix
>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>

Thanks for the update!

> Changes in v4:
> - Change the clocks in the dt nodes to use SGD1 instead of SGD4. (see
>   patch 1 for details)
> - Removed "clk: renesas: r8a78000: Add clock for FCPV and VSP for SCP FW SDKv4.36"

And it still works without providing these clocks because the fcpv
and vsp2 drivers do not manage clocks, right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
