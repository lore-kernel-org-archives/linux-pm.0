From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V3
Date: Thu, 25 Jun 2009 08:30:35 -0700
Message-ID: <20090625153035.GA21920__39063.899490475$1245945676$gmane$org@suse.de>
References: <20090610121659.27937.13560.sendpatchset@rx1.opensource.se>
	<87r5xhqzr4.fsf@deeprootsystems.com>
	<200906251635.44787.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906251635.44787.rjw@sisk.pl>
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
Cc: paul@pwsan.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 25, 2009 at 04:35:43PM +0200, Rafael J. Wysocki wrote:
> On Thursday 18 June 2009, Kevin Hilman wrote:
> > Magnus Damm <magnus.damm@gmail.com> writes:
> > 
> > > From: Magnus Damm <damm@igel.co.jp>
> > >
> > > Allow architecture specific data in struct platform_device V3.
> > >
> > > With this patch struct pdev_archdata is added to struct
> > > platform_device, similar to struct dev_archdata in found in
> > > struct device. Useful for architecture code that needs to
> > > keep extra data associated with each platform device.
> > >
> > > Struct pdev_archdata is different from dev.platform_data, the
> > > convention is that dev.platform_data points to driver-specific
> > > data. It may or may not be required by the driver. The format
> > > of this depends on driver but is the same across architectures.
> > >
> > > The structure pdev_archdata is a place for architecture specific
> > > data. This data is handled by architecture specific code (for
> > > example runtime PM), and since it is architecture specific it
> > > should _never_ be touched by device driver code. Exactly like
> > > struct dev_archdata but for platform devices.
> > >
> > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > 
> > Since there is no 'Feature-desired-by:' tag, I'll addd
> > 
> > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> > 
> > For PM on ARM in general, and OMAP in particular we definitely need a
> > generic way to handle arch-specific data per platform_device.
> 
> Greg, is this patch fine with you?

Yes:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

thanks,

greg k-h
