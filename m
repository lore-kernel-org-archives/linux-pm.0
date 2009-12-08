From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 14:32:40 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912081420220.3560__39904.2306970388$1260311615$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912081643290.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912081643290.3046-100000@iolanthe.rowland.org>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 8 Dec 2009, Alan Stern wrote:
> 
> Suppose A and B are unrelated devices and we need to impose the
> off-tree constraint that A suspends after B.

Ah. Ok, I can imagine the off-tree constraints, but part of my "keep it 
simple" was to simply not do them. If there are constraints that aren't 
in the topology of the tree, then I simply don't think that async is worth 
it in the first place.

> You misunderstand.  The suspend algorithm will look like this:
> 
> 	dpm_suspend()
> 	{
> 		list_for_each_entry_reverse(dpm_list, dev) {
> 			down_write(dev->lock);
> 			async_schedule(device_suspend, dev);
> 		}
> 	}
> 
> 	device_suspend(dev)
> 	{
> 		device_for_each_child(dev, child) {
> 			down_read(child->lock);
> 			up_read(child->lock);
> 		}
> 		dev->suspend(dev);	/* May do off-tree down+up pairs */
> 		up_write(dev->lock);
> 	}

Ok, so the above I think work (and see my previous email: I think 
completions would be workable there too).

It's just that I think the "looping over children" is ugly, when I think 
that by doing it the other way around you can make the code simpler and 
only depend on the PM device list and a simple parent pointer access.

I also think that you are wrong that the above somehow protects against 
non-topological dependencies. If the device you want to keep delay 
yourself suspending for is after you in the list, the down_read() on that 
may succeed simply because it hasn't even done its down_write() yet and 
you got scheduled early.

But I guess you could do that by walking the list twice (first to lock 
them all, then to actually call the suspend function). That whole 
two-phase thing, except the first phase _only_ locks, and doesn't do any 
callbacks.

			Linus
