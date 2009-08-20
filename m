From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Thu, 20 Aug 2009 09:05:48 -0700
Message-ID: <20090820090548.2ea98580@jbarnes-g45>
References: <Pine.LNX.4.44L0.0908191022390.3001-100000@iolanthe.rowland.org>
	<200908192322.25261.rjw@sisk.pl> <200908201741.06423.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908201741.06423.rjw@sisk.pl>
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
Cc: Greg KH <greg@kroah.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Alek Du <alek.du@intel.com>, Dave Airlie <airlied@redhat.com>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Aug 2009 17:41:06 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Wednesday 19 August 2009, Rafael J. Wysocki wrote:
> > On Wednesday 19 August 2009, Alan Stern wrote:
> > > On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:
> > > 
> > > > > Commenting out the second call to pci_restore_state()
> > > > > apparently fixes the problem.  I have no idea whether it's
> > > > > the right thing to do, though.
> > > > 
> > > > It is.  The PCI core have restored the PCI config already
> > > > anyway at the early resume stage.
> > > > 
> > > > I think the first pci_restore_state() could be dropped from
> > > > there as well.
> > > 
> > > What about the other AGP drivers in drivers/char/agp?  Looks like
> > > their suspend and resume routines could all use some updating.
> > 
> > As well as many other drivers. :-)
> > 
> > Usually, however, restoring the PCI config space twice doesn't
> > hurt, although it evidently does hurt on your system.
> > 
> > Hm, there's a patch that should help here I think.  Can you please
> > test this one: http://patchwork.kernel.org/patch/40062/ ?
> 
> Quoting the patch for completness.
> 
> ---
> From: Alek Du <alek.du@intel.com>
> Subject: [PATCH] pci: check saved state before restore

Ok, I'll send that over to Linus.  I'd been holding off on it since it
didn't actually fix any external reports.  But now that we have one...

-- 
Jesse Barnes, Intel Open Source Technology Center
