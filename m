From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from
	pci_set_power_state for D3hot->D0
Date: Mon, 11 Jul 2005 09:15:22 -0400
Message-ID: <20050711131518.GB23093@tuxdriver.com>
References: <20050708095104.A612@den.park.msu.ru>
	<20050707.233530.85417983.davem@davemloft.net>
	<20050708110358.A8491@jurassic.park.msu.ru>
	<20050708.003333.28789082.davem@davemloft.net>
	<20050708122043.A8779@jurassic.park.msu.ru>
	<20050708183452.GB13445@tuxdriver.com>
	<20050711144844.A16143@tin.liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67883620085645524=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050711144844.A16143@tin.liacs.nl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Lennert Buytenhek <buytenh+lkml@liacs.nl>
Cc: rmk+lkml@arm.linux.org.uk, grundler@parisc-linux.org, matthew@wil.cx, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, herbertb@cs.vu.nl, "David S. Miller" <davem@davemloft.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-pci@atrey.karlin.mff.cuni.cz, byjac@matfyz.cz
List-Id: linux-pm@vger.kernel.org

--===============67883620085645524==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 11, 2005 at 02:48:44PM +0200, Lennert Buytenhek wrote:
> On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:
> 
> > Some PCI devices lose all configuration (including BARs) when
> > transitioning from D3hot->D0.  This leaves such a device in an
> > inaccessible state.  The patch below causes the BARs to be restored
> > when enabling such a device, so that its driver will be able to
> > access it.
> 
> It might be useful to have this functionality exported to outside of
> the generic PCI code.

Fine by me...patch to follow...

John
-- 
John W. Linville
linville@tuxdriver.com

--===============67883620085645524==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67883620085645524==--
