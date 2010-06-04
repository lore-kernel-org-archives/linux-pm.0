From: Ingo Molnar <mingo@elte.hu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 12:03:06 +0200
Message-ID: <20100604100306.GB3324__46653.379375539$1275645948$gmane$org@elte.hu>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<1275645245.27810.39493.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1275645245.27810.39493.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2010-06-04 at 11:43 +0200, Peter Zijlstra wrote:
> > I still believe containment is a cgroup problem. The freeze/snapshot/resume
> > container folks seem to face many of the same problems. Including the
> > pending timer one I suspect. Lets solve it there. 
> 
> While talking to Thomas about this, we'd probably need a CLOCK_MONOTONIC 
> namespace to pull this off, so that resumed apps don't see the jump in 
> absolute time.
> 
> This would also help with locating the relevant timers, since they'd be on 
> the related timer base.

Ok - this looks workable, and looks technically isolated that can be pursued 
as a separate module of this whole topic.

> The only 'interesting' issue I can see here is that if you create 1000 
> CLOCK_MONOTONIC namepaces, we'd need to have a tree of trees in order to 
> efficiently find the leftmost timer.

Realistically Android userspace would create just a single such namespace for 
all the untrusted/unknown/uncontrolled apps, right?

	Ingo
