From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Platform-specific system power states
Date: Fri, 22 Jun 2007 23:30:35 +0200
Message-ID: <200706222330.35829.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706211635450.2553-100000@iolanthe.rowland.org>
	<200706221249.29068.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706221249.29068.david-b@pacbell.net>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 22 June 2007 21:49, David Brownell wrote:
> On Thursday 21 June 2007, Alan Stern wrote:
> > 
> > I'd be perfectly happy to have the list of supported system power 
> > states be exported by the platform code instead of predetermined by the 
> > PM core.  It would still be necessary to add a method whereby the PM 
> > core could inform the platform about the new target state at the 
> > beginning of a state change.  And of course there would have to be a 
> > way for drivers or subsystems to query the platform, to see what 
> > resources would be available.
> 
> Rafael will propose the new method, I guess;

Yes, I will.

Still, for now, I'm going to make it take an integer argument equal to either
PM_SUSPEND_STANDBY or PM_SUSPEND_MEM, since these are the only two sleep states
known to the core right now.

I think, however, that in the long run the better solution would be to make
the platform tell the PM core, during the initialization, what system sleep
states are available.  Then, before the transition, the PM core will tell the
platform which state is the target one.  IMO for this purpose the sleep will
need to be identified in a universal way and perhaps it's a good idea to
discuss that for a while. ;-)

> and as for querying, the many power-related resources involved would seem to
> be clocks and power domains.  ACPI has an internal notion of the latter, but 
> skips the former.  You've seen my proposal for what seems to be sufficient in
> the case of clocks.  (And one of these days I'm sure I'll push it upstream.
> After that new method lands, to replace the now-missing functionality...)

In fact the ACPI spec regards clock sources as power resources.  More
precisely, it defines a power resource as "resources (for example, power planes
and clock sources) that a device requires to operate in a given power state"
(Section 2.1 in the 3.0b spec).  Perhaps we also could use a general notion of
"power resource" in a similar fashion?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
