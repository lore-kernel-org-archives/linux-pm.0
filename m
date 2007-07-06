From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 06 Jul 2007 13:54:15 +1000
Message-ID: <1183694055.3388.108.camel__20955.4676818245$1183694235$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707060913.05644.nigel@nigel.suspend2.net>
	<1183677643.3388.105.camel@localhost.localdomain>
	<200707060935.12706.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707060935.12706.nigel@nigel.suspend2.net>
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

On Fri, 2007-07-06 at 09:35 +1000, Nigel Cunningham wrote:
> 
> Nice try :) Okay then, you remove the freezer, try hibernating, then get back 
> to me after you've fixed your filesystem because some process that wasn't 
> frozen started writing things after the atomic copy (making the on disk 
> filesystem inconsistent with the snapshot).
> 
> As Pavel rightly said, you can get rid of the freezer, but you're only going 
> to have to implement another one that does the essentially the same thing, 
> even if it is at some other level.

I was mostly talking about STR... Regarding STD, we have a different
problem and we all know it. The freezer is one somewhat horrible way to
get it working for now, I would prefer something more along the way that
blocks the page cache from writing out new dirty pages though, except
those specifically flagged by the snapshot.

That is, some kind of proper snapshotting facility, as linus was
describing some time ago.

Ben.

> > > >  - Silently add GFP_NOIO to all allocations, to avoid having things
> > > > blocking in kmalloc() with a mutex held that will deadlock with
> > > > suspend() in a driver for example. Or set some way to have all GFP
> > > > waiters wakeup and fail rather than wait for IOs. It's hard/bizarre but
> > > > necessary, again, with or without a freezer.
> > > 
> > > GFP_ATOMIC? (In driver suspend, they shouldn't be sleeping either, right?)
> > 
> > NOIO should be enough I think but ATOMIC would do).
> >  
> > That's one of the reason why I used to have the pre-suspend and
> > post-resume hooks in my original powermac implementation, for those few
> > drivers complicated enough to require some pre-allocations.
> >  
> > > >  - Deal with the firmware problem. The best way is probably to have an
> > > > async request_firmware interface(). Another thing is, drivers may want
> > > > to cache their firmware in main memory, that sort of thing...
> > > >
> > 
> > Note that the above firmware problem could be dealt with also with the
> > pre-suspend/post-resume. Allowing to pre-request firmware etc... and
> > keep it around until after resume, because we know we will need it.
> > Gives a chance to drivers to perform things while the system is still
> > live, filesystems still working, etc... (big memory allocations for
> > example).
> > 
> > > > And that's just a small list off the top of my mind, of known problems
> > > > that will cause deadlocks or misbehaviours today, with or without the
> > > > freezer, and that need to be addressed.
> > > 
> > > Userspace device drivers too?
> > 
> > Maybe but they are less of an issue, most of the time, they don't do DMA
> > or whatever harmful things. If they are USB drivers, for example, they
> > are an non-issues at that level.
> 
> (Leaving the rest of the message intact so we don't have to fragment the 
> discussion into a million subthreads).
> 
> Regards,
> 
> Nigel
> 
> 
> Invalid signature
> 
> 
