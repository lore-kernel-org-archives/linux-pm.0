From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 3.7-rc3
Date: Fri, 02 Nov 2012 21:35:31 +0100
Message-ID: <4475100.SUWa7JIGmB@vostro.rjw.lan>
References: <CA+55aFwwTc4QXKqiECgE9NOE2zjC6GsGHHydGP9YDbgQSbw9Aw@mail.gmail.com> <26004880.qboZkUVCy9@vostro.rjw.lan> <CA+55aFxm0D77c0RYJuAiq2EDJxn+hGKTEGYJnHXNM8XkVAYOTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53034 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab2KBUbZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Nov 2012 16:31:25 -0400
In-Reply-To: <CA+55aFxm0D77c0RYJuAiq2EDJxn+hGKTEGYJnHXNM8XkVAYOTA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>

On Friday, November 02, 2012 01:25:37 PM Linus Torvalds wrote:
> On Mon, Oct 29, 2012 at 5:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > Unfortunately, s2disk is broken with this one and previous -rc.  In the
> > majority of cases it just hangs the machine during hibernation, although
> > sometimes it returns to user space reporting freezing problems, suspicions
> > RCU usage and similar stuff, pretty much without any useful debug information.
> 
> Ugh. I was hoping that we'd get more reports on this, right now
> there's not enough information to even make a guess about what's up.
> 
> I also note that no actual i915 people were cc'd, despite your
> graphics driver suspect. Adding Daniel and Dave (one of the millions)
> to the cc since they probably do have lkml but probably don't react
> unless something gets pointed out.
> 
> Daniel/Dave, do you have any reports of hibernation failing (or VT
> switching problems) with i915 after 3.6?
> 
> Rafael, do you have logs of the suspicious RCU usage etc reports?

Not at the moment, unfortunately.  I'll try to collect some tomorrow,
but I'm leaving for LinuxCon Europre on Sunday morning, so I'm a bit
time constrained now. :-)

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
