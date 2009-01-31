From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sat, 31 Jan 2009 10:41:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901311033590.6305-100000@netrider.rowland.org>
References: <20090131074743.GA13633@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090131074743.GA13633@bulgaria.corp.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 30 Jan 2009, Brian Swetland wrote:

> [Alan Stern <stern@rowland.harvard.edu>]
> > > > Does the wakelock mechanism distinguish between suspend or power-state
> > > > transitions that happen automatically and transitions requested
> > > > directly by userspace?
> > > 
> > > No.
> > 
> > And I think this is a big mistake.  It makes sense to have locks for
> > blocking auto suspend, but it does not make sense to prevent the user
> > from putting his own computer to sleep.
> > 
> > For example: Suppose some program happens to hold a wakelock, perhaps 
> > because of a simple bug, when the user closes the laptop lid and throws 
> > the laptop into a backpack.  We don't want the computer to remain awake 
> > under those circumstances!
> 
> It depends on the particular "computer" and the problem you're solving.

I disagree.

> Imagine the computer in question is a cellphone which is going to need
> to wake up when a call comes in to do traditional cellphone things, like
> ring, bring up the incall UI (so the user can answer/cancel), etc.

Yes.  So what?  Nothing I said prevents the computer from waking up 
when a call comes in.  What I said was that when the user tells the 
computer to suspend (e.g., by writing "mem" to /sys/power/state), the 
computer should suspend even if some wakelocks are still locked.

> Or perhaps it's an always-connected data device that might get remote
> messages (IM notifications, contacts/email sync, etc) over the network
> while it's "asleep" that need some processing.

By "asleep", do you mean something other than suspended?  If you do 
then you have misunderstood me.  I'm talking about a true suspend -- 
that is, the suspend routines in drivers/base/power/main.c have run, 
everything is in a low-power state or turned off, and the CPU isn't 
running.

Obviously the computer can't do any processing when it is suspended.  
The only thing it can do is resume.  And a resume can be initiated by a
wide variety of signals, including such things as receipt of a network 
packet or a phone call.

> Bad usage of wakelocks can certainly lead to poor battery life, but
> there are definitely situations where you might want to operate in a
> mode where the user considers the device "asleep" but it may still wake
> up to handle certain tasks.

I don't care what the user thinks; I care about what the kernel 
actually does.  If the user wants to delude himself into thinking the 
computer is "asleep" while the kernel is still running, that's his 
problem.

Alan Stern
