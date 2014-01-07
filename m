From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/4] thermal: rcar: Add missing clock handling
Date: Tue, 7 Jan 2014 23:13:25 +0100
Message-ID: <CAMuHMdWBVZ6RNe8B5m3hh+6O=2Sg0NR7sGrAg-xDEKgsGrDnbw@mail.gmail.com>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
	<52CC770E.1000004@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:65400 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbaAGWN0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2014 17:13:26 -0500
In-Reply-To: <52CC770E.1000004@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Valentine,

On Tue, Jan 7, 2014 at 10:52 PM, Valentine
<valentine.barshak@cogentembedded.com> wrote:
> On 01/07/2014 10:57 PM, Geert Uytterhoeven wrote:
>> This patch series fixes a problem when the thermal-rcar device is
>> instantiated from the device tree on the r8a7791-based Koelsch development
>> board. The driver fails during initialization with:
>
>
> I think explicitly acquiring the clocks should not be needed.
> Could you please try the patches from the following series instead?
>
> http://marc.info/?l=linux-sh&m=138823255807611&w=2

I already had these applied, and the problem persists.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
