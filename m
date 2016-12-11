From: Peter Rosin <peda@axentia.se>
Subject: bq24735 charger and ac-detect
Date: Mon, 12 Dec 2016 00:12:47 +0100
Message-ID: <d796f6f9-1b6a-647c-100b-b3e85fc2f4c0@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db5eur01on0092.outbound.protection.outlook.com ([104.47.2.92]:35616
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750780AbcLLGqx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Dec 2016 01:46:53 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>

Hi!

I'm wondering about the dt bindings for the bq24735 charger. Specifically
the ac-detect property. The bindings say:

 - ti,ac-detect-gpios : This GPIO is optionally used to read the AC adapter
   presence. This is a Host GPIO that is configured as an input and
   connected to the bq24735.

The only way I can make sense of that is if this is the pin on the bq24735
that is named ACOK. But that pin is active high, and the code has this:

static bool bq24735_charger_is_present(struct bq24735 *charger)
{
	if (charger->status_gpio)
		return !gpiod_get_value_cansleep(charger->status_gpio);
...


(status_gpio is what holds the gpio_desc of ac-detect)

In other words, the code seems to want a signal that is effectively
active low (the code negates the signal and thus returns "present"
when the signal is zero). The existing dts users all have active high
in their bindings, so it's not like they say active low to work around
the negation in the code...

This just makes no sense to me and I'm wondering what I'm missing and
what pin is really meant to be fed to ac-detect???

Yes, there is a pin on the bq24735 that is named ACDET which seems like
a good match, but that is a signal that is entering the bq24735. And it
is also active high, at least the way I read it so the problem persists...

Cheers,
Peter
