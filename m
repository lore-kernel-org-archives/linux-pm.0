From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 2/10] PCI PM: Add suspend counterpart of
	pci_reenable_device
Date: Mon, 5 Jan 2009 11:49:47 +0100
Message-ID: <20090105104946.GE27199__22443.8551151708$1231152770$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200812190049.34343.rjw@sisk.pl> <200812281607.28007.rjw@sisk.pl>
	<200812302333.45560.rjw@sisk.pl> <200812302337.10257.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200812302337.10257.rjw@sisk.pl>
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
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> PCI devices without drivers are not disabled during suspend and
> hibernation, but they are enabled during resume, with the help of
> pci_reenable_device(), so there is an unbalanced execution of
> pcibios_enable_device() in the resume code path.
> 
> To correct this introduce function pci_disable_enabled_device()
> that will disable the argument device, if it is enabled when the
> function is being run, without updating the device's pci_dev
> structure and use it in the suspend code path to balance the
> pci_reenable_device() executed during resume.

> +/**
> + * pci_disable_enabled_device - Disable device without updating enable_cnt
> + * @dev: PCI device to disable
> + *
> + * NOTE: This function is a backend of PCI power management routines and is
> + * not supposed to be called drivers.

"by drivers"?

> @@ -441,7 +455,10 @@ static int pci_pm_suspend(struct device 
>  		}
>  	} else if (pci_has_legacy_pm_support(pci_dev)) {
>  		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
> +	} else {
> +		pci_default_pm_suspend_early(pci_dev);
>  	}
> +
>  	pci_fixup_device(pci_fixup_suspend, pci_dev);
>  
>  	return error;

So tre fixup runs on the disabled device?

Acked-by: Pavel Machek <Pavel@suse.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
