From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] PM / Runtime: Convert pm_runtime_set_suspended() to
 return an int
Date: Fri, 21 Oct 2016 14:21:45 +0200
Message-ID: <CACRpkdafHZ_ftV=MD_mLwsSvCNSMk4sCpuhmHxum8UaGjHSKEQ@mail.gmail.com>
References: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org> <1476728221-26530-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32911 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754368AbcJUMVr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 08:21:47 -0400
Received: by mail-qk0-f181.google.com with SMTP id n189so149111382qke.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2016 05:21:46 -0700 (PDT)
In-Reply-To: <1476728221-26530-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Mon, Oct 17, 2016 at 8:17 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Because pm_runtime_set_suspended() invokes __pm_runtime_set_status(), which
> can fail, pm_runtime_set_suspended() can also fail.
>
> Instead of hiding a potential error, let's propagate it by converting
> pm_runtime_set_suspended() from a void to return an int. In this way users
> are able to check the error code and act accordingly.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
