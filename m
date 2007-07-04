From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 21:34:48 +1000
Message-ID: <18059.34264.421573.246262__49676.2931500145$1183548951$gmane$org@cargo.ozlabs.ibm.com>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707041242.59552.rjw@sisk.pl>
	<18059.32111.58643.97174@cargo.ozlabs.ibm.com>
	<200707041325.55779.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041325.55779.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki writes:

> They are mostly related to kernel threads, that we've already agreed no to
> freeze (except for the ones that want that, but they will be responsible for
> getting everything right).  The initial patches for that are in -mm and more
> will come.

Serious question: which kernel threads would actually want to be
frozen?

Threads that do no I/O at all don't care about suspend/resume and
don't need to be frozen in any case.  Threads that issue I/O requests
in order to service incoming I/O requests can't be frozen because of
the possibility of deadlock.  Which leaves threads that do I/O just
for the fun of it. :)

What am I missing?

> > Also, no-one has yet answered my fundamental objection to the freezer,
> > which is that the very kernel threads we would want to freeze are
> > often the same ones that we must not freeze, namely the threads that
> > issue I/O requests in order to satisfy incoming I/O requests.
> 
> See above.  We're moving away from freezing kernel threads.

I believe the distinction between threads and user processes is a
false one, because user processes can now do things that were formerly
only doable by kernel threads.

> > If there was an automatic way to construct the graph of dependencies
> > (including data flows) between tasks, and derive an ordering for
> > freezing that guarantees that all I/Os will get completed without
> > deadlocks, then I could accept the freezer.  But we don't have
> > anything like that.
> 
> No we don't.
> 
> Still, my position is this:
> 
> 1) The freezer (in the modified form, with the freezing of kernel threads
> limited to the ones that want to be frozen) is needed for hibernation.
> 
> 2) The freezer is generally not needed for suspend, _but_ there are drivers
> in the tree that rely on it being used.  Thus, at some point in time we can

Do you know which drivers they are?  I'm happy to help hack things
into shape.

> remove the freezer from the suspend code path, _but_ no sooner than we are
> sure that the majority of drivers is prepared for that.
> 
> 3) In the meantime, if there are freezer-related problems, they should be
> fixed rather than used as arguments for immediate removal of it, because of 2).

I don't know how you can make the freezer completely deadlock-free
while still providing the guarantee that some drivers currently need,
without constructing the dependency graph I mentioned.

Paul.
