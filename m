From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Sat, 14 Jan 2006 11:29:51 +0000
Message-ID: <20060114112950.GA2571@ucw.cz>
References: <200601122241.07363.rjw@sisk.pl> <20060113205927.GN1906@elf.ucw.cz>
	<200601132224.27529.rjw@sisk.pl> <200601141040.00088.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============092741691529439896=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601141040.00088.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org, Ingo Oeser <ioe-lkml@rameria.de>
List-Id: linux-pm@vger.kernel.org

--===============092741691529439896==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > > > It returns the number of pages.  Well, it should be written explicitly,
> > > > > > so I'll fix that.
> > > > > 
> > > > > Please always talk to the kernel in bytes. Pagesize is only a kernel
> > > > > internal unit. Sth. like off64_t is fine.
> > > > 
> > > > These are values returned by the kernel, actually.  Of course I can convert them
> > > > to bytes before sending to the user space, if that's preferrable.
> > > > 
> > > > Pavel, what do you think?
> > > 
> > > Bytes, I'd say. It would be nice if preffered image size was in bytes,
> > > too, for consistency.
> > 
> > OK
> 
> Having actually tried to do that I see two reasons for keeping the image size
> in megs.
> 
> First, if that was in bytes, I'd have to pass it via a pointer, because
> unsigned long might overflow on i386.  Then I'd have to use get_user()

Actually unsigned long is okay. We can't do images > 1.5GB, anyway,
on i386.

> to read the value.  However, afterwards I'd have to rescale that value
> to megs for swsusp_shrink_memory().  It's just easier to pass the value
> in megs using the last argument of ioctl() directly (which is consistent
> with the /sys/power/image_size thing, BTW).

Well, I'd be inclined to make image_size in bytes, too. Having
each ioctl/sys file in different units seems wrong.

> Second, if that's in bytes, it would suggest that the memory-shrinking
> mechanism had byte granularity (ie. way off).

Yep, but it is not that bad.

> There also is a reason for which SNAPSHOT_AVAIL_SWAP should return
> the number of pages, IMO.  Namely, if that's in pages, the number is directly
> comparable with the number of image pages which the suspending
> utility can read from the image header.  Otherwise it would have to rescale
> one of these values using PAGE_SIZE, but that's exactly what we'd like
> to avoid.

I see.... We could put #bytes into image header (unsigned long) :-).

Its not too bad one way or another, because uswsusp tools are
intimately tied to kernel, anyway.
							Pavel
-- 
Thanks, Sharp!

--===============092741691529439896==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============092741691529439896==--
