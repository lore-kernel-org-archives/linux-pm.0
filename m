From: Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from
	pci_set_power_state for D3hot->D0
Date: Tue, 26 Jul 2005 16:49:34 -0700
Message-ID: <20050726234934.GA6584@kroah.com>
References: <20050708095104.A612@den.park.msu.ru>
	<20050707.233530.85417983.davem@davemloft.net>
	<20050708110358.A8491@jurassic.park.msu.ru>
	<20050708.003333.28789082.davem@davemloft.net>
	<20050708122043.A8779@jurassic.park.msu.ru>
	<20050708183452.GB13445@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94798474893050044=="
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
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk, matthew@wil.cx, grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ambx1@neo.rr.com
List-Id: linux-pm@vger.kernel.org

--===============94798474893050044==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:
> @@ -301,6 +335,16 @@ pci_set_power_state(struct pci_dev *dev,
>  		udelay(200);
>  	dev->current_state = state;
>  
> +	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> +	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
> +	 * from D3hot to D0 _may_ perform an internal reset, thereby
> +	 * going to "D0 Uninitialized" rather than "D0 Initialized".
> +	 * In that case, we need to restore at least the BARs so that
> +	 * the device will be accessible to its driver.
> +	 */
> +	if (need_restore)
> +		pci_restore_bars(dev);
> +

This code doesn't even build, as need_restore isn't a global variable.

Care to redo this patch (and merge it with your other one) and resend
it?

thanks,

greg k-h

--===============94798474893050044==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94798474893050044==--
