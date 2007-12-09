From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: parallel suspend/resume
Date: Sun, 9 Dec 2007 10:31:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712091025310.1600-100000@netrider.rowland.org>
References: <200712091423.55174.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712091423.55174.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 9 Dec 2007, Oliver Neukum wrote:

> Am Samstag, 8. Dezember 2007 16:43:25 schrieb Alan Stern:
> > On Sat, 8 Dec 2007, Oliver Neukum wrote:
> > 
> > > Am Freitag, 7. Dezember 2007 19:01:12 schrieb David Brownell:
> > > > FWIW the appended patch removes that rude "order of registration"
> > > > policy, so that the suspend/resume list matches the device tree.
> > > > It's behaved OK on PCs and, in light duty, a few development boards;
> > > > I've carried it around most of this year.
> > > 
> > > As it is a tree, why not store it as such?
> > 
> > There's no need to "store" the tree ordering specially, since all the
> > pointers already exist.  The question is: In what order should the tree
> 
> Nevertheless, we currently have a list. Why? To reverse the temporal order
> only?

As far as I know, yes.  Maybe also to simplify the traversal; it takes 
less code to follow a list than to go through a tree.

> > be traversed?  About the only explicit constraint we have now is that
> > children must be suspended before their parents, but there undoubtedly
> > are plenty of undocumented implicit constraints (maybe some of them
> > aren't known to anybody at all).
> 
> We will need to know them for runtime pm.

Maybe.  But that knowledge will be localized in drivers and not 
consolidated in the PM core, since that's where runtime PM is handled.  
What we don't have is any way for drivers to export the knowledge.

> > Given the vast number of possible orders, and given that the only order 
> > we _know_ works correctly is reverse order of registration, I don't see 
> 
> modus advocati diaboli:
> 
> Suppose I have a system with a FibreChannel disk. Now I hot plug another
> FibreChannel controller and connect it to the disk. Then I disconnect the disk
> from the original controller. What will happen if I suspend the system?

That seems a little strange.  What happens during the intermediate
stage when you have a single disk connected to the computer by two I/O
pathways?  Will the OS think it is really two disks?  Will it get
confused by seeing on-disk data structures in unstable incomplete
states and subject to apparently random updates?

A better question is what happens when a Bluetooth communications
driver creates a new tty device and then uses device_move() to put the
Bluetooth device under the newer tty.  Will the tty get suspended
before its Bluetooth child?

Alan Stern
