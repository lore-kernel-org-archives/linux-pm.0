From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Status of the PM links framework
Date: Fri, 24 Dec 2010 15:21:10 +0100
Message-ID: <201012241521.10155.rjw@sisk.pl>
References: <201012201444.01510.laurent.pinchart@ideasonboard.com>
	<201012202339.02468.rjw@sisk.pl>
	<201012210041.54652.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012210041.54652.laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 21, 2010, Laurent Pinchart wrote:
> Hi Rafael,

Hi,

Sorry for the delay.

CCing linux-pm, as this information may be interesting to more people.

> On Monday 20 December 2010 23:39:02 Rafael J. Wysocki wrote:
> > On Monday, December 20, 2010, Laurent Pinchart wrote:
> > > 
> > > I recently came across your asynchronous suspend of devices patch set
> > > (https://lists.linux-foundation.org/pipermail/linux-pm/2009-
> > > September/022662.html) which includes a PM link framework.
> > > 
> > > I need to model master-slave power management relationships between
> > > devices that have no parent-child relationships. The PM link framework
> > > seems to be one possibly way to solve the problem.
> > > 
> > > The patch set hasn't been integrated into mainline, so I was wondering
> > > what its status was. Has it been replaced by something else that I could
> > > use to achieve the same goal ?
> > 
> > The pm_links idea was dropped, because of some strong opposition from
> > Linus. Apparently, he thought that it was overdesgned and not really
> > necessary to address the problem at hand (which was to ensure the right
> > ordering of asynchronous suspend and resume of devices).  He thought that
> > the off-tree dependencies between devices were occasional and not really
> > worth introducing an entirely new framework.
> > 
> > As a result, the ordering of asychronous suspend and resume is controlled
> > with the help of completions in such a way that, for example, the resume
> > of a child device will be blocked until the parent device's completion is
> > completed.  The handling of off-tree dependencies is left to device drivers
> > (ie. if the driver of device A knows that A cannot resume before device B,
> > it will block on the B's completion by calling device_pm_wait_for_dev()).
> 
> So A needs to be aware of B. I'll need to see how I can implement that.

More precisely, either the driver of A or the subsystem invoking its
->suspend() and ->resume() callbacks needs to know of B.  Also, in the
majority of cases, the driver of B (or its subsystem) needs to know of A
(if A needs to wait for B during resume, then most likely B needs to wait
for A during suspend).

> > That said, I don't really think the pm_links idea was too bad.  It
> > certainly _looked_ like overly complicated at that time, but it turns out
> > that it might be useful in some situations _unrelated_ to asynchronous
> > suspend and resume.
> > 
> > However, it isn't suitable for handling device dependencies in some
> > situations, one of which is the initialization of devices.
> > 
> > I wonder what's your potential use case?
> 
> I'm working with a sensor (on an I2C bus) connected to an image signal 
> processor (ISP, on a platform bus) in a system on chip (SoC). The ISP provides 
> a clock to the sensor, but the sensor driver is not aware of any ISP-specific 
> information, as the sensor can be used on other platforms.
> 
> To implement this I'm using an abstraction framework in V4L called V4L2 
> subdevs. Basically it models the sensor as an abstract sub-device that 
> implements a set of operations. Communication between the subdev (sensor) and 
> main device (ISP) can be performed as well through a notification callback.
> 
> Depending on the platform, the clock can also be provided by the SoC or by an 
> on-board oscillator, so this needs to be configurable.
> 
> During suspend I need to stop the sensor before turning the clock off, 
> otherwise it won't answer I2C commands. Similarly, during resume, I need to 
> turn the clock back on before resuming the sensor.
> 
> Can all this be implemented using completion handlers (and are there 
> completion handlers or something similar for suspend, not only for resume) ?

There are no completion handlers.  The driver (or subsystem) handling the
device that needs to wait should call device_pm_wait_for_dev() (with
appropriate arguments) exactly at the point in which the "master" device is
to be waited for.

So, presumably, the driver handling the suspend of the "clock device" will
have to call device_pm_wait_for_dev() during suspend to wait for the I2C
sensor.  Analogously, during resume the I2C device's ->resume() callback
(or its subsystem's callbacks) will have to call device_pm_wait_for_dev() to
wait for the "clock device".

Please note, however, that this only applies to _system_ suspend/resume, it
doesn't cover runtime PM at all.

Thanks,
Rafael
