From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Sat, 12 Dec 2009 18:35:40 +0100
Message-ID: <200912121835.40663.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912111938310.32493-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912111938310.32493-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 12 December 2009, Alan Stern wrote:
> On Sat, 12 Dec 2009, Rafael J. Wysocki wrote:
> 
> > Below is a patch I've just tested, but there's a lockdep problem in it I don't
> > know how to solve.  Namely, lockdep is apparently unhappy with us not releasing
> > the lock taken in device_suspend() and it complains we take it twice in a row
> > (which we do, but for another device).  I need to use down_read_non_owner()
> > to make it shut up and then I also need to use up_read_non_owner() in
> > __device_suspend(), although there's the comment in include/linux/rwsem.h
> > saying exatly this about that:
> > 
> > /*
> >  * Take/release a lock when not the owner will release it.
> >  *
> >  * [ This API should be avoided as much as possible - the
> >  *   proper abstraction for this case is completions. ]
> >  */
> > 
> > (I'd like to know your opinion about that).  Yet, that's not all, because next
> > it complains during resume that __device_resume() releases a lock it didn't
> > acquire, which it clearly does, but that is intentional.  Unfortunately,
> > there's no up_write_non_owner() ...
> 
> Hah!  I knew it!
> 
> How come lockdep didn't complain earlier?  What's different about this 
> patch?  Only the nesting annotations?  Why should adding annotations 
> make lockdep less happy?

I'm not sure.  Perhaps I made a mistake during the previous tests.

Rafael
