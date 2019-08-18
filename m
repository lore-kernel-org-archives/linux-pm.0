Return-Path: <SRS0=Wgrr=WO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB0C3A589
	for <linux-pm@archiver.kernel.org>; Sun, 18 Aug 2019 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9872186A
	for <linux-pm@archiver.kernel.org>; Sun, 18 Aug 2019 22:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TD2+3+1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfHRWVH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 18 Aug 2019 18:21:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47087 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfHRWVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 18:21:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id f9so9709212ljc.13
        for <linux-pm@vger.kernel.org>; Sun, 18 Aug 2019 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4N7EQSOmGj3kmcTNPKFw2gJI2T24TmEUzwOY9YGFTVM=;
        b=TD2+3+1CBIjNRgLZwww8Qq1LkU6sL6SugbzUz9h75QIzYAWD2xhMDuC0So6puRH8K/
         iApu6xW3d/+oN6p/QIPV23VeNNe/mecvBVOJMEuOHE7gZyJFq2/RZrDODrJWG7UmxggJ
         GDNNpMvgBHiYo3kNf4l9NRdnpmfuDrMqkq76t+AGMW5fbt3aO/vCPtfGQvAZ/MnjAsUX
         0yZHcS/5ZsDYU+RGiZNOWT1lXWItU6r8HxgJVqpswqhfQY3PtUSlPgl+007u22HBBLYJ
         843UiEnSTVPsCiZJ2wIlxQMVx12hy+5yUryslha16M6jZgkJ3VchfVa9xPJWa5mETfq7
         l+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4N7EQSOmGj3kmcTNPKFw2gJI2T24TmEUzwOY9YGFTVM=;
        b=uivs37G/RGfbNp2ei8eusoEHjn1AfaOAzlnJuRUdp4Xhq7m+0LyE34D82DRy16RT4H
         scvh8tioAnJXfUsWbg2Ek1ed8HFZ2ThFgc4AopmEv/2ryOW1JjKY7ECxlLWjAiJYy0Or
         Gy+1tZGz4OCK0rbCZywb3mjdnztM5qvGUMTLAEkHV1Mo03C1jbiOf2m+MM05BY9wPuEQ
         AYKCat5+U1YrMTSJHS7wr++WsAqBTxbYW4uXMr/DZXFKWdF95E8j/vu6149psyMTKaOw
         YrLMZXiyCkT/MLUNTflnriaFJk5pDfDCmDXwni44l4+fJlBQjtQJ0U35PA39eC19BTMx
         OWNQ==
X-Gm-Message-State: APjAAAUoqimQl1BxyJjvm/VAFN6UqylFJTbxGpSFhGAm4ox6bLCWGINb
        +yZOSwHhiQfC8VHbqtNwKGNsNBHyCQT+3Dq748Dm+g==
X-Google-Smtp-Source: APXvYqygo5u9eGNktFx7NI+0t+FrzDYrgrxjIyb5vohICZ2YZlXEyO7G1boHyXHcMYWVxQvpQ9j4dnY7P4p+0WVk2wo=
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr11157494lja.180.1566166865940;
 Sun, 18 Aug 2019 15:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com> <1565984527-5272-3-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1565984527-5272-3-git-send-email-skomatineni@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Aug 2019 00:20:54 +0200
Message-ID: <CACRpkda7CTUevWogRo9FQQOBZfO4hQqt-1fGYpAiGJTm-sE_Xw@mail.gmail.com>
Subject: Re: [PATCH v9 02/22] pinctrl: tegra: Flush pinctrl writes during resume
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jckuo@nvidia.com, Joseph Lo <josephl@nvidia.com>, talho@nvidia.com,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>, spatra@nvidia.com,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 16, 2019 at 9:42 PM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:

> This patch adds pinctrl register read to flush all the prior pinctrl
> writes and then adds barrier for pinctrl register read to complete
> during resume to make sure all pinctrl changes are effective.
>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Patch applied.

Yours,
Linus Walleij
