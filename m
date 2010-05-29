From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 20:10:38 -0700
Message-ID: <20100529031038.GD11600__20430.8004621$1275102681$gmane$org@gvim.org>
References: <alpine.LFD.2.00.1005271545190.3032@localhost.localdomain>
	<Pine.LNX.4.44L0.1005271053420.3239-100000@iolanthe.rowland.org>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005271053420.3239-100000@iolanthe.rowland.org>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 11:06:23AM -0400, Alan Stern wrote:
> If people don't mind, here is a greatly simplified summary of the 
> comments and objections I have seen so far on this thread:
> 
> 	The in-kernel suspend blocker implementation is okay, even
> 	beneficial.

Only if they only block.  You get into trouble when the in kernel
un-block opperation triggers an implicit suspend. 


> 
> 	Opportunistic suspends are okay.
> 
> 	The proposed userspace API is too Android-specific.
> 
> 	More kernel mechanisms are needed for expressing processes'
> 	latency requirements.

True.

--mgross

> 
> The last one is obviously a longer-term issue, so let's ignore it for
> now.  That leaves as the only point of contention the userspace
> suspend-blocker API.
> 
> The proposal I made a couple of days ago removes this API and leaves
> the other things (i.e., the in-kernel suspend blockers and
> opportunistic suspend) intact.  In place of the userspace
> kernel-blocker API, Android would have to implement a power manager
> process that would essentially juggle all the latency requirements in
> userspace.
> 
> Communication between the power manager process and the kernel would be 
> limited to adding a new "opportunistic" entry to /sys/power/state -- 
> something which could well be useful in its own right.  Even if this 
> API turns out not to be good, it's simple enough that it could be 
> removed pretty easily.
> 
> This answers Alan Cox's (and other's) desire not to implement a 
> questionable or special-purpose API.  And it also answers Thomas's 
> desire to make scheduling decisions based on latency requirements 
> (although the answer is simply to punt all these decisions out of the 
> kernel and into userspace -- which is reasonable for now since the 
> alternative would require a long-term kernel development effort).
> 
> Indeed, having a power manager thread may well turn out to be a useful
> thing -- but even if it doesn't, this scheme minimizes the damage while
> still allowing the Android platform to use a vanilla kernel with only
> limited modifications to their userspace.
> 
> Alan Stern
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
