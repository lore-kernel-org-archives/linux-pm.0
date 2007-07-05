From: David Brownell <david-b@pacbell.net>
Subject: Re: Wakeup settings for USB hubs?
Date: Thu, 5 Jul 2007 14:30:39 -0700
Message-ID: <200707051430.39999.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0707051546010.4198-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707051546010.4198-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 05 July 2007, Alan Stern wrote:

> Dave, you created the original wakeup attribute.  What do you think 
> about adding a separate wakeup_runtime?  (At a minimum, perhaps you can 
> suggest a better name!)

I'll have to scan the emails in my queue to see what the issue
is (umm, is this really 300+ messages in just the last couple
days??) but my initial reaction is to avoid complications.  We
have enough configuration knobs ... but userspace hasn't even
begun to use them.  Adding more knobs will not improve that
situation at all.

At one level, we want USB mice and keyboards to act pretty much
like the PS2 variety.  Which means being wakeup sources in most
cases ... though BIOS settings often overrides the PS2 stuff.

It'd make sense that _removing_ devices not normally be a wake
event for USB ports.  But we don't always have that option...

- Dave
