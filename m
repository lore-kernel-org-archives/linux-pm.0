From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Thu, 27 Aug 2009 09:18:34 -0700
Message-ID: <20090827091834.3571d9a7@jbarnes-g45>
References: <20090824023423.GC4624@zhen-devel.sh.intel.com>
	<Pine.LNX.4.44L0.0908271031420.2649-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908271031420.2649-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Alek Du <alek.du@intel.com>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Aug 2009 10:51:47 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Mon, 24 Aug 2009, Zhenyu Wang wrote:
> 
> > yeah, Alex's patch is ok in general, and Alan's problem seems
> > specific on 845G. So the origin restore order issue for us seems
> > gone with pci layer early resume, we could remove the restore in
> > intel_agp and drm/i915, although Alex's patch makes them noop.
> > 
> > How about this one? Alan, could you help to test this with drm/i915
> > module loaded?
> > 
> > thanks.
> > 
> > From 7ab123a67e3ab3f31051d95e74362ae711e0657e Mon Sep 17 00:00:00
> > 2001 From: Zhenyu Wang <zhenyuw@linux.intel.com>
> > Date: Mon, 24 Aug 2009 10:29:07 +0800
> > Subject: [PATCH] agp/intel: remove restore in resume
> > 
> > As earlier pci driver resume has already restored space for
> > host bridge and graphics device, don't need to restore it
> > again which might cause problem on some chips, e.g 845G tested
> > by Alan.
> > 
> > Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> > ---
> >  drivers/char/agp/intel-agp.c    |    9 ---------
> >  drivers/gpu/drm/i915/i915_drv.c |    1 -
> >  2 files changed, 0 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/char/agp/intel-agp.c
> > b/drivers/char/agp/intel-agp.c index 8c9d50d..ed43ab2 100644
> > --- a/drivers/char/agp/intel-agp.c
> > +++ b/drivers/char/agp/intel-agp.c
> > @@ -2308,15 +2308,6 @@ static int agp_intel_resume(struct pci_dev
> > *pdev) struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
> >  	int ret_val;
> >  
> > -	pci_restore_state(pdev);
> > -
> > -	/* We should restore our graphics device's config space,
> > -	 * as host bridge (00:00) resumes before graphics device
> > (02:00),
> > -	 * then our access to its pci space can work right.
> > -	 */
> > -	if (intel_private.pcidev)
> > -		pci_restore_state(intel_private.pcidev);
> > -
> >  	if (bridge->driver == &intel_generic_driver)
> >  		intel_configure();
> >  	else if (bridge->driver == &intel_850_driver)
> > diff --git a/drivers/gpu/drm/i915/i915_drv.c
> > b/drivers/gpu/drm/i915/i915_drv.c index fc4b68a..645f298 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.c
> > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > @@ -95,7 +95,6 @@ static int i915_resume(struct drm_device *dev)
> >  	int ret = 0;
> >  
> >  	pci_set_power_state(dev->pdev, PCI_D0);
> > -	pci_restore_state(dev->pdev);
> >  	if (pci_enable_device(dev->pdev))
> >  		return -1;
> >  	pci_set_master(dev->pdev);
> 
> I tested the following configurations (each with your patch applied):
> 
> 	Without Alex's patch and without i915 loaded;
> 
> 	With Alex's patch and without i915 loaded;
> 
> 	With Alex's patch and with i915 loaded.
> 
> They all worked.  (Note that I normally run without drm/i915.  The
> Xorg 2D-acceleration code is buggy on my hardware, so I don't use it.)

Could I convince you to file bugs for the problems you're seeing at
bugs.freedesktop.org?  We don't have many 845G test machines but we
have fixed several problems on that chipset recently.

-- 
Jesse Barnes, Intel Open Source Technology Center
