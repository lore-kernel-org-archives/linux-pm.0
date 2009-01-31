From: Brian Swetland <swetland@google.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Fri, 30 Jan 2009 23:47:43 -0800
Message-ID: <20090131074743.GA13633@bulgaria.corp.google.com>
References: <d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
	<Pine.LNX.4.44L0.0901300955270.2466-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0901300955270.2466-100000@iolanthe.rowland.org>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

[Alan Stern <stern@rowland.harvard.edu>]
> > > Does the wakelock mechanism distinguish between suspend or power-state
> > > transitions that happen automatically and transitions requested
> > > directly by userspace?
> > 
> > No.
> 
> And I think this is a big mistake.  It makes sense to have locks for
> blocking auto suspend, but it does not make sense to prevent the user
> from putting his own computer to sleep.
> 
> For example: Suppose some program happens to hold a wakelock, perhaps 
> because of a simple bug, when the user closes the laptop lid and throws 
> the laptop into a backpack.  We don't want the computer to remain awake 
> under those circumstances!

It depends on the particular "computer" and the problem you're solving.

Imagine the computer in question is a cellphone which is going to need
to wake up when a call comes in to do traditional cellphone things, like
ring, bring up the incall UI (so the user can answer/cancel), etc.

Or perhaps it's an always-connected data device that might get remote
messages (IM notifications, contacts/email sync, etc) over the network
while it's "asleep" that need some processing.

Bad usage of wakelocks can certainly lead to poor battery life, but
there are definitely situations where you might want to operate in a
mode where the user considers the device "asleep" but it may still wake
up to handle certain tasks.

Brian
