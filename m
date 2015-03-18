From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/9] PM / Domains: Add dev_pm_domain_get|put() APIs
Date: Wed, 18 Mar 2015 02:16:43 +0100
Message-ID: <41985989.P7cCrZRiSl@vostro.rjw.lan>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org> <37566526.IvGLQo2usO@vostro.rjw.lan> <20150317142555.GW8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59936 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754484AbbCRAwt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 20:52:49 -0400
In-Reply-To: <20150317142555.GW8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tuesday, March 17, 2015 02:25:55 PM Russell King - ARM Linux wrote:
> On Tue, Mar 17, 2015 at 03:45:55PM +0100, Rafael J. Wysocki wrote:
> > Well, I wouldn't really like to add new callbacks to struct bus_type for
> > intermediate steps, because that's guaranteed to lead to confusion.
> > 
> > So I think the infrastructure is better added first and users may be
> > switched over to it gradually.
> > 
> > I don't see any particular problems with moving the ACPI PM domain
> > attach/detach to bus_add/remove_device(), so that can be done as the first
> > step.  As for genpd, it can implement the ->post_probe thing first and do
> > the rest in the bus type ->probe until the generic code is ready.
> 
> At what point do you see the genpd binding taking place - remembering
> that this can fail with -EPROBE_DEFER when DT specifies a genpd, but
> the domain hasn't been registered yet?

That -EPROBE_DEFER needs to be returned from the ->pre_probe callback
I think.  Otherwise bus types would need to duplicate that code.

> I'm guessing that needs to happen either in the bus type ->probe or
> the ->pre_probe callback.  ->pre_probe sounds better as it can be
> a standard genpd function which bus types hook directly into that
> method.

Right.

Still, I'd like the bus type's (new) ->pm_domain_init (or whatever it will
be eventually) to be used for populating the devices' ->pm_domain pointers.
There are two reasons for that.  First, those pointers only need to be
populated once per device life cycle (and not during every driver probe/remove).
Second, that will make limited power management of devices without drivers
possible (at least in the ACPI case).

Rafael

