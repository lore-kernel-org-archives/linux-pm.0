From: leiming <tom.leiming@gmail.com>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Sat, 18 Apr 2009 11:50:51 +0800
Message-ID: <20090418115051.175f292f__34111.0045942061$1240026985$gmane$org@linux-lm>
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

> @@ -742,7 +742,7 @@ static int uvc_alloc_urb_buffers(struct
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

Now uvc only uses the previous allocated buffer in suspend/resume
path, so the packet size doen't change in this path.

> potentially bigger number than the already allocated buffer, no?

If this case does exist, the URBs need to be updated and the patch is 
not enough. 

> 
> So I think it should round down (ie use a regular divide). No?

Because the following fact:

	uvc_alloc_urb_buffers()
	{
		...
		video->urb_size = psize * npackets; 
		...
	}

so DIV_ROUND_UP still can work correctly.

Thanks!

-- 
Lei Ming
