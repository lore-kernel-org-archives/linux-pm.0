From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 00/07] pm: remove late/early platform driver
	pm	callbacks V2
Date: Wed, 24 Jun 2009 13:33:52 -0700
Message-ID: <20090624203352.GA28516__5928.46267759359$1245877154$gmane$org@suse.de>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
	<200906242048.40956.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906242048.40956.rjw@sisk.pl>
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
Cc: ben-linux@fluff.org, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 24, 2009 at 08:48:39PM +0200, Rafael J. Wysocki wrote:
> On Wednesday 24 June 2009, Magnus Damm wrote:
> > pm: remove late/early platform driver pm callbacks V2
> > 
> > [PATCH 01/07] arm: rework omap suspend_late()/resume_early()
> > [PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
> > [PATCH 03/07] dma: rework txx9dmac suspend_late()/resume_early()
> > [PATCH 04/07] i2c: rework i2c-pxa suspend_late()/resume_early()
> > [PATCH 05/07] i2c: rework i2c-s3c2410 suspend_late()/resume() V2
> > [PATCH 06/07] usb: rework musb suspend()/resume_early()
> > [PATCH 07/07] pm: remove platform device suspend_late()/resume_early() V2
> > 
> > These patches simply remove ->suspend_late() and ->resume_early()
> > from struct platform_driver. Drivers are converted to dev_pm_ops
> > with CONFIG_SUSPEND in mind. Untested.
> > 
> > All patches except [02/07] are known to compile.
> > 
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> 
> If no one objects, I'd like to take this series into the suspend-2.6 tree as
> 2.6.32 material.  Greg?

Looks good to me, feel free to add an:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to the whole series.

thanks,

greg k-h
