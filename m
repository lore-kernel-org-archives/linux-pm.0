From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] PM / Sleep / Runtime: Add pm_runtime_suspend|resume_force functions
Date: Mon, 24 Feb 2014 14:19:25 +0100
Message-ID: <CACRpkda=Qo+ib77Ug2sWWiLEJdG2Z=pjvn6LzCy9-Y0wN=pbjA@mail.gmail.com>
References: <1392225374-28156-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:45315 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbaBXNT0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2014 08:19:26 -0500
Received: by mail-oa0-f53.google.com with SMTP id o6so1876322oag.26
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2014 05:19:25 -0800 (PST)
In-Reply-To: <1392225374-28156-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@linaro.org>, Russell King <linux@arm.linux.org.uk>

On Wed, Feb 12, 2014 at 6:16 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> This patch provides two new runtime PM helper functions which intend to
> be used from system suspend/resume callbacks, to make sure devices are
> put into low power state during system suspend and brought back to full
> power at system resume.
>
> The prerequisite is to have all levels of a device's runtime PM
> callbacks to be defined through the SET_PM_RUNTIME_PM_OPS macro, which
> means these are available for CONFIG_PM.
>
> By using the new runtime PM helper functions especially the two
> scenarios below will be addressed.
>
> 1) The PM core prevents .runtime_suspend callbacks from being invoked
> during system suspend. That means even for a runtime PM centric
> subsystem and driver, the device needs to be put into low power state
> from a system suspend callback. Otherwise it may very well be left in
> full power state (runtime resumed) while the system is suspended. By
> using the new helper functions, we make sure to walk the hierarchy of
> a device's power domain, subsystem and driver.
>
> 2) Subsystems and drivers need to cope with all the combinations of
> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME. The two new helper functions
> smothly addresses this.
>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This looks to my amateurish eyes like a piece of the puzzle that
was always missing - there was simply no way for walking
the ladder for drivers, so FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
