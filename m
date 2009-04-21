From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Tue, 21 Apr 2009 09:47:34 +0800
Message-ID: <d82e647a0904201847n403424efnb5a0c40a4cac365d__42026.590210344$1240278673$gmane$org@mail.gmail.com>
References: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
	<alpine.LFD.2.00.0904171952260.4042@localhost.localdomain>
	<20090418125111.6646e997@linux-lm>
	<200904202208.23899.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904202208.23899.laurent.pinchart@skynet.be>
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
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, mchehab@infradead.org, Linux ACPI <linux-acpi@vger.kernel.org>, video4linux-list@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2009/4/21 Laurent Pinchart <laurent.pinchart@skynet.be>:
> On Saturday 18 April 2009 06:51:11 leiming wrote:
>> On Fri, 17 Apr 2009 19:55:29 -0700 (PDT)
>>
>> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> > > @@ -742,7 +742,7 @@ static int uvc_alloc_urb_buffers(struct
>> > > uvc_video_device *video,
>> > > =A0 /* Buffers are already allocated, bail out. */
>> > > =A0 if (video->urb_size)
>> > > - =A0 =A0 =A0 =A0 return 0;
>> > > + =A0 =A0 =A0 =A0 return DIV_ROUND_UP(video->urb_size, psize);
>> >
>> > I don't think this is right. It should round _down_.
>> >
>> > It's supposed to return 'npackets', but if you pass it a different
>> > packet size than it was passed originally, it can now return a
>> > potentially bigger number than the already allocated buffer, no?
>> >
>> > So I think it should round down (ie use a regular divide). No?
>>
>> Yes,you are correct, please ignore my last reply, and following is
>> the fixed patch.
>
> psize and video->urb_size shouldn't have changed before and after resume,
> otherwise we'll get into trouble anyway. A regular divide and a round-up
> divide should then return the same result. I'll take the regular divide, =
as it
> will be more efficient.

Yes.

>
>> Thanks.
>>
>> From a3b3d72cdd57a0699fb643b41b78eb7beb211ff5 Mon Sep 17 00:00:00 2001
>> From: Ming Lei <tom.leiming@gmail.com>
>> Date: Wed, 15 Apr 2009 22:32:51 +0800
>> Subject: [PATCH] V4L/DVB:usbvideo:fix uvc resume failed(v2)
>>
>> Now urb buffers is not freed before suspend, so uvc_alloc_urb_buffers
>> should return packet counts allocated originally during uvc resume
>> , instead of zero.
>>
>> This version uses round down to return packet counts on Linus's
>> suggestions, or else may lead to buffer destructed if packet size
>> is changed before calling uvc_alloc_urb_buffers() in this kind of
>> case.
>
> The comment is misleading. If the packet size changes we need to realloca=
te
> the buffers anyway. Have you checked if the packet size (which depends on=
 the
> endpoint being selected) can be changed between suspend and resume, eithe=
r by
> the uvcvideo driver (I don't think it can) or the USB core ?

The packet size does not change between suspend and resume.  I mean
uvc_alloc_urb_buffers()
still can be used in other cases if buffers was not freed and is
reuesed in future. It seems there is no
such cases in uvcvideo now, but uvc_alloc_urb_buffers() really __can__
 work in such case, isn't it?

IMHO It is only used to allocate or reserve UVC_URBS usb buffers,
which size is video->urb_size, and
npackets can be shortened or enlarged if psize is changed, after all.

Thanks!

-- =

Lei Ming
