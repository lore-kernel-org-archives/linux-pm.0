From: Rafael Wysocki <rjwysocki@gmail.com>
Subject: Re: [PATCH 02/24] drivercore: Bind/unbind power domain on probe/remove
Date: Thu, 12 Jun 2014 21:33:42 +0200
Message-ID: <CAJZ5v0goz_oE5V7kmYdTjKjMSuW33-sK+C60pS-iNe8Aim8UZQ@mail.gmail.com>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
	<20140610212731.GA11191@kroah.com>
	<53977BC1.5000301@gmail.com>
	<2753039.YD6R0RpJkS@vostro.rjw.lan>
	<20140612163901.GZ5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:48722 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaFLTdn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jun 2014 15:33:43 -0400
In-Reply-To: <20140612163901.GZ5099@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Tomasz Figa <t.figa@samsung.com>

On Thu, Jun 12, 2014 at 6:39 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 11, 2014 at 02:18:44AM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, June 10, 2014 11:42:25 PM Tomasz Figa wrote:
>
>> > OK, so proposed solution is to put this in:
>
>> > - platform_drv_probe(),
>> > - spi_drv_probe(),
>> > - i2c_device_probe(),
>> > - amba_probe(),
>
>> Yes.  Specifically, those are bus types that don't do their own power
>> management.
>
> This sounds tedious.  Can we not instead introduce some generic helpers
> which all such buses call/use and then implement the hooks in there
> (along with anything else that they should all do)?

Well, good idea.

> There must be other things that all these buses are having to cut'n'paste.

Quite likely.

Rafael
