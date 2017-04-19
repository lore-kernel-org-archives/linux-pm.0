From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PCI: Freeze PME scan before suspending devices
Date: Wed, 19 Apr 2017 08:07:24 +0200
Message-ID: <CAMuHMdUCqcQndMJuyxuYZdXKrzDUwXCnagR_3gtV7Ay2sv5d1A@mail.gmail.com>
References: <03aaf3220cccbabb7db86aa4eb10d1147add5c34.1492536769.git.lukas@wunner.de>
 <4107359.5uIJCz7KyJ@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <4107359.5uIJCz7KyJ@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Simon Horman <horms+renesas@verge.net.au>, Yinghai Lu <yinghai@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci <linux-pci@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Wed, Apr 19, 2017 at 12:05 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tuesday 18 Apr 2017 20:44:30 Lukas Wunner wrote:
>> Laurent Pinchart reported that the Renesas R-Car H2 Lager board
>> (r8a7790) crashes during suspend tests.  Geert Uytterhoeven managed to
>> reproduce the issue on an M2-W Koelsch board (r8a7791):

[...]

>> Reported-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> My Lager board now fails to resume (but that's also the case without this
> patch, I'll have to investigate that separately) but the PCI crash is gone, so

"mm: move pcp and lru-pcp draining into single wq" broke resume from s2ram
(https://lkml.org/lkml/2017/4/18/614)

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks for double checking!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
