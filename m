From: Alan Stern <stern@rowland.harvard.edu>
Subject: Platform-specific system power states
Date: Thu, 21 Jun 2007 17:00:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706211635450.2553-100000@iolanthe.rowland.org>
References: <200706211251.52952.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706211251.52952.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

[Note change of Subject and CC: list restriction]

On Thu, 21 Jun 2007, David Brownell wrote:

> That is, the knowledge of that target sleep state never leaves
> that platform's PM code.  (In this case, ACPI; including its PCI
> support, which lives in drivers/pci not drivers/acpi.)  Because
> no subsystem other than ACPI itself should care how ACPI does any
> of its PM stuff.

> > I agree that the list of system states should be configurable and 
> > perhaps even adjustable at runtime.  However this is somewhat OT.
> 
> Only slightly; remember, a main reason Linux has so few states is
> that PCs don't use any more.  There are a number of PC-specific
> models and assumptions lurking in this area.  One of them is that
> the target sleep state is anything more than a stepping-stone to
> the important platform-specific information.

I'd be perfectly happy to have the list of supported system power 
states be exported by the platform code instead of predetermined by the 
PM core.  It would still be necessary to add a method whereby the PM 
core could inform the platform about the new target state at the 
beginning of a state change.  And of course there would have to be a 
way for drivers or subsystems to query the platform, to see what 
resources would be available.


> > Perhaps something like this: Resource providers have an API whereby
> > drivers can find out what resources either are currently available or
> > will be available in the next system state (a little awkward to specify
> > which is needed).  Then drivers decide on a new device state based on
> > the type of change requested and the available resources, and notify
> > the providers via a second API about any change in resource usage.
> 
> Resource providers have interfaces (*) they expose; yes.  *IF* those
> resources change availability based on system states, there must be
> interfaces drivers can use to notice that.  The providers already have
> interfaces to manage resources, and won't need new cals for that. 
> 
> The calls to expose whether a given in-use resource must be released
> or modified would be simplest if they're just query calls made by
> driver suspend()/resume() methods, but there's also something to be
> said for callbacks in certain contexts.

I'm not sure how the callback approach would work.  Fortunately so far
none of this has been needed in USB programming; only the host
controllers (PCI and non-PCI each in their own ways) have to worry
about it.  That might change in a more generalized setting; conceivably 
there could be multiple system power states in which USB devices are 
allowed to run.  Then the platform would need an interface to tell the 
USB subsystem whether the devices must be suspended in the new state.


> (*) "API" == "Application Programming Interface", a userspace thing.
>     So I avoid using that TLA for anything inside the OS kernel.

Strong agreement -- I abhor the term "API".  I use it because it is so 
convenient; "interface" is much longer and is overloaded with other 
meanings.

When you come down to it, "Application" is itself short for 
"Application Program" which AFAIK originated in Apple (that could 
easily be wrong).  But it is used to mean _any_ program, application or 
otherwise, and as such it is a misnomer.  Strictly speaking, utility 
programs aren't applications -- they are utilities.  Same goes for 
system management programs and other categories.  Remember MS-DOS and 
TSRs?  Or the old Mac OS and desk accessories?

So if a user library has an API, does that mean the library can't be 
used by utilities or other non-application programs?  :-)

Alan Stern
