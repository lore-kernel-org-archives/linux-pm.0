From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH] ACPI / PCI: Fix NULL pointer dereference
	in	acpi_get_pci_dev()
Date: Mon, 5 Oct 2009 17:37:59 -0600
Message-ID: <20091005233759.GB14394__35707.1213926703$1254842269$gmane$org@ldl.fc.hp.com>
References: <200910060130.43246.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200910060130.43246.rjw@sisk.pl>
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
Cc: chepioq@gmail.com, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Danny Feng <dfeng@redhat.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki <rjw@sisk.pl>:
> 
> Fixes http://bugzilla.kernel.org/show_bug.cgi?id=14129, which is a
> regression from 2.6.30.

Thanks for doing this.

One small comment below (not major), but other than that:

Reviewed-by: Alex Chiang <achiang@hp.com>

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-by: Danny Feng <dfeng@redhat.com>
> Tested-by: chepioq <chepioq@gmail.com>
> ---
>  drivers/acpi/pci_root.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6/drivers/acpi/pci_root.c
> @@ -389,6 +389,18 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
>  
>  		pbus = pdev->subordinate;
>  		pci_dev_put(pdev);
> +
> +		/*
> +		 * During resume from a sleep state we can get a dock
> +		 * notification for a device that is present in ACPI tables,
> +		 * but not physically accessible at the moment, so tell the
> +		 * caller it's not present in that case.
> +		 */
> +		if (!pbus) {
> +			dev_info(&pdev->dev, "Secondary bus not present\n");

Should this be dev_dbg() or maybe even strike it completely?

> +			pdev = NULL;
> +			break;
> +		}
>  	}
>  out:
>  	list_for_each_entry_safe(node, tmp, &device_list, node)
> 
