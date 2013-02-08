From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: [fuse-devel] [PATCH] fuse: make fuse daemon frozen along with
 kernel threads
Date: Fri, 8 Feb 2013 15:11:23 +0100
Message-ID: <20130208141123.GA29460@frosties>
References: <1360113112.17267.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
 <CAJfpegvJD75ahBViUqAwVTBLuF5yrxOcVvzYHmcsTgwxX+7Oqg@mail.gmail.com>
 <20130207084144.GB6168@frosties>
 <CAJfpegv1-Db+0DxZ8QUQv9BJiEBG3-8a2YaOVMbkb=Y7m+3DTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:53588 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758547Ab3BHOLc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 Feb 2013 09:11:32 -0500
Content-Disposition: inline
In-Reply-To: <CAJfpegv1-Db+0DxZ8QUQv9BJiEBG3-8a2YaOVMbkb=Y7m+3DTw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Li Fei <fei.li@intel.com>, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, biao.wang@intel.com, linux-pm@vger.kernel.org, fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com

On Thu, Feb 07, 2013 at 10:59:19AM +0100, Miklos Szeredi wrote:
> [CC list restored]
> 
> On Thu, Feb 7, 2013 at 9:41 AM, Goswin von Brederlow <goswin-v-b@web.de> wrote:
> > On Wed, Feb 06, 2013 at 10:27:40AM +0100, Miklos Szeredi wrote:
> >> On Wed, Feb 6, 2013 at 2:11 AM, Li Fei <fei.li@intel.com> wrote:
> >> >
> >> > There is well known issue that freezing will fail in case that fuse
> >> > daemon is frozen firstly with some requests not handled, as the fuse
> >> > usage task is waiting for the response from fuse daemon and can't be
> >> > frozen.
> >> >
> >> > To solve the issue above, make fuse daemon frozen after all all user
> >> > space processes frozen and during the kernel threads frozen phase.
> >> > PF_FREEZE_DAEMON flag is added to indicate that the current thread is
> >> > the fuse daemon,
> >>
> >> Okay and how do you know which thread, process or processes belong to
> >> the "fuse daemon"?
> >
> > Maybe I'm talking about the wrong thing but isn't any process having
> > /dev/fuse open "the fuse daemon"? And that doesn't even cover cases
> > where one thread reads requests from the kernel and hands them to
> > worker threads (that do not have /dev/fuse themself). Or the fuse
> > request might need mysql to finish a request.
> >
> > I believe figuring out what processes handle fuse requests is a lost
> > proposition.
> 
> Pretty much.
> 
> >
> >
> > Secondly how does freezing the daemon second garanty that it has
> > replied to all pending requests? Or how is leaving it thawed the right
> > decision?
> >
> > Instead the kernel side of fuse should be half frozen and stop sending
> > out new requests. Then it should wait for all pending requests to
> > complete. Then and only then can userspace processes be frozen safely.
> 
> The problem with that is one fuse filesystem might be calling into
> another.  Say two fuse filesystems are mounted at /mnt/A and /mnt/B,
> Process X starts a read request on /mnt/A. This is handled by process
> A, which in turn starts a read request on /mnt/B, which is handled by
> B.  If we freeze the system at the moment when A starts handling the
> request but hasn't yet sent the request to B then things wil be stuck
> and the freezing will fail.
> 
> So the order should be:  Freeze the "topmost" fuse filesystems (A in
> the example) first and if all pending requests are completed then
> freeze the next ones in the hierarchy, etc...  This would work if this
> dependency between filesystems were known.  But it's not and again it
> looks like an impossible task.

What is topmost? The kernel can't know that for sure.
 
> The only way to *reliably* freeze fuse filesystems is to let it freeze
> even if there are outstanding requests.  But that's the hardest to
> implement, because then it needs to allow freezing of tasks waiting on
> i_mutex, for example, which is currently not possible.  But this is
> the only way I see that would not have unsolvable corner cases that
> prop up at the worst moment.
> 
> And yes, it would be prudent to  wait some time for pending requests
> to finish before freezing.  But it's not a requirement, things
> *should* work without that: suspending a machine is just like a very
> long pause by the CPU, as long as no hardware is involved.  And with
> fuse filesystems there is no hardware involved directly by definition.
> 
> But I'm open to ideas and at this stage I think even patches that
> improve the situation for the majority of the cases would be
> acceptable, since this is turning out to be a major problem for a lot
> of people.
> 
> Thanks,
> Miklos

For shutdown in userspace there is the sendsigs.omit.d/ to avoid the
problem of halting/killing processes of the fuse filesystems (or other
services) prematurely. I guess something similar needs to be done for
freeze. The fuse filesystem has to tell the kernel what is up.

MfG
	Goswin
