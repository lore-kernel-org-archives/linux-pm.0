From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Sat, 9 May 2009 11:28:19 +0800
Message-ID: <20090509112819.759594d5__47602.1391609267$1241839842$gmane$org@linux-lm>
References: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
	<200904202208.23899.laurent.pinchart@skynet.be>
	<d82e647a0904201847n403424efnb5a0c40a4cac365d@mail.gmail.com>
	<200904220121.12002.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904220121.12002.laurent.pinchart@skynet.be>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Laurent Pinchart <laurent.pinchart@skynet.be>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, mchehab@infradead.org, Linux ACPI <linux-acpi@vger.kernel.org>, video4linux-list@redhat.com, Linux@smtp1.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 22 Apr 2009 01:21:10 +0200
Laurent Pinchart <laurent.pinchart@skynet.be> wrote:

> Hi,
> 
> On Tuesday 21 April 2009 03:47:34 Ming Lei wrote:
> > 2009/4/21 Laurent Pinchart <laurent.pinchart@skynet.be>:
> > > On Saturday 18 April 2009 06:51:11 leiming wrote:

> > >> From a3b3d72cdd57a0699fb643b41b78eb7beb211ff5 Mon Sep 17
> > >> 00:00:00 2001 From: Ming Lei <tom.leiming@gmail.com>
> > >> Date: Wed, 15 Apr 2009 22:32:51 +0800
> > >> Subject: [PATCH] V4L/DVB:usbvideo:fix uvc resume failed(v2)
> > >>
> > >> Now urb buffers is not freed before suspend, so
> > >> uvc_alloc_urb_buffers should return packet counts allocated
> > >> originally during uvc resume , instead of zero.
> > >>
> > >> This version uses round down to return packet counts on Linus's
> > >> suggestions, or else may lead to buffer destructed if packet size
> > >> is changed before calling uvc_alloc_urb_buffers() in this kind of
> > >> case.
> > >
> > > The comment is misleading. If the packet size changes we need to
> > > reallocate the buffers anyway. Have you checked if the packet
> > > size (which depends on the endpoint being selected) can be
> > > changed between suspend and resume, either by the uvcvideo driver
> > > (I don't think it can) or the USB core ?
> >
> > The packet size does not change between suspend and resume.  I mean
> > uvc_alloc_urb_buffers() still can be used in other cases if buffers
> > was not freed and is reuesed in future. It seems there is no such
> > cases in uvcvideo now, but uvc_alloc_urb_buffers() really __can__
> > work in such case, isn't it?
> >
> > IMHO It is only used to allocate or reserve UVC_URBS usb buffers,
> > which size is video->urb_size, and npackets can be shortened or
> > enlarged if psize is changed, after all.
> 
> You're right. Patch applied, thanks.

Rc5 has been released today, why isn't this patch accepted by upstream
now?  It is really a bug fix.

Thanks.

> 
> Best regards,
> 
> Laurent Pinchart
> 

-- 
Lei Ming
