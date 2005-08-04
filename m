From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Toward runtime power management in Linux
Date: Thu, 04 Aug 2005 20:24:02 +0300
Message-ID: <1123176243.23489.24.camel@localhost>
References: <Pine.LNX.4.44L0.0508010935440.4961-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============025955124322503575=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0508010935440.4961-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============025955124322503575==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-08-01 at 10:07 -0400, ext Alan Stern wrote:

[snip]

> Furthermore, there's a trade-off between doing a bunch of chores all at 
> once (i.e., have a kernel thread scan a list of devices to see which have 
> exceeded their idle timeouts) and distributing those chores piecemeal 
> (i.e., have each driver reschedule an idle timer every time one of its 
> devices carries out some activity).  In the absence of actual measurements 
> it's impossible to know which will affect performance more -- and in fact 
> the effects are likely to be highly variable, depending on workload.

Especially in embedded systems also the technology used for the silicon
is going to affect the decision, not only the balance between cpu load
and i/o load: according to the energy spent just for having the system
active, the choice might move between "all at once" and "split timewise"
because of the possible cost in terms of ramp-up and ramp-down.

> 
> As for your "if nothing is happening, nothing should be running" mantra, 
> it runs counter to the very idea of runtime PM.  If nothing is happening, 
> the system should wait until enough idle time has gone past, and then it 
> should actively turn off power to devices that don't need it.  That's very 
> different from running nothing!
I think that this depends on which is the desired behaviour and how
quickly some specific hw can react to requests for drastic shifts in
power states.
Idling implies trying to avoid a ramp-down & ramp-up sequence because of
an impending activity that will see the sequence as an overhead. 
It depends also how much of this on/off switching can be demanded to
dedicated hw and how much must be sw controlled.

> 
> 
> > > Userspace support: It's easy to see how userspace could use sysfs to
> > > request a single device state change.  But what if the user wants to
> > > suspend an entire subtree?  [ ... ]
> > 
> > 	If you wanted to get really fancy, you could establish via a
> > userspace API a named "device collection" which acts as a virtual device.
> > You then apply the state change to the device collection, and the kernel
> > percolates it through all the actual devices, taking locking into account.
> 
> I suspect that's fancier than we need, although perhaps it would come in 
> handy in special circumstances.  For now, it should be good enough to 
> restrict such "device collections" to be subtrees of the device tree.
> 
> Alan Stern
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm

Igor Stoppa, Nokia M / Tampere Finland

--===============025955124322503575==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============025955124322503575==--
