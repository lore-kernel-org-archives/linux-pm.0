From: David Brownell <david-b@pacbell.net>
Subject: Re: Platform-specific system power states
Date: Fri, 22 Jun 2007 12:49:28 -0700
Message-ID: <200706221249.29068.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0706211635450.2553-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706211635450.2553-100000@iolanthe.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 21 June 2007, Alan Stern wrote:
> 
> I'd be perfectly happy to have the list of supported system power 
> states be exported by the platform code instead of predetermined by the 
> PM core.  It would still be necessary to add a method whereby the PM 
> core could inform the platform about the new target state at the 
> beginning of a state change.  And of course there would have to be a 
> way for drivers or subsystems to query the platform, to see what 
> resources would be available.

Rafael will propose the new method, I guess; and as for querying,
the many power-related resources involved would seem to be clocks
and power domains.  ACPI has an internal notion of the latter, but
skips the former.  You've seen my proposal for what seems to be
sufficient in the case of clocks.  (And one of these days I'm sure
I'll push it upstream.  After that new method lands, to replace
the now-missing functionality...)


> > > Perhaps something like this: Resource providers have an API whereby
> > > drivers can find out what resources either are currently available or
> > > will be available in the next system state (a little awkward to specify
> > > which is needed).  Then drivers decide on a new device state based on
> > > the type of change requested and the available resources, and notify
> > > the providers via a second API about any change in resource usage.
> > 
> > Resource providers have interfaces (*) they expose; yes.  *IF* those
> > resources change availability based on system states, there must be
> > interfaces drivers can use to notice that.  The providers already have
> > interfaces to manage resources, and won't need new cals for that. 
> > 
> > The calls to expose whether a given in-use resource must be released
> > or modified would be simplest if they're just query calls made by
> > driver suspend()/resume() methods, but there's also something to be
> > said for callbacks in certain contexts.
> 
> I'm not sure how the callback approach would work.

One old example comes from early "DPM" support.  When a system's
base clock rate changes, derived clocks may need to change.  When
that involves for example a USART clock, the external bit rate
must remain the same ... which means adjusting dividers.  In fact
it might even mean needing to reject proposed clock rate changes,
if they can't support the necessary frequency.


> Fortunately so far 
> none of this has been needed in USB programming; only the host
> controllers (PCI and non-PCI each in their own ways) have to worry
> about it.  That might change in a more generalized setting; conceivably 
> there could be multiple system power states in which USB devices are 
> allowed to run.  Then the platform would need an interface to tell the 
> USB subsystem whether the devices must be suspended in the new state.

The usual situation with USB is there are two modes other than
"fully operational".  One is where everything's suspended but
the USB functional clock is available.  (Maybe the register
interface isn't clocked though.)  The other is where that clock
isn't available.  In some cases that implies controller reset.
In other cases it doesn't; and if it doesn't, potentially the
key power session state can be maintained with help from the
PHY ... and, on the host side, something supplying VBUS.


> > (*) "API" == "Application Programming Interface", a userspace thing.
> >     So I avoid using that TLA for anything inside the OS kernel.
> 
> Strong agreement -- I abhor the term "API".  I use it because it is so 
> convenient; "interface" is much longer and is overloaded with other 
> meanings.

I recall Sun talking lots about a "Device Driver Interface" or DDI.
Presumably there are other names for such stuff.  I'm not sure any
better acronym could catch on.  ;)

 
> When you come down to it, "Application" is itself short for 
> "Application Program" which AFAIK originated in Apple (that could 
> easily be wrong).

I'm quite certain that terminology predates Apple by many decades!


> But it is used to mean _any_ program, application or  
> otherwise, and as such it is a misnomer.  Strictly speaking, utility 
> programs aren't applications -- they are utilities.  Same goes for 
> system management programs and other categories.  Remember MS-DOS and 
> TSRs?  Or the old Mac OS and desk accessories?
> 
> So if a user library has an API, does that mean the library can't be 
> used by utilities or other non-application programs?  :-)

Well, from the perspective of hardware *all* software is "application". :)

- Dave


 
