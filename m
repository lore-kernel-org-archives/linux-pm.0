From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFD] How to tell ACPI drivers what the target
	sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 22:37:27 +0200
Message-ID: <200706212237.28305.rjw__14586.6608633243$1182457902$gmane$org@sisk.pl>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
	<20070621185910.GH18481@elf.ucw.cz>
	<200706211303.25004.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706211303.25004.david-b@pacbell.net>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 21 June 2007 22:03, David Brownell wrote:
> On Thursday 21 June 2007, Pavel Machek wrote:
> > Hi!
> > 
> > > > > IMO it can be done in two different ways:
> > > > > 1) via a .suspend() argument
> > > > > 2) via a global variable that the drivers can read.
> > > 
> > > For sufficiently small values of "two" that is.  
> > > 
> > > Other solutions that have been described on the PM list include
> > > 
> > >   3) Providing accessors to the information actually needed
> > >      in drivers ... e.g. say whether this clock or power domain
> > >      will be available in that target state.
> > > 
> > >   4) Act more like "current" ... there's a function returning
> > >      whatever "state" struct is settled on.  (But ideally
> > >      without the pseudo-global.)
> > > 
> > > I'm amused that nobody really reacted to the technical comments in
> > > my previous posts on this thread.  That's unfortunate, since from
> > > where I sit it feels to me like everyone else is a johnny-come-lately
> > > on this issue, and is now grasping at the quickest and dirtiest ways
> > > to work around the issue instead of coming to grasp with the various
> > > underlying issues.
> > 
> > Well, rest of the word is still using PC here, so johny-come-lately
> > may not be completely unexpected.
> 
> True.  I could hardly escape noticing this problem though, given
> what it takes to get USB remote wakeup working on various systems.
> We've had a few years now to get that infrastructure in place.
> 
> 
> > Could you push framework for some embedded system you care about? OLPC
> > by chance?
> 
> I'll probably push those two patches (clock core, AT91 implementation)
> since there seemed to be no objections.  I don't work on OLPC.  :)
> 
> 
> > > IMO #3 is strongly preferable.
> > 
> > 3) actually looks ok to me. For acpi it would mean
> > 
> > int acpi_state_we_are_entering(void)
> > 
> > returning S1..S4, right?
> 
> My original patch included acpi_get_target_sleep_state()
> returning ACPI_STATE_Sx values, yes.  However, that was
> purely internal to ACPI-aware logic ... it was used to
> implement pci_choose_state().
> 
> Drivers would never make such ACPI calls themselves, they'd
> use pci_choose_state() instead.
> 
> 
> And the clk_must_disable() call is another instance of the
> same approach as pci_choose_state():  drivers getting access
> to the PM-reated information they need, without needing to
> use platform-specific calls or care about "what the target
> sleep state is".
> 
>  
> > > But I really thought the discussion on new PM methods, back a
> > > couple months now, was going to finally get rid of that.
> > 
> > Umm, well, when someone gets to implement that...
> 
> Oh.  *THAT* little problem.  Sorry, I thought it was in the works.

In fact it is, but I had no time to complete it yet.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
