From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFD] Functional dependencies between devices
Date: Fri, 30 Oct 2015 10:50:26 +0100
Message-ID: <CACRpkdbTtzs4DbYjAiA7DwkrK6AFntL9Sg0oWBgZsiL15m4WKw@mail.gmail.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33698 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758963AbbJ3Ju1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 05:50:27 -0400
Received: by oiad129 with SMTP id d129so56216354oia.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2015 02:50:26 -0700 (PDT)
In-Reply-To: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On Tue, Oct 27, 2015 at 4:24 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> My idea is to represent a supplier-consumer dependency between devices (or
> more precisely between device+driver combos) as a "link" object containing
> pointers to the devices in question, a list node for each of them and some
> additional information related to the management of those objects, ie.
> something like:
>
> struct device_link {
>         struct device *supplier;
>         struct list_head supplier_node;
>         struct device *consumer;
>         struct list_head consumer_node;
>         <flags, status etc>
> };
>
> In general, there will be two lists of those things per device, one list
> of links to consumers and one list of links to suppliers.

I like this idea. I earlier have written that the device core needs to know
the dependencies of devices as a graph. This mechanism does that.

IIUC the mechanism does not inheritly protect against creating
cyclic graphs (you can get stuck in a loop) but that is just the
nature of the things and even deferred probe has the ability
to shoot oneself in the foot. Besides we're not doing computer
science here, we're solving practical problems.

What I further like about the approach is that it can even be used
by archs still doing boardfiles and not using any HW description
mechanism: it is there for anyone. Those platforms can define
dependencies with good old code.

Yours,
Linus Walleij
