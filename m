From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Fri, 21 Aug 2009 10:32:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908211022210.2912-100000@iolanthe.rowland.org>
References: <20090821031320.GA21420@zhen-devel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090821031320.GA21420@zhen-devel.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Aug 2009, Zhenyu Wang wrote:

> > I can't understand why Alex's patch could fix for you, or because you've
> > seen 'state_saved' is false in your testing, and Alex's patch just workaround
> > state restore for you? I don't understand why 'state_saved' is false in your
> > case, as pci layer should do save state for us by default, no?

The PCI layer _does_ save the state, in pci_legacy_suspend_late().  
And then in pci_pm_default_resume_noirq() it restores the state and
sets state_saved to false.  That's why state_saved is false when
agp_intel_resume() runs.

> > Could you try with this one? And what's your gfx chip?

00:02.0 VGA compatible controller: Intel Corporation 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)


> oops, here's right one for testing...
> 
> diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
> index 8c9d50d..5ed62c1 100644
> --- a/drivers/char/agp/intel-agp.c
> +++ b/drivers/char/agp/intel-agp.c
> @@ -2303,6 +2303,13 @@ static void __devexit agp_intel_remove(struct pci_dev *pdev)
>  }
>  
>  #ifdef CONFIG_PM
> +static int agp_intel_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	pci_save_state(pdev);
> +	pci_set_power_state(pdev, 3);
> +	return 0;
> +}

I don't think this will help.  The state _is_ getting saved, so saving
it again won't make any difference.  The problem occurs because the
state is restored at the wrong time.

> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index fc4b68a..f54880f 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -95,7 +95,11 @@ static int i915_resume(struct drm_device *dev)
>  	int ret = 0;
>  
>  	pci_set_power_state(dev->pdev, PCI_D0);
> -	pci_restore_state(dev->pdev);
> +	/* XXX as pci layer should have already early restore state
> +	   for us, or intel_agp driver has taken care of reconfigure,
> +	   we don't need to restore again here, which might corrupt
> +	   reconfigured state...*/
> +	/* pci_restore_state(dev->pdev); */
>  	if (pci_enable_device(dev->pdev))
>  		return -1;
>  	pci_set_master(dev->pdev);

And I don't think this will help since I don't have a 915 controller.

Alan Stern
