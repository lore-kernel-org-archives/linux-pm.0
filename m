From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: print error when activating a child to unactive parent
Date: Mon, 04 Jul 2016 15:07:38 +0200
Message-ID: <1928381.0koxqb6YuQ@vostro.rjw.lan>
References: <1466414066-6131-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65311 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753595AbcGDNDF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2016 09:03:05 -0400
In-Reply-To: <1466414066-6131-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org

On Monday, June 20, 2016 11:14:26 AM Linus Walleij wrote:
> The code currently silently bails out with -EBUSY if you try to
> activate a child to an inactive parent.
> 
> This typically happens when you have a runtime suspended parent
> and runtime resume your child, but forgot to set .ignore_children
> on the parent to true with pm_suspend_ignore_children(dev).
> 
> Silently ignoring this error is not good as it gives rise to
> other strange behaviour like double-resume of devices after
> silently bailing out of the .runtime_resume() callback.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks!

