From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Wed, 19 Aug 2009 23:22:25 +0200
Message-ID: <200908192322.25261.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908191022390.3001-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908191022390.3001-100000@iolanthe.rowland.org>
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
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Zhenyu Wang <zhenyuw@linux.intel.com>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wednesday 19 August 2009, Alan Stern wrote:
> On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > Commenting out the second call to pci_restore_state() apparently fixes 
> > > the problem.  I have no idea whether it's the right thing to do, 
> > > though.
> > 
> > It is.  The PCI core have restored the PCI config already anyway at the early
> > resume stage.
> > 
> > I think the first pci_restore_state() could be dropped from there as well.
> 
> What about the other AGP drivers in drivers/char/agp?  Looks like their
> suspend and resume routines could all use some updating.

As well as many other drivers. :-)

Usually, however, restoring the PCI config space twice doesn't hurt, although
it evidently does hurt on your system.

Hm, there's a patch that should help here I think.  Can you please test
this one: http://patchwork.kernel.org/patch/40062/ ?

Best,
Rafael
