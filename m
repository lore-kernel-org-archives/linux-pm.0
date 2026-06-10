Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C53B42FB
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082754; cv=none; b=ndzy5LiO6/Q8TYEQrnJNIxA/f/noPPacoUftKjMcFnJQffDHErMmItXWYt31picOzmiGMUQmKbW/5Z63Qjrq4WgUOt3W0Mc1oaO/TwxNjC2KoNMB+tH7KqoPW7ojWFqkoR/TZ6ZpNxbQaNXszSOz6dTKSIqY9s1NXNAwukl3ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082754; c=relaxed/simple;
	bh=ghK6aF6aETbxP54GDjHQxquaNVQAGy5VaoplYO1SdZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTxnt8pf223C+RCJKEGii/I4omKgKHli9ktFH+07W/HbGe4ejNT+PxTspz9BAAQjaGeASfO0v52dTiJ7s1CPm6bRs6HPt7hCcxGXeozP1QEwQnV1hEtoMSKJCuU5aTXGH8Sz5khu3Eprhh0IrQTwAw2UJ/dpsDyv+RjG6+g/h+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-963a722ed58so3876404241.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 02:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082752; x=1781687552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvSiPxRSSuyA2Tu0Q5BTWv5ByEu4oB1xOvuu6Hi/THA=;
        b=ULGmQ98Jy2eh+NWWdG0flhnpLyOdoHS7B6tdw99olEEmARuIj2/9sCbpjcJ3x7ycuR
         jp7IQRoHJK95yJvbKkWr38y/VfZBjjgDSeH87/bqiMz8R8OmnmC/cHl+02G8MeMsYk3u
         F50oAsMDHMx+HuJylKhy68wRsfaZIy1JEnAjHbBd3Iq1zHXY/x3oECn3VeQOe3QfmENd
         QUmrtnv0y0QO3K4rzFqmxGKIH6ZJrtmDacp9Mc+QkmvMaYLkLVXy6a4ymQ4yubU09M75
         ugapgEQenqG+XUPJrqYbu54tHwOUNOwrd4BUyqDd26N989+5OnY638i9kbMXP5Wuot2p
         xE2g==
X-Forwarded-Encrypted: i=1; AFNElJ9qI9KlPXN9zF18CDY2BLSUOy4kosntkxc0jbKvv6SIXps8gtJnH1HHsGegCkCMY7epyvFiTFanMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyMll5Jp+dsguUJB6nOszfATdZjqR5SgITq2mlqHMZzec7dwVd
	WsMLSdpr0BxqlDnuOxfxkOrat42OHHYiVegviRssJFESgNJ9xOF19Nmq7PAAGPo6Guw=
X-Gm-Gg: Acq92OE3SF2J0ljMesmnb7cHKfxcFMMhxzlXLcZJ/tnaTNXoNTLXod2gj/WtqFr7mLS
	0lAwLsQET+/QAOYg8oMNQ02ZlWqUbWFKnSgsivNXZYKNYGuVwGPyJTfXOd2q8VP7VSa7HAVHcUk
	V54ibW6SyRaOZRhNtbHV1W6cZIDE3991MV/CDewlo/ZxXh5aRsxe1BK6Cv2WntbMMokdVdVMKaW
	9DcrkfIPpTL/MQ+CA2oZwujmD8c8pBjG+JEVTP3fcksZDVWQqspPzNFsTsbwb06YpXdeOIUXHb+
	vhpp2yuk3tlXkXlLhcEMzDyQzLZafIH+AiIaYq0BGZVfM0CVvftIQC4nsZtz1LqzGT2HlzrB9km
	rWKGkVotTYx/O5Ki81pIl7tVMi5BEfFBUR3WrgPt5zHcg8ALvteU3UTxF+T4BUrbs/gGHrtRV1h
	rHAUqRo8bvz+JzlJ+MVji3UGTFFKRWKAeKuVUeZeIkInO1ET0ZCYEMub0uoibjRDweUmu2hgcJi
	i4=
X-Received: by 2002:a05:6102:6886:b0:633:c6c4:b321 with SMTP id ada2fe7eead31-6fef853029dmr15202785137.18.1781082751777;
        Wed, 10 Jun 2026 02:12:31 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb5549144csm19438738137.3.2026.06.10.02.12.31
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:12:31 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59d4aa96ef2so4647987e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 02:12:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+dbV9FBFpU/TCbDrpgjDtMJ4MKgD+pWkJ4kdfO1TzLaI4BnhmDx8J//zeOafgKVaRYhe6Zap2nLA==@vger.kernel.org
X-Received: by 2002:a05:6122:c8b:b0:576:1a8d:8989 with SMTP id
 71dfb90a1353d-5ac48b8c8ebmr13425310e0c.0.1781082751415; Wed, 10 Jun 2026
 02:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609160634.246526-1-johan@kernel.org>
In-Reply-To: <20260609160634.246526-1-johan@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Jun 2026 11:12:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVyRq7fT_m_gWtVKkkaTZQvSUvkMamQHb44x+Ed0jNbMQ@mail.gmail.com>
X-Gm-Features: AVVi8Cf3V4HusrebWQc7qKyySkLkeCjwskLNcCaeFmQk0clX5eufjcOE9wWHUEM
Message-ID: <CAMuHMdVyRq7fT_m_gWtVKkkaTZQvSUvkMamQHb44x+Ed0jNbMQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: fix early domain registration
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Tue, 9 Jun 2026 at 18:07, Johan Hovold <johan@kernel.org> wrote:
> A recent change switching to a dynamically allocated root device broke
> platforms like rcar-sysc that registers PM domains before the PM domain
> bus itself has been registered (cf. commit c5ae5a0c6112 ("pmdomain:
> renesas: rcar-sysc: Add genpd OF provider at postcore_initcall")).
>
> Defer the assignment of the parent root device until the domain is
> registered with driver core to avoid it being left unset.

Thanks for your patch!

> Fixes: a96e40f4afdc ("pmdomain: core: switch to dynamic root device")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/r/CAMuHMdUHabMGJyJ7e7yp7DLC+JJc9k6NK9p4anj2wRKNuwZUng@mail.gmail.com

s/Link/Closes/

> Signed-off-by: Johan Hovold <johan@kernel.org>

This fixes the issue on R-Car H1, M2-W, H3 ES2.0, and on RZ/A1H.
No regressions seen on SH-Mobile AG5, R-Mobile A1, and R-Car V4M.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
