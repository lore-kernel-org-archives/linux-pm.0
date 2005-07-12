From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from
	pci_set_power_state for D3hot->D0
Date: Mon, 11 Jul 2005 22:28:55 -0400
Message-ID: <20050712022855.GA3689@neo.rr.com>
References: <20050708095104.A612@den.park.msu.ru>
	<20050707.233530.85417983.davem@davemloft.net>
	<20050708110358.A8491@jurassic.park.msu.ru>
	<20050708.003333.28789082.davem@davemloft.net>
	<20050708122043.A8779@jurassic.park.msu.ru>
	<20050708183452.GB13445@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94025188170896268=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050708183452.GB13445@tuxdriver.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: rmk+lkml@arm.linux.org.uk, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, grundler@parisc-linux.org, matthew@wil.cx, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

--===============94025188170896268==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:
> Some PCI devices lose all configuration (including BARs) when
> transitioning from D3hot->D0.  This leaves such a device in an
> inaccessible state.  The patch below causes the BARs to be restored
> when enabling such a device, so that its driver will be able to
> access it.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> Some firmware leaves devices in D3hot after a (re)boot.  Most drivers
> call pci_enable_device very early, so devices left in D3hot that lose
> configuration during the D3hot->D0 transition will be inaccessible to
> their drivers.

Also, I think there is a possibility of only enabling boot devices for ACPI
S4.  However, for the reboot case, we're not restoring anything.  Instead new
resource assignments are being made.  Doesn't the PCI subsystem already
handle this?

> 
> Drivers could be modified to account for this, but it would
> be difficult to know which drivers need modification.  This is
> especially true since often many devices are covered by the same
> driver.  It likely would be necessary to replicate code across dozens
> of drivers.

Agreed.

> 
> The patch below should trigger only when transitioning from D3hot->D0
> (or at boot), and only for devices that have the "no soft reset" bit
> cleared in the PM control register.  I believe it is safe to include as
> part of the PCI infrastructure.


>   * pci_set_power_state - Set the power state of a PCI device
>   * @dev: PCI device to be suspended
>   * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
> @@ -239,7 +270,7 @@ pci_find_parent_resource(const struct pc
>  int
>  pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  {

Couldn't this be in pci_restore_state() instead?  I was thinking it would
(in part) replace the ugly dword reads we have now.  They include many
registers we don't need to touch.  I wonder if we'll need pci_save_state()
at all or if we can derive all the information from the pci_dev.  I'll have
to look into it further.

Also we need a way to restore specific PCI capabilities.

Thanks,
Adam

--===============94025188170896268==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94025188170896268==--
