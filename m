From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Sat, 4 Jul 2015 10:50:36 +0200
Message-ID: <CAMuHMdUXJ_fobDSiDgRhovjHOE0wcKEXVvJWP5ExFs7+vOKsdA@mail.gmail.com>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
	<CAJvTdKn71W0+js3D4OwK5Tx4z5KdA8hb-FyRMTuw0rdyQj9pRw@mail.gmail.com>
	<20150703014250.GM7943@dastard>
	<1496051.AgsebokWnB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36627 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbbGEJTx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jul 2015 05:19:53 -0400
In-Reply-To: <1496051.AgsebokWnB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Sat, Jul 4, 2015 at 3:03 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> [The argument that the user can pull removable storage devices out of the
> system while suspended doesn't hold any water to me, because the user can
> pull them out of the system when not suspended just as well and cause the
> same kind of damage to happen.]

The user may not notice the difference between a suspended and powered
off machine, and thus think it's safe to unplug the USB memory stick while
the machine appears off.

If that's considered a valid use case, this would be a regression.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
