From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] PM / Runtime: Don't allow to suspend a device with an
 active child
Date: Fri, 21 Oct 2016 14:23:16 +0200
Message-ID: <CACRpkdZRLPjGdKAYj0i3ZLuPaCvsPYKCd1iGTnr4-Xazdy=tHQ@mail.gmail.com>
References: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org> <1476728221-26530-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34823 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754097AbcJUMXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 08:23:17 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so148703663qkc.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2016 05:23:16 -0700 (PDT)
In-Reply-To: <1476728221-26530-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Mon, Oct 17, 2016 at 8:17 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> When resuming a device in __pm_runtime_set_status(), the prerequisite is
> that its parent must already be active, else an error code is returned and
> the device's status remains suspended.
>
> When suspending a device there is no similar constraints being validated.
> Let's change this to make the behaviour consistent, by not allowing to
> suspend a device with an active child, unless it has been explicitly set to
> ignore its children.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks correct. If there are drivers/buses relying on this
erroneous semantic we will learn about it pretty quickly I think :D

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
