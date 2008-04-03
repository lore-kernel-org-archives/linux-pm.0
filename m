From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC][PATCH 1/3] use new pm_ops in DRM drivers
Date: Thu, 3 Apr 2008 14:41:07 -0700
Message-ID: <200804031441.07703.jbarnes@virtuousgeek.org>
References: <200804020207.40278.rjw@sisk.pl>
	<200804031150.55967.jbarnes@virtuousgeek.org>
	<200804032323.59133.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804032323.59133.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 03, 2008 2:23 pm Rafael J. Wysocki wrote:
> > +static int i915_poweroff(struct device *dev)
> > +{
> > +	/* Shut down the device */
> > +	pci_disable_device(dev->pdev);
> > +	pci_set_power_state(dev->pdev, PCI_D3hot);
>
> I think you may need to do that in ->suspend() too, as opposed to
> ->freeze(), ...

Because ->poweroff won't be called in the paths that do ->suspend?  Ah yeah, 
must have skipped over that section of the documentation...

>
> > +}
> > +
> > +static struct pm_ops i915_pm_ops = {
> > +	.prepare = NULL, /* DRM core should prevent any new ioctls? */
> > +	.complete = NULL, /* required to re-enable DRM client requests */
> > +	.suspend = i915_save,
> > +	.resume = i915_restore,
> > +	.freeze = i915_save,
>
> ... so perhaps define ->suspend() as ->save() + ->poweroff()?

Yep, I can just make a wrapper for it in the driver.

Thanks a lot for making these changes to the core.  My only worry is that all 
the old-style stuff will stick around forever...  so fwiw you can add my

Acked-by:  Jesse Barnes <jesse.barnes@intel.com>

to the series.

Thanks,
Jesse
