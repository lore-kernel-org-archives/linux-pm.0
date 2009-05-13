From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: dev->status.power and future of DPM_
Date: Wed, 13 May 2009 15:22:31 +0200
Message-ID: <200905131522.31882.rjw@sisk.pl>
References: <aec7e5c30905130329t5610c8d1x925d554b833dedcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30905130329t5610c8d1x925d554b833dedcc@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 13 May 2009, Magnus Damm wrote:
> Hi everyone,

Hi,
 
> What is the future plan for dev->status.power? Right now it seems to
> reflect the upcoming internal software state of each device when
> performing suspend and resume. The attached picture may clarify things
> if it makes it to the list.
> 
> I'm a bit interested in modifying dev->status.power to reflect the
> current device power state. Basically getting rid of DPM_PREPARING,
> DPM_RESUMING, DPM_SUSPENDING and DPM_OFF_NOIRQ (they seem to be fairly
> unused anyway),

Please read drivers/base/power/main.c once again _carefully_ and rethink
your observation above.

> and instead using the following states:
> 
> DPM_ON - default operational state
> DPM_FROZEN - set after PMSG_FREEZE
> DPM_OFF - set after PMSG_HIBERNATE
> DPM_SUSPENDED - set after PMSG_SUSPEND

The PMSG_* things are only used to pass information between the
suspend/hibernation core and the functions in drivers/base/power/main.c .
They are also used by the legacy suspend callbacks of device drivers, but
drivers are encouraged to use struct dev_pm_ops objects instead.
And struct dev_pm_ops contains also  the .prepare()/.complete() callbacks that
you don't seem to be taking into consideration.

What exactly is the purpose of the changes you're suggesting?

> On top of this I'd like to allow device drivers to mark devices as
> idle. And if a device is marked idle then I'd like to allow power
> management code to perform freeze() on a single device. After that
> marking the device frozen using DPM_FROZEN. poweroff() may also be
> called to perform some partial system suspend. It gets more
> complicated of course, but I guess we need a way to know the state of
> each device regardless.

We have discussed that for several times already IIRC and the conclusion has
always been that such things should better be done at the bus type level, not
at the core level.

If you look at the PCI power management code, you'll notice that the drivers'
PM callbacks are not called directly by the core, but they are called by the
PCI bus type PM callbacks which in turn carry out some bus-specific operations
before or after executing the drivers' callbacks.  However, these bus-specific
operations generally need not be suitable for run-time power management of
devices (they are designed with system-wide power transitions in mind).
Also, such things as PM events signalling (eg. a device has been suspended
at run time, but there's activity on the device which causes it to notify the
kernel and the device signals the event somehow) tend to be bus-specific or
platform-specific.

USB, where run-time power management has already been
implemented, is a good example too.

Thanks,
Rafael
