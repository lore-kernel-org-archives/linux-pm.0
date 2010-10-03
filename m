From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 0/2] PM: Wakeup sources and async suspend
 error path bug fix
Date: Sun, 3 Oct 2010 15:04:20 -0700
Message-ID: <20101003220420.GA3707__14056.2287219383$1286143606$gmane$org@gvim.org>
References: <201009201957.40995.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009201957.40995.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 20, 2010 at 07:57:40PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> The following two patches are ready to go into linux-next from my point of
> view, so please let me know if there are any objections:
> 
> [1/2] - PM / Wakeup: Introduce wakeup source objects and event statistics (v3)
> 
> [2/2] - PM: Fix potential issue with failing asynchronous suspend
> 
> Thanks,
> Rafael

Sorry for the late response but, what user feed back will this provide
to the OS stack looking to put the system in a low power state?

There are 2 cases I can think of:
1) system wakes from an event that user mode needs to handle (i.e. key
press or phone ring or alarm events)
2) system wakes (or more likely, is blocked from suspending) by a
kernel critical section, say if USB-OTG is connected.

When wake's are of the type 1, then the power manager service could
simply wait for a user mode wake lock be taken and released from the
usermode before re-attempting to suspend.

When the wakes are of type 2, a power manager service thread would need
to do a select on a system file and be woken up to re-try the suspend
after the suspend-blocking is no longer needed.

Do you think I should cobble together an android PM driver that plugs
into your code to expose an ABI for the 2 cases listed above?

Also, with this do we want to revisit a pm_qos class for "active"
systems?  Or do you think thats redundant now?

--mark
