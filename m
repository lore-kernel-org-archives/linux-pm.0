From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 9/10] PCI PM: Run default PM callbacks
	for all devices using new framework
Date: Mon, 5 Jan 2009 12:26:07 +0100
Message-ID: <20090105112607.GM27199__48298.9202057526$1231155125$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200812190049.34343.rjw@sisk.pl> <200812281607.28007.rjw@sisk.pl>
	<200812302333.45560.rjw@sisk.pl> <200812302347.37164.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200812302347.37164.rjw@sisk.pl>
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

> 
> It should be quite clear that it generally makes sense to execute
> the default PM callbacks (ie. the callbacks used for handling
> suspend, hibernation and resume of PCI devices without drivers) for
> all devices.  Of course, the drivers that provide legacy PCI PM
> support (ie. the ->suspend, ->suspend_late, ->resume_early
> or ->resume hooks in the pci_driver structure), carry out these
> operations too, so we can't do it for devices with such drivers.
> Still, we can make the default PM callbacks run for devices with
> drivers using the new framework (ie. implement the pm object), since
> there are no such drivers at the moment.
> 
> This also simplifies the code and reduces its size.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Pavel Machek <Pavel@suse.cz>
> ---
>  drivers/pci/pci-driver.c |  135 ++++++++++++++++++-----------------------------
>  1 file changed, 53 insertions(+), 82 deletions(-)
> 
> Index: linux-2.6/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-driver.c
> +++ linux-2.6/drivers/pci/pci-driver.c
> @@ -472,6 +472,8 @@ static void pci_pm_default_suspend(struc
>  
>  	if (!pci_is_bridge(pci_dev))
>  		pci_prepare_to_sleep(pci_dev);
> +
> +	pci_fixup_device(pci_fixup_suspend, pci_dev);
>  }
>  
>  static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
> @@ -514,16 +516,13 @@ static int pci_pm_suspend(struct device 
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_SUSPEND);
>  
> -	if (drv && drv->pm) {
> -		if (drv->pm->suspend) {
> -			error = drv->pm->suspend(dev);
> -			suspend_report_result(drv->pm->suspend, error);
> -		}
> -	} else {
> -		pci_pm_default_suspend(pci_dev);
> +	if (drv && drv->pm && drv->pm->suspend) {
> +		error = drv->pm->suspend(dev);
> +		suspend_report_result(drv->pm->suspend, error);
>  	}
>  
> -	pci_fixup_device(pci_fixup_suspend, pci_dev);
> +	if (!error)
> +		pci_pm_default_suspend(pci_dev);
>  
>  	return error;
>  }
> @@ -537,15 +536,14 @@ static int pci_pm_suspend_noirq(struct d
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend_late(dev, PMSG_SUSPEND);
>  
> -	if (drv && drv->pm) {
> -		if (drv->pm->suspend_noirq) {
> -			error = drv->pm->suspend_noirq(dev);
> -			suspend_report_result(drv->pm->suspend_noirq, error);
> -		}
> -	} else {
> -		pci_pm_set_unknown_state(pci_dev);
> +	if (drv && drv->pm && drv->pm->suspend_noirq) {
> +		error = drv->pm->suspend_noirq(dev);
> +		suspend_report_result(drv->pm->suspend_noirq, error);
>  	}
>  
> +	if (!error)
> +		pci_pm_set_unknown_state(pci_dev);
> +
>  	return error;
>  }
>  
> @@ -558,14 +556,10 @@ static int pci_pm_resume(struct device *
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume(dev);
>  
> -	if (drv && drv->pm) {
> -		pci_fixup_device(pci_fixup_resume, pci_dev);
> +	error = pci_pm_default_resume(pci_dev);
>  
> -		if (drv->pm->resume)
> -			error = drv->pm->resume(dev);
> -	} else {
> -		error = pci_pm_default_resume(pci_dev);
> -	}
> +	if (!error && drv && drv->pm && drv->pm->resume)
> +		error = drv->pm->resume(dev);
>  
>  	return error;
>  }
> @@ -579,14 +573,10 @@ static int pci_pm_resume_noirq(struct de
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
>  
> -	if (drv && drv->pm) {
> -		pci_fixup_device(pci_fixup_resume_early, pci_dev);
> +	pci_pm_default_resume_noirq(pci_dev);
>  
> -		if (drv->pm->resume_noirq)
> -			error = drv->pm->resume_noirq(dev);
> -	} else {
> -		pci_pm_default_resume_noirq(pci_dev);
> -	}
> +	if (drv && drv->pm && drv->pm->resume_noirq)
> +		error = drv->pm->resume_noirq(dev);
>  
>  	return error;
>  }
> @@ -611,15 +601,14 @@ static int pci_pm_freeze(struct device *
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_FREEZE);
>  
> -	if (drv && drv->pm) {
> -		if (drv->pm->freeze) {
> -			error = drv->pm->freeze(dev);
> -			suspend_report_result(drv->pm->freeze, error);
> -		}
> -	} else {
> -		pci_pm_default_suspend_generic(pci_dev);
> +	if (drv && drv->pm && drv->pm->freeze) {
> +		error = drv->pm->freeze(dev);
> +		suspend_report_result(drv->pm->freeze, error);
>  	}
>  
> +	if (!error)
> +		pci_pm_default_suspend_generic(pci_dev);
> +
>  	return error;
>  }
>  
> @@ -632,15 +621,14 @@ static int pci_pm_freeze_noirq(struct de
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend_late(dev, PMSG_FREEZE);
>  
> -	if (drv && drv->pm) {
> -		if (drv->pm->freeze_noirq) {
> -			error = drv->pm->freeze_noirq(dev);
> -			suspend_report_result(drv->pm->freeze_noirq, error);
> -		}
> -	} else {
> -		pci_pm_set_unknown_state(pci_dev);
> +	if (drv && drv->pm && drv->pm->freeze_noirq) {
> +		error = drv->pm->freeze_noirq(dev);
> +		suspend_report_result(drv->pm->freeze_noirq, error);
>  	}
>  
> +	if (!error)
> +		pci_pm_set_unknown_state(pci_dev);
> +
>  	return error;
>  }
>  
> @@ -653,12 +641,10 @@ static int pci_pm_thaw(struct device *de
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume(dev);
>  
> -	if (drv && drv->pm) {
> -		if (drv->pm->thaw)
> -			error =  drv->pm->thaw(dev);
> -	} else {
> -		pci_pm_reenable_device(pci_dev);
> -	}
> +	pci_pm_reenable_device(pci_dev);
> +
> +	if (drv && drv->pm && drv->pm->thaw)
> +		error =  drv->pm->thaw(dev);
>  
>  	return error;
>  }
> @@ -672,12 +658,10 @@ static int pci_pm_thaw_noirq(struct devi
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
>  
> -	if (drv && drv->pm) {
> -		if (drv->pm->thaw_noirq)
> -			error = drv->pm->thaw_noirq(dev);
> -	} else {
> -		pci_update_current_state(pci_dev, PCI_D0);
> -	}
> +	pci_update_current_state(pci_dev, PCI_D0);
> +
> +	if (drv && drv->pm && drv->pm->thaw_noirq)
> +		error = drv->pm->thaw_noirq(dev);
>  
>  	return error;
>  }
> @@ -691,16 +675,13 @@ static int pci_pm_poweroff(struct device
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>  
> -	if (drv && drv->pm) {
> -		if (drv->pm->poweroff) {
> -			error = drv->pm->poweroff(dev);
> -			suspend_report_result(drv->pm->poweroff, error);
> -		}
> -	} else {
> -		pci_pm_default_suspend(pci_dev);
> +	if (drv && drv->pm && drv->pm->poweroff) {
> +		error = drv->pm->poweroff(dev);
> +		suspend_report_result(drv->pm->poweroff, error);
>  	}
>  
> -	pci_fixup_device(pci_fixup_suspend, pci_dev);
> +	if (!error)
> +		pci_pm_default_suspend(pci_dev);
>  
>  	return error;
>  }
> @@ -713,11 +694,9 @@ static int pci_pm_poweroff_noirq(struct 
>  	if (pci_has_legacy_pm_support(to_pci_dev(dev)))
>  		return pci_legacy_suspend_late(dev, PMSG_HIBERNATE);
>  
> -	if (drv && drv->pm) {
> -		if (drv->pm->poweroff_noirq) {
> -			error = drv->pm->poweroff_noirq(dev);
> -			suspend_report_result(drv->pm->poweroff_noirq, error);
> -		}
> +	if (drv && drv->pm && drv->pm->poweroff_noirq) {
> +		error = drv->pm->poweroff_noirq(dev);
> +		suspend_report_result(drv->pm->poweroff_noirq, error);
>  	}
>  
>  	return error;
> @@ -732,14 +711,10 @@ static int pci_pm_restore(struct device 
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume(dev);
>  
> -	if (drv && drv->pm) {
> -		pci_fixup_device(pci_fixup_resume, pci_dev);
> +	error = pci_pm_default_resume(pci_dev);
>  
> -		if (drv->pm->restore)
> -			error = drv->pm->restore(dev);
> -	} else {
> -		error = pci_pm_default_resume(pci_dev);
> -	}
> +	if (!error && drv && drv->pm && drv->pm->restore)
> +		error = drv->pm->restore(dev);
>  
>  	return error;
>  }
> @@ -753,14 +728,10 @@ static int pci_pm_restore_noirq(struct d
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
>  
> -	if (drv && drv->pm) {
> -		pci_fixup_device(pci_fixup_resume_early, pci_dev);
> +	pci_pm_default_resume_noirq(pci_dev);
>  
> -		if (drv->pm->restore_noirq)
> -			error = drv->pm->restore_noirq(dev);
> -	} else {
> -		pci_pm_default_resume_noirq(pci_dev);
> -	}
> +	if (drv && drv->pm && drv->pm->restore_noirq)
> +		error = drv->pm->restore_noirq(dev);
>  
>  	return error;
>  }
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
