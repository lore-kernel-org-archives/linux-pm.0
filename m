From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Runtime: Fix error path in pm_runtime_force_resume()
Date: Tue, 26 Apr 2016 01:59:53 +0200
Message-ID: <3138868.36kMgeR1xN@vostro.rjw.lan>
References: <1460113823-32290-1-git-send-email-ulf.hansson@linaro.org> <CACRpkdYGb2g-trk9KXK2r2tndv7H64fqvU6EBQvt+XujXzeLXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55849 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752104AbcDYX4y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 19:56:54 -0400
In-Reply-To: <CACRpkdYGb2g-trk9KXK2r2tndv7H64fqvU6EBQvt+XujXzeLXg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>

On Saturday, April 09, 2016 06:18:35 PM Linus Walleij wrote:
> On Fri, Apr 8, 2016 at 1:10 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> > As pm_runtime_set_active() may fail because the device's parent isn't
> > active, we can end up executing the ->runtime_resume() callback for the
> > device when it isn't allowed.
> >
> > Fix this by invoking pm_runtime_set_active() before running the callback
> > and let's also deal with the error code.
> >
> > Fixes: 37f204164dfb ("PM: Add pm_runtime_suspend|resume_force functions")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Oh I recognize that. I saw that behaviour. This should fix it.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks!

