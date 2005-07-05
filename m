From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci:
	restore BAR values in pci_enable_device_bars
Date: Tue, 5 Jul 2005 13:46:20 -0400
Message-ID: <20050705174617.GB21933@tuxdriver.com>
References: <20050623191451.GA20572@tuxdriver.com>
	<20050624022807.GF28077@tuxdriver.com>
	<20050630171010.GD11369@kroah.com>
	<20050701014056.GA13710@tuxdriver.com>
	<20050701022634.GA5629.1@tuxdriver.com>
	<20050702072954.GA14091@colo.lackof.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============42852841341316239=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050702072954.GA14091@colo.lackof.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-pm <linux-pm@lists.osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============42852841341316239==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 02, 2005 at 01:29:54AM -0600, Grant Grundler wrote:
> On Thu, Jun 30, 2005 at 10:26:37PM -0400, John W. Linville wrote:

> > +	/* Some devices lose PCI config header data during D3hot->D0
> 
> Can you name some of those devices here?
> I just want to know what sort of devices need to be tested 
> if this code changes in the future.

I don't really have a list.  The devices that brought this issue to
my attention are a 3c905B and a 3c556B, both covered by the 3c59x
driver.

According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT INTERFACE
SPECIFICATION, REV. 1.2", a device transitioning from D3hot to D0
_may_ perform an internal reset, thereby going to "D0 Uninitialized"
rather than "D0 Initialized".  Since this behaviour is ratified by
the spec, I think we need to accomodate it.

A bit in the PMCSR register indicates how a device will behave in
this regard.  We could have a test to only execute the BAR restoration
for those devices that seem to need it.  I left that out because it
seemed to add needless complexity.  In the meantime the patch has
gotten bigger and more complex, so maybe that code doesn't make it
any worse.  Do you want me to add that?

> 
> > +	   transition.	Since some firmware leaves devices in D3hot
> > +	   state at boot, this information needs to be restored.
> 
> Again, which firmware?
> Examples are good since it makes it possible to track down
> the offending devices for testing.

The Thinkpad T21 does this.  I don't know of any others specifically,
but it seems like something laptop BIOSes would be likely to do.

> The following chunk looks like it will have issues with 64-bit BARs:

As RMK pointed-out, this code is inspired by setup-res.c; specifically
that in pci_update_resource.  I'd prefer not to blaze any new trails
regarding 64-bit BAR support ATM... :-)

So, is the current patch acceptable?  Or shall I add the check for the
"no soft reset" bit in the PMCSR register?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com

--===============42852841341316239==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============42852841341316239==--
