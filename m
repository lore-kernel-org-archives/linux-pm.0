From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?=5BRFC_09/15=5D_PM_/_Hibernate=3A_user?=
 =?iso-8859-1?q?=2C_=09implement_user=5Fops_writer?=
Date: Tue, 30 Mar 2010 23:03:12 +0200
Message-ID: <201003302303.12758.rjw@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003300009.18315.rjw@sisk.pl> <4BB1508E.9030103@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BB1508E.9030103@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 30 March 2010, Nigel Cunningham wrote:
> Hi.
> 
> On 30/03/10 09:09, Rafael J. Wysocki wrote:
> > On Monday 29 March 2010, Jiri Slaby wrote:
... 
> Okay. So the read or write terminology is from userspace's perspective, 
> right?

Yes.

> Perhaps that's part of what I've found confusing about the kernel side of things.
> 
> > [Note that snapshot_[read|write]_next() belong to the memory management
> > part of the hibernation subsystem and that's exactly why they are in
> > snapshot.c.]
> >
> > Now, compression can happen in two places: while the image is created
> > or after it has been created (current behavior).  In the latter case, the image
> > pages need not be compressed in place, they may be compressed after being
> > returned by snapshot_read_next(), in a temporary buffer (that's now s2disk
> > does that).  So you can arrange things like this:
> >
> > create image
> > repeat:
> > - snapshot_read_next() ->  buffer
> > - if buffer is full, compress it (possibly encrypt it) and write the result to
> >    the storage
> >
> > This way you'd just avoid all of the complications and I fail to see any
> > drawbacks.
> >
> > Now, an attractive thing would be to compress data while creating the image
> > and that may be done in the following way:
> >
> > have a buffer ready
> > repeat:
> > - copy image pages to the buffer (instead of copying them directly into the
> >    image storage space)
> > - if buffer is full, compress it and copy the result to the image storage
> >    space, page by page.
> 
> A few points that might be worth considering:
> 
> Wouldn't compressing the image while creating it rather than while 
> writing increase the overall time taken to hibernate (since the time 
> taken can't then be combined with the time for writing the image)?

It would, but that's attractive anyway, because the image could be larger than
1/2 of memory this way without using the LRU pages as temporary storage
space (which I admit I'm reluctant to do).

> Wouldn't it also increase the memory requirements?

Not really, or just a little bit (the size of the buffer).  I'm talking about
the image that's created atomically after we've frozen devices.

Rafael
