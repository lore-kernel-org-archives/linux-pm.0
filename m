From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sat, 4 Sep 2010 10:57:46 +0200
Message-ID: <20100904085746.GC2569__42526.6164275401$1283590834$gmane$org@elf.ucw.cz>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<Pine.LNX.4.44L0.1008120733130.21006-100000@netrider.rowland.org>
	<AANLkTinMwt27wuDUh32F36wpoC54Syzp1_nK9UCxYmEK@mail.gmail.com>
	<20100812125248.GA2763@thunk.org>
	<20100814075000.GB27430@elf.ucw.cz>
	<20100816081655.3e9e29f7@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100816081655.3e9e29f7@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > The question is why are we adding a user-space API that:
> > > >  1) no user-space beside Android has expresses interest in implementing
> > > >  2) is dubious whether the benefits are worth the pain for non-Android
> > > > user-space
> > > >  3) will become less and less attractive as dynamic PM gets closer to
> > > > the sweet-spot, and then surpass it
> > > >  4) Android can keep in a separate tree until it's clear in the linux
> > > > community that it's useful (if it ever happens)
> > > 
> > > So, Felipe,
> > > 
> > > Do you believe you speak for all of LKML?
> > > 
> > > Are you willing to tell ZDNet and the Slashdot fanboys that it's OK
> > > for Suspend blockers to live in a separate tree, and it's not a case
> > > of OMG!  Google is forking the kernel?
> > > 
> > > If you could speak out a passionately on those forums as you have
> > > here, that would be great.
> > 
> > Ted, what is going on here? Are you suggesting people disagreeing with
> > Google patches suddenly have to do advocacy for Google?
> > 
> > And yes, for the record Felipe speaks for me pretty well.
> > 
> > Normal path of merging stuff to the kernel is
> > 
> > "Google develops it, then modifies it to address the review comments,
> > then it is merged, then it is deployed".
> 
> Pavel, you should know better than this.  You've been working on Linux
> long enough to know that development doesn't happen this way.

Well, I know that world is not always ideal, but it still surprised me
how far from "ideal" Google got.... 

> Although it would have been nice for Google to work more directly with
> upstream on their suspend blockers for Android, I don't think they
> could have made their product development cycle a slave to the politics
> of upstream development.

"Slave of upstream politics" would be going all the way; seeing the
patches before there were million devices out there would also help a
lot...

> Fortunately in this case the problem doesn't seem to be fatal.  We've
> already established that the userland API portion of suspend blockers
> could be implemented in userspace with a bit more work, given that the
> kernel problems with suspend/resume and events are addressed.

You are an optimist. Yes, I also hope it will work out fine, but...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
