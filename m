From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 06 Jul 2007 09:20:43 +1000
Message-ID: <1183677643.3388.105.camel__26233.7947650396$1183677902$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<20070705093013.GA3228@elf.ucw.cz>
	<1183675615.3388.81.camel@localhost.localdomain>
	<200707060913.05644.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707060913.05644.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> Will you be able to guarantee that every place where a task can/will block 
> will be harmless place? If so, how will you guarantee that? How will you 
> debug issues where a task occasionally doesn't block in the right place, 
> particularly instances where it is some less than obvious interaction with 
> other tasks?

Which places aren't harmless if you don't have a freezer ?

> This is the whole point to having the freezer. It makes things more 
> predictable and testable. It shows us, clearly, when process X is the one 
> that is causing problems.

No, the freezer creates all those places what are harmful for a task to
block because they will break the freezer :-)

> >  - Silently add GFP_NOIO to all allocations, to avoid having things
> > blocking in kmalloc() with a mutex held that will deadlock with
> > suspend() in a driver for example. Or set some way to have all GFP
> > waiters wakeup and fail rather than wait for IOs. It's hard/bizarre but
> > necessary, again, with or without a freezer.
> 
> GFP_ATOMIC? (In driver suspend, they shouldn't be sleeping either, right?)

NOIO should be enough I think but ATOMIC would do).
 
That's one of the reason why I used to have the pre-suspend and
post-resume hooks in my original powermac implementation, for those few
drivers complicated enough to require some pre-allocations.
 
> >  - Deal with the firmware problem. The best way is probably to have an
> > async request_firmware interface(). Another thing is, drivers may want
> > to cache their firmware in main memory, that sort of thing...
> >

Note that the above firmware problem could be dealt with also with the
pre-suspend/post-resume. Allowing to pre-request firmware etc... and
keep it around until after resume, because we know we will need it.
Gives a chance to drivers to perform things while the system is still
live, filesystems still working, etc... (big memory allocations for
example).

> > And that's just a small list off the top of my mind, of known problems
> > that will cause deadlocks or misbehaviours today, with or without the
> > freezer, and that need to be addressed.
> 
> Userspace device drivers too?

Maybe but they are less of an issue, most of the time, they don't do DMA
or whatever harmful things. If they are USB drivers, for example, they
are an non-issues at that level.
