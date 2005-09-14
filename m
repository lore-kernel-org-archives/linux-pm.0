From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 2.6.14-rc1] pci: only call pci_restore_bars
	at boot
Date: Wed, 14 Sep 2005 12:47:44 -0400
Message-ID: <20050914164742.GD16667@tuxdriver.com>
References: <09142005095242.32027@bilbo.tuxdriver.com>
	<43283CDC.3070603@pobox.com>
	<20050914.092650.99910742.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17850503164632947=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050914.092650.99910742.davem@davemloft.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, kaos@sgi.com, rmk+lkml@arm.linux.org.uk, grundler@parisc-linux.org, matthew@wil.cx, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, ink@jurassic.park.msu.ru, linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com
List-Id: linux-pm@vger.kernel.org

--===============17850503164632947==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 14, 2005 at 09:26:50AM -0700, David S. Miller wrote:
> From: Jeff Garzik <jgarzik@pobox.com>
> Date: Wed, 14 Sep 2005 11:08:12 -0400
> 
> > This seems like it will break a lot of stuff that -does- need the BARs 
> > restored when resuming from D3.
> 
> I wasn't going to say anything about this ia64 workaround,
> but yes I have to agree with Jeff, this change starts to
> lose the whole point of the original change.

Those cases are handled by the driver calling pci_restore_state after
calling pci_set_power_state(..., PCI_D0).

The only time need_restore is actually needed is when the device is
first accessed after boot (signified by PCI_UNKNOWN).  When PCI drivers
load, they typically call pci_enable_device before doing anything else.
pci_enable_device calls pci_set_power_state(..., PCI_D0), which exposes
the device to potentially become uninitialized if it had previously
been left in PCI_D3hot.  Any other time pci_set_power_state(..., PCI_D0)
is called, drivers know to call (and can call) pci_restore_state
afterwards.

If not calling pci_restore_bars from pci_set_power_state during normal
transitions from PCI_D3hot was a problem, it would have been a problem
long before the pci_restore_bars patch came along in 2.6.14-rc1. :-)

John
-- 
John W. Linville
linville@tuxdriver.com

--===============17850503164632947==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17850503164632947==--
