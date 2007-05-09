From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Wed, 9 May 2007 12:35:05 -0700
Message-ID: <200705091235.05613.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0705080949280.3217-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705080949280.3217-100000@iolanthe.rowland.org>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 May 2007, Alan Stern wrote:

> So here's the current state of my understanding of ACPI:
> 
> 	S4 is the lowest-power Sleep state.  RAM is not powered, the OS
> 	has stored a non-volatile memory image somewhere, and some ACPI
> 	state is maintained.
> 
> 	S5 is misnamed, in that it isn't really a Sleep state at all --
> 	it's an Off state. 

It's called "Soft Off" ... :)

The reason it resembles a sleep state is that various events other
than power switches are allowed to wake systems in S5.  RTC alarms
and keyboard events come to mind as common examples.

Agreed that the distinction between S4 and S5 seems too much in the
category of "because we said so!" than because of real technical
differences (beyond presence/absence of a non-volatile image, and
a few additional wakeup event sources).


> 			In fact, it is the state the computer enters 
> 	when you first plug it in (or insert the battery).

No; again, you're missing the entire point of G3 "mechanical off".

When you first plug it in, it's going to be in G3.  Then you turn
on the power switch.  Then you press the "on/off" button.

>From then on you can use only the "on/off" button, but the system
is vampiric ... when off/dead, it can choose to come alive, and is
always sucking power/blood at a low level.

But the "large red switch" option is available to put the system
into G3 ... driving a bloody stake through its heart, so it can't
re-activate itself at midnight, and preventing constant power drain.


> From the user's point of view, the differences between S4 and S5 amount to
> just these: power consumption and availability of wakeup devices.

And the fact that in S4 there's always a resumable OS image.

- Dave
