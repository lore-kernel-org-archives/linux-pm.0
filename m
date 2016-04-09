From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] PM / Runtime: Fix error path in pm_runtime_force_resume()
Date: Sat, 9 Apr 2016 18:18:35 +0200
Message-ID: <CACRpkdYGb2g-trk9KXK2r2tndv7H64fqvU6EBQvt+XujXzeLXg@mail.gmail.com>
References: <1460113823-32290-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35130 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbcDIQSh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 12:18:37 -0400
Received: by mail-oi0-f46.google.com with SMTP id p188so166555763oih.2
        for <linux-pm@vger.kernel.org>; Sat, 09 Apr 2016 09:18:36 -0700 (PDT)
In-Reply-To: <1460113823-32290-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>

On Fri, Apr 8, 2016 at 1:10 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> As pm_runtime_set_active() may fail because the device's parent isn't
> active, we can end up executing the ->runtime_resume() callback for the
> device when it isn't allowed.
>
> Fix this by invoking pm_runtime_set_active() before running the callback
> and let's also deal with the error code.
>
> Fixes: 37f204164dfb ("PM: Add pm_runtime_suspend|resume_force functions")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Oh I recognize that. I saw that behaviour. This should fix it.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
