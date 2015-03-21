From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v3] driver core / PM: Add PM domain callbacks for device setup/cleanup
Date: Fri, 20 Mar 2015 17:09:30 -0700
Message-ID: <7hzj77i539.fsf@deeprootsystems.com>
References: <3533423.QQDErEmeTO@vostro.rjw.lan>
	<1810625.BTgaNclHRk@vostro.rjw.lan>
	<1654636.FxBHsexDm1@vostro.rjw.lan>
	<3289026.ADmXXipokh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34381 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbCUAJe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 20:09:34 -0400
Received: by pacwe9 with SMTP id we9so123807076pac.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2015 17:09:33 -0700 (PDT)
In-Reply-To: <3289026.ADmXXipokh@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Fri, 20 Mar 2015 13:59:27 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If PM domains are in use, it may be necessary to prepare the code
> handling a PM domain for driver probing.  For example, in some
> cases device drivers rely on the ability to power on the devices
> with the help of the IO runtime PM framework and the PM domain
> code needs to be ready for that.  Also, if that code has not been
> fully initialized yet, the driver probing should be deferred.
>
> Moreover, after the probing is complete, it may be necessary to
> put the PM domain in question into the state reflecting the current
> needs of the devices in it, for example, so that power is not drawn
> in vain.  The same should be done after removing a driver from
> a device, as the PM domain state may need to be changed to reflect
> the new situation.
>
> For these reasons, introduce new PM domain callbacks, ->activate,
> ->sync and ->dismiss called, respectively, before probing for a
> device driver, after the probing has completed successfully and
> if the probing has failed or the driver has been removed.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> One more update taking Dmitry's comments into account and fixing an
> overoptimization bug spotted by Ulf.
>
> And this actually contains the patch this time (clicked on "Send" too
> early last time, sorry about that).

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Unless I'm missing somthing, this along with the just the genpd part of
Russell's patch should then fix his problem as well.

Kevin
