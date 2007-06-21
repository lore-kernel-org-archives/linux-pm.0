From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 22:41:31 +0200
Message-ID: <200706212241.32704.rjw__36855.7133399465$1182458233$gmane$org@sisk.pl>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
	<200706212204.36999.rjw@sisk.pl>
	<200706211322.06557.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706211322.06557.david-b@pacbell.net>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 21 June 2007 22:22, David Brownell wrote:
> On Thursday 21 June 2007, Rafael J. Wysocki wrote:
> > On Thursday, 21 June 2007 16:48, David Brownell wrote:
> 
> > > They really don't care what the state is.  The $SUBJECT patch isn't
> > > driver code ... it's for platform hooks that expose attributes to
> > > the drivers.  Specifically, it's ACPI code, talking to drivers that
> > > must run on non-ACPI systems.  Any driver that thinks it needs to
> > > understand anything about ACPI states is sadly broken.
> > 
> > But finally it has to place the device into a specific state and that state
> > needs to be determined somehow. 
> 
> I suppose I'm still thinking that the approach in my original
> patch works Just Fine.  Layering is kind of like this, going
> from top to bottom (and omitting the go-to-pci-hardware stack,
> and the initial ACPI pm hook before suspension starts):

We're missing that hook right now. ;-)

> 	PM infrastructure ... calling suspend() for everything
> 
> 	PCI bus support ... translates to PCI-specific typed call
> 
> 	PCI driver ... suspend() calling pci_choose_state()
> 
> 	ACPI support for PCI ... implementing choose_state()
> 
> 	ACPI core code ... remembering ACPI_STATE_Sx, calling AML
> 
> That is, ACPI gets invoked at various points, but the driver and
> core code doesn't need to know ACPI from Rumpelstiltskin.

I agree with that, but we need to add a mechanism to tell the ACPI core
what it needs to know (ie. the target system sleep state) before we suspend
devices or while we are suspending them.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
