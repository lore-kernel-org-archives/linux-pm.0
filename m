From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 4/9] drivercore / platform: Keep PM domain powered
 during ->probe()
Date: Fri, 31 Oct 2014 10:19:19 +0100
Message-ID: <CAPDyKFqacYD0HoQMr2CgHKxggUOyC6c9+JWZ3BRrh710E-NmAA@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
	<1413208930-26019-5-git-send-email-ulf.hansson@linaro.org>
	<7hoast8eu8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:63540 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137AbaJaJTU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Oct 2014 05:19:20 -0400
Received: by mail-qc0-f179.google.com with SMTP id o8so5455157qcw.24
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2014 02:19:19 -0700 (PDT)
In-Reply-To: <7hoast8eu8.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

On 30 October 2014 21:47, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> To sucessfully probe some devices their corresponding PM domains may
>> need to be powered.
>
> Isn't that what pm_runtime_get*() is supposed to be doing?  Why isn't
> that working?

Let stay at the discussion of the cover letter patch. I just replied
to this there.

Kind regards
Uffe
