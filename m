From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2] Driver core: Re-init runtime PM states at probe error and driver unbind
Date: Wed, 18 Nov 2015 10:27:15 -0800
Message-ID: <7hoaerxiws.fsf@deeprootsystems.com>
References: <1447843719-9501-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36503 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbKRS1S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 13:27:18 -0500
Received: by pacdm15 with SMTP id dm15so52422442pac.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 10:27:18 -0800 (PST)
In-Reply-To: <1447843719-9501-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Wed, 18 Nov 2015 11:48:39 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eduardo Valentin <edubezval@gmail.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> There are two common expectations among several subsystems/drivers that
> deploys runtime PM support, but which isn't met by the driver core.

[...]

> To address these issues, let's change the policy of the driver core to
> meet these expectations. More precisely, at ->probe() failures and driver
> unbind, restore the initial states of runtime PM.
>
> Although to still allow subsystem's to control PM for devices that doesn't
> ->probe() successfully, don't restore the initial states unless runtime PM
> is disabled.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Thanks for the detailed changelog!

Kevin
