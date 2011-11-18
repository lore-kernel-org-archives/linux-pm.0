From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: HIBERNATION: skip the swap size check if
 the snapshot image size is anticipative
Date: Fri, 18 Nov 2011 20:02:33 +0100
Message-ID: <20111118190233.GA16136__7103.84393246404$1321643515$gmane$org@elf.ucw.cz>
References: <1320392176-3906-1-git-send-email-Barry.Song@csr.com>
	<20111105182244.GB6772@elf.ucw.cz>
	<CAGsJ_4xU28APFEcALAzuB2jAACa8FbOR6iSvOaEeGZa=JyjNeA@mail.gmail.com>
	<CAGsJ_4xm05N4UZ94kvUtUGLGkcDnxesojV0fL9hQQnZBOFvohg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xm05N4UZ94kvUtUGLGkcDnxesojV0fL9hQQnZBOFvohg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Barry Song <21cnbao@gmail.com>
Cc: Xiangzhen Ye <Xiangzhen.Ye@csr.com>, linux-kernel@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon 2011-11-07 09:31:10, Barry Song wrote:
> 2011/11/6 Barry Song <21cnbao@gmail.com>:
> > 2011/11/6 Pavel Machek <pavel@ucw.cz>:
> >> Hi!
> >>
> >>> From: Barry Song <Baohua.Song@csr.com>
> >>>
> >>> Current swsusp requires swap partitions even larger than real saved pages
> >>> due to the worst compress ratio:
> >>> but for an embedded system, which has limited storage space, then it might
> >>> can't give the big size partition to save snapshot.
> >>> In the another way, some embedded systems can definitely know the most size
> >>> needed for snapshot since they run some specific application lists.
> >>> So this patch provides the possibility for bootloader to tell kernel even
> >>> the system has a little snapshot partition, but it is still enough.
> >>> For example, if the system need to save 120MB memory, origin swsusp will require
> >>> a 130MB partition to save snapshot. but if users know 30MB is enough for them(
> >>> compressed image will be less than 30MB), they just make a 30MB
> >>> partition.
> >>
> >> Would it be better to have /sys/power/... entry which would allow
> >> configuring expected compression ratio at runtime?
> >
> > i think it is better to have a sys node than add another kernel param.
> > but the point is i only care about the final image size but not
> > compression ratio. i don't care how well lzo will do for me since i
> > only have limited disk space and know how many pages want to be saved.
> > there has been a image_size node, will we have a expected_image_size node?
> 
> or will we have just a node named /sys/power/check_size, if
> 1(default), check, otherwise(0 set by users), skip checking?

Or just avoid the check at all, since it no longer makes sense with
compression?

What is the failure scenario? Hibernation still fails, but it takes
longer to fail?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
