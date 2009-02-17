From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 00:21:58 +0100
Message-ID: <200902180022.00239.rjw__8389.08810769699$1234913190$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0902162156380.24097-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902162156380.24097-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 17 February 2009, Alan Stern wrote:
> On Tue, 17 Feb 2009, Rafael J. Wysocki wrote:
> 
> > Phase 1: I agree that system-auto-suspend-on, system-auto-suspend-off would be
> > useful, but I don't like the wakelocks interface.  Do you think there is an
> > alternative way/mechanism of doing this?
> 
> I rather like the suggestions Matthew Garrett has been making.  They 
> show how to improve the wakelock interface without losing any function.
> 
> Really, the idea behind wakelocks comes down to the question of how to
> determine when the system is sufficiently idle to go into auto-suspend.  
> There may be occasions when no task is runnable but userspace knows
> that the system should not go to sleep because some work will be done
> in the near future.  (Arve's example of a non-empty input buffer is
> such a case.)  How should userspace let the kernel know whether it's
> okay to suspend at these times?  That is the problem userspace
> wakelocks are meant to solve.

Still, do we really need multiple user space wakelocks (I'd prefer to call them
sleeplocks)?  It seems that one such lock and a user space manager controlling
it should be sufficient.

> Kernel wakelocks are a separate matter.  They are more like a form of 
> optimization, preventing the kernel from starting an auto-suspend when 
> some driver knows beforehand that it will return -EBUSY.

I think kernel-side autosuspend (or rather autosleep) should only happen
after certain subset of devices have been suspended using a per-device
run-time autosuspend mechanism.

> > Phase 3: Probably explicit control left to open/close.
> 
> While that's generally a good idea, it's important to recognize that 
> some devices should be runtime-suspended even while they are open.

>From the kernel side, yes (and that should be transparent to the user space
having them open).  By the user space, no.
 
> Basically, any device that is "always open" falls in this category.  
> Some examples are the screen, the keyboard, the mouse, and disk drives.  
> And of course, some of these things already have runtime power 
> management.

Thanks,
Rafael
