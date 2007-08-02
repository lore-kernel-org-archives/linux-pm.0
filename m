From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Possible problem with device_move()
Date: Thu, 2 Aug 2007 16:58:12 +0200
Message-ID: <200708021658.12991.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0708021020370.3611-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0708021020370.3611-100000@iolanthe.rowland.org>
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 2 August 2007 16:24, Alan Stern wrote:
> On Thu, 2 Aug 2007, Rafael J. Wysocki wrote:
> 
> > > > Perhaps we should create dpm_active right before the suspend, by really
> > > > traversing the device tree, when we own all device semaphores and no device
> > > > objects can be added/removed?
> > > 
> > > We're doing okay the way things are.  Changing the order is more likely
> > > to cause new problems than to solve existing ones.
> > 
> > Well, my idea is not to change the order, but to create the list from scratch
> > when we need it and not in advance, because creating the list in advance
> > causes problems to appear.
> 
> Doing it that way will almost certainly result in a different order 
> from the one we have now.

Yes, but wouldn't that order be more accurate?

> And it won't help the EHCI issue, because there the question is which of
> several siblings should come last. 

Why not?  If the device can indicate something like "place me after that one"
to the code creating the list, we can handle that too. 

> > In fact, if the system is never suspended, the list that we create is not even
> > useful for anything.
> 
> True.  But it doesn't take up much space, especially if PM isn't 
> configured.  And creating the list doesn't take much time.

Sure.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
