From: Lennert Buytenhek <buytenh+lkml@liacs.nl>
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from
	pci_set_power_state for D3hot->D0
Date: Mon, 11 Jul 2005 14:48:44 +0200
Message-ID: <20050711144844.A16143@tin.liacs.nl>
References: <20050708095104.A612@den.park.msu.ru>
	<20050707.233530.85417983.davem@davemloft.net>
	<20050708110358.A8491@jurassic.park.msu.ru>
	<20050708.003333.28789082.davem@davemloft.net>
	<20050708122043.A8779@jurassic.park.msu.ru>
	<20050708183452.GB13445@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6536865598872903=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050708183452.GB13445@tuxdriver.com>;
	from linville@tuxdriver.com on Fri, Jul 08, 2005 at 02:34:56PM
	-0400
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk, matthew@wil.cx, grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com, ambx1@neo.rr.com
Cc: herbertb@cs.vu.nl, byjac@matfyz.cz
List-Id: linux-pm@vger.kernel.org

--===============6536865598872903==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:

> Some PCI devices lose all configuration (including BARs) when
> transitioning from D3hot->D0.  This leaves such a device in an
> inaccessible state.  The patch below causes the BARs to be restored
> when enabling such a device, so that its driver will be able to
> access it.

It might be useful to have this functionality exported to outside of
the generic PCI code.

There are a number of PCI boards that have their reset logic wired
up wrong and lose their config space info (BARs) when you reset them.
The Radisys ENP2611 PCI board is a good example -- it has its reset
logic wired in such a way that if you reset the (ARM-based) CPU on
the board, it also causes the 21555 nontransparent PCI bridge on the
board to be reset, which makes it lose all its primary config space
info (BARs, etc.)  The IXP1200 CPU-based PCI cards (now obsolete)
used to suffer from the same issue.

This is currently worked around in the driver, which caches all BAR
values when the module is first loaded, and detects when the card is
reset and then writes back all BARs manually.


--L

--===============6536865598872903==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============6536865598872903==--
