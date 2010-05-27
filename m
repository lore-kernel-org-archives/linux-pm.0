From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Thu, 27 May 2010 21:56:37 +0200
Message-ID: <201005272156.37468.rjw__23121.4364445352$1274990183$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005262048050.6349-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005262048050.6349-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 27 May 2010, Alan Stern wrote:
> On Thu, 27 May 2010, Rafael J. Wysocki wrote:
> 
> > On Wednesday 26 May 2010, Alan Stern wrote:
> > > On Wed, 26 May 2010, Rafael J. Wysocki wrote:
> > > 
> > > > At this point, yes.  At least drivers should leave the devices active and
> > > > let the core power take care of them.
> > > 
> > > What if the driver is unbound while the device is suspended?  It seems 
> > > pretty awkward.  The release method would have to do:
> > > 
> > > 	pm_runtime_get_sync(dev);
> > > 	pm_runtime_disable(dev);
> > > 	pm_runtime_set_suspended(dev);
> > > 	pm_runtime_put_noidle(dev);
> > 
> > That's correct, but as I said I don't think it's safe to do anything else in
> > general at this point (please remember that it must cooperate with system
> > suspend/resume).
> > 
> > This still is a work in progress, though, so if you have an idea how to improve
> > it, I surely won't object. :-)
> 
> I'm just trying to determine what drivers are currently expected to 
> do.
> 
> So when a device isn't bound, it should be disabled for runtime PM and
> in an active state (D0), but its runtime status should be RPM_SUSPENDED
> -- the same as the default values when a new device structure is
> initialized.  Right?

Yes.

Rafael
