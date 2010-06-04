From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Fri, 04 Jun 2010 12:13:59 +0200
Message-ID: <1275646439.27810.39540.camel__9025.22588517076$1275646701$gmane$org@twins>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu> <1275644619.27810.39462.camel@twins>
	<1275645245.27810.39493.camel@twins>
	<alpine.LFD.2.00.1006041156350.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006041156350.2933@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-06-04 at 12:11 +0200, Thomas Gleixner wrote:
> On Fri, 4 Jun 2010, Peter Zijlstra wrote:
> 
> > On Fri, 2010-06-04 at 11:43 +0200, Peter Zijlstra wrote:
> > > I still believe containment is a cgroup problem. The freeze/snapshot/resume
> > > container folks seem to face many of the same problems. Including the
> > > pending timer one I suspect. Lets solve it there. 
> > 
> > While talking to Thomas about this, we'd probably need a CLOCK_MONOTONIC
> > namespace to pull this off, so that resumed apps don't see the jump in
> > absolute time.
> > 
> > This would also help with locating the relevant timers, since they'd be
> > on the related timer base.
> > 
> > The only 'interesting' issue I can see here is that if you create 1000
> > CLOCK_MONOTONIC namepaces, we'd need to have a tree of trees in order to
> > efficiently find the leftmost timer.
> 
> We can do more clever than that. All CLOCK_MONOTONIC timers can live
> in the CLOCK_MONOTONIC rbtree, we just need proper annotation, i.e.:
> 
> struct hrtimer {
>        ktime_t expires;
>        ......
>        struct list_head namespace;
>        ktime_t base_offset;
> };
> 
> So expires would be on CLOCK_MONOTONIC as seen from the kernel, just
> the user space interfaces would take the base_offset into account.
> 
> On freeze we remove the timers from the rbtree (they are easy to
> find via the namespace list) and on thaw we set the base_offset
> accordingly and insert them again. So no surprise for user space and
> no tree of trees to walk through.

Ah indeed, much nicer.
