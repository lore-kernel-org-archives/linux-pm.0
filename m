From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci:
	restore BAR values in pci_enable_device_bars
Date: Thu, 7 Jul 2005 20:57:04 -0400
Message-ID: <20050708005701.GA13384@tuxdriver.com>
References: <20050623191451.GA20572@tuxdriver.com>
	<20050624022807.GF28077@tuxdriver.com>
	<20050630171010.GD11369@kroah.com>
	<20050701014056.GA13710@tuxdriver.com>
	<20050701022634.GA5629.1@tuxdriver.com>
	<20050702072954.GA14091@colo.lackof.org>
	<20050702090913.B1506@flint.arm.linux.org.uk>
	<20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk>
	<20050705224620.B15292@flint.arm.linux.org.uk>
	<20050706033454.A706@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26006928893476422=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050706033454.A706@den.park.msu.ru>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Grant Grundler <grundler@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============26006928893476422==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 06, 2005 at 03:34:54AM +0400, Ivan Kokshaysky wrote:
> On Tue, Jul 05, 2005 at 10:46:20PM +0100, Russell King wrote:

> > Rather than reimplementing the internals of pci_update_resource() it
> > may be worth splitting the common stuff out so it gets fixed for both
> > pci_update_resource() and pci_enable_device().
> 
> Just use pci_update_resource().
 
Problem: pci_update_resource doesn't exist for sparc64.

> John, I'd also suggest following changes to the patch:
> - move the code to pci_set_power_state(), where it belongs to;
> - explicitly check for D3hot->D0 transition *and* for the
>   No_Soft_Reset bit, to avoid unnecessary config space accesses;
> - add a quote from PCI spec (as a comment) explaining why is it needed.

I have reformulated the patch to account for these comments, but I am
not currently using pci_update_resource for the reason stated above.
I'll go ahead and post the new patch for comment.  If we can resolve
the pci_update_resource issue, I'll post another (either alternative
or additional) patch to cover that.  Patch to follow...

Thanks!

John
-- 
John W. Linville
linville@tuxdriver.com

--===============26006928893476422==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26006928893476422==--
