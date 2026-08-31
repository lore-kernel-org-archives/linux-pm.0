Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA73B4E8B
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161224; cv=none; b=cxxKTRnzO4cC6hI4xNQWUrmyZaY7saCNiZoUKkiRfUheoKGJjzU9qYReIS1A9S4cvFpqNmKnnbs9utDRLutxKVyZZSekbwLPgfZWEKnn3/MYi6IFDVNe8bdWWvftH/HDRKn30Gwl/pDsqpcnC4v4QcT/N/FHUXnnJDpHsfHzRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161224; c=relaxed/simple;
	bh=NJSjNKxk7UVV5IkXZUW1icC4wugzqjTWkRjzeCpiY/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7A6L1A24P4CKjTdr2IEUA0V4sdA/rB/AG94RFeeeAdbaAsYG8j1Dx4Su8aMK/6ip53thn4BqJDrA306tfjU2Vjmf2kdOwzZXTfgeoBW14uQVnIx6tWYfpsvd7Dk+KnbHWnwobhxFuwfZIr44MEQQsZTJGMtj+PKW5crIZ7Uahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-966e7380109so2275802241.3
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 00:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788161221; x=1788766021;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pcgoboI+Bb0AHIqjcsWKmhJCOrwEFYSWyvEil53/SRU=;
        b=Y4ZpJUecXfGbMYYHmQaCd5FdSOIbd8Z5SvRerzwEStJqyk1JtInZBSwXrqu/Z9nVUL
         xR/seu+1jzn8pRXTY6DLUSsbCumYeXeVuGSoGe4EV1g5xNFU93xkr0zBjIEZWgvfbLaF
         LN9tW4IOMkVk33uip/z46zlBEVZxBMmcY87S2DmSgXNRDbRRl03XPO+E4xD8Qud9bXcp
         keviSRRbP7av/NFgXpLT2cuwO/Ctt7R5BDXTDcZgTQgOP47rjPfU4n8YIUhUh3JAM3Vv
         kBdgvtCoLZpKJ3sfPvEQm22/Rzak2Syp7p+hayMs/zHorStovkrducgEJIEvEDNYH9Gz
         Vwhw==
X-Forwarded-Encrypted: i=1; AHgh+Rpmsh1+Lm8YdfCDXWqmgOjmP+kBevyBV1quQIhYBGaChxKCrMoWEt7bTYbHbRyCG3ZX47IUCQXpDA==@vger.kernel.org
X-Gm-Message-State: AFuF++lukFC2UkeFhDVmoqGr8eE+q9Z7OEh5HHEyK8Fd4qFj9PYyRCsv
	KueUxaLdkyieWqejSi18JjlY6dJ/CjkZz/VgRxMaxDH+iZWsPX08phMq4CL+vTAh
X-Gm-Gg: AR+sD11o7/cTwVobOZbaYW1kZlmKUcIWIlkgLJFr6oPh2HVZRw/0P2mi8ZknUaY05ux
	lsqmRG8HYSNzjb2hI3rvrztpeHYgetQ0m68C7eMs6+lfwQhXAmqLvmB37N+besRO9Q9CiqpkMtc
	NtB4rqYE5MVYK+0mUDC38mOj7o/FqhdL4n/Fvztw0h8DTdmF+w2d4u75c8riJEksWJqLrDt2ZnV
	jczCvldlgZdxoXDbz2c9C4heyuup6l3h70d204wkuwbbEHKwjUH+HxWx9PyuEqIqQdzA/WqD2xT
	0DOiyZy7LtYgWYobf4XbTC31pHPIyvh7iGL48e//rIO4j4WnOM5wO8c4LZ6VuDFz6+aJYS6/Vge
	0DXK/W0wo4hJ38Qsp8tkPCNkXMyFx/qsZy72gx49G5FqKw4ekO+cGs6wERgGBYxUcjscVJfyYCe
	86dBF+55c9uwbWP2aa90mBmejUpG740beP7echTkcPFUNLNLAHeFXCHVT+GWrIzWRzfBGmG6s9b
	pXGvbZXExILCYtpb/W/hyymUouVDtzr6QfO
X-Received: by 2002:a05:6102:2acf:b0:778:f972:32eb with SMTP id ada2fe7eead31-7859996dba0mr9501339137.12.1788161220795;
        Mon, 31 Aug 2026 00:27:00 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e84a55284sm7366286241.4.2026.08.31.00.27.00
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 00:27:00 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-966e7380109so2275790241.3
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 00:27:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr+wODAIKko1XA7tQEJ8NZR40TguikmchMn/g2kkIB3Mb38lqm66o79y+GHFv2YZDo2UY6EUfg41Q==@vger.kernel.org
X-Received: by 2002:a05:6102:f9b:b0:77f:7df:ddd2 with SMTP id
 ada2fe7eead31-785972e710emr9393256137.1.1788161220080; Mon, 31 Aug 2026
 00:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829195105.4173953-1-joshua.yeong@starfivetech.com>
In-Reply-To: <20260829195105.4173953-1-joshua.yeong@starfivetech.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2026 09:26:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_3WoqOv_gsFnTpC61A48bQsmO_9FMT6PVAZ4bduedtg@mail.gmail.com>
X-Gm-Features: AcwNN1VNpwApm_cNNaV5_gp-0ahi5LN4GtBUOfohdJ4zOMTErKzIMnHRgt2jJ5w
Message-ID: <CAMuHMdU_3WoqOv_gsFnTpC61A48bQsmO_9FMT6PVAZ4bduedtg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Honour pd_ignore_unused in the sync_state power-off
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Heiko Stuebner <heiko@sntech.de>, Hiago De Franco <hiago.franco@toradex.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Joshua,

On Sat, 29 Aug 2026 at 21:51, Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
> The pd_ignore_unused command line option is documented to "keep all
> power-domains already enabled by bootloader on, even if no driver has
> claimed them". On an OF platform it no longer does.
>
> Powering off unclaimed PM domains used to be the job of
> genpd_power_off_unused(), which bails out on the option.
> Commit 002ebddd695a ("pmdomain: core: Restore behaviour for disabling
> unused PM domains") stopped that late_initcall_sync from clearing
> stay_on, so it can no longer power off a PM domain that was found
> powered-on at initialization. The only remaining path that clears
> stay_on is ->sync_state(), and it never looked at the option, so an
> unclaimed PM domain that the bootloader left on is powered off there
> regardless.
>
> Honour the option in the sync_state paths, for the PM domains that have
> no consumer attached. Those are the ones the option describes, and once
> genpd_power_off_unused() has bailed out they have no other power-off
> trigger, so they stay on as documented.
>
> The stay_on constraint is dropped either way, leaving the lifetime of
> the constraint unchanged. The PM domains that do have a consumer
> attached therefore stay under the control of runtime PM, which the
> option has never covered, and a PM domain that gains a consumer after
> ->sync_state() is not left pinned.
>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

Thanks for your patch!

I did something similar in "[PATCH/RFC] pmdomain: core: Support
pd_ignore_unused with sync_state"[1], and Ulf responded[2]:

   "Right, I think it's time to consider removing it, unless people still
    find it useful ofcourse."

[1] https://lore.kernel.org/1cfa86b72b2a5aa2ade92f247dd318c9cb6ef2a1.1771267504.git.geert+renesas@glider.be
[2] https://lore.kernel.org/CAPDyKFq2it5TAEBBKBh+q+UiRsGYaORar0Q_42LCuxyKRLYj0A@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
