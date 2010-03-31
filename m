From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Wed, 31 Mar 2010 22:25:25 +0200
Message-ID: <201003312225.25085.rjw@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003302303.12758.rjw@sisk.pl> <4BB2B3E5.7020708@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BB2B3E5.7020708@crca.org.au>
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

On Wednesday 31 March 2010, Nigel Cunningham wrote:
> Hi.
> 
> On 31/03/10 08:03, Rafael J. Wysocki wrote:
> >>> Now, an attractive thing would be to compress data while creating the image
> >>> and that may be done in the following way:
> >>>
> >>> have a buffer ready
> >>> repeat:
> >>> - copy image pages to the buffer (instead of copying them directly into the
> >>>     image storage space)
> >>> - if buffer is full, compress it and copy the result to the image storage
> >>>     space, page by page.
> >>
> >> A few points that might be worth considering:
> >>
> >> Wouldn't compressing the image while creating it rather than while
> >> writing increase the overall time taken to hibernate (since the time
> >> taken can't then be combined with the time for writing the image)?
> >
> > It would, but that's attractive anyway, because the image could be larger than
> > 1/2 of memory this way without using the LRU pages as temporary storage
> > space (which I admit I'm reluctant to do).
> >
> >> Wouldn't it also increase the memory requirements?
> >
> > Not really, or just a little bit (the size of the buffer).  I'm talking about
> > the image that's created atomically after we've frozen devices.
> 
> The buffer would be the size of the compressed image.

Not necessarily if the image is compressed in chunks.  According to
measurements I did some time ago, 256 KiB chunks were sufficient.

> Assuming you rely on 50+% compression, you'll still need to ensure that at
> least 1/3 of memory is available for the buffer for the compressed data.

That's correct.

> This would give maximum image size of only 1/6th of memory more than without 
> compression - not much of a gain.

Still, on a 1 GiB machine that's about 170 MiB which is quite some data.

> It's also ugly because if you find that you don't achieve the expected 
> compression, you'll need to undo the going atomic, free some more memory 
> and try again - or just give up (which I hope you won't consider to be a 
> real option).

>From my experience we can safely assume 50% compression in all cases.

> Regarding using LRU pages as temporary storage, if it wasn't safe and 
> reliable, I would have stopped doing it ages ago.

We've been through that already and as you can see I'm still not convinced.
Sorry, but that's how it goes.  The fact that ToI uses this approach without
seeing any major breakage is a good indication that it _may_ be safe in
general, not that it _is_ safe in all cases one can imagine.

Besides, that would be a constraint on the future changes of the mm subsystem
that I'm not sure we should introduce.  At least the mm people would need to
accept that and there's a long way before we're even able to ask them.

Rafael
