From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 23:16:43 +0200
Message-ID: <200604262316.44162.rjw@sisk.pl>
References: <200604242355.08111.rjw@sisk.pl>
	<200604261341.32500.nigel@suspend2.net>
	<444F9E2D.2000901@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <444F9E2D.2000901@yahoo.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 26 April 2006 18:22, Nick Piggin wrote:
> Nigel Cunningham wrote:
> > On Wednesday 26 April 2006 12:24, Nick Piggin wrote:
> > 
> >>Rafael J. Wysocki wrote:
> >>
> >>>This means if we freeze bdevs, we'll be able to save all of the LRU pages,
> >>>except for the pages mapped by the current task, without copying.  I think
> >>>we can try to do this, but we'll need a patch to freeze bdevs for this
> >>>purpose. ;-)
> >>
> >>Why not the current task? Does it exit the kernel? Or go through some
> >>get_uesr_pages path?
> > 
> > 
> > I think Rafael is asleep at the mo, so I'll answer for him - he's wanting it 
> > to be compatible with using userspace to control what happens (uswsusp). In 
> > that case, current will be the userspace program that's calling the ioctls to 
> > get processes frozen etc.

Thanks Nigel. :-)

> OK, so what happens if, upon exit from kernel, that userspace task
> subsequently changes some pagecache but doesn't have that mapped? Or
> mmaps something then changes it?

The page cache that is not mapped by anyone is copied before creating the
image and the copy is included in the image.  However there would be a problem
if some page cache mapped by someone else were mapped by the suspending
task after it had exited the kernel.

Fortunately this task is forbidden to open() or mmap() any files at that time
anyway, because it would be likely to corrupt some filesystems if it did.
In fact it must not _touch_ any filesystems after the image has been created.

Greetings,
Rafael
