From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 06 Jul 2015 01:25:35 +0200
Message-ID: <3178110.trcxC53OR0@vostro.rjw.lan>
References: <4290667.ZqInAykFGS@vostro.rjw.lan> <1496051.AgsebokWnB@vostro.rjw.lan> <CAMuHMdUXJ_fobDSiDgRhovjHOE0wcKEXVvJWP5ExFs7+vOKsdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44864 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751509AbbGEW7M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jul 2015 18:59:12 -0400
In-Reply-To: <CAMuHMdUXJ_fobDSiDgRhovjHOE0wcKEXVvJWP5ExFs7+vOKsdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Saturday, July 04, 2015 10:50:36 AM Geert Uytterhoeven wrote:
> On Sat, Jul 4, 2015 at 3:03 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > [The argument that the user can pull removable storage devices out of the
> > system while suspended doesn't hold any water to me, because the user can
> > pull them out of the system when not suspended just as well and cause the
> > same kind of damage to happen.]
> 
> The user may not notice the difference between a suspended and powered
> off machine, and thus think it's safe to unplug the USB memory stick while
> the machine appears off.
> 
> If that's considered a valid use case, this would be a regression.

Well, if user space configures the system to use suspend as a "power off
flavor" and doesn't even try to ensure the filesystems to be synced before
suspending (in that mode), that's on the edge of insanity.

And it falls into the "latent bugs that may be there because we've always
synced before suspending" category in my view.

Thanks,
Rafael

