From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 22:09:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902162156380.24097-100000__18966.1360149787$1234840329$gmane$org@netrider.rowland.org>
References: <200902170008.31054.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902170008.31054.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Feb 2009, Rafael J. Wysocki wrote:

> Phase 1: I agree that system-auto-suspend-on, system-auto-suspend-off would be
> useful, but I don't like the wakelocks interface.  Do you think there is an
> alternative way/mechanism of doing this?

I rather like the suggestions Matthew Garrett has been making.  They 
show how to improve the wakelock interface without losing any function.

Really, the idea behind wakelocks comes down to the question of how to
determine when the system is sufficiently idle to go into auto-suspend.  
There may be occasions when no task is runnable but userspace knows
that the system should not go to sleep because some work will be done
in the near future.  (Arve's example of a non-empty input buffer is
such a case.)  How should userspace let the kernel know whether it's
okay to suspend at these times?  That is the problem userspace
wakelocks are meant to solve.

Kernel wakelocks are a separate matter.  They are more like a form of 
optimization, preventing the kernel from starting an auto-suspend when 
some driver knows beforehand that it will return -EBUSY.

> Phase 3: Probably explicit control left to open/close.

While that's generally a good idea, it's important to recognize that 
some devices should be runtime-suspended even while they are open.  
Basically, any device that is "always open" falls in this category.  
Some examples are the screen, the keyboard, the mouse, and disk drives.  
And of course, some of these things already have runtime power 
management.

Alan Stern
