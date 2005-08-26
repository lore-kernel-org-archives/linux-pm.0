From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Toward runtime power management in Linux
Date: Thu, 25 Aug 2005 22:25:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508252201430.6761-100000@netrider.rowland.org>
References: <1125006155.12538.21.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7286308088945681=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1125006155.12538.21.camel@gaston>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============7286308088945681==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 26 Aug 2005, Benjamin Herrenschmidt wrote:

> On Thu, 2005-08-25 at 11:27 -0400, Alan Stern wrote:
> 
> > But it complicates the structure of drivers by forcing them to use a
> > state-machine approach with a bunch of tedious intermediate states ("link
> > change request issued, waiting for notification").  
> 
> Not necessarily. The driver could do synchronous blocking wait if it's
> not running inside the context of the iterator thread which won't be the
> case most of the time.

I was talking specifically about the part of the driver that _does_ run in
the context of the iterator thread.  Your plan makes that part more
complex than it would be otherwise.


> > It also introduces
> > complications from the possible arrival of several change requests or
> > notifications at once, since there's no locking to guarantee mutual
> > exclusion among them.
> 
> Who else but the driver is allowed to request a link state change on the
> device ?

A driver for a child device is allowed to.  (I.e., it's allowed to request
a state change on a downward-going link.)  And in addition to the
link-state changes, the user (through sysfs) is allowed to request a 
power-state change.

>  That specific race can be dealt with or considered as a
> programming error.

Not at all.  I can easily imagine a situation where two child devices try
to send link-change notifications to their common parent at the same time,
or where two user processes try to initiate a power change simultaneously.  
The proper way to handle such things is by mutual exclusion -- locking.


> > 	Device removal racing with power state changes.  During device
> > 	removal the PM lock should be held; this will prevent the two
> > 	operations from overlapping.  You might end up trying to carry
> > 	out a power-state change on an already-removed device; that's
> > 	not a problem -- it will simply fail.
> 
> Those locks are a wonderful deadlock scenario as soon as the driver end
> up triggering add/remove events while they are held and that does
> happen. I'm really not fan of those global and/or cascaded locks, I find
> the approach very deadlock prone.

There's no question that these locks are easy to misuse.  With care I
believe it can be done correctly.  As for the power-change code triggering
add/remove events -- that's a problem we will have to deal with no matter
what.  Avoiding locks won't make it any easier to solve the problem
correctly, although it may make the consequences of an incorrect
solution less obvious!

Ultimately we may be forced to handle these add/remove events in a
different thread from the one doing the power changes.  For instance, say
a child tells its parent that it wants to wake up.  The parent is also
suspended, so the parent has to resume before returning to the child.  
During the resume, the parent detects that some other children have gone
away, or new ones have appeared.  I don't think there's any way to handle
these events in the power-change thread.  Any scheme for doing so will be 
subject to races.

Alan Stern


--===============7286308088945681==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============7286308088945681==--
