Return-Path: <SRS0=beHt=CG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8D9C433E2
	for <linux-pm@archiver.kernel.org>; Fri, 28 Aug 2020 11:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF68521473
	for <linux-pm@archiver.kernel.org>; Fri, 28 Aug 2020 11:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shriYB3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgH1LW7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgH1LWs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 07:22:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAFDC061236;
        Fri, 28 Aug 2020 04:20:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ba12so830095edb.2;
        Fri, 28 Aug 2020 04:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGEywKnAVd/7RJTemAGpNeUCwMzvl8U0yMAeNAGkB+A=;
        b=shriYB3pW6Ji3P2tXtVXq6xzGJe0LNr+8mfFOiPUVkx57QPmVvXTOTGFb0htkFze7Y
         2v0c4EIBb0oav/RbMcJLGQfuDgwPgu/qEJ+y1gpi6I5Dgk5D+XaZCjt0xOoJCGBA+8Qm
         kAj3XodzB19CoWxvyawj2FxA4aPoH65gSPyq5tlDNym9wpcp6z/HpD/4vP6yWl4Yn6gg
         sdciGTkwW7IzjbqxQ/YpIOle8YleayqpeTzTziEusYe88ucETWUk7Czxll4vKhd12hPy
         UK7O9s2hd7YszqsIdXG+/zZh5LWqQgBl3EyEKFXuAFQy6ZXhkOiy9wFdfJvMhUWZE2ca
         ACkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGEywKnAVd/7RJTemAGpNeUCwMzvl8U0yMAeNAGkB+A=;
        b=XGXwtVloXQvb/0VRzVHnV8kLNX6Hb/OBGUoD9fTy2UQBolB4PsSupiKQav397kOl4v
         ynfmVIVsFv/0DbM0NB6ZgtkTtEWJ1YC8fqxiQXI4bWvgTcAE0ZvC+gaBdHxYH2mIjVy4
         q83xr+CyjwmVIsrhB2FwpMNbjh4DH442Wcrs9tXoRFcf6vIIopeyb8J1cHV/qaIC0HAm
         YPHdvKzx16GzvgPLfdifHa1/wtKNSQcesW5h1Fh7OR6sgH/Tf43Zvc+wQdELbp3VQJSk
         iu3Cbuan/lweI3eAf0iZsABDExwHG1QDprRBTmP8Dtyrrpy78BY7/b6D19LvfGu0lPso
         H/Ow==
X-Gm-Message-State: AOAM5301wL8NOwEUPirWNIylCifOtSoEghHJMHM5BbByvpujxd+ZHW3n
        AszEwOJdY1dSWnbYappVzKhmc2ZKbJIpVHeL9m8=
X-Google-Smtp-Source: ABdhPJxHU6efi6VP56oGN/Gh8MTTFv9XTrFYMw2OHFqrv85P8OtpsB8qpJMUBIjJbVCGFYF+pUj1wj0YES8n8n5LRp0=
X-Received: by 2002:a05:6402:1a46:: with SMTP id bf6mr1307131edb.284.1598613640690;
 Fri, 28 Aug 2020 04:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595572867.git.frank@allwinnertech.com> <CACRpkdYOKOj4r-9U2iHCkdB74fWkm2J0xHqsnH_sE81SV5g1=w@mail.gmail.com>
In-Reply-To: <CACRpkdYOKOj4r-9U2iHCkdB74fWkm2J0xHqsnH_sE81SV5g1=w@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 28 Aug 2020 19:20:29 +0800
Message-ID: <CAEExFWuO06yBY+_Z33FHvi5B_y=haX5Q_LSH8zN8Sr3FUqkwKw@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Allwinner A100 Initial support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Ondrej Jirman <megous@megous.com>,
        Corentin Labbe <clabbe@baylibre.com>, bage@linutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI Linus,

On Fri, Aug 28, 2020 at 6:02 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jul 24, 2020 at 8:53 AM Frank Lee <frank@allwinnertech.com> wrote:
>
> > This patch set adds initial support for allwinner a100 soc,
> > which is a 64-bit tablet chip.
>
> Shall I commit the pinctrl patches (if Maxime ACKed) separately
> or not? Once Maxime is happy, I am usually happy too.

Maxime told me he wanted you to commit the pinctrl patches.

Thx,
Yangtao
