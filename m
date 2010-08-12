From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 07:40:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008120733130.21006-100000__23976.9120504663$1281613314$gmane$org@netrider.rowland.org>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: david@lang.hm, Theodore Tso <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Aug 2010, Felipe Contreras wrote:

> My goal is to shine light. I've heard many invalid arguments in favor
> of suspend blockers, I want to shut them down.
> 
> In my mind it's crystal clear that independently of what opportunistic
> suspend is supposed to be fixing, the fact of the matter is that it's
> not a silver bullet as it's claimed to be.
> 
> So far, nobody has refuted these:
>  1) opportunistic suspend needs a good behaved user-space to work properly

That seems entirely reasonable, since opportunistic suspend is 
essentially a userspace facility.  Its in-kernel component is extremely 
small (and is already in mainline).

>  2) if suspend blockers are enabled in a system, *all* user-space must
> implement them to work correctly

That isn't clear at all.  Certainly they must be implemented correctly 
in some parts of userspace.  But other parts can simply be denied 
permission to use them.

>  3) implementing suspend blockers in user-space is not a straight-forward task

Perhaps so.  Lots of things in userspace aren't straight-forward --
GUIs, for example.  So what?  That's not a proof they shouldn't be
used.

>  4) there's a point where sleeping (not doing work) has diminished returns

Agreed.  It is platform dependent.  The Google people seem to believe 
strongly they have not yet reached that point on their platforms.

> So, as the length of this thread has shown, the benefits of
> opportunistic suspend are *dubious* at best, and more likely not worth
> the changes needed in user-space which eventually will get pretty
> close to what suspend blockers can achieve even in ideal circumstances
> by just doing dynamic PM.

You're ignoring the fact that Android has _already_ made the necessary
userspace changes.  Now you're going to ask them to change back,
offering as motivation the loss of a real (albeit "dubious")  
power-saving advantage?  Why should they accept your offer?

Alan Stern
