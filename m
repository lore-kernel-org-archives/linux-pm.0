From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] PM / Domains: Add dev_pm_domain_get|put() APIs
Date: Tue, 17 Mar 2015 14:25:55 +0000
Message-ID: <20150317142555.GW8656@n2100.arm.linux.org.uk>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
 <5508804.qPsCdhOgnd@vostro.rjw.lan>
 <CAPDyKFoVcZAc4FKkG_ywk6qrqrGMp=0aT+LGigWPiXg-TTi0CA@mail.gmail.com>
 <37566526.IvGLQo2usO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:51590 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbbCQO0O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 10:26:14 -0400
Content-Disposition: inline
In-Reply-To: <37566526.IvGLQo2usO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Mar 17, 2015 at 03:45:55PM +0100, Rafael J. Wysocki wrote:
> Well, I wouldn't really like to add new callbacks to struct bus_type for
> intermediate steps, because that's guaranteed to lead to confusion.
> 
> So I think the infrastructure is better added first and users may be
> switched over to it gradually.
> 
> I don't see any particular problems with moving the ACPI PM domain
> attach/detach to bus_add/remove_device(), so that can be done as the first
> step.  As for genpd, it can implement the ->post_probe thing first and do
> the rest in the bus type ->probe until the generic code is ready.

At what point do you see the genpd binding taking place - remembering
that this can fail with -EPROBE_DEFER when DT specifies a genpd, but
the domain hasn't been registered yet?

I'm guessing that needs to happen either in the bus type ->probe or
the ->pre_probe callback.  ->pre_probe sounds better as it can be
a standard genpd function which bus types hook directly into that
method.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
