From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/9] PM: Rework shmobile and OMAP runtime PM
 using power domains (v2)
Date: Sun, 24 Apr 2011 16:36:44 -0700
Message-ID: <20110424233644.GA20577__14159.3021144674$1303689903$gmane$org@suse.de>
References: <201104130205.26988.rjw@sisk.pl> <201104170135.19388.rjw@sisk.pl>
	<201104242330.13607.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104242330.13607.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 24, 2011 at 11:30:13PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> Taking the feedback from the last version of the patchset into account
> I reworked patches [7/9] and [8/9] so that multiple clocks can be used for
> runtime PM.  I also fixed a couple of build issues (the patches have been
> built for x86, ARM/shmobile and ARM/OMAP1).
> 
> On Sunday, April 17, 2011, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following series of patches is my attempt to consolidate the shmobile and
> > OMAP runtime PM code using power domains so that it is not necessary to
> > replace the platform bus type's runtime PM callbacks any more.
> > 
> > Some of the patches have already been posted, some are new and some are
> > from Kevin. :-)
> 
> The high-level description of what the patches do hasn't changed, so:
> 
> [1/9] - Make power domain callbacks take precedence over subsystem ones
>         (this one has been discussed already).
> 
> [2/9] - Export the platform bus type's default PM callbacks so that they
>         can be used in power domain objects.
> 
> [3/9] - Use a default power domain for runtime PM on shmobile (both ARM
>         and SH flavors) instead of replacing the platform bus type's
>         runtime PM callbacks (using __weak).
> 
> [4/9] - Use generic runtime PM callbacks directly in the platform bus type.
> 
> [5/9] - Move OMAP2 runtime PM implementation to using a power domain object
>         (patch from Kevin rebased on top of [1-4/9]).
> 
> [6/9] - Add subsystem data field to struct dev_pm_info.
> 
> [7/9] - Introduce generic clock manipulation routines for runtime PM and
>         convert ARM shmobile to using them.
> 
> [8/9] - Move OMAP1 runtime PM to the new core infrastructure.
> 
> [9/9] - Remove platform_bus_set_pm_ops() (patch from Kevin).
> 
> If there are no objections (or reports of breakage), I'd like to push these
> patches through the suspend-2.6 tree in the 2.6.40 merge window.

No objections from me at all, looks great, thanks for doing this.

greg k-h
