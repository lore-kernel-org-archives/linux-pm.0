From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach completes
Date: Mon, 17 Nov 2014 10:28:56 -0800
Message-ID: <7hd28l3clz.fsf@deeprootsystems.com>
References: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:55177 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaKQS27 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 13:28:59 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so5924879pad.38
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2014 10:28:58 -0800 (PST)
In-Reply-To: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 17 Nov 2014 16:19:10 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The amba bus, amba drivers and a vast amount of platform drivers which
> enables runtime PM, don't invoke a pm_runtime_get_sync() while probing
> their devices.
>
> Instead, once they have turned on their PM resourses during ->probe()
> and are ready to handle I/O, these invokes pm_runtime_set_active() to
> synchronize its state towards the runtime PM core.
>
> From a runtime PM point of view this behavior is perfectly acceptable,

In the context of PM domains that can be dynamically powered on/off, I'm
not so sure it's perfectly acceptable anymore.

Why doesn't the bus do a _get_sync() instead of a _get_noresume()
followed by a _set_active().  

By using the _get_noresume() you're bypassing the paths that would bring
up your PM domain.

Kevin
