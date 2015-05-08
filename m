From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 08 May 2015 22:30:17 +0200
Message-ID: <4290667.ZqInAykFGS@vostro.rjw.lan>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com> <20150508201310.5c4ccfaa@lxorguk.ukuu.org.uk> <CAJvTdKnoZhworj21Bsdt5ttGK+vQQ0tB_0-2Aok-rdsU8VvNkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59828 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932348AbbEHUFM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 16:05:12 -0400
In-Reply-To: <CAJvTdKnoZhworj21Bsdt5ttGK+vQQ0tB_0-2Aok-rdsU8VvNkg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Friday, May 08, 2015 03:32:30 PM Len Brown wrote:
> On Fri, May 8, 2015 at 3:13 PM, One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> 2. worst case latency is obscene, there are examples of some
> >>     syncs which take over 3,000 ms to complete.
> >
> > ATA is pretty open ended on this. I believe the vendors use 7 seconds
> > just for the cache flush as their limit because after 7 seconds some non
> > Linux OS's blow up. However if my suspend/resume crashes (as still I'm
> > sorry to say happens far too often) I don't want my last ten minutes of
> > work trashed.
> >
> >> Unfortunately, sys_sync() can be a significant pain point,
> >> even for systems that run Android.
> >
> > Android devices often have slow I/O devices coupled with a lot of memory
> > so yes that is true.
> >
> > There are however some very important reasons for using sync() in a
> > suspend
> >
> > - I can read data off the suspended machines disk volumes even though I
> >   can't write to them. People do this.

Reportedly, for some journaling FSes that may trigger a jornal replay and
therefore on-disk data modifications to happen.  I think we're talking about
FAT mostly here, though.

I guess the concern is about things that autosleep (eg. Android) and so may
not be able to sync() from user space before suspending, but for them we
can just move the sync() to the autosleep thread.

> > - Suspend requires the firmware, drivers and kernel all get it exactly
> >   right. On a lot of machines therefore suspend is still a buggy pile of
> >   crap. Sync is extremely valuable given that you can't be entirely
> >   sure your system will resume.
> >
> > - Users habitually do stupid things like removing USB dongles from
> >   suspended boxes and thinking afterwards. Perception is that the device
> >   is off therefore you can unplug it.
> >
> > So I think its inappropriate to change the default. Allow users to turn
> > it off by all means, and I imagine many phones would use that.
> 
> FWIW, 18-months ago, I proposed a patch to make the sys_sync() optional
> "[PATCH 1/1] suspend: make sync() on suspend-to-RAM optional"
> and feedback was that fewer choices would be better.
> 
> Note that user-space has full license both before and after this patch
> to sync().  Indeed, the s2disk and s2ram utilities do exactly that.
> 
> > Some of this however is crappy suspend/resume handling. If the suspend
> > subsystem was doing its job then for the cases of timeout triggered
> > suspend it would have triggered most of the disk writes ten seconds
> > before it tried to suspend properly ;-)
> 
> No problem, continue to use s2ram on your system -- and to the extent
> that sync works, your data will be on disk.  (sync reliability is a
> different topic...)
> 
> Understand, however, there are systems which suspend/resume reliably
> many times per second, making policy choice of having the kernel hard-code
> a sys_sync() into the suspend path a bad idea.

My current view on that is that whether or not to do a sync() before suspending
ultimately is a policy decision and should belong to user space as such (modulo
the autosleep situation when user space may not know when the suspend is going
to happen).

Moreover, user space is free to do as many sync()s before suspending as it
wants to and the question here is whether or not the *kernel* should sync()
in the suspend code path.

Since we pretty much can demonstrate that having just one sync() in there is
not sufficient in general, should we put two of them in there?  Or just
remove the existing one and leave it to user space entirely?

Rafael

