From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH 10/12] PCI / ACPI PM: Platform support
	for PCI PME	wake-up (rev. 4)
Date: Fri, 4 Dec 2009 16:21:07 +0000
Message-ID: <20091204162107.GA13371__13102.1029352725$1259943753$gmane$org@srcf.ucam.org>
References: <200911160047.46299.rjw@sisk.pl> <200911291632.44763.rjw@sisk.pl>
	<200911291642.20172.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911291642.20172.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 29, 2009 at 04:42:20PM +0100, Rafael J. Wysocki wrote:

> +	if (event == ACPI_NOTIFY_DEVICE_WAKE) {
> +		if (nb->dev->wakeup.run_wake_count > 0) {
> +			if (nb->pci_bus)
> +				pci_pme_wakeup_bus(nb->pci_bus);
> +			if (nb->pci_dev)
> +				pci_pme_wakeup(nb->pci_dev);

We may receive wakeup events on devices that aren't PME capable, which 
is the case for uhci on my test box. In that case we probably want to 
wake them up unconditionally.

+                       if (nb->pci_dev) {
+                               if (nb->pci_dev->pm_cap)
+                                       pci_pme_wakeup(nb->pci_dev);
+                               else
+                                       pm_request_resume(&nb->pci_dev->dev);

seems to work, though possibly we should assume that the firmware knows 
best and always schedule a wake in respose to a resume request?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
