Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B464941D239
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576047; cv=none; b=aU7mBtxGFiP1DUkiVscmzzuiJg5m2pDOYR6Gv2xPVFg3ay4WiFHqQuK6nTPWCAyuyUj9Q6uR9FkwyAUaDJv3sV0ffCWsrmAMmhy50hoyuBH3gpsSJVHQm45TWSn/YCi9Bsi3CP92GD7baKvpfEG5Q6TQBf+3QervOMFuTWcupuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576047; c=relaxed/simple;
	bh=22qCBYveRKFJxcMmmUW+ua4eXWAmfuygrtGmmXgJgbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpKzEIhPJu/W0sSfLZTUR4WY/79tSMDEVn1XBekYeYXWoWW/DfKNaOsNemj0lpocsJwOOdozPewH9AM2XrWMvsn3hn3N4OO7tltLuyYdg5bYW6wxBebBdl4CiIu80PiPKR7hDPpyMQNRUltrI38UmJzN1cZuNGAAcwSB8+RjhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-97c7be9cb6dso1276905241.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 05:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576044; x=1788180844;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Eom/X8opTXnjGOdU2jJfg3a1DGcqhjQm02nKfziCp2M=;
        b=mMEejKF82hrOD2WzfyTpuouenWPIqIFSWC7lvvT5gavmccZr4jYEQOKCKKpPrT6iSz
         I4EZusdIAdJOIoBHucXX1jNaZ6pBdJSX+RdP7R0lFXNjzCbzp/EnGQJQ58BPOeFNqEbu
         B9vNEwrtlAxgfRsbRW5bU0RxKrMV55qqf90Bz3PVtXwmtaVUhHhg4cS6s+rKPuVSzOMV
         3f/w2TNf/cnSxBrv7i8sx905YN+Wsl0eQXR0nIimjZyL+gWITwbLIcJry7WSYT1qfdoj
         YPauC1qrGq3dCgk1FJnxsBHr+WClELkRdo8vywUllMb4EO654jBf11vSnfeWDoHNCbJo
         4oBg==
X-Forwarded-Encrypted: i=1; AHgh+RrprZD9QooSmA1S3WtLGyEoLb3UOIbwINZM15EX0BIXU8OEUS4dpFZE76wPJyVLcWHSOTk/wgW/+Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lyqGtwG7dKbxCrMyX7CL8+2IseuqNE5cy1QfOVmU1zM9DOnBqN
	PZs2fnRdZgBRhH2jJ/SSFWa/TswVwMjr4vHJureCAhvOfF4BDRWiKnL61h58MN/H
X-Gm-Gg: AR+sD13tszq16PmhAPw0pZxAx5EqtLIdd37ryIEu7Hn1WqmKpFw9i105b0M5sE/M522
	Lew2jfPMnR3mtjBowOaZOtPAoajy+lxxqSuWEqdQVY33t+yL/6r3DwLLBLMSg8pIHnP8KRvoDT0
	CL5HExorpQ8jpae5sjYqDhdoqZaTYqF9e9zWCHPO2ugPIiJLxL1KGsZLqu1QvkKzNO7khV1Z2ku
	yBgzLiS00qk+PYz8PLdoz7wMQsPy5SO6rZT0pNQBX43Yf0sUXcswoFA/Mc3nZGXSdzTLANQcUaS
	Yd1NXHnpbx1nqtI14wHlMYDY1WUpwpx8rJctm8TugJtS25bcX9z88Kq1JlBBjiHraszXBT/hF4R
	I/AxBTjmUwlsgXWEOLFzErwmSXF2QMaFWs00fHP4jA+USKqai8p6TTQtIjdxT2YogWS4m95DBoa
	1Ndp5HXTEp+VHGp+faA0AU8ffterEaJlYiDnuOD6ZfRK/uRGjT85Zj+xwt/BonE0WXIQeDJWNp/
	Sgvnz4a5OM3T1MOwwDmDlFnVLynIQArsABCyg==
X-Received: by 2002:a05:6102:f8c:b0:77a:7cd:8473 with SMTP id ada2fe7eead31-77a62847969mr11221008137.4.1787576044528;
        Mon, 24 Aug 2026 05:54:04 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c836fb2d8sm7464802241.10.2026.08.24.05.54.04
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 05:54:04 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-977168e4f3dso2616319241.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 05:54:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrf5twGFR23HSwRt81ib5nK9eBPcXJGXXxUWo6ufYPsa7/xK+T3JcEEWDAwp0tFRbAuwLGf8SNvLg==@vger.kernel.org
X-Received: by 2002:a05:6102:3c9d:b0:77b:b14e:b6c5 with SMTP id
 ada2fe7eead31-77bb14ec487mr6712686137.9.1787576044162; Mon, 24 Aug 2026
 05:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150940.75282-1-ayman.chaudhry.kc@renesas.com>
In-Reply-To: <20260821150940.75282-1-ayman.chaudhry.kc@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2026 14:53:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAWhwybqECDZWyMXNR8cv4GXvFe4BQV-m-Wax+j6U5hw@mail.gmail.com>
X-Gm-Features: AcwNN1VBZ53Z8AyT5wwWA02V_hOL4uH3XypVon522o3KZn9AAHsHiFE4wR9dg0U
Message-ID: <CAMuHMdUAWhwybqECDZWyMXNR8cv4GXvFe4BQV-m-Wax+j6U5hw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: rcar-sysc: Update description of chan_offs
To: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ayman,

On Fri, 21 Aug 2026 at 17:09, Ayman Chaudhry
<ayman.chaudhry.kc@renesas.com> wrote:
> The description of `rcar_sysc_area.chan_offs` does not clearly document
> how the field is used.
>
> When `rcar_sysc_area.flags` is set to `PD_ALWAYS_ON`,
> `rcar_sysc_area.chan_offs` gets ignored, therefore improve the
> description of `rcar_sysc_area.chan_offs` to make it clear that the
> field is set to 0 if power is always on.
>
> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

Thanks for your patch!

> --- a/drivers/pmdomain/renesas/rcar-sysc.h
> +++ b/drivers/pmdomain/renesas/rcar-sysc.h
> @@ -29,7 +29,7 @@
>
>  struct rcar_sysc_area {
>         const char *name;
> -       u16 chan_offs;          /* Offset of PWRSR register for this area */
> +       u16 chan_offs;          /* PWRSR register offset; or 0 if area is always on */
>         u8 chan_bit;            /* Bit in PWR* (except for PWRUP in PWRSR) */
>         u8 isr_bit;             /* Bit in SYSCI*R */

The same is true for chan_bit, and almost true for irs_bit, too.
So I'd rather correct all three comments at once.

>         s8 parent;              /* -1 if none */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
