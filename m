From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Wakeup settings for USB hubs?
Date: Wed, 18 Jul 2007 18:58:49 +0800
Message-ID: <1184756329.8054.73.camel@rzhang1-laptop>
References: <Pine.LNX.4.44L0.0707051546010.4198-100000@iolanthe.rowland.org>
	<200707051430.39999.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707051430.39999.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,
No one interested in this topic?
I thought it might be hot. :)

On Fri, 2007-07-06 at 05:30 +0800, David Brownell wrote:
> On Thursday 05 July 2007, Alan Stern wrote:
> 
> > Dave, you created the original wakeup attribute.  What do you think
> > about adding a separate wakeup_runtime?  (At a minimum, perhaps you
> can
> > suggest a better name!)
I think it's reasonable.

> I'll have to scan the emails in my queue to see what the issue
> is (umm, is this really 300+ messages in just the last couple
> days??) but my initial reaction is to avoid complications.  We
> have enough configuration knobs ... but userspace hasn't even
> begun to use them.  Adding more knobs will not improve that
> situation at all.
Well, I can not find one for the system sleep wakeup attribute,
I mean the ability to wakeup the system from a sleep state.
The patch http://www.spinics.net/lists/mm-commits/msg27356.html
makes the "wakeup" from device runtime suspend and the "wakeup" from
system suspend both controlled by .../power/wakeup.
This doesn't work in some cases, and that's why the patch
http://www.spinics.net/lists/mm-commits/msg30526.html are dropped.

I think we should find an alternative way instead of
using .../power/wakeup.
Another wakeup file or more values in the .../power/wakeup makes sense
to me, while the first one seems better. :)

Dave, what's you opinion?
Are there any available knobs that we can make use of but I missed?

Thanks,
Rui

> At one level, we want USB mice and keyboards to act pretty much
> like the PS2 variety.  Which means being wakeup sources in most
> cases ... though BIOS settings often overrides the PS2 stuff.
> 
> It'd make sense that _removing_ devices not normally be a wake
> event for USB ports.  But we don't always have that option...
