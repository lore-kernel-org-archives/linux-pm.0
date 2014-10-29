From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] PM / Domains: Let the ->attach_dev() callback return
 an error code
Date: Wed, 29 Oct 2014 10:26:35 +0100
Message-ID: <CAPDyKFpuhXx=G2yOZJK4SiUOh3OV7GzdzwrC8UK4_5et1arCag@mail.gmail.com>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
	<1414507090-516-5-git-send-email-ulf.hansson@linaro.org>
	<CAMuHMdVn2mfk5v8MQshU0gko+dL9xtCT_zBuqyntHHrmxjwfSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:43758 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756154AbaJ2J0f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 05:26:35 -0400
Received: by mail-qa0-f47.google.com with SMTP id dc16so1781966qab.6
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2014 02:26:35 -0700 (PDT)
In-Reply-To: <CAMuHMdVn2mfk5v8MQshU0gko+dL9xtCT_zBuqyntHHrmxjwfSA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

On 28 October 2014 21:31, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf, Rafael,
>
> On Tue, Oct 28, 2014 at 3:38 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Typically an ->attach_dev() callback would fetch some PM resourses.
>>
>> Those operations, like for example clk_get() may fail with different
>> errors, including -EPROBE_DEFER. Instead of ignoring these errors and
>> potentially only print an error message, let's propagate them to give
>> callers the option to handle them.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Given that several patch series using ->attach_dev() are already floating
> around and will be in -next soon, what is the plan of getting this in?
> Doing it ASAP (in v3.18-rc3)?
> Delaying this to v3.19-rc2, which will require an atomic fixing of its users?
> Any other option?

I would prefer if we consider 3.18-rc[x|. That's applies also to the
below patchset, which actually fixes an issue. It would simplify the
process of handling other SOC specific patches which adds PM domain
support.

[PATCH v3 0/9] PM / Domains: Fix race conditions during boot

Obviously the patches needs to be reviewed, I guess we are still in
the process of doing that.

Kind regards
Uffe
