From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Sat, 19 Dec 2009 22:41:03 +0100
Message-ID: <200912192241.03991.rjw__2251.08084637231$1261258946$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912181205290.2987-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912181205290.2987-100000@iolanthe.rowland.org>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 18 December 2009, Alan Stern wrote:
> On Fri, 18 Dec 2009, Rafael J. Wysocki wrote:
> 
> > I didn't manage to do that, but I was able to mark sd and i8042 as async and
> > see the impact of this.
> 
> Apparently this didn't do what you wanted.  In the nx6325
> sd+i8042+async+extra log, the 0:0:0:0 device (which is a SCSI disk) was
> suspended by the main thread instead of an async thread.

Hm, that's odd, because there's a noticeable time difference between the
two cases in which the sd is sync and async.  I'll look into it further.

> There's an important point I neglected to mention before.  Your logs 
> don't show anything for devices with no suspend callbacks at all.  
> Nevertheless, these devices sit on the device list and prevent other
> devices from suspending or resuming as soon as they could.

Unless they are async, that is.

> For example, the fingerprint sensor (3-1) took the most time to resume.  
> But other devices were delayed until after it finished because it had
> children with no callbacks, and they delayed the devices following
> them in the list.
> 
> What would happen if you completed these devices immediately, as part 
> of the first pass?

OK.  How do the PM core is supposed to check if a device has null suspend
and resume?  Check all of the function pointers in the first pass?

Rafael
