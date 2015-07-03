From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 3 Jul 2015 11:42:50 +1000
Message-ID: <20150703014250.GM7943@dastard>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
 <Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
 <20150509202518.GB20282@khazad-dum.debian.net>
 <CAJvTdKmGFPHtO-rOwXWJr6bPDS4PuEo+g7H-uQhuMc_+kh4CuA@mail.gmail.com>
 <20150625171158.GB27230@khazad-dum.debian.net>
 <CAJvTdKmscv8andz=T4zPjhgtqHq4+k6iB3Lm+_14eqnah=Fdcw@mail.gmail.com>
 <1435753306.1134542.312471953.3DCB0D87@webmail.messagingengine.com>
 <CAJvTdKn71W0+js3D4OwK5Tx4z5KdA8hb-FyRMTuw0rdyQj9pRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:27574 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754199AbbGCBmy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2015 21:42:54 -0400
Content-Disposition: inline
In-Reply-To: <CAJvTdKn71W0+js3D4OwK5Tx4z5KdA8hb-FyRMTuw0rdyQj9pRw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Wed, Jul 01, 2015 at 11:07:29PM -0400, Len Brown wrote:
> >> The _vast_ majority of systems using Linux suspend today are under
> >> an Android user-space.  Android has no assumption that that suspend to
> >> mem will necessarily stay suspended for a long time.
> >
> > Indeed, however your change was not android-specific, and it is not
> > "comfortable" on x86-style hardware and usage patterns.
> 
> "comfortable on x86-style and usage patterns"?
> If you mean "traditional" instead of "comfortable",
> where "tradition" is based on 10-year old systems, then sure.

Even if this were true(*) we don't break things that currently work
just because something different is "just around the corner". e.g.
if you shut the lid on your laptop and it suspends to RAM, you can
pull the USB drive out that you just copied stuff to and plug it
into another machine and find all the data you copied there is
present.

Remove the sync() from the freeze code, and this isn't guaranteed to
work anymore. It is now dependent on userspace implementations for
this to work, and we know what userspace developers will choose in
this situation. i.e. fast and "works for me", not "safe for
everyone".

(*) Which it clearly isn't true because, as this example shows, my
shiny new laptop still has exactly the same data integrity
requirements as the laptop I was using 10 years ago.

Just because there are lots of Android or Chrome out there it
doesn't mean we can just ignore the requirements of everything
else...

> > That said, as long as x86 will still try to safeguard my data during mem
> > sleep/resume as it does today, I have no strong feelings about
> > light/heavy-weight "mem" sleep being strictly a compile-time selectable
> > thing, or a more flexible runtime-selectable behavior.
> 
> The observation here is that the kernel should not force every system
> to sys_sync() on every suspend.  The only question is how to best
> implement that.

No, your observation was that "sync is slow". Your *solution* is "we
need to remove sync".

However, your arguement so far has these problems:

	- repeated sync from outside the suspend context is does not
	  demonstrate the problem you are seeing during suspend, and
	  you have not yet identified why this is the case.
	- it has been demonstrated that inode cache size plays a
	  significant role in sync latency, but you haven't provided
	  any information to tell us what the cache sizes were when
	  you see large latencies.
	- it has been demonstrated that there are patches pending
	  that improve clean filesystem sync speed, but you have not
	  produced numbers to demonstrate that those patches do not
	  meet your requirements.
	- In several tests your "sync latency" monitoring was
	  dirtying the filesystem and hence *causing* the repeated
	  syncs to be slow.
	- you have not told us whether your suspend monitoring was
	  the cause of the suspend sync latency or not.
	- you have been testing on hardware with questionable power
	  management behaviour.

IOWs, you have not yet identified the root cause of the slow sync
behaviour on suspend, you have not determined if pending work fixes
the latency problems, and you have not reproduced your results after
fixing  the flaws in your testing methodology.

> The obvious solution was to delete this forced policy
> from the kernel, and let user-space handle it.
> Rafael has not agreed to push that obvious, though less-than-gentle
> solution upstream, and so I'll re-send the historic patch
> that allows distros to still sync like it is 1999, if they want to:-)

Please stop shouting about "obvious" solutions until you've actually
proved there is a problem and that problems you find aren't already
fixed by the pending sync changes....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
