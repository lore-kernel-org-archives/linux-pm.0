Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC8BC10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE34D20883
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 12:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eosgU5hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfDHMuu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:50:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38039 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfDHMuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 08:50:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id u24so2482194lfg.5
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2019 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kObOSXeLNarr4A7JyCeGDmf2Aqlc+AnUxoBbHSTRZHQ=;
        b=eosgU5hidfriIgdzaffD+gEjxqfYzI3r3ZsjYh7VmHGSIrCKhE0HubpIvm4G6Q66JC
         RmlZkX8thltFNhRW7qB2FRiv6rWE0gDjg9utnyKd97Nrj6YKU5tepS45ju+O4mnVeU5s
         la/UeY1gCcgYSVlcA9mdEjGXHp42yRzQfi6eA5qUweC3RNJ8cBsI9uQLWnp0lEJEgKqi
         /hYnBQmrRh3WqiIsdSSqkRy5/WCC7nM/M9OMMudpC0ndIklTQmbpRJVj4LSvmJ/638Mx
         IIwgPo2M19TUfc0yd4ZllxLYHmUqp5oBXEjATgeE0LjILu/Y97JPmRGWjy6zhwWwaJqY
         0HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kObOSXeLNarr4A7JyCeGDmf2Aqlc+AnUxoBbHSTRZHQ=;
        b=tb1RIH+S4dfZksIiFMcX3Pp+SqwRrvJK5KCxsN9jCygc8itzlcasQ4mgcumAqYSiqb
         cdQdTrY4+EyO3bf83K0zNMUrcIKPlkTJ618HI3ECrw5Dw4VSsQUBhqe7IGMbtWs0Nuyo
         Rb1tNUEtvnfDz8adtvNvdm4+O7z+yxYKWQMNWiqPFoxGxX3i52MDeLDPhTqa1JsBUGSq
         aB2eCL4PsR0OaY/eJeQDQ3VA/+LdZwXKjJb1iI9/PpBsWllf9ZnN7R3Yc6ZWkqU1GyFd
         iSp5zHOHRgU8WjUuB73AouuJck/HdPkI3aGMXLOQq79hg6e4Q9/ZMriGRL6gJe/QtN2t
         i+qQ==
X-Gm-Message-State: APjAAAVP1jEYE78qvdmpdJ634BNGaFGMwjEFf3eSXD65RXOHEMkC1ggT
        H8zVKE5IsPlokWwFFHqOV3Ylb7J57hOhIFs2ht7TXA==
X-Google-Smtp-Source: APXvYqxm6gQM5RizB+QB98o/vRKWl9Hck0t3rr9vH0/mChEJSdcx8mhIM4dkN1BSfuO67QpDJ3ehnEaYQ430riupIIk=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr16050034lfk.138.1554727847932;
 Mon, 08 Apr 2019 05:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190320103927.21227-1-geert+renesas@glider.be>
In-Reply-To: <20190320103927.21227-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 14:50:36 +0200
Message-ID:
 <CACRpkdaAZ8C-kmhWRMqu3y6yVJ--6UFjnoRi_iRtogwzzyGseQ@mail.gmail.com>
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190408125036.DS6wsrLQoAMNbUBiIkp-A--uSoUJWOz-XQvU7ZE3WWc@z>

On Wed, Mar 20, 2019 at 11:39 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If a device is part of the wake-up path, it should indicate this by
> setting its power.wakeup_path field.  This allows the genpd core code to
> keep the device enabled during system suspend when needed.
>
> As regulators powering devices are not handled by genpd, the driver
> handles these itself, and thus must skip regulator control when the
> device is part of the wake-up path.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied with Ulf's Review tag.

If there are even better ways to do it I think we can fix that on top of
this, it is best to start with something that obviously works and
take it from there.

Yours,
Linus Walleij
