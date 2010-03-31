From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Wed, 31 Mar 2010 23:36:50 +0200
Message-ID: <201003312336.50620.rjw@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003312225.25085.rjw@sisk.pl> <4BB3B95A.5000901@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BB3B95A.5000901@crca.org.au>
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
> On 01/04/10 07:25, Rafael J. Wysocki wrote:
> > On Wednesday 31 March 2010, Nigel Cunningham wrote:
> >> Hi.
> >>
> >> On 31/03/10 08:03, Rafael J. Wysocki wrote:
...
> > Not necessarily if the image is compressed in chunks.  According to
> > measurements I did some time ago, 256 KiB chunks were sufficient.
> 
> I must be missing something. You're talking about doing compression of 
> the image during the atomic copy, right? If that's the case, where do 
> the 256KiB chunks come in?

I thought about an algorithm like this:

Have a sufficient number of free pages to store the compressed image data.
repeat:
- copy image pages to a buffer until it's full
- compress the buffer (perhaps use another buffer to store the result)
- copy the result to the free pages

and hence the buffer.

> >> Assuming you rely on 50+% compression, you'll still need to ensure that at
> >> least 1/3 of memory is available for the buffer for the compressed data.
> >
> > That's correct.
> >
> >> This would give maximum image size of only 1/6th of memory more than without
> >> compression - not much of a gain.
> >
> > Still, on a 1 GiB machine that's about 170 MiB which is quite some data.
> >
> >> It's also ugly because if you find that you don't achieve the expected
> >> compression, you'll need to undo the going atomic, free some more memory
> >> and try again - or just give up (which I hope you won't consider to be a
> >> real option).
> >
> >  From my experience we can safely assume 50% compression in all cases.
> 
> I've seen it lower in some cases - lots of video or such like in memory. 
> But then perhaps that's just because I'm not discarding anything.
> 
> >> Regarding using LRU pages as temporary storage, if it wasn't safe and
> >> reliable, I would have stopped doing it ages ago.
> >
> > We've been through that already and as you can see I'm still not convinced.
> > Sorry, but that's how it goes.  The fact that ToI uses this approach without
> > seeing any major breakage is a good indication that it _may_ be safe in
> > general, not that it _is_ safe in all cases one can imagine.
> 
> It's not "any major breakage", but no breakage at all over a course of 
> about 6 or 7 years of usage. I agree that it's not mathematical proof, 
> but still...

I'd say without any reported breakage you could blame on the usage of LRU
pages.  But I think even if such things were reported, it wouldn't be really
straightforward to track them down to the LRU, because they wouldn't be
reproducible.

> > Besides, that would be a constraint on the future changes of the mm subsystem
> > that I'm not sure we should introduce.  At least the mm people would need to
> > accept that and there's a long way before we're even able to ask them.
> 
> It doesn't need to be that way. As with KMS, a simple way of flagging 
> which pages need to be atomically copied is all that's necessary.

I'm not sure about that.

Besides, assuming that the LRU pages are really safe, I'd prefer to save them
directly as a part of the image along with the atomic copy instead of using
them as temporary storage.

Thanks,
Rafael
