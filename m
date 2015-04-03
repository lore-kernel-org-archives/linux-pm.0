From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
Date: Fri, 3 Apr 2015 15:27:40 +0200
Message-ID: <CAMuHMdVhX-MrFxeW5j98NLaQQtJ+DToxkz2Z1+SRSs7YF27RDw@mail.gmail.com>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
	<1428064923-24950-6-git-send-email-geert+renesas@glider.be>
	<20150403125727.GT10964@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34743 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbbDCN1l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 09:27:41 -0400
In-Reply-To: <20150403125727.GT10964@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, driverdevel <devel@driverdev.osuosl.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 3, 2015 at 2:57 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> +     error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
>> +     if (error)
>> +             pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
>> +             return error;
>
> Missing curly braces.  Also it's weird that don't we need a clk_put()
> on the error patch as well as the success path?

Thanks!

So it worked only by accident: with the new per-user struct clk instances
clk_put() must not be called if clk_register_clkdev() succeeded.

Will call clk_put() only if it failed.

>> +
>> +     clk_put(clk);
>> +     return 0;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
