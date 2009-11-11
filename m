From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pci: Updates to Rafael's runtime PCI PM
	patch set
Date: Wed, 11 Nov 2009 20:58:20 +0100
Message-ID: <200911112058.20331.rjw__20035.7963833541$1257969497$gmane$org@sisk.pl>
References: <200910090051.50932.rjw@sisk.pl>
	<1257806529-6535-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1257806529-6535-1-git-send-email-mjg@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 09 November 2009, Matthew Garrett wrote:
> There's a few quirks with Rafael's PCI runtime PM code - this modifies
> them a little. The body of it is just porting it to my GPE rewrite, but
> it also moves the PCI binding earlier (otherwise acpi_pci_bind bails, since
> it's primarily intended for bridges), and also ensures that the pme bit
> gets set properly on hardware that requires it.

Well, I thought more changes would be necessary. :-)

Looking good, a few comments below.

> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/acpi/pci_bind.c  |   12 ++++++------
>  drivers/acpi/wakeup.c    |   36 ------------------------------------
>  drivers/pci/pci-acpi.c   |   43 ++++++++++++++++---------------------------
>  drivers/pci/pci-driver.c |    6 ++++++
>  include/acpi/acpi_bus.h  |    6 ------
>  5 files changed, 28 insertions(+), 75 deletions(-)
> 
...
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index eb4f26a..d644db6 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -967,6 +967,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  			pci_prepare_to_sleep(pci_dev);
>  	}
>  
> +	if (pci_pme_capable(pci_dev, pci_target_state(pci_dev)))
> +		pci_pme_active(pci_dev, true);
> +

The PME was supposed to be turned on by pci_prepare_to_sleep().
I guess it wasn't in practice?

>  	pci_platform_run_wake(pci_dev, true);
>  
>  	return 0;
> @@ -980,6 +983,9 @@ static int pci_pm_runtime_resume(struct device *dev)
>  	if (!pm || !pm->runtime_resume)
>  		return -ENOSYS;
>  
> +	if (pci_pme_capable(pci_dev, pci_target_state(pci_dev)))
> +		pci_pme_active(pci_dev, false);
> +

Same here, pci_pm_default_resume_early() should cleare the PME theoretically,
although not for bridges.

>  	pci_platform_run_wake(pci_dev, false);
>  	pci_pm_default_resume_early(pci_dev);
>  	pci_pm_default_resume(pci_dev);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 935036e..9541588 100644

Generally, some parts of it belong to the
"PCI PM: Run-time callbacks for PCI bus type" patch and the others belong
to "PCI / ACPI PM: Platform support for PCI PME wake-up" patch.  Should I fold
the changes into them?

Rafael
