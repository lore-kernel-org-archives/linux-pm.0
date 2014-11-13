From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
Date: Thu, 13 Nov 2014 22:59:16 +0100
Message-ID: <CAPDyKFq1KOGEZgEADownDyh33=7ffpGu59+wxx9=pemVh_D7bQ@mail.gmail.com>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
	<20141107215751.GA4439@dtor-ws>
	<CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
	<2882656.Dm8xnxDtKM@vostro.rjw.lan>
	<CAPDyKFry2QCBrEWJW-CVVzvpjKu9bYyaQs8o3b-nYfu9=ezpqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:37521 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934044AbaKMV7R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Nov 2014 16:59:17 -0500
Received: by mail-qg0-f51.google.com with SMTP id j5so11340509qga.10
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2014 13:59:16 -0800 (PST)
In-Reply-To: <CAPDyKFry2QCBrEWJW-CVVzvpjKu9bYyaQs8o3b-nYfu9=ezpqA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[...]

>> Essentially, the "power up" operation will depend on the PM domain and
>> bus type, so they'll need to provide callbacks that will most likely
>> duplicate runtime PM callbacks.  And those callbacks need to be available
>> when we do the "power up" thing.
>
> In principle what you suggest me to do is this, right?
>
> 1. Re-design how the device gets attached to its PM domain. That will
> also change the ACPI PM domain, which I have limited knowledge about.
> :-) In principle we want the PM domain pointer to be assigned to the
> device at device enumeration. This is needed since you think we should
> do the "power up" thing from the driver core.
>
> 2. Add "pm_power_up|down()" APIs with corresponding ->"power
> up|down"() callbacks in the struct dev_pm_domain. Similar as done in
> patch "[PATCH v3 1/9] PM / Domains: Add dev_pm_domain_get|put() APIs"
> [2]. Since the callbacks will be unique per PM domain those will be
> assigned at PM domain initialization.
>
> 3. Invoke the new APIs, pm_power_up|down() around really_probe() in driver core.
>

Answering my own email, I guess am starting to be paranoid. :-)

I assume that the above solution is close to what you had in mind. If
not, please just ignore this response.

As I stated earlier, the 1) could be a bit tricky to sort out.
Especially since there are SOC specific patchsets that's been queued
for 3.19 already which adds genpd support. I am not saying that we
can't do it, but I am bit concerned that we wont solve the _real_
problem before the issues really starts to show up for several SOCs.

Therefore, I wonder if you could consider the following somewhat
intermediate step, instead of going directly towards 1):

- Move the calls to dev_pm_domain_attach/detach() from the various
buses ->probe(), into the driver core (really_probe()). In that way,
we will be able to power up the PM domain from the driver core, since
the device's PM domain pointer would be assigned.

I do realize that you rejected this approach earlier, but I guess we
have some new "data" to consider!? :-)

Kind regards
Uffe
