From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 3.7-rc3
Date: Fri, 02 Nov 2012 22:40:25 +0100
Message-ID: <4911582.xWBr8PDhoE@vostro.rjw.lan>
References: <CA+55aFwwTc4QXKqiECgE9NOE2zjC6GsGHHydGP9YDbgQSbw9Aw@mail.gmail.com> <CA+55aFxm0D77c0RYJuAiq2EDJxn+hGKTEGYJnHXNM8XkVAYOTA@mail.gmail.com> <CAKMK7uEgnpTET0_VXWm7JyGePnXL-q_nHgSWq4g=qWodwrg38Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53094 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757221Ab2KBVgT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Nov 2012 17:36:19 -0400
In-Reply-To: <CAKMK7uEgnpTET0_VXWm7JyGePnXL-q_nHgSWq4g=qWodwrg38Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie <airlied@linux.ie>

On Friday, November 02, 2012 10:07:10 PM Daniel Vetter wrote:
> On Fri, Nov 2, 2012 at 9:25 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, Oct 29, 2012 at 5:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>
> >> Unfortunately, s2disk is broken with this one and previous -rc.  In the
> >> majority of cases it just hangs the machine during hibernation, although
> >> sometimes it returns to user space reporting freezing problems, suspicions
> >> RCU usage and similar stuff, pretty much without any useful debug information.
> >
> > Ugh. I was hoping that we'd get more reports on this, right now
> > there's not enough information to even make a guess about what's up.
> >
> > I also note that no actual i915 people were cc'd, despite your
> > graphics driver suspect. Adding Daniel and Dave (one of the millions)
> > to the cc since they probably do have lkml but probably don't react
> > unless something gets pointed out.
> >
> > Daniel/Dave, do you have any reports of hibernation failing (or VT
> > switching problems) with i915 after 3.6?
> 
> Not that I've heard of. We did though rewrite the entire modeset
> sequence driving code in i915 for 3.7, removing massive amounts of
> hacks and stupid "let's disable/enable things harder" code simply
> because the old code couldn't keep track of the hw state well enough.
> So I wouldn't be surprised at all if that unearthed a hidden bug
> somewhere, but we've also added ridiculous amounts of self-checks. And
> thus far they caught all issues due to that rework (and some ancient
> bugs on top) when either the i915 driver or the bios did something
> nefarious ...
> 
> I've rechecked the git log and otherwise there's nothing else which
> pops up that would fit VT-switching/hibernate going bad but the
> modeset rework.

Can you point me to a range of commits worth checking?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
