From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Platform-specific system power states
Date: Fri, 22 Jun 2007 21:32:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706222130440.11186-100000@netrider.rowland.org>
References: <200706222330.35829.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706222330.35829.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 22 Jun 2007, Rafael J. Wysocki wrote:

> On Friday, 22 June 2007 21:49, David Brownell wrote:
> > On Thursday 21 June 2007, Alan Stern wrote:
> > > 
> > > I'd be perfectly happy to have the list of supported system power 
> > > states be exported by the platform code instead of predetermined by the 
> > > PM core.  It would still be necessary to add a method whereby the PM 
> > > core could inform the platform about the new target state at the 
> > > beginning of a state change.  And of course there would have to be a 
> > > way for drivers or subsystems to query the platform, to see what 
> > > resources would be available.
> > 
> > Rafael will propose the new method, I guess;
> 
> Yes, I will.
> 
> Still, for now, I'm going to make it take an integer argument equal to either
> PM_SUSPEND_STANDBY or PM_SUSPEND_MEM, since these are the only two sleep states
> known to the core right now.
> 
> I think, however, that in the long run the better solution would be to make
> the platform tell the PM core, during the initialization, what system sleep
> states are available.  Then, before the transition, the PM core will tell the
> platform which state is the target one.  IMO for this purpose the sleep will
> need to be identified in a universal way and perhaps it's a good idea to
> discuss that for a while. ;-)

A good way to identify a sleep state would be a pointer to a string 
containing the state's name.  The PM core could use these pointers to 
export the states in sysfs.

Alan Stern
