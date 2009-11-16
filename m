From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 9/10] PCI / ACPI PM: Platform support
	for PCI PME wake-up (rev. 3)
Date: Mon, 16 Nov 2009 20:04:57 +0100
Message-ID: <200911162004.57416.rjw__6767.94731193713$1258398299$gmane$org@sisk.pl>
References: <200911160047.46299.rjw@sisk.pl> <200911160057.42421.rjw@sisk.pl>
	<4B00D6E2.9010404@np.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B00D6E2.9010404@np.css.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 16 November 2009, Jin Dongming wrote:
> Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > +/**
> > + * pci_acpi_add_pm_notifier - Register PM notifier for given device.
> > + * @dev: ACPI device to add the notifier for.
> > + * @pci_dev: PCI device to check for the PME status if an event is signaled.
> > + * @pci_bus: PCI bus to walk (checking PME status) if an event is signaled.
> > + *
> > + * Check if there is a notifier object for @dev and if that is the case, add
> > + * @pci_dev to it as the device whose PME status should be checked if a PM
> > + * event is signaled for @dev.  Also, add @pci_bus to it as the bus to walk
> > + * checking the PME status of all devices on it if a PM event is signaled for
> > + * @dev.  Otherwise, create a new notifier object for @dev and add both
> > + * @pci_dev and @pci_bus to it.
> > + */
> > +acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
> > +				     struct pci_dev *pci_dev,
> > +				     struct pci_bus *pci_bus)
> > +{
> > +	struct pci_acpi_notifier_block *nb;
> > +	acpi_status status = AE_OK;
> > +
> > +	if (!dev->wakeup.flags.run_wake)
> > +		return AE_BAD_PARAMETER;
> > +
> > +	mutex_lock(&pci_acpi_notifier_mtx);
> > +
> > +	list_for_each_entry(nb, &pci_acpi_runtime_notifiers, entry)
> > +		if (nb->dev == dev) {
> > +			if (nb->pci_dev || nb->pci_bus)
> > +				goto out;
> > +			else
> > +				goto add;
> > +		}
> > +
> > +	nb = new_notifier(dev);
> > +	if (!nb) {
> > +		status = AE_NO_MEMORY;
> > +		goto out;
> > +	}
> > +	list_add_tail(&nb->entry, &pci_acpi_runtime_notifiers);
> > +
> > +	status = acpi_install_notify_handler(dev->handle, ACPI_SYSTEM_NOTIFY,
> > +						pci_acpi_event_fn, nb);
> > +	if (ACPI_FAILURE(status)) {
> > +		list_del(&nb->entry);
> > +		kfree(nb);
> > +	}
> 
> I think when nb is freed, it should be go to "out:".

You're absolutely right, thanks for catching this bug.

I'll fix it in the next version of the patch.

> > +
> > + add:
> > +	nb->pci_dev = pci_dev;
> > +	nb->pci_bus = pci_bus;
> > +
> > + out:
> > +	mutex_unlock(&pci_acpi_notifier_mtx);
> > +	return status;
> > +}
> > +
> > +/**
> > + * pci_acpi_remove_pm_notifier - Unregister PM notifier for given device.
> > + * @dev: ACPI device to remove the notifier from.
> > + *
> > + * Find the notifier object for @dev and clear its @pci_dev and @pci_bus fields.
> > + * If the notifier object is not necessary any more after that, remove it too.
> > + */

Best,
Rafael
