From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Sat, 14 Jan 2006 10:39:59 +0100
Message-ID: <200601141040.00088.rjw@sisk.pl>
References: <200601122241.07363.rjw@sisk.pl> <20060113205927.GN1906@elf.ucw.cz> <200601132224.27529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751631AbWANJi1@vger.kernel.org>
In-Reply-To: <200601132224.27529.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, 13 January 2006 22:24, Rafael J. Wysocki wrote:
> On Friday, 13 January 2006 21:59, Pavel Machek wrote:
> > On P=E1 13-01-06 21:49:38, Rafael J. Wysocki wrote:
> > > On Friday, 13 January 2006 20:53, Ingo Oeser wrote:
> > > > On Friday 13 January 2006 00:31, Rafael J. Wysocki wrote:
> > > > > On Thursday, 12 January 2006 23:09, Pavel Machek wrote:
> > > > > > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available s=
wap (the last argument
> > > > > > > +	should be a pointer to an unsigned int variable that wi=
ll contain
> > > > > > > +	the result if the call is successful)
> > > > > >=20
> > > > > > Is this good idea? It will overflow on 32-bit systems. Ammo=
unt of
> > > > > > available swap can be >4GB. [Or maybe it is in something el=
se than
> > > > > > bytes, then you need to specify it.]
> > > > >=20
> > > > > It returns the number of pages.  Well, it should be written e=
xplicitly,
> > > > > so I'll fix that.
> > > >=20
> > > > Please always talk to the kernel in bytes. Pagesize is only a k=
ernel
> > > > internal unit. Sth. like off64_t is fine.
> > >=20
> > > These are values returned by the kernel, actually.  Of course I c=
an convert them
> > > to bytes before sending to the user space, if that's preferrable.
> > >=20
> > > Pavel, what do you think?
> >=20
> > Bytes, I'd say. It would be nice if preffered image size was in byt=
es,
> > too, for consistency.
>=20
> OK

Having actually tried to do that I see two reasons for keeping the imag=
e size
in megs.

=46irst, if that was in bytes, I'd have to pass it via a pointer, becau=
se
unsigned long might overflow on i386.  Then I'd have to use get_user()
to read the value.  However, afterwards I'd have to rescale that value
to megs for swsusp_shrink_memory().  It's just easier to pass the value
in megs using the last argument of ioctl() directly (which is consisten=
t
with the /sys/power/image_size thing, BTW).

Second, if that's in bytes, it would suggest that the memory-shrinking
mechanism had byte granularity (ie. way off).

There also is a reason for which SNAPSHOT_AVAIL_SWAP should return
the number of pages, IMO.  Namely, if that's in pages, the number is di=
rectly
comparable with the number of image pages which the suspending
utility can read from the image header.  Otherwise it would have to res=
cale
one of these values using PAGE_SIZE, but that's exactly what we'd like
to avoid.

Anyway returning the swap offsets in bytes is a good idea, as it will a=
llow us
to eliminate PAGE_SIZE from the user space utilities entirely.

Greetings,
Rafael
