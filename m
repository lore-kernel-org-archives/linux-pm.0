From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/8] PM: Asynchronous suspend and resume of
	devices
Date: Sun, 24 Jan 2010 11:37:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001241128250.28594-100000__31859.3048993082$1264351097$gmane$org@netrider.rowland.org>
References: <201001240035.37550.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001240035.37550.rjw@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Greg KH <gregkh@suse.de>, Linux SCSI <linux-scsi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 24 Jan 2010, Rafael J. Wysocki wrote:

> The async threads started for different devices as a result of
> calling async_schedule() are synchronized with each other and with
> the main suspend/resume thread with the help of completions, in the
> following way:
> (1) There is a completion, power.completion, for each device object.
> (2) Each device's completion is reset before calling async_schedule()
>     for the device or, in the case of devices with the
>     power.async_suspend flags unset, before executing the device's
>     suspend and resume callbacks.
> (3) During suspend, right before running the bus type, device type
>     and device class suspend callbacks for the device, the PM core
>     waits for the completions of all the device's children to be
>     completed.
> (4) During resume, right before running the bus type, device type and
>     device class resume callbacks for the device, the PM core waits
>     for the completion of the device's parent to be completed.
> (5) The PM core completes power.completion for each device right
>     after the bus type, device type and device class suspend (or
>     resume) callbacks executed for the device have returned.

...

>  /**
> + * dpm_wait - Wait for a PM operation to complete.
> + * @dev: Device to wait for.
> + * @async: If unset, wait only if the device's power.async_suspend flag is set.
> + */
> +static void dpm_wait(struct device *dev, bool async)
> +{
> +	if (!dev)
> +		return;
> +
> +	if (async || dev->power.async_suspend)
> +		wait_for_completion(&dev->power.completion);
> +}

There needs to be a public interface to this function available for 
drivers that have non-tree constraints.  The arguments should be the 
device to wait for and the device doing the waiting (needed only to 
determine whether the caller is running synchronously or not).

This will be necessary for USB.  In fact, your current code (with patch 
7/8 applied) is subject to a race that will sometimes cause a 
non-high-speed USB device to fail to resume from hibernation.

Alan Stern
