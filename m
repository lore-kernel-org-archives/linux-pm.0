From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Platform-specific system power states
Date: Tue, 26 Jun 2007 01:04:57 +0200
Message-ID: <200706260104.58266.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706211635450.2553-100000@iolanthe.rowland.org>
	<200706222330.35829.rjw@sisk.pl>
	<200706241726.21206.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706241726.21206.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, 25 June 2007 02:26, David Brownell wrote:
> On Friday 22 June 2007, Rafael J. Wysocki wrote:
> > On Friday, 22 June 2007 21:49, David Brownell wrote:
> 
> > > and as for querying, the many power-related resources involved would seem to
> > > be clocks and power domains.  ACPI has an internal notion of the latter, but 
> > > skips the former.  You've seen my proposal for what seems to be sufficient in
> > > the case of clocks.  (And one of these days I'm sure I'll push it upstream.
> > > After that new method lands, to replace the now-missing functionality...)
> > 
> > In fact the ACPI spec regards clock sources as power resources.  More
> > precisely, it defines a power resource as "resources (for example, power planes
> > and clock sources) that a device requires to operate in a given power state"
> > (Section 2.1 in the 3.0b spec).  Perhaps we also could use a general notion of
> > "power resource" in a similar fashion?
> 
> The problem with claiming that ACPI has a notion of clocks is that it
> doesn't have any clock-like semantics.  Like getting/setting rates,
> reparenting, and so forth ... everything the clk_*() interfaces do.
> At best it has "stuff that can be enabled/disabled".

I think the idea in the spec is similar to how fans are treated by ACPI (they
can only be 'on' or 'off' and if you have one fan with two speeds, you need to
define two 'logical fans' to describe the physical one etc.).


> Related:  Linux doesn't even expose the limited notion of power resource
> that ACPI packages.  And, as shown by some comments on one patch I posted,
> even that notion needs work before it behaves.  ISTR the issue was that
> the ACPI power methods apply to PCI functions, but the resources applied
> to PCI devices.  So in the absense of refcounting, powering down one
> function would surprisingly enough power them all down... absolutely
> contrary to the intent of powering down just that function.
> 
> There's probably some generalizable notion lurking there, but clearly it's
> not cooked in today's Linux ACPI stack.

Agreed.

> And suffice it to say that I've seen work with such "general notions"
> blow up so regularly (the basic crime being loss of contact with real
> world problems, leading to useless code bloat) that my first reaction
> is almost always "no, don't generalize yet, solve some problems first".
> 
> Hence my ongoing belief that we need voltage abstractions (both producer
> and consumer) resembling the current clock abstraction, before we start
> to think about grouping the two under some umbrella.

Still, we'd need to take the ACPIish way of treating power resources into
consideration somehow.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
