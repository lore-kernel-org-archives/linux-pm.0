From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Getting rid of freezer for suspend [was Re: [fuse-devel] [PATCH] fuse: make fuse daemon frozen along with kernel threads]
Date: Wed, 13 Feb 2013 22:21:11 +0100
Message-ID: <24327774.p6haZy6gvA@vostro.rjw.lan>
References: <1360113112.17267.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC> <CAJfpegvV0zQ5Lftx=ELP0MAH1-7oY5HfT-CSYEaFUWJLmXoD7A@mail.gmail.com> <CAJfpegsFThkzv3uF60AMXO7Y-yEzU_20HeGyPra0O8Vk5OqCGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38011 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042Ab3BMVOo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Feb 2013 16:14:44 -0500
In-Reply-To: <CAJfpegsFThkzv3uF60AMXO7Y-yEzU_20HeGyPra0O8Vk5OqCGQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Pavel Machek <pavel@ucw.cz>, Goswin von Brederlow <goswin-v-b@web.de>, Li Fei <fei.li@intel.com>, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, biao.wang@intel.com, linux-pm@vger.kernel.org, fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com

On Wednesday, February 13, 2013 06:34:16 PM Miklos Szeredi wrote:
> On Tue, Feb 12, 2013 at 2:17 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > On Tue, Feb 12, 2013 at 2:13 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >> On Tue, Feb 12, 2013 at 11:46 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >>
> >>> (After all, with FUSE, filesystem clients are just doing IPC. In ideal
> >>> world, that would be freezeable and killable with -9).
> 
> Well, I thought this can be constrained to locks directly related to
> the fuse filesystem itself, but it can't...  The reason is page
> faults.  Pretty much everyone and their brother uses get_user_pages*,
> holding various locks (mmap_sem for sure but others as well).  A fuse
> filesystem frozen during a page read will block those.
> 
> Separating those parts of the kernel that can be frozen from those
> that can't looks increasingly difficult.
> 
> So I think the PF_FREEZE_DAEMON idea (the patch from Li Fei that
> started this thread) may still be our best bet at handling this
> situation.  The idea being that pure "originator" processes (ones that
> take no part in serving filesystem syscalls) can be frozen up-front.
> Then the "fuse daemon" (or "server") processes are hopefully in a
> quiescent state and can be frozen without difficulty.
> 
> Unfortunately it needs help from userspace: the kernel can't easily
> guess which processes are part of a "fuse daemon" and which aren't.
> Fortunately we have a standard library (libfuse) that can tell it to
> the kernel for the vast majority of cases.

So basically the idea would be to introduce something like PF_FREEZE_LATE
for user space processes that need to be frozen after all of the other
(non-PF_FREEZE_LATE) user space processes have been frozen and hack fuse
to use that flag?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
