From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / OPP: Fix NULL pointer dereference when no regulator
 is defined
Date: Thu, 11 Feb 2016 22:17:15 +0100
Message-ID: <CAJZ5v0hW1M=GzLh=KSSEY2v7Ek3mU+d-9Q2SGJ8=rLvyn7kK_A@mail.gmail.com>
References: <6387373.HWURUPOrgK@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33114 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbcBKVRQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 16:17:16 -0500
In-Reply-To: <6387373.HWURUPOrgK@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>

On Thu, Feb 11, 2016 at 5:13 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Commit 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't
> supported by the regulator") causes NULL pointer dereference
> OOPS when no regulator for OPP is defined.  Fix it by
> replacing IS_ERR() check with IS_ERR_OR_NULL() one (since
> providing regulator for OPP is optional).
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Fixes: 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't supported by the regulator")
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> This fixes linux-pm/linux-next tree boot hang regression on
> Exynos4412 SoC based Odroid-U3 board.
>
> Rafael, please apply.  Thank you!

This has been fixed by an identical patch from Jon Hunter I received earlier.

Thanks,
Rafael
