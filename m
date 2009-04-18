From: leiming <tom.leiming@gmail.com>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Sat, 18 Apr 2009 12:51:11 +0800
Message-ID: <20090418125111.6646e997__5648.95053762502$1240030755$gmane$org@linux-lm>
References: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
	<d82e647a0904161837w6b6fb652la0da05f9061e95dc@mail.gmail.com>
	<200904172336.12414.rjw@sisk.pl> <20090418103226.54250420@linux-lm>
	<alpine.LFD.2.00.0904171952260.4042@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904171952260.4042@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Andrew@smtp1.linux-foundation.org, Linux ACPI <linux-acpi@vger.kernel.org>, video4linux-list@redhat.com, laurent.pinchart@skynet.be, Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, mchehab@infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Apr 2009 19:55:29 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > @@ -742,7 +742,7 @@ static int uvc_alloc_urb_buffers(struct
> > uvc_video_device *video, 
> >  	/* Buffers are already allocated, bail out. */
> >  	if (video->urb_size)
> > -		return 0;
> > +		return DIV_ROUND_UP(video->urb_size, psize);
> 
> I don't think this is right. It should round _down_.
> 
> It's supposed to return 'npackets', but if you pass it a different
> packet size than it was passed originally, it can now return a
> potentially bigger number than the already allocated buffer, no?
> 
> So I think it should round down (ie use a regular divide). No?

Yes,you are correct, please ignore my last reply, and following is
the fixed patch.

Thanks.

>From a3b3d72cdd57a0699fb643b41b78eb7beb211ff5 Mon Sep 17 00:00:00 2001
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 15 Apr 2009 22:32:51 +0800
Subject: [PATCH] V4L/DVB:usbvideo:fix uvc resume failed(v2)

Now urb buffers is not freed before suspend, so uvc_alloc_urb_buffers
should return packet counts allocated originally during uvc resume
, instead of zero.

This version uses round down to return packet counts on Linus's
suggestions, or else may lead to buffer destructed if packet size
is changed before calling uvc_alloc_urb_buffers() in this kind of
case.

This patch is against v2.6.30-rc2.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/media/video/uvc/uvc_video.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/uvc/uvc_video.c b/drivers/media/video/uvc/uvc_video.c
index a95e173..6ce974d 100644
--- a/drivers/media/video/uvc/uvc_video.c
+++ b/drivers/media/video/uvc/uvc_video.c
@@ -742,7 +742,7 @@ static int uvc_alloc_urb_buffers(struct uvc_video_device *video,
 
 	/* Buffers are already allocated, bail out. */
 	if (video->urb_size)
-		return 0;
+		return video->urb_size / psize;
 
 	/* Compute the number of packets. Bulk endpoints might transfer UVC
 	 * payloads accross multiple URBs.
-- 
1.6.0.GIT





-- 
Lei Ming
