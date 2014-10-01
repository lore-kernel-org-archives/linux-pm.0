From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/4] PM / Domains: Expect PM domains being powered at initialization
Date: Wed, 1 Oct 2014 12:47:01 +0200
Message-ID: <CAPDyKFr-pBKoYS5=1-5bz5TkcAzFOsk0u2gPtPL2Q0eN8sxsow@mail.gmail.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<1412081033-8136-4-git-send-email-ulf.hansson@linaro.org>
	<7hr3ytx8oc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:48155 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaJAKrD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Oct 2014 06:47:03 -0400
Received: by mail-qc0-f173.google.com with SMTP id x13so37964qcv.18
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2014 03:47:02 -0700 (PDT)
In-Reply-To: <7hr3ytx8oc.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

On 30 September 2014 20:30, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> At ->probe() it's common practice for drivers/subsystems to bring their
>> devices to full power and without depending on CONFIG_PM_RUNTIME.
>>
>> We could also expect that drivers/subsystems requires their device's
>> corresponding PM domains to be powered, to successfully complete a
>> ->probe() sequence.
>>
>> Align the generic PM domain to the behavior above, by enforcing a PM
>> domain to be powered at initialization. Since all callers of
>> pm_genpd_init() already provides "false" as the value for the "is_off"
>> parameter
>
> This is only true after PATCH 2/4 is applied.

That's right. I could have been more clear about that in the commit message.

Do you want me to send a v2 to fix it?

Kind regards
Uffe

>
> The exynos code currently checks the hw state of its power domains will
> call pm_genpd_init() with is_off = true any hw domains that are off.

>
> Kevin
