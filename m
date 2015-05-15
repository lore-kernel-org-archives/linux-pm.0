From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / sleep: Let devices force direct_complete
Date: Fri, 15 May 2015 16:54:59 +0200
Message-ID: <2082109.RajuayHQfS@vostro.rjw.lan>
References: <1431610673-16801-1-git-send-email-tomeu.vizoso@collabora.com> <2929090.OdVc2hRah5@vostro.rjw.lan> <CAAObsKB6=upGWKnGfhCzrvY+aQEmh+b-35Law=P6WCtLKfcPJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61343 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934063AbbEOO3r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 10:29:47 -0400
In-Reply-To: <CAAObsKB6=upGWKnGfhCzrvY+aQEmh+b-35Law=P6WCtLKfcPJg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday, May 15, 2015 03:25:00 PM Tomeu Vizoso wrote:
> On 14 May 2015 at 21:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, May 14, 2015 03:37:52 PM Tomeu Vizoso wrote:
> >> Introduce a new per-device flag power.force_direct_complete that will
> >> instruct the PM core to let that device remain in runtime suspend when
> >> the system goes into a sleep power state, regardless of the PM state of
> >> any of its descendants.
> >>
> >> This is needed because otherwise it would be needed to get dozens of
> >> drivers to implement the prepare() callback and be runtime PM active
> >> even if they don't have a 1-to-1 relationship with a piece of HW.
> >>
> >> This only applies to devices that aren't wakeup-capable, as those would
> >> need to setup their IRQs as wakeup-capable in their prepare() callbacks.
> >>
> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >
> > Well, my idea of a "direct complete" flag was a bit different and I have
> > a concern with this particular implementation. ->
> 
> Yeah, I started like that but then realized that, at least in the
> uvcvideo case, it doesn't know at probe() time how many descendants
> it's going to have.
> 
> This was discussed in:
> 
> http://article.gmane.org/gmane.linux.power-management.general/59157

I guess the solution may be to inherit the parent setting when creating
a device in those cases, so the ucvideo will set the flag for the top-most
device at probe() time and the devices below it will simply inherit the
setting.

This way or another, I would very much prefer to restrict this new thing
to device_prepare().


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
