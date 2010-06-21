From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 11:23:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006211111060.1687-100000__31527.9380920858$1277134065$gmane$org@iolanthe.rowland.org>
References: <20100621073233.3f874ad0@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100621073233.3f874ad0@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Jun 2010, Florian Mickler wrote:

> On Sun, 20 Jun 2010 22:23:38 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:

> > This is the race I was talking about:
> > 
> > > > What happens if an event arrives just before you read
> > > > /sys/power/wakeup_count, but the userspace consumer doesn't realize
> > > > there is a new unprocessed event until after the power manager checks
> > > > it?
> > 
> > > I think this is not the kernel's problem.  In this approach the kernel makes it
> > > possible for the user space to avoid the race.  Whether or not the user space
> > > will use this opportunity is a different matter.
> > 
> > It is _not_ possible for userspace to avoid this race.  Help from the 
> > kernel is needed.
> 
> It is possible if every (relevant) userspace program implements a
> callback for the powermanager to check if one of it's wakeup-sources
> got activated.
> 
> That way the powermanager would read /sys/power/wakeup_count, then do
> the roundtrip to all it's registered users and only then suspend. 
> 
> This turns the suspend_blockers concept around. Instead of actively
> signaling the suspend_blockers, the userspace programs only answer
> "yes/no" when asked.  (i.e. polling?) 

In the end you would want to have communication in both directions:  
suspend blockers _and_ callbacks.  Polling is bad if done too often.  
But I think the idea is a good one.

In fact, you don't need a "yes/no" response.  Programs merely need a
chance to activate a new suspend blocker if a wakeup source was
recently activated before they acknowledge the poll.

> You _can not_ implement userspace suspend blockers with this approach,
> as it is vital for every userspace program to get scheduled and check
> it's wakeup-source (if even possible) before you know that the right
> parties have won the race.

I'm not sure what you mean.  Certainly you can take a userspace 
suspend-blocker implementation of the sort discussed before (where 
programs communicate their needs to a central power-manager process) 
and add this callback mechanism on top.

There is still at least one loophole to be closed: Android's
timer-based wakelocks.  These include cases where the Android
developers didn't add enough wakelocks to cover the entire path from
kernel-event to userspace-handler, so they punted and relied on a timer
to decide when the wakelock should be deactivated.  (There may be other
cases too; I didn't follow the original discussion very closely.)  
It's not clear whether these things can be handled already in Rafael's
scheme with your addition, or whether something new is needed.

Alan Stern
