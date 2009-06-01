From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][RFC] Driver Core: Rework platform
	suspend/resume, print warning
Date: Tue, 2 Jun 2009 00:48:09 +0200
Message-ID: <200906020048.10046.rjw@sisk.pl>
References: <20090601102044.10780.12920.sendpatchset@rx1.opensource.se>
	<200906012044.27631.rjw@sisk.pl> <20090601210255.GB2236@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090601210255.GB2236@suse.de>
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
To: Greg KH <gregkh@suse.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 01 June 2009, Greg KH wrote:
> On Mon, Jun 01, 2009 at 08:44:27PM +0200, Rafael J. Wysocki wrote:
> > On Monday 01 June 2009, Magnus Damm wrote:
> > > From: Magnus Damm <damm@igel.co.jp>
> > > 
> > > This patch reworks the platform driver code for legacy
> > > suspend and resume to avoid installing callbacks in
> > > struct device_driver. A warning is also added telling
> > > users to update the platform driver to use dev_pm_ops.
> > > 
> > > The functions platform_legacy_suspend()/resume() directly
> > > call suspend and resume callbacks in struct platform_driver
> > > instead of wrapping things in platform_drv_suspend()/resume().
> > > 
> > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > 
> > Greg, is this patch fine with you?
> 
> Fine with me.  If you want to take it in your tree, feel free to add:
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

I will, thanks!

Best,
Rafael
