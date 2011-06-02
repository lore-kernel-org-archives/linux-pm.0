From: Kevin Hilman <khilman@ti.com>
Subject: Re: calling runtime PM from system PM methods
Date: Thu, 02 Jun 2011 10:10:23 -0700
Message-ID: <87lixkyxa8.fsf__30247.7044206627$1307034687$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Thu, 2 Jun 2011 10:18:06 -0400 (EDT)")
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Wed, 1 Jun 2011, Kevin Hilman wrote:
>
>> In the process of experimenting with other solutions, I found an
>> interesting discovery:
>> 
>> In the driver's ->suspend() hook, I did something like this:
>> 
>> 	priv->forced_suspend = false;
>> 	if (!pm_runtime_suspended(dev)) {
>> 		pm_runtime_put_sync(dev);
>> 		priv->forced_suspend = true;
>> 	}
>> 
>> and in the resume hook I did this:
>> 
>> 	if (priv->forced_suspend)
>> 		pm_runtime_get_sync(dev);
>> 
>> Even after disabling runtime PM from userspace via
>> /sys/devices/.../power/control, the ->suspend() hook triggered an actual
>> transition.  This is because pm_runtime_forbid() just uses the usage
>> counter, so the _put_sync() in the ->suspend callback decrements the
>> counter and triggers an rpm_idle().   Is this expected behavior?
>
> Not really.  In fact it is a bug in your experimental code -- you are
> decrementing the usage counter in a context where you did not
> previously increment it.  In principle, the counter might already be 0
> when the suspend hook runs.
>
> Yes, it is indeed possible for a device to be active while the usage
> counter is 0.  For example (assuming the counter is initially 0), this
> will happen if you call
>
> 	pm_runtime_get_sync(dev);
> 	pm_runtime_put_noidle(dev);
>
> or even if you simply call
>
> 	pm_runtime_resume(dev);
>
> Of course, the drivers you're talking about may never do this.  Still, 
> it's a logical mistake to do a *_put without previously doing a *_get.

OK.  I was trying to catch that by checking pm_runtime_suspended(), but
now see that that cannot work in general.

The problem I'm trying to solve is how (or whether) I can use runtime PM
from the system PM methods, specifically in the case where runtime PM
has been disabled from userspace (or pm_runtime_forbid() has been
called.)  

In a nutshell, what I'm after is for any pm_runtime_forbid() calls to be
cancelled during system PM, thus allowing pending runtime PM events to
occur during system PM.

Basically, what I have is several drivers who don't really need suspend
hooks if runtime PM is enabled, because they use runtime PM on a per
transaction basis, handle all the HW stuff in the runtime PM callbacks,
and from a HW perspective, there is no difference in power state between
runtime and static suspend.  These devices are already runtime suspended
when the system PM callbacks run, so there is nothing for the system PM
callbacks to do.

If pm_runtime_forbid() has been called, but then a system suspend is
initiated, we'd like these devices to actually suspend, meaning allowing
any pending runtime PM transitions to happen during system suspend.
In order to force/trick/pursuade the device to to this, something like
this works:

static int omap_i2c_suspend(struct device *dev)
{
	if (dev->power.runtime_auto == false)
		pm_runtime_put_sync(dev);

	return 0;
}

static int omap_i2c_resume(struct device *dev)
{
	if (dev->power.runtime_auto == false)
		pm_runtime_get_sync(dev);

	return 0;
}

Yes, this does a put without a get, but when runtime_auto == true,
there was an implicit _get_noresume() done by the runtime PM core.

Possibly a cleaner way, but one that would force the driver to keep
addiional state would be something like

suspend (or prepare):

	if (dev->power.runtime_auto == false) {
		priv->rpm_forced = true;
		pm_runtime_allow(dev);
	}

resume (or complete):

       	if (priv->rpm_forced)
		pm_runtime_forbid(dev);

If this is acceptable, I'd probably implement this at the device power
domain level instead of having to have every driver do this.

Kevin
