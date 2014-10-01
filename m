From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/4] PM / Domains: Expect PM domains being powered at initialization
Date: Wed, 1 Oct 2014 13:09:30 +0200
Message-ID: <CAPDyKFqw5qLtzxH4d3j8aVrN5be+c+XAZ8=gs77pSBsg5H8HMw@mail.gmail.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<1412081033-8136-4-git-send-email-ulf.hansson@linaro.org>
	<7h61g5ynns.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:43350 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaJALJb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Oct 2014 07:09:31 -0400
Received: by mail-qa0-f52.google.com with SMTP id dc16so44479qab.39
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2014 04:09:30 -0700 (PDT)
In-Reply-To: <7h61g5ynns.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

On 30 September 2014 20:21, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> At ->probe() it's common practice for drivers/subsystems to bring their
>> devices to full power and without depending on CONFIG_PM_RUNTIME.
>
> If they're not using pm_runtime to bring the device to full power,
> shouldn't these drivers be using pm_runtime_set_active()?  (or maybe
> pm_runtime_force_resume()?)

Since drivers needs to cope with combinations of
CONFIG_PM_|RUNTIME|SLEEP a common practice it to follow below
sequence:

1. Fetch resources. (Clocks, regulators, pinctrls, irqs, etc)
2. Enable resources etc.
...
3. pm_runtime_get_noresume()
4. pm_runtime_set_active()
5. pm_runtime_enable()
....
6. pm_runtime_put()

Obviously there are variations, but the idea is the same; Use
pm_runtime_set_active() to reflect that the current state is active,
then schedule a runtime PM idle request before leaving ->probe().

>
> Wouldn't using those force the genpd to stay powered on?

pm_runtime_set_active() - no.
pm_runtime_force_resume() - yes, but with some side effects.

Kind regards
Uffe
