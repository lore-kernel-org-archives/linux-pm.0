From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] PM / Runtime: Remove the exported function pm_children_suspended()
Date: Fri, 21 Oct 2016 14:20:01 +0200
Message-ID: <CACRpkdY093tX09tQZoXn0pt5MAF9yjwrtbidcBFBEopB-Wp8TQ@mail.gmail.com>
References: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org> <1476728221-26530-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35062 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932685AbcJUMUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 08:20:03 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so148529629qkc.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2016 05:20:02 -0700 (PDT)
In-Reply-To: <1476728221-26530-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Mon, Oct 17, 2016 at 8:16 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The exported function pm_children_suspended() has only one caller, which is
> the runtime PM internal function, rpm_check_suspend_allowed().
>
> Let's clean-up this code, by removing pm_children_suspended() altogether
> and instead do the one-liner check directly in rpm_check_suspend_allowed().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
