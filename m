From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFD] Functional dependencies between devices
Date: Thu, 19 Nov 2015 07:50:45 +0100
Message-ID: <564D7145.40300@samsung.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <564B224D.3050904@samsung.com>
 <20151117135549.GR31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:22655 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757729AbbKSGvU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 01:51:20 -0500
In-reply-to: <20151117135549.GR31303@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On 11/17/2015 02:55 PM, Mark Brown wrote:
> On Tue, Nov 17, 2015 at 01:49:17PM +0100, Andrzej Hajda wrote:
>
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
>
>> On 10/27/2015 04:24 PM, Rafael J. Wysocki wrote:
>> this scenario:
>> - many clock providers, irq domains are not provided by devices,
> That seems like something we can and possibly should change if we want.
>
>> - there are also dependencies between clock providers, ie. some clock provider
>> requires clocks provided by another clock provider, so the entity is also not a
>> device driver,
> This is going to be really common but I'm not sure I see a problem with
> it in terms of what Raphael is proposing - could you go into more detail
> on the problem you see here?

If clock provider is not a device driver and it depends on clocks of
another clock
provider you cannot 'translate' this dependency as dependency between
devices,
so this RFD does not cover them.
Additionally if you look into kernel there are many calls in form
'clk_get(NULL, name)',
it suggests that not only clock providers are consumers without
underlying device driver.

Regards
Andrzej

