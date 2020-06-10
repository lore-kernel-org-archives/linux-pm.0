Return-Path: <SRS0=jqOB=7X=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C1DC433DF
	for <linux-pm@archiver.kernel.org>; Wed, 10 Jun 2020 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14FAE206F4
	for <linux-pm@archiver.kernel.org>; Wed, 10 Jun 2020 09:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvYAdsPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgFJJzA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgFJJy7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 05:54:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFA0C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:54:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a9so1683013ljn.6
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3zJYnC4xPTLUvpdLo3hJwVKdm6pQi65dX2AKRAnoeU=;
        b=bvYAdsPRtcgtKGb3QnS8DYfgeu9iZZ+3d2bED2t8THtIt6RXgj3rz6bJ0WI05t7K47
         +S2m2gtlLbauUSYPZl432zrDFRlIBRN2mPTRZgZDiXnJNOSYx4dZAXcyf2SSaaUokmrx
         qVB2HZbK17hqs4ANJ7RnqHLEaM7R175Avt5uOuhEsndixOsScfNf8E6yth0csDjL4++i
         11C+CaDkudPtzHu2RUUIqkccZzBAv+hx+fUpQTfFTIjk8GRHt2BknPV2aPnw55VrtjKi
         BxJJMY/+jFPOQCFmUxcecRWR1wsGxP/jiYvWMPeMx3abSq8ULRS6glsS4+oC4Nrlsum/
         9Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3zJYnC4xPTLUvpdLo3hJwVKdm6pQi65dX2AKRAnoeU=;
        b=bcaeJKEIulFPLui15QbPpOw3Y1A3VBaYKQxnsgEqXQg13MEE+giUHGzFZH3K6ccZIa
         J5MYYjV474TdGIoN1N5/bUgJ36wrenDEn+FsBK+SRe9B6xVHRs9KBc4hm4qmoNirwLHx
         LuUHL3+yc6lzIUFKnJzSYmfqgAHterr6F1wXXCpKwnPfKlE1r+ISERUZperAH1lj+knl
         3xWXkPZndl4cLdMbxVrFE9ie60IbvrGysI75usPlVKXHUDCVpLHA23fOF+Pbq08iJLuN
         4B4JOeNMVP6FEU3eS7m0vgX7j+2/Aaky3yq5PLI48oKttvI5DB/Gy9v4EXiGWHp/R5Ae
         ZJ7A==
X-Gm-Message-State: AOAM530E4PJOJmj1rcZHovQXlhCn4/RU9XXv7pZTKOY2glmyDif6MjNy
        MY4hnX7QCCgbqh6ptjwtTWOLHEWinH4KfIu0MxMJYw==
X-Google-Smtp-Source: ABdhPJyaZm9bWv1+tQfyTESsLtLgh1gwb2LxItCKaISMEvf2pjgPzCFpj8OL4bZ3WpufhOyscllUPZAmRJY1WJJKSVo=
X-Received: by 2002:a2e:350a:: with SMTP id z10mr1288366ljz.104.1591782897430;
 Wed, 10 Jun 2020 02:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-6-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-6-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:54:46 +0200
Message-ID: <CACRpkdabXvC2z3TEzChQb4MAOuFEZXQ_wN63mdSGTQh1YHxaHA@mail.gmail.com>
Subject: Re: [PATCHv2 5/6] ARM: sa1100: Use GPIO descriptor for gpio-charger
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Provide AC detect GPIO via gpiod table instead of
> legacy platform data so that legacy GPIO support
> can be removed from the driver.
>
> Due to lack of hardware this has only been compile
> tested.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
