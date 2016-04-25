From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] PM / Runtime: Move ignore_children flag under CONFIG_PM
Date: Tue, 26 Apr 2016 01:59:22 +0200
Message-ID: <2967804.8pl75VQiCs@vostro.rjw.lan>
References: <1460115653-32421-1-git-send-email-ulf.hansson@linaro.org> <20160409160202.GG19362@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50261 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751456AbcDYX4X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 19:56:23 -0400
In-Reply-To: <20160409160202.GG19362@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On Saturday, April 09, 2016 06:02:02 PM Pavel Machek wrote:
> Hi!
> 
> > The ignore_children flag is used only when CONFIG_PM is set, so let's move
> > it into that section within the struct dev_pm_info.
> > 
> > Move also the corresponding pm_suspend_ignore_children() API out of
> > device.h into pm_runtime.h, to be consistent with similar APIs.
> > 
> > Unfortunate this causes the Toshiba PCI SD mmc host driver to fail to
> > compile as it needs pm_runtime.h, so let's fix this here as well.
> > 
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks!

