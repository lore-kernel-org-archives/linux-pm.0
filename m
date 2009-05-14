From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] pm: rename device_power_down/up()
Date: Thu, 14 May 2009 14:39:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905141421130.4344-100000@iolanthe.rowland.org>
References: <200905141943.53151.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: linux-pm@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 14 May 2009, Rafael J. Wysocki wrote:

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

Renaming these routines is a great idea.  The inconsistent naming has 
bothered me for a long time.

Shouldn't it go even farther?  With this patch we'll have:

	__device_resume_noirq
	dpm_power_up
	device_resume_noirq
	resume_device
	dpm_resume
	complete_device
	dpm_complete
	device_resume

	__device_suspend_noirq
	device_suspend_noirq
	suspend_device
	dpm_suspend
	prepare_device
	dpm_prepare
	device_suspend

Firstly, there's no reason for dpm_power_up to be separate from
device_resume_noirq.  They should be merged; after all, the analogous
functionality is combined in device_suspend_noirq.

Secondly, it looks bad to have two functions named resume_device and 
device_resume.  Ditto for suspend_device and device_suspend.  Even 
without those unfortunate pairs, it looks like people couldn't make up 
their minds whether the names should be <verb>_device or device_<verb>.

So I suggest even more renaming on top of these changes:

	resume_device -> device_resume
	complete_device -> device_complete
	device_resume - > dpm_resume_all

	suspend_device -> device_suspend
	prepare_device -> device_prepare
	device_suspend -> dpm_suspend_all

How does that sound?

Alan Stern
