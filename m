From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci:
	restore BAR values in pci_enable_device_bars
Date: Sat, 2 Jul 2005 09:09:13 +0100
Message-ID: <20050702090913.B1506@flint.arm.linux.org.uk>
References: <20050623191451.GA20572@tuxdriver.com>
	<20050624022807.GF28077@tuxdriver.com>
	<20050630171010.GD11369@kroah.com>
	<20050701014056.GA13710@tuxdriver.com>
	<20050701022634.GA5629.1@tuxdriver.com>
	<20050702072954.GA14091@colo.lackof.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65913739031736451=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050702072954.GA14091@colo.lackof.org>;
	from grundler@parisc-linux.org on Sat, Jul 02, 2005 at 01:29:54AM
	-0600
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
Cc: linux-pm <linux-pm@lists.osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============65913739031736451==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 02, 2005 at 01:29:54AM -0600, Grant Grundler wrote:
> On Thu, Jun 30, 2005 at 10:26:37PM -0400, John W. Linville wrote:
> ...
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -378,9 +378,56 @@ pci_restore_state(struct pci_dev *dev)
> >  int
> >  pci_enable_device_bars(struct pci_dev *dev, int bars)
> >  {
> > -	int err;
> > +	int i, numres, err;
> >  
> >  	pci_set_power_state(dev, PCI_D0);
> > +
> > +	/* Some devices lose PCI config header data during D3hot->D0
> 
> Can you name some of those devices here?
> I just want to know what sort of devices need to be tested 
> if this code changes in the future.
> 
> > +	   transition.	Since some firmware leaves devices in D3hot
> > +	   state at boot, this information needs to be restored.
> 
> Again, which firmware?
> Examples are good since it makes it possible to track down
> the offending devices for testing.
> 
> The following chunk looks like it will have issues with 64-bit BARs:
> ...
> > +	for (i = 0; i < numres; i ++) {
> > +		struct pci_bus_region region;
> > +		u32 val;
> > +		int reg;
> ...
> > +		val = region.start
> > +		    | (dev->resource[i].flags & PCI_REGION_FLAG_MASK);
> > +
> > +		reg = PCI_BASE_ADDRESS_0 + (i * 4);
> 
> ISTR dev->resource[i] doesn't necessarily correspond directly BAR[i].
> If BAR0 is a 64-bit BAR, then dev->resource[1] will point at BAR2.

That's contary to the assumptions made by setup-res.c.  BAR0 is
dev->resource[0].  If that resource is 64-bit, dev->resource[1]
is unused and the next resource is dev->resource[2].

> > +		pci_write_config_dword(dev, reg, val);
> > +
> > +		if ((val & (PCI_BASE_ADDRESS_SPACE
> > +		          | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
> > +		 == (PCI_BASE_ADDRESS_SPACE_MEMORY
> > +		   | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
> > +			pci_write_config_dword(dev, reg + 4, 0);
> 
> 64-bit BARs need the upper half of dev->resource[] written.
> I expect something like:
> 		val = region.start >> 4;

Are you sure you mean >> 4 ?  Don't you mean >> 32 ?  Note again that
setup-res.c writes zero unconditionally here.

The PCI subsystem is incomplete for 64-bit BAR support.  What it does
do though is ensure that 64-bit BARs will work correctly in a 32-bit
system.  Therefore, I think that folk who want 64-bit BAR support to
work need to do some code reviews on the PCI subsystem to resolve the
remaining issues.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

--===============65913739031736451==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65913739031736451==--
