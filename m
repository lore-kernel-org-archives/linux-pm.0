From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Possible problem with device_move()
Date: Wed, 1 Aug 2007 13:35:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708011316250.2663-100000@iolanthe.rowland.org>
References: <20070801190406.6c53ccc4@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070801190406.6c53ccc4@gondolin.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007, Cornelia Huck wrote:

> On Wed, 1 Aug 2007 11:22:12 -0400 (EDT),
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > As it stands right now, every place device_move() gets called is 
> > already special!
> 
> The "special cases" I was thinking about are those where the order to
> suspend/resume is not covered by a parent/child relationship, but by
> (possibly random) order of registration. I'd have thought the rule "the
> child must be suspended before the parent" was pretty straightforward,
> but...

So you mean additional requirements, like what I encountered with EHCI.  
It's peculiar in that the controller contains a hardware switch which
can literally connect a USB device to a different (companion)
controller, and setting the switch before the companion controller has
been resumed won't work.  The correct way to handle this would be to
set the switch later when the USB device is resumed, but that would be
much more awkward.

I haven't heard of any other cases.

> (The whole list based on registration order thing seems a bit fragile
> to me, but I don't know enough of the PM core and suspend/resume in
> general to make a better suggestion :/)

It hasn't been bad in the past.  If A was discovered before B then ipso 
facto it is safe to suspend B before suspending A.  Likewise, in the 
absence of device_move, if A was discovered before B then A cannot 
appear below B in the device tree.  Of course, this assumes devices are 
registered as they are discovered.

Alan Stern
