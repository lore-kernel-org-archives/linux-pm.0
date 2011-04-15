From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] pm: disabling runtime power-management
 has to reset the status
Date: Fri, 15 Apr 2011 16:57:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104151621240.2051-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.1104152154340.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.1104152154340.18593@axis700.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.linux-foundation.org, Magnus Damm <damm@opensource.se>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Apr 2011, Guennadi Liakhovetski wrote:

> > > Yes, I can. On the first loading of an MMC driver, which does the standard
> > > 
> > > 	pm_runtime_enable(&pdev->dev);
> > > 	ret = pm_runtime_resume(&pdev->dev);
> > > 
> > > in .probe() and
> > > 
> > > 	pm_runtime_disable(&pdev->dev);
> > > 
> > > in .release() (see [1]), with an inserted card, on the first modprobe I 
> > > see a full pm-runtime run down to platform_pm_runtime_resume() and to 
> > > platform_pm_runtime_suspend() on rmmod. On a repeated modprobe 
> > > platform_pm_runtime_resume() does not get called, because 
> > > dev->power.runtime_status != RPM_SUSPENDED, instead, it is still 
> > > RPM_ACTIVE, so, rpm_resume() exits prematurily.
> > 
> > I see.  And is it true that you really do want to set the status to 
> > RPM_SUSPENDED without touching the hardware, i.e., without disabling 
> > any clocks or gating any power supplies?
> 
> I'd expected, that pm_runtime_disable() would do all the necessary 
> suspending too in such a case.

No, pm_runtime_disable() merely prevents the runtime PM callbacks from
being used; it doesn't change the device's power status.  If you really
want to suspend the device, call pm_runtime_suspend() before the
runtime_disable.  And if you want to leave the device alone but change
the power status value, call pm_set_suspended() after the
runtime_disable.

>  Isn't this "enable-resume-disable" sequence 
> standard and shouldn't this suffice for the complete cycle?

It isn't standard as far as I know.  More common is:

	enable supend resume suspend resume suspend resume ...
	(many repeats of suspend resume) ... disable

Obviously this would be slightly different if the device's default
state (i.e., its state before the kernel detected it) was unpowered.

Alan Stern
