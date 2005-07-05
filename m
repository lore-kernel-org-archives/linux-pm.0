From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci:
	restore BAR values in pci_enable_device_bars
Date: Tue, 5 Jul 2005 21:05:55 +0100
Message-ID: <20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk>
References: <20050623191451.GA20572@tuxdriver.com>
	<20050624022807.GF28077@tuxdriver.com>
	<20050630171010.GD11369@kroah.com>
	<20050701014056.GA13710@tuxdriver.com>
	<20050701022634.GA5629.1@tuxdriver.com>
	<20050702072954.GA14091@colo.lackof.org>
	<20050702090913.B1506@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41165540560696323=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050702090913.B1506@flint.arm.linux.org.uk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Grant Grundler <grundler@parisc-linux.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============41165540560696323==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 02, 2005 at 09:09:13AM +0100, Russell King wrote:
> The PCI subsystem is incomplete for 64-bit BAR support.  What it does
> do though is ensure that 64-bit BARs will work correctly in a 32-bit
> system.  Therefore, I think that folk who want 64-bit BAR support to
> work need to do some code reviews on the PCI subsystem to resolve the
> remaining issues.

64-bit BARs work fine on 64-bit machines.  I'm ambivalent whether we
ought to support 64-bit BARs on 32-bit machines.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

--===============41165540560696323==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41165540560696323==--
