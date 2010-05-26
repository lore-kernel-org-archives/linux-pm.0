From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM for PCI-based USB host controllers
Date: Thu, 27 May 2010 00:39:35 +0200
Message-ID: <201005270039.35649.rjw__48015.5111443766$1274917404$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005261753230.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005261753230.1328-100000@iolanthe.rowland.org>
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

On Wednesday 26 May 2010, Alan Stern wrote:
> On Wed, 26 May 2010, Rafael J. Wysocki wrote:
> 
> > At this point, yes.  At least drivers should leave the devices active and
> > let the core power take care of them.
> 
> What if the driver is unbound while the device is suspended?  It seems 
> pretty awkward.  The release method would have to do:
> 
> 	pm_runtime_get_sync(dev);
> 	pm_runtime_disable(dev);
> 	pm_runtime_set_suspended(dev);
> 	pm_runtime_put_noidle(dev);

That's correct, but as I said I don't think it's safe to do anything else in
general at this point (please remember that it must cooperate with system
suspend/resume).

This still is a work in progress, though, so if you have an idea how to improve
it, I surely won't object. :-)

Rafael
