Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B02CCA47A
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jun 2022 21:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354124AbiFNVcE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiFNVcC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 17:32:02 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644DB51307;
        Tue, 14 Jun 2022 14:32:01 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id t21so7067488qtw.11;
        Tue, 14 Jun 2022 14:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PZK9Icgxpkd1Nlbn2edlrCQm5XYsFqwIxCzqxft+Dc=;
        b=HsoFlgBaBSt48mzfWUmD7Krn9XrCGrGRT/NBErNu5KiOpI66E+vK66V4nM7q4GZE9M
         RLEI9Qtov9c9dKOV+FhixAOZIOTDaLksWig/4VkVWAu67GJPQW6TUZMVIyQCN6Z2oJG3
         +MMEUzTyQL6mEfdWeQEZpdOHGQKiE6zBbFYSYIKDdOctJeYDDkq+045wPSJdA2gB4pmp
         N8w5mLuHx4xQL9iRQvrpbZxI951DMKzVamkPXVrofx7CPcUFOmlj6TUzU0Y+BFmLTKz8
         JFCv8mcFiQ4uncky6aueEiZD75NPyqYwAIUqsoxLl7MoIP5cXDwxBVabQGNkjgwU3yQy
         vSvQ==
X-Gm-Message-State: AOAM530Ipk0yKZ3LhiDy+im7cGnk9uzrPFpPFvo7mXmBiX+oQ5JreQuw
        zxpgN6vhqjNxDGnWkIdaAKtYuC/+XcGn/g==
X-Google-Smtp-Source: ABdhPJwnMTi47HKefj6U3ZHJcYdIa5S9AO6X0wc6UpDswbVEgZZpj4tkDcN26HpPINgFlT7Uj/dRTQ==
X-Received: by 2002:ac8:5cc9:0:b0:304:e03b:5964 with SMTP id s9-20020ac85cc9000000b00304e03b5964mr5913229qta.433.1655242320289;
        Tue, 14 Jun 2022 14:32:00 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a410100b006a65c58db99sm10963831qko.64.2022.06.14.14.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 14:32:00 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-30fa61b1a83so43802617b3.0;
        Tue, 14 Jun 2022 14:31:59 -0700 (PDT)
X-Received: by 2002:a0d:f801:0:b0:30f:f716:2950 with SMTP id
 i1-20020a0df801000000b0030ff7162950mr8241270ywf.358.1655242319521; Tue, 14
 Jun 2022 14:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
 <20220610201701.7946-2-wsa+renesas@sang-engineering.com> <CAMuHMdW3uxQHk6SBX5MqnZsYqwY8p+0wmD6gHwS3ESUrkmpWkQ@mail.gmail.com>
 <YqjtBQdzexzCRrmq@shikoro>
In-Reply-To: <YqjtBQdzexzCRrmq@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jun 2022 23:31:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTR8+8TbM_AaMXk96adHvdp_Oof8v48_zCY+R5FsOLnQ@mail.gmail.com>
Message-ID: <CAMuHMdUTR8+8TbM_AaMXk96adHvdp_Oof8v48_zCY+R5FsOLnQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779f0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Wolfram,

On Tue, Jun 14, 2022 at 10:18 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > What about splitting this in two separate checks at the top level:
> >   - one for regs (R-Car V3U vs. the world), and
> >   - a second for interrupts (R-Car V3U+S4-8 vs. the world)?
>
> This task seems too much for my YAML-foo :( I couldn't get it to work.
> Can we leave it as-is for now?

You just need an allOf with two if statements, cfr. e.g.
Documentation/devicetree/bindings/media/renesas,vin.yaml?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
