From: Eric Sesterhenn <snakebyte@gmx.de>
Subject: Re: Suspend regression, hang after matroxfb
Date: Fri, 30 Jan 2009 23:09:41 +0100
Message-ID: <20090130220941.GC13207__18063.6669545949$1233353738$gmane$org@alice>
References: <20090129125855.GA4597@alice> <20090130124643.GA8394@alice>
	<200901302215.28057.rjw@sisk.pl> <200901302303.23143.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901302303.23143.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Kernel Testers <kernel-testers@vger.kernel.org>, vandrove@vc.cvut.cz
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> On Friday 30 January 2009, Rafael J. Wysocki wrote:
> > On Friday 30 January 2009, Eric Sesterhenn wrote:
> > > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > > On Thursday 29 January 2009, Eric Sesterhenn wrote:
> > > > > hi,
> > > > > 
> > > > > on this box standby worked with 2.6.28, but is broken with 2.6.29-rc3.
> > > > > 
> > > > > Dmesg of startup
> > > > > http://www.cccmz.de/~snakebyte/200.log
> > > > > .config
> > > > > http://www.cccmz.de/~snakebyte/config_200
> > > > > 
> > > > > When testing the devices 
> > > > > 
> > > > > root@computer-desktop:/sys/power# echo devices > pm_test 
> > > > 
> > > > What happens if you replace 'devices' with 'core' ?
> > > 
> > > no change, it hangs after matroxfb
> > > 
> > > root@computer-desktop:/sys/power# echo core > pm_test 
> > > root@computer-desktop:/sys/power# echo standby > state
> > > 
> > [--snip--]
> > > 
> > > > If the same, what happens without the matroxfb driver?
> > > 
> > > It gets a bit further, suspend seems to complete,
> > > but hangs during resume
> > 
> > Please check if the appended patch helps.
> 
> Sorry, wrong version.
> 
> Please try this one instead.

looks similar, I resolved the conflicts of the other one
by hand. Thanks

> Thanks,
> Rafael
> 
> ---
>  drivers/pci/pci-driver.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-driver.c
> +++ linux-2.6/drivers/pci/pci-driver.c
> @@ -443,11 +443,11 @@ static void pci_pm_default_suspend_gener
>  	pci_save_state(pci_dev);
>  }
>  
> -static void pci_pm_default_suspend(struct pci_dev *pci_dev)
> +static void pci_pm_default_suspend(struct pci_dev *pci_dev, bool prepare)
>  {
>  	pci_pm_default_suspend_generic(pci_dev);
>  
> -	if (!pci_is_bridge(pci_dev))
> +	if (prepare && !pci_is_bridge(pci_dev))
>  		pci_prepare_to_sleep(pci_dev);
>  
>  	pci_fixup_device(pci_fixup_suspend, pci_dev);
> @@ -507,7 +507,7 @@ static int pci_pm_suspend(struct device 
>  	}
>  
>  	if (!error)
> -		pci_pm_default_suspend(pci_dev);
> +		pci_pm_default_suspend(pci_dev, drv && drv->pm);
>  
>  	return error;
>  }
> @@ -666,7 +666,7 @@ static int pci_pm_poweroff(struct device
>  	}
>  
>  	if (!error)
> -		pci_pm_default_suspend(pci_dev);
> +		pci_pm_default_suspend(pci_dev, drv && drv->pm);
>  
>  	return error;
>  }
