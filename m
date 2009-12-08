From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 13:04:02 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912081256310.3560__33568.9292093322$1260306325$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912072225390.4179-100000@netrider.rowland.org>
	<200912081323.50606.rjw@sisk.pl>
	<alpine.LFD.2.00.0912080728590.3560@localhost.localdomain>
	<200912082044.52098.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912082044.52098.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:
> 
> Anyway, if we use an rwsem, it won't be checkable from interrupt context just
> as well.

You can't do a lock() from an interrupt, but the unlocks should be 
irq-safe. 

> Suppose we use rwsem and during suspend each child uses a down_read() on a
> parent and then the parent uses down_write() on itself.  What if, whatever the
> reason, the parent is a bit early and does the down_write() before one of the
> children has a chance to do the down_read()?  Aren't we toast?

We're toast, but we're toast for a totally unrealted reason: it means that 
you tried to resume a child before a parent, which would be a major bug to 
begin with.

Look, I even wrote out the comments, so let me repeat the code one more 
time.

 - suspend time calling:
        // This won't block, because we suspend nodes before parents
        down_read(node->parent->lock);
        // Do the part that may block asynchronously
        async_schedule(do_usb_node_suspend, node);

 - resume time calling:
        // This won't block, because we resume parents before children,
        // and the children will take the read lock. 
        down_write(leaf->lock);
        // Do the blocking part asynchronously
        async_schedule(usb_node_resume, leaf);

See? So when we take the parent lock for suspend, we are guaranteed to do 
so _before_ the parent node itself suspends. And conversely, when we take 
the parent lock (asynchronously) for resume, we're guaranteed to do that 
_after_ the parent node has done its own down_write.

And that all depends on just one trivial thing; that the suspend and 
resume is called in the right order (children first vs parent first 
respectively). And that is such a _major_ correctness issue that if that 
isn't correct, your suspend isn't going to work _anyway_.

			Linus
