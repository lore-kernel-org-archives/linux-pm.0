From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] pm: rename device_power_down/up()
Date: Thu, 14 May 2009 11:32:32 -0700
Message-ID: <20090514183232.GA14432@suse.de>
References: <20090514122356.19418.31612.sendpatchset@rx1.opensource.se>
	<200905141943.53151.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905141943.53151.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 14, 2009 at 07:43:52PM +0200, Rafael J. Wysocki wrote:
> On Thursday 14 May 2009, Magnus Damm wrote:
> > From: Magnus Damm <damm@igel.co.jp>
> > 
> > Rename the functions performing "_noirq" dev_pm_ops
> > operations from device_power_down() and device_power_up()
> > to device_suspend_noirq() and device_resume_noirq().
> > 
> > The new function names are chosen to show that the functions
> > are responsible for calling the _noirq() versions to finalize
> > the suspend/resume operation. The current function names do
> > not perform power down/up anymore so the names may be misleading.
> > 
> > Global function renames:
> > - device_power_down() -> device_suspend_noirq()
> > - device_power_up() -> device_resume_noirq()
> > 
> > Static function renames:
> > - suspend_device_noirq() -> __device_suspend_noirq()
> > - resume_device_noirq() -> __device_resume_noirq() 
> 
> Pavel, Alan, Greg, any objections?

No objection from me:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
