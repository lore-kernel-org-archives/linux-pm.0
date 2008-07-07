From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 03/11] PCI: Rework pci_set_power_state
	function (rev. 3)
Date: Mon, 7 Jul 2008 09:15:02 +0200
Message-ID: <20080707071501.GD5643__47066.9061215178$1215524456$gmane$org@ucw.cz>
References: <200806231934.08565.rjw@sisk.pl> <200806231945.32682.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806231945.32682.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2008-06-23 19:45:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCI: Rework pci_set_power_state function (rev. 3)
> 
> Rework pci_set_power_state() so that the platform callback is
> invoked before the native mechanism, if necessary.  Also, make
> the function check if the device is power manageable by the
> platform before invoking the platform callback.
> 
> This may matter if the device dependent on additional power
> resources controlled by the platform is being put into D0, in which
> case those power resources must be turned on before we attempt to
> handle the device itself. 
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks mostly ok to me...

> +/**
> + * pci_set_power_state - Set the power state of a PCI device
> + * @dev: PCI device to handle.
> + * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
> + *
> + * Transition a device to a new power state, using the platform formware and/or
> + * the device's PCI PM registers.
> + *
> + * RETURN VALUE:
> + * -EINVAL if the requested state is invalid.
> + * -EIO if device does not support PCI PM or its PM capabilities register has a
> + * wrong version, or device doesn't support the requested state.
> + * 0 if device already is in the requested state.
> + * 0 if device's power state has been successfully changed.
> + */
> +int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> +{
> +	int pm, error;
> +
> +	/* bound the state we're entering */
> +	if (state > PCI_D3hot)
> +		state = PCI_D3hot;
> +	else if (state < PCI_D0)
> +		state = PCI_D0;

Should it return einval in those two cases? Docs above says it does...

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
