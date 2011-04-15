From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] pm: disabling runtime power-management
 has to reset the status
Date: Fri, 15 Apr 2011 21:59:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104152154340.18593@axis700.grange>
References: <Pine.LNX.4.44L0.1104151539330.2051-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1104151539330.2051-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Magnus Damm <damm@opensource.se>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Apr 2011, Alan Stern wrote:

> On Fri, 15 Apr 2011, Guennadi Liakhovetski wrote:
> 
> > On Fri, 15 Apr 2011, Alan Stern wrote:
> > 
> > > On Fri, 15 Apr 2011, Guennadi Liakhovetski wrote:
> > > 
> > > > Restore the initial RPM_SUSPENDED runtime pm status, when disabling,
> > > > otherwise the following enable will not function. This happens, e.g.,
> > > > when unloading and reloading drivers.
> 
> ...
> 
> > > This certainly doesn't look right.  Can you explain in more detail the 
> > > problem you are trying to solve?
> > 
> > Yes, I can. On the first loading of an MMC driver, which does the standard
> > 
> > 	pm_runtime_enable(&pdev->dev);
> > 	ret = pm_runtime_resume(&pdev->dev);
> > 
> > in .probe() and
> > 
> > 	pm_runtime_disable(&pdev->dev);
> > 
> > in .release() (see [1]), with an inserted card, on the first modprobe I 
> > see a full pm-runtime run down to platform_pm_runtime_resume() and to 
> > platform_pm_runtime_suspend() on rmmod. On a repeated modprobe 
> > platform_pm_runtime_resume() does not get called, because 
> > dev->power.runtime_status != RPM_SUSPENDED, instead, it is still 
> > RPM_ACTIVE, so, rpm_resume() exits prematurily.
> 
> I see.  And is it true that you really do want to set the status to 
> RPM_SUSPENDED without touching the hardware, i.e., without disabling 
> any clocks or gating any power supplies?

I'd expected, that pm_runtime_disable() would do all the necessary 
suspending too in such a case. Isn't this "enable-resume-disable" sequence 
standard and shouldn't this suffice for the complete cycle?

Thanks
Guennadi

> If so, then your release routine should simply do
> 
> 	pm_set_suspended(&pdev->dev);
> 
> after calling pm_runtime_disable().  There's no need to modify the 
> runtime PM core.
> 
> Alan Stern
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
