From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Tue, 19 Jan 2010 00:33:15 +0100
Message-ID: <201001190033.16055.rjw__6233.52614134109$1263857739$gmane$org@sisk.pl>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001180000.23376.rjw@sisk.pl> <1263851757.724.500.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1263851757.724.500.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 18 January 2010, Benjamin Herrenschmidt wrote:
> On Mon, 2010-01-18 at 00:00 +0100, Rafael J. Wysocki wrote:
> > On Sunday 17 January 2010, Benjamin Herrenschmidt wrote:
> > > On Sun, 2010-01-17 at 14:27 +0100, Rafael J. Wysocki wrote:
> > ...
> > > However, it's hard to deal with the case of allocations that have
> > > already started waiting for IOs. It might be possible to have some VM
> > > hook to make them wakeup, re-evaluate the situation and get out of that
> > > code path but in any case it would be tricky.
> > 
> > In the second version of the patch I used an rwsem that made us wait for these
> > allocations to complete before we changed gfp_allowed_mask.
> > 
> > [This is kinda buggy in the version I sent, but I'm going to send an update
> > in a minute.]
> 
> And nobody screamed due to cache line ping pong caused by this in the
> fast path ? :-)

Apparently not. :-)

> We might want to look at something a bit smarter for that sort of
> read-mostly-really-really-mostly construct, though in this case I don't
> think RCU is the answer since we are happily scheduling.
> 
> I wonder if something per-cpu would do, it's thus the responsibility of
> the "writer" to take them all in order for all CPUs.

I think I'll get back to the first version of the patch which I think is not
going to have side effects (as long as no one will change gfp_allowed_mask
in parallel with suspend/resume), for now.

We can add more complicated things on top of it, then.

Rafael
