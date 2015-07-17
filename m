From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Sat, 18 Jul 2015 01:54:09 +0200
Message-ID: <1684935.fYtBRJbzgO@vostro.rjw.lan>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org> <55A668FE.80409@gmail.com> <1A7043D5F58CCB44A599DFD55ED4C948468A7978@fmsmsx115.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60326 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751901AbbGQX12 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 19:27:28 -0400
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C948468A7978@fmsmsx115.amr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Austin S Hemmelgarn <ahferroin7@gmail.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, July 15, 2015 02:58:22 PM Brown, Len wrote:
> 
> > -----Original Message-----
> > From: Austin S Hemmelgarn [mailto:ahferroin7@gmail.com]
> > Sent: Wednesday, July 15, 2015 10:07 AM
> > To: Pavel Machek; Len Brown
> > Cc: rjw@rjwysocki.net; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Brown, Len
> > Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
> > 
> > On 2015-07-15 02:43, Pavel Machek wrote:
> > > On Tue 2015-07-14 22:24:51, Len Brown wrote:
> > >> From: Len Brown <len.brown@intel.com>
> > >>
> > >> The Linux kernel suspend path has traditionally invoked sys_sync().
> > >>
> > >> But sys_sync() can be expensive, and some systems do not want
> > >> to pay the cost of sys_sync() on every suspend.
> > >
> > > Have you measured how expensive it can be, and why it is expensive?
> 
> > How expensive it is can vary widely, but it pretty much boils down to
> > how much dirty data still needs written out, and how slow the storage it
> > needs written to is.  There's not really much that can be done in the
> > kernel to change this, and most userspace suspend systems call sync
> > themselves during the suspend sequence.
> 
> Right.
> And now, user-space gets is no longer forced to incur that
> delay on every suspend if they do not want it.
> 
> Yes, have measured this under many conditions.
> The bottom line is that sys_sync() is rarely as fast as 1ms,
> and is sometimes as slow as hundreds of ms.
> 
> >> Why do you need CONFIG parameter?
> 
> So that an OS that doesn't want to change their user-space,
> can build a kernel that does what they want by default.
> 
> Originally I had the config parameter remove this code entirely,
> which would achieve the same goal.
> But Rafael prefers the sysfs attribute always exist
> and the config simply set the default.

Indeed.

And so I'm queuing this patch up for 4.3 (with a couple of minor fixups).

Thanks,
Rafael

