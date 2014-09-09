From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/9] PM / Domains: Add generic OF-based PM domain look-up
Date: Tue, 9 Sep 2014 09:04:57 +0200
Message-ID: <CAPDyKFok8oE2S0BQg1mwikFjyQ+VH9GevCYXTgG68z+5MW+W6Q@mail.gmail.com>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
	<3075771.rIWPm62y5x@vostro.rjw.lan>
	<CAPDyKFovLmajQORVT1Mf01J5L7O73JNDFz=gr3fXKvF5xZGCdQ@mail.gmail.com>
	<5191943.peyCs6gZVs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:41446 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbaIIHE6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 03:04:58 -0400
Received: by mail-qg0-f45.google.com with SMTP id j107so3576642qga.32
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2014 00:04:58 -0700 (PDT)
In-Reply-To: <5191943.peyCs6gZVs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh+dt@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dre>

On 8 September 2014 23:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, September 08, 2014 09:26:20 AM Ulf Hansson wrote:
>> On 8 September 2014 00:13, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Thursday, September 04, 2014 03:52:29 PM Ulf Hansson wrote:
>> >> From: Tomasz Figa <t.figa@samsung.com>
>> >>
>> >> This patch introduces generic code to perform PM domain look-up using
>> >> device tree and automatically bind devices to their PM domains.
>> >>
>> >> Generic device tree bindings are introduced to specify PM domains of
>> >> devices in their device tree nodes.
>> >>
>> >> Backwards compatibility with legacy Samsung-specific PM domain bindings
>> >> is provided, but for now the new code is not compiled when
>> >> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code.
>> >> This will change as soon as the Exynos PM domain code gets converted to
>> >> use the generic framework in further patch.
>> >>
>> >> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> [Ulf:Added attach|detach functions, fixed review comments]
>> >> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
>> >
>> > However, for this one (and consequently the rest) I need an ACK from the
>> > people who maintain the bindings.
>>
>> These DT bindings have been discussed between Tomasz and devicetree
>> maintainers previously. So I think there are fine.
>>
>> Also, when browsing the mail-archives, I found an ack from Rob Herrring:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/237989.html
>>
>> I realize that I didn't put the DT maintainers on the to-line when
>> posting this patch, but just the devicetree list. I have now included
>> them on this reply, but maybe I should repost instead. What do you
>> think? Are you happy with the above ack from Rob?
>
> That should be sufficient, but I wonder why you didn't add it to the patch
> to start with?

I didn't remember it being formally acked, until I decided to browsed
the mail archives in detail. Sorry about that.

Kind regards
Uffe
