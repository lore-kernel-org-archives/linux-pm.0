From: "Li, Fei" <fei.li@intel.com>
Subject: RE: Getting rid of freezer for suspend [was Re: [fuse-devel]
 [PATCH] fuse: make fuse daemon frozen along with kernel threads]
Date: Wed, 20 Feb 2013 02:54:20 +0000
Message-ID: <BEC9F67575FA1E429CA7CF5AE9BE3634403505@SHSMSX102.ccr.corp.intel.com>
References: <1360113112.17267.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
 <6332427.iqPUMjtDaQ@vostro.rjw.lan>
 <BEC9F67575FA1E429CA7CF5AE9BE3634400F30@SHSMSX102.ccr.corp.intel.com>
 <3321530.AgvEeduuPx@vostro.rjw.lan>
 <20130219104633.GA23279@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46268 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933341Ab3BTCyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Feb 2013 21:54:25 -0500
In-Reply-To: <20130219104633.GA23279@xo-6d-61-c0.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Goswin von Brederlow <goswin-v-b@web.de>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "Wang, Biao" <biao.wang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Liu, Chuansheng" <chuansheng.liu@intel.com>

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Tuesday, February 19, 2013 6:47 PM
> To: Rafael J. Wysocki
> Cc: Li, Fei; Miklos Szeredi; Goswin von Brederlow; Brown, Len;
> mingo@redhat.com; peterz@infradead.org; Wang, Biao;
> linux-pm@vger.kernel.org; fuse-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org; Liu, Chuansheng
> Subject: Re: Getting rid of freezer for suspend [was Re: [fuse-devel] [PATCH] fuse:
> make fuse daemon frozen along with kernel threads]
> 
> Hi!
> 
> > > > > > Well, I suppose that information is available to user space.
> > > > > >
> > > > > > Do we need an interface for a process to mark itself as PF_FREEZE_LATE
> or
> > > > > > do we need an interface for one process to mark another process as
> > > > > > PF_FREEZE_LATE, or both?
> > > > >
> > > > > As a first step marking self with PF_FREEZE_LATE and inheriting this
> > > > > flag across fork/clone would work for most cases, I think.
> > > >
> > > > OK, so we can just have a switch for that in /proc I suppose.
> > >
> > > Thanks for feedback and suggestion.
> > >
> > > We have ever tried similar idea, expose interface
> /sys/power/pm_freeze_daemon,
> > > userspace tasks write 1 to this attribute to make itself to be frozen at the
> same time
> > > with kernel tasks, and it worked in our experiment.
> > >
> > > Do you think it's suitable and enough to use such attribute
> /sys/power/pm_freeze_late,
> > > or other more suitable place under /proc suggested?
> >
> > I think it should be inder /proc, because that's where controls related to
> > process behavior are located.  E.g. /proc/PID/freeze_late or something like
> > that.
> 
> freeze_priority?
> 
> I _hope_ we will not need more than three priorities, (user, fused, kernel), but
> I hoped not no need more than two before, so...
> 									Pavel
> --

IMHO, we still use two priorities, with the exception that user space process such
as fuse daemon can be configured to be frozen in kernel threads frozen phase
instead of user space processes frozen phase.

I submit a patch on https://lkml.org/lkml/2013/2/19/705 for such implementation.
Could you please help to check whether it's suitable?

Thanks and Regards,
Li Fei

> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
