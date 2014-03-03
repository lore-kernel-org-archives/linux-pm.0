From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH V3 2/8] PM / Sleep / Runtime: Add pm_runtime_suspend|resume_force functions
Date: Mon, 03 Mar 2014 00:30:00 -0800
Message-ID: <7hppm3sn07.fsf@paris.lan>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
	<1393671371-2398-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:62607 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbaCCIaP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Mar 2014 03:30:15 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so3439199pdi.35
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2014 00:30:15 -0800 (PST)
In-Reply-To: <1393671371-2398-3-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Sat, 1 Mar 2014 11:56:05 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

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
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

FWIW

Acked-by: Kevin Hilman <khilman@linaro.org>
